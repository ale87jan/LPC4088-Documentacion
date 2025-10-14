/**
 * @file    led_rgb.h
 * @brief   Funciones de manejo de un LED RGB mediante PWM.
 *
 * @details El LED RGB deberá estar conectado a los siguientes pines:
 *
 * Pin uC   | Canal PWM | Pin placa | Pin LED
 * -------- | -------   | --------- | :-----:
 * P1[3]    | PWM0[2]   | J3[29]    | R
 * P1[6]    | PWM0[4]   | J3[30]    | G
 * P1[11]   | PWM0[6]   | J3[31]    | B
 * GND      |           | J3[1]     | - (cátodo)
 *
 * @author      Alejandro Lara Doña - alejandro.lara@uca.es | Eduardo Romero
 * @date        2014/2025
 * @version     2.0
 *
 * @copyright   GNU General Public License version 3 or later
 */

#ifndef LED_RGB_H
#define LED_RGB_H

#include "tipos.h"

// ===== LED_RGB - Constantes Publicas =====
/**
 * @brief   Símbolo para la frecuencia PWM a la que se iluminará el LED.
 * @ingroup LED_RGB
 *
 * @details La frecuencia PWM para iluminación LED se recomienda superior a 100Hz para evitar que
 * el parpadeo sea visible al ojo humano. En general, cuanto mayor frecuencia mejor, aunque puede
 * dar lugar a que generen sonidos dentro del rango audible (50Hz-24kHz), y son necesarios
 * componentes de mayor calidad por la alta frecuencia de conmutación.
 *
 * Rango recomendado: 500-1000 Hz
 *
 * Frecuencia PWM = 520 Hz -> Periodo = 1923.07692us >< 1920us -> Frecuencia final = 520.83 Hz
 *
 * @note Para evitar acoplamientos con la frecuencia de la red eléctrica (o sus armónicos) es
 * recomendable utilizar frecuencias que no sean múltiplos de 50/60Hz.
 */
#define LED_RGB_PERIODO_PWM_US  1920

/**
 * @brief   Convierte las componentes r, g y b en su homólogo de 24 bits.
 * @ingroup LED_RGB
 *
 * @details   Función para convertir el valor expresado en las componentes roja, verde y azul de
 * 8bits a 24 bits para que sea similar a como se realiza para la pantalla GLCD.
 *
 * @param[in]   r   Intensidad del led rojo
 * @param[in]   g   Intensidad del led verde
 * @param[in]   b   Intensidad del led azul
 */
#define LED_RGB(r, g, b) ((((r) & 0xFF) << 16) | (((g) & 0xFF) << 8) | ((b) & 0xFF))

/**
 * @brief   Simbolos de varios colores en español.
 * @ingroup LED_RGB
 */
enum led_rgb_color {
  LED_RGB_NEGRO    = LED_RGB(0, 0, 0),
  LED_RGB_ROJO     = LED_RGB(255, 0, 0),
  LED_RGB_VERDE    = LED_RGB(0, 255, 0),
  LED_RGB_AZUL     = LED_RGB(0, 0, 255),
  LED_RGB_AMARILLO = LED_RGB(255, 255, 0),
  LED_RGB_VIOLETA  = LED_RGB(255, 0, 255),
  LED_RGB_CIAN     = LED_RGB(0, 255, 255),
  LED_RGB_BLANCO   = LED_RGB(255, 255, 255)
};

// ===== LED_RGB - Funciones Publicas =====
void led_rgb_inicializar(void);
bool_t led_rgb_ajustar_color(uint32_t color);

#endif // LED_RGB_H
