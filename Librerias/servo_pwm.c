/**
 * @file    servo_pwm.c
 * @brief   Funciones de manejo del servo de rotación contínua HSR-1425CR mediante PWM.
 *
 * @author      Alejandro Lara Doña - alejandro.lara@uca.es | Eduardo Romero
 * @date        2014/2025
 * @version     2.0
 *
 * @copyright   GNU General Public License version 3 or later
 */

#include "servo_pwm.h"
#include <LPC407x_8x_177x_8x.h>
#include "tipos.h"
#include "iocon_lpc40xx.h"

// ===== Servo_PWM - Funciones Publicas =====
/**
 * @brief   Inicializa la generación de señal PWM.
 * @ingroup Servo_PWM
 *
 * @details Habilita el modulo PWM1 y configura el pin P1[18] para gobernar el servo de rotación
 * contínua HSR-1425CR. El servo debe quedar en reposo.
 */
void servo_pwm_inicializar(void) {

  // Aplicar alimentación al módulo PWM1 poniendo a 1 el bit 6 de LPC_SC->PCONP
  LPC_SC->PCONP |= (1u << 6);

  // Configurar el pin P1[18] para que realice la función PWM1[1]
  iocon_configurar_pin(PUERTO1, PIN18, PWM1_1, 0);

  /* Es mejor parar el conteo del registro TC del módulo PWM mientras se realiza su configuración.
   * Para el módulo PWM1 escribiendo 0 en su registro TCR (LPC_PWM1->TCR). Esto pondrá a 0 el bit
   * Counter Enable de TCR y con ello el módulo parará (o permanecerá parado si ya lo está).
   */
  LPC_PWM1->TCR = 0;

  // Poner a 0 el registro contador de preescala, PC, y el contador principal, TC
  LPC_PWM1->PC = 0;
  LPC_PWM1->TC = 0;

  // Ajusta el registro de preescala, PR, para que el contador TC se incremente cada microsegundo
  LPC_PWM1->PR = PeripheralClock * 1e-6 - 1;

  /* Programa el registro de control de match, MCR, y el registro de match 0, MR0, para que el
   * periodo de la señal PWM sea de 20000 microsegundos (20 ms). En el fichero servo_pwm.h está
   * definido el símbolo SERVO_PWM_PERIODO_PWM_US con el valor 20000.
   */
  LPC_PWM1->MCR = (1u << 1);
  LPC_PWM1->MR0 = SERVO_PWM_PERIODO_PWM_US - 1;

  /* Como usaremos la salida PWM1[1], el tiempo que la señal PWM generada estará en ON estará
   * determinada por el valor del registro de match 1, MR1.
   * Queremos que el tiempo en ON inicial sea de 1545 microsegundos porque así el servo estará
   * parado inicialmente. Para conseguirlo, carga el registro MR1 con el valor 1545. En el fichero
   * servo_pwm.h está definido el símbolo SERVO_PWM_T_ON_REPOSO_US con dicho valor.
   */
  LPC_PWM1->MR1 = SERVO_PWM_T_ON_REPOSO_US;

  /* Ajustar el valor del registro PCR para habilitar la generación de una señal PWM por el pin
   * PWM1[1]. Configurar el modo PWM de control de un solo flanco.
   */
  LPC_PWM1->PCR = (1u << 9);

  /* Poner a 1 el bit 1 del registro LER para que el registro shadow MR1 se cargue con el valor
   * de MR1 cuando se produzca el siguiente match con MR0.
   */
  LPC_PWM1->LER = (1u << 1);

  // Habilita el conteo y el modo PWM en el registro TCR
  LPC_PWM1->TCR = (1u << 0) | (1u << 3);
}

/**
 * @brief       Ajustar la velocidad y sentido de giro del servo.
 * @ingroup Servo_PWM
 *
 * @details     Ajustar el tiempo en ON de la señal PWM para conseguir que el servo se mueva al
 * porcentaje de su velocidad máxima indicado por el valor absoluto de velocidad y el sentido
 * indicado por su signo. Considera que si el signo de velocidad es negativo el giro debe ser
 * antihorario y que si es positivo debe ser horario.
 *
 * @param[in]   velocidad   Porcentaje (-100,100) de la velocidad máxima del servo al que se quiere
 *                          que gire. Los valores negativos corresponden a sentido de giro
 *                          antihorario y los valores positivos a sentido de giro horario.
 *
 * @retval  FALSE   No se ha podido ajustar la velocidad (velocidad fuera de rango).
 * @retval  TRUE    Velocidad ajustada correctamente.
 */
bool_t servo_pwm_ajustar_velocidad(int8_t velocidad) {

  // Si el valor de velocidad es menor que -100 o mayor que 100, retornar FALSE inmediatamente.
  if (velocidad > 100 || velocidad < -100) {
    return FALSE;
  }

  int32_t incremento_us = (SERVO_PWM_SEMIINTERVALO_T_ON_US * velocidad) / 100;

  /*
  if ((incremento_us < SERVO_PWM_REPOSO_ZONA_MUERTA/2) && (velocidad > 0)) {
    incremento_us += SERVO_PWM_REPOSO_ZONA_MUERTA/2;

  } else if ((incremento_us > -SERVO_PWM_REPOSO_ZONA_MUERTA/2) && (velocidad < 0)) {
    incremento_us -= SERVO_PWM_REPOSO_ZONA_MUERTA/2;
  }
  */

  /* Ajustar el registro MR1 para que el tiempo en ON de la señal PWM sea el adecuado para
   * conseguir que el servo se mueva al porcentaje de su velocidad máxima indicado por el valor
   * absoluto de velocidad y el sentido indicado por su signo. Consejo: Utiliza las constantes
   * SERVO_PWM_T_ON_REPOSO_US y SERVO_PWM_SEMIINTERVALO_T_ON_US.
   */
  LPC_PWM1->MR1 = SERVO_PWM_T_ON_REPOSO_US + incremento_us;

  /* Escribe en el registro LER el valor adecuado para que el registro shadow MR1 se actualice
   * con el valor del registro MR1 cuando ocurra el siguiente evento de match con MR0.
   */
  LPC_PWM1->LER = (1u << 1);

  return TRUE;
}

