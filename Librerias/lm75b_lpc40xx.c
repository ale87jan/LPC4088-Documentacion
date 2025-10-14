/**
 * @file    lm75b_lpc40xx.c
 * @brief   Funciones para acceder a un sensor de temperatura LM75B a través de una de las
 * interfaces I2C del LPC40xx.
 *
 * @details La tarjeta Embedded Artist Developer's Kit dispone de un LM75B integrado conectado a
 * la interfaz I2C0 en los siguiente pines:
 *
 * Pin uC | Función
 * ------ | ---------
 * P0[27] | SDA
 * P0[28] | SCL
 *
 * @author      Alejandro Lara Doña - alejandro.lara@uca.es | Eduardo Romero
 * @date        2014/2025
 * @version     2.0
 *
 * @copyright   GNU General Public License version 3 or later
 */

#include "lm75b_lpc40xx.h"
#include <LPC407x_8x_177x_8x.h>
#include "tipos.h"
#include "error.h"
#include "i2c_lpc40xx.h"

// =====  LM75B - Variables Privadas =====
/* Variables globales estáticas para mantener los parámetros utilizados para la comunicación con el
 * LM75B. La función lm75b_inicializar almacena en ellas los valores que se utilizarán en el resto
 * de funciones.
 */
/**
 * @brief     Interfaz I2C a la que está conectado el LM75B.
 * @ingroup   LM75B
 * @private
 */
static LPC_I2C_TypeDef* lm75b_interfaz_i2c;

/**
 * @brief     Dirección I2c del LM75B a utilizar.
 * @ingroup   LM75B
 * @private
 */
static uint8_t lm75b_dir_i2c;

/**
 * @brief     Configura la interfaz I2C para la comunicación con el LM75B y devuelve si es el
 * dispositivo está disponible.
 * @ingroup   LM75B
 *
 * @param[in] i2c_regs          Puntero a regs. de la interfaz a inicializar.
 * @param[in] frecuencia_scl    Frecuencia de la señal SCL.
 * @param[in] puerto_sda        Puerto que se desea para la función SDA.
 * @param[in] mascara_pin_sda   Pin que se desea para la función SDA.
 * @param[in] puerto_scl        Puerto que se desea para la función SCL.
 * @param[in] mascara_pin_scl   Pin que se desea para la función SCL.
 * @param[in] dir_i2c           Dirección I2C del LM75B.
 *
 * @retval    TRUE    Se ha podido establecer la comunicación con el LM75B.
 * @retval    FALSE   No se ha podido establecer la comunicación con el LM75B.
 */
bool_t lm75b_inicializar(LPC_I2C_TypeDef *i2c_regs, uint32_t frecuencia_scl,
                         LPC_GPIO_TypeDef *puerto_sda, uint32_t mascara_pin_sda,
                         LPC_GPIO_TypeDef *puerto_scl, uint32_t mascara_pin_scl, uint8_t dir_i2c) {


  bool_t respuesta;

  i2c_inicializar(i2c_regs, frecuencia_scl, puerto_sda, mascara_pin_sda,
                  puerto_scl, mascara_pin_scl);

  lm75b_interfaz_i2c = i2c_regs;
  lm75b_dir_i2c = dir_i2c;

  i2c_start(lm75b_interfaz_i2c);

  respuesta = i2c_transmitir_byte(lm75b_interfaz_i2c, (lm75b_dir_i2c << 1) | I2C_BIT_ESCRIBIR);

  i2c_stop(I2C0);

  return respuesta;
}

/**
 * @brief     Escribe un dato en un registro interno del LM75B.
 * @ingroup   LM75B
 *
 * @param[in] dir_registro  Dirección del registro a escribir.
 * @param[in] dato          Dato a escribir en el registro.
 */
void lm75b_escribir_registro(uint8_t dir_registro, uint16_t dato) {

  if (dir_registro == LM75B_REG_CONF) {

    i2c_start(lm75b_interfaz_i2c);
    i2c_transmitir_byte(lm75b_interfaz_i2c, (lm75b_dir_i2c << 1) | I2C_BIT_ESCRIBIR);

    i2c_transmitir_byte(lm75b_interfaz_i2c, LM75B_REG_CONF);

    i2c_transmitir_byte(lm75b_interfaz_i2c, dato);

    i2c_stop(lm75b_interfaz_i2c);
    
    return;

  } else if (dir_registro == LM75B_REG_THYST || dir_registro == LM75B_REG_TOS) {

    i2c_start(lm75b_interfaz_i2c);
    i2c_transmitir_byte(lm75b_interfaz_i2c, (lm75b_dir_i2c << 1) | I2C_BIT_ESCRIBIR);

    i2c_transmitir_byte(lm75b_interfaz_i2c, dir_registro);

    i2c_transmitir_byte(lm75b_interfaz_i2c, ((dato >> 8) & 0xFF));
    i2c_transmitir_byte(lm75b_interfaz_i2c, (dato & 0xFF));

    i2c_stop(lm75b_interfaz_i2c);
    
    return;
  }

  ERROR("Registro no valido");
}

/**
 * @brief     Lee un registro interno del LM75B.
 * @ingroup   LM75B
 *
 * @param[in] dir_registro   Dirección del registro a leer.
 *
 * @return    Valor leído del registro.
 */
uint16_t lm75b_leer_registro(uint8_t dir_registro) {

  if (dir_registro == LM75B_REG_CONF) {

    uint8_t byte_recibido;

    i2c_start(lm75b_interfaz_i2c);
    i2c_transmitir_byte(lm75b_interfaz_i2c, (lm75b_dir_i2c << 1) | I2C_BIT_ESCRIBIR);

    i2c_transmitir_byte(lm75b_interfaz_i2c, LM75B_REG_CONF);

    i2c_start(lm75b_interfaz_i2c);
    i2c_transmitir_byte(lm75b_interfaz_i2c, ((lm75b_dir_i2c << 1) | I2C_BIT_LEER));

    byte_recibido = i2c_recibir_byte(lm75b_interfaz_i2c, FALSE);

    i2c_stop(lm75b_interfaz_i2c);

    return byte_recibido;

  } else if (dir_registro == LM75B_REG_THYST || dir_registro == LM75B_REG_TOS ||
             dir_registro == LM75B_REG_TEMP ) {

    uint8_t byte_recibido_alto, byte_recibido_bajo;
    uint16_t dato_recibido_suma;

    i2c_start(lm75b_interfaz_i2c);
    i2c_transmitir_byte(lm75b_interfaz_i2c, (lm75b_dir_i2c << 1) | I2C_BIT_ESCRIBIR);

    i2c_transmitir_byte(lm75b_interfaz_i2c, dir_registro);

    i2c_start(lm75b_interfaz_i2c);
    i2c_transmitir_byte(lm75b_interfaz_i2c, ((lm75b_dir_i2c << 1) | I2C_BIT_LEER));

    byte_recibido_alto = i2c_recibir_byte(lm75b_interfaz_i2c, TRUE);
    byte_recibido_bajo = i2c_recibir_byte(lm75b_interfaz_i2c, FALSE);

    dato_recibido_suma = (byte_recibido_alto << 8) | byte_recibido_bajo;

    i2c_stop(lm75b_interfaz_i2c);

    return dato_recibido_suma;

  }

  ERROR("Registro no valido");

  return 0;  // Al utilizar ERROR() esta instrucción nunca se ejecutará
}

/**
 * @brief     Lee el registro TEMP del LM75B y retorna la temperatura en grados centígrados.
 * @ingroup   LM75B
 *
 * @return  Temperatura en grados centígrados.
 */
float32_t lm75b_leer_temperatura(void) {

  uint16_t registro_leido_temp = lm75b_leer_registro(LM75B_REG_TEMP);

  // La temperatura son los 12 bits más significativos
  registro_leido_temp = (registro_leido_temp >> 5) & 0x7FF;

  return registro_leido_temp * 0.125f;
}
