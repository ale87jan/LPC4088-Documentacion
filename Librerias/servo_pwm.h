/**
 * @file    servo_pwm.h
 * @brief   Funciones de manejo del servo de rotación contínua HSR-1425CR mediante PWM.
 *
 * @author      Alejandro Lara Doña - alejandro.lara@uca.es | Eduardo Romero
 * @date        2014/2025
 * @version     2.0
 *
 * @copyright   GNU General Public License version 3 or later
 */

#ifndef SERVO_PWM_H
#define SERVO_PWM_H

#include "tipos.h"

// ===== Servo_PWM - Constantes Publicas =====
/**
 * @brief Parámetros PWM del servo de rotación continua HSR-1425CR.
 * @ingroup Servo_PWM
 */
enum servo_pwm_config {
  SERVO_PWM_PERIODO_PWM_US = 20000,       //!< Periodo PWM en us.
  SERVO_PWM_T_ON_REPOSO_US = 1545,        //!< Ton para reposo en us.
  SERVO_PWM_ZONA_MUERTA = 10,             //!< Zona muerta desde la posición actual.
  SERVO_PWM_REPOSO_ZONA_MUERTA = 50,      //!< Zona muerta desde la posición de reposo.
  SERVO_PWM_SEMIINTERVALO_T_ON_US = 180   //!< Mitad de la amplitud de variación de Ton en us.
};

// ===== Servo_PWM - Funciones Publicas =====
void servo_pwm_inicializar(void);
bool_t servo_pwm_ajustar_velocidad(int8_t porcentaje_velocidad);

#endif // SERVO_PWM_H
