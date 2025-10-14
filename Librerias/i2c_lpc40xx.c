/**
 * @file    i2c_lpc40xx.c
 * @brief   Funciones de manejo de las interfaces I2C del LPC40xx.
 *
 * @author      Alejandro Lara Doña - alejandro.lara@uca.es | Eduardo Romero
 * @date        2014/2025
 * @version     2.0
 *
 * @copyright   GNU General Public License version 3 or later

 * @note    Sólo se han implementado las funciones como maestro.
 */

#include "i2c_lpc40xx.h"
#include <LPC407x_8x_177x_8x.h>
#include "tipos.h"
#include "error.h"
#include "iocon_lpc40xx.h"

/**
 * @brief   Inicializa una interfaz I2C del LPC40xx.
 * @ingroup I2C
 *
 * @param[in]   i2c_regs  Puntero al bloque de registros de la interfaz.
 * @param[in]   frecuencia_scl     Frecuencia de la señal SCL.
 * @param[in]   puerto_sda         Puerto que se desea para la función SDA.
 * @param[in]   mascara_pin_sda    Pin que se desea para la función SDA.
 * @param[in]   puerto_scl         Puerto que se desea para la función SCL.
 * @param[in]   mascara_pin_scl    Pin que se desea para la función SCL.
 *
 * @note Los números de puerto y pin se comprueban en las funciones de configuración de pines
 */
void i2c_inicializar(LPC_I2C_TypeDef *i2c_regs, uint32_t frecuencia_scl,
                     LPC_GPIO_TypeDef *puerto_sda, uint32_t mascara_pin_sda,
                     LPC_GPIO_TypeDef *puerto_scl, uint32_t mascara_pin_scl) {

  uint32_t sclh_mas_scll = PeripheralClock / frecuencia_scl;

  ASSERT(i2c_regs == I2C0 || i2c_regs == I2C1 || i2c_regs == I2C2,
         "No existe la interfaz I2C seleccionada.");

  ASSERT(sclh_mas_scll >= 8, "No es posible ajustar a la frecuencia I2C solicitada.");

  // Aplicar alimentación a la interfaz elegida y configurar los pines SDA y SCL indicados
  if (i2c_regs == I2C0) {
    LPC_SC->PCONP |= (1u << 7);
    iocon_configurar_pin(puerto_sda, mascara_pin_sda, I2C0_SDA,
                         IOCON_NO_PULL_UP_NO_PULL_DOWN | IOCON_FILTER | IOCON_OD | IOCON_HS);
    iocon_configurar_pin(puerto_scl, mascara_pin_scl, I2C0_SCL,
                         IOCON_NO_PULL_UP_NO_PULL_DOWN | IOCON_FILTER | IOCON_OD | IOCON_HS);

  } else if (i2c_regs == I2C1) {
    LPC_SC->PCONP |= (1u << 19);
    iocon_configurar_pin(puerto_sda, mascara_pin_sda, I2C1_SDA,
                         IOCON_NO_PULL_UP_NO_PULL_DOWN | IOCON_FILTER | IOCON_OD);
    iocon_configurar_pin(puerto_scl, mascara_pin_scl, I2C1_SCL,
                         IOCON_NO_PULL_UP_NO_PULL_DOWN | IOCON_FILTER | IOCON_OD);

  } else {
    LPC_SC->PCONP |= (1u << 26);
    iocon_configurar_pin(puerto_sda, mascara_pin_sda, I2C2_SDA,
                         IOCON_PULL_UP| IOCON_FILTER | IOCON_OD);
    iocon_configurar_pin(puerto_scl, mascara_pin_scl, I2C2_SCL,
                         IOCON_PULL_UP| IOCON_FILTER | IOCON_OD);
  }

  // Mientras se configura, borrar los flags del registro de control y deshabilitar la interfaz
  i2c_regs->CONCLR = I2C_CON_I2EN | I2C_CON_STA | I2C_CON_SI | I2C_CON_AA;

  // Establecer la frecuencia SCL. El valor de SCLL siempre será sclh_mas_scll / 2
  i2c_regs->SCLL = sclh_mas_scll / 2;

  //El valor de SCLH será sclh_mas_scll/2 si sclh_mas_scll es par o sclh_mas_scll/2 + 1 si es impar
  i2c_regs->SCLH = sclh_mas_scll / 2 + ((sclh_mas_scll % 2 == 1) ? 1 : 0);

  // Habilitar la interfaz
  i2c_regs->CONSET = I2C_CON_I2EN;
}

/**
 * @brief   Genera una condición de START en el bus I2C.
 * @ingroup I2C
 *
 * @param[in]   i2c_regs  Puntero al bloque de registros de la interfaz.
 */
void i2c_start(LPC_I2C_TypeDef *i2c_regs) {

  ASSERT(i2c_regs == I2C0 || i2c_regs == I2C1 || i2c_regs == I2C2,
         "No existe la interfaz I2C seleccionada.");

  // El estado inicial de los bits STA y SI debe ser 0
  i2c_regs->CONCLR = I2C_CON_STA | I2C_CON_SI;

  // Crear condición de START activando el bit STA del registro CON
  i2c_regs->CONSET = I2C_CON_STA;
}

/**
 * @brief   Genera una condición de STOP en el bus I2C.
 * @ingroup I2C
 *
 * @param[in]   i2c_regs  Puntero al bloque de registros de la interfaz.
 */
void i2c_stop(LPC_I2C_TypeDef *i2c_regs) {

  ASSERT(i2c_regs == I2C0 || i2c_regs == I2C1 || i2c_regs == I2C2,
         "No existe la interfaz I2C seleccionada.");

  // Esperar a que termine la operación anterior (bit SI del registro CON a 1)
  while ((i2c_regs->CONSET & I2C_CON_SI) == 0) {;}

  // Activar el bit STO del registro CON
  i2c_regs->CONSET = I2C_CON_STO;

  /* Borrar el bit STA del registro CON para estar seguros de no crear un START antes del STOP que
   * queremos (STA podría estar a 1 ahora). Borrar el bit SI del registro CON. Con esto la máquina
   * de estados de la interfaz avanza y crea la condición de STOP.
   */
  i2c_regs->CONCLR = I2C_CON_STA | I2C_CON_SI;
}

/**
 * @brief   Transmite un byte a un esclavo a través del I2C.
 * @ingroup I2C
 *
 * @param[in]   i2c_regs  Puntero al bloque de registros de la interfaz.
 * @param[in]   byte      Byte a transmitir.
 *
 * @retval  TRUE  - El esclavo reconoció el dato.
 * @retval  FALSE - El esclavo no lo reconoció.
 */
bool_t i2c_transmitir_byte(LPC_I2C_TypeDef *i2c_regs, uint8_t byte) {

  uint8_t status;

  ASSERT(i2c_regs == I2C0 || i2c_regs == I2C1 || i2c_regs == I2C2,
         "No existe la interfaz I2C seleccionada.");

  // Esperar a que termine la operación anterior (bit SI del registro CON a 1)
  while ((i2c_regs->CONSET & I2C_CON_SI) == 0) {}

  // Escribir el byte a enviar en el registro de datos DAT
  i2c_regs->DAT = byte;

  /* Borrar el bit STA del registro CON para estar seguros de no crear un START (STA podría estar a
   * 1 ahora). Borrar el bit SI del registro CON. Con esto la máquina de estados de la interfaz
   * avanza y envía el dato del registro DAT.
   */
  i2c_regs->CONCLR = I2C_CON_STA | I2C_CON_SI;

  // Esperar a que termine la transmisión del byte (bit SI del registro CON a 1)
  while ((i2c_regs->CONSET & I2C_CON_SI) == 0) {;}

  // Leer el registro de estado para determinar si el esclavo reconoció o no el byte
  status = i2c_regs->STAT;
  if ((status == 0x18) || (status == 0x28)) {
    return TRUE;
  }

  return FALSE;
}

/**
 * @brief   Recibe un byte desde un esclavo a través del I2C.
 * @ingroup I2C
 *
 * @param[in]   i2c_regs  Puntero al bloque de registros de la interfaz.
 * @param[in]   ack       TRUE - generar un ACK, FALSE - generar un NACK.
 *
 * @return  Byte recibido.
 */
uint8_t i2c_recibir_byte(LPC_I2C_TypeDef *i2c_regs, bool_t ack) {

  ASSERT(i2c_regs == I2C0 || i2c_regs == I2C1 || i2c_regs == I2C2,
         "No existe la interfaz I2C seleccionada.");

  // Esperar a que termine la operación anterior (bit SI del registro CON a 1)
  while ((i2c_regs->CONSET & I2C_CON_SI) == 0) {}

  /* Si queremos reconocer el dato, activar el bit AA del registro CON. Si no queremos reconocer
   * el dato, borrar el bit AA.
   *
   * En ambos casos se borra el bit STA del registro CON para estar seguros de no crear un
   * condición de START (STA podría estar a 1 ahora). También se borra el bit SI del registro CON.
   * Con esto la máquina de estados de la interfaz avanza y comienza la recepción del byte.
   */
  if (ack) {
    i2c_regs->CONSET = I2C_CON_AA;
    i2c_regs->CONCLR = I2C_CON_STA | I2C_CON_SI;

  } else {
    i2c_regs->CONCLR = I2C_CON_STA | I2C_CON_SI | I2C_CON_AA;
  }

  // Esperar a que termine la recepción del byte (bit SI del registro CON a 1)
  while ((i2c_regs->CONSET & I2C_CON_SI) == 0) {;}

  // Retornar el byte recibido
  return i2c_regs->DAT;
}
