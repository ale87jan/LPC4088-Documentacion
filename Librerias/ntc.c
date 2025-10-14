/**
 * @file    ntc.c
 * @brief   Conversión de la tensión en un termistor NTC a la temperatura correspondiente mediante
 * un divisor de tensión.
 *
 * @note    El divisor de tensión se supone 3.3V - 10KOhm - PinADC - NTC - GND.
 */

#include "ntc.h"
#include <math.h>

// ===== NTC - Funciones públicas =====
/**
 * @brief   Calcular la temperatura en grados centígrados correspondiente al resultado de 12bits
 * de la conversión A/D de la tensión de salida del módulo KY-013 de Keyes basado en una NTC.
 * @ingroup NTC
 *
 * @param[in] tension   Tensión en el divisor de tensión formado por el NTC y una resistencia fija
 *                      de 10k según se indica abajo.
 *
 * @return    Temperatura correspondiente en grados centígrados.
 *
 * @details La tensión en el PinADC es la tensión de salida del módulo sensor, que es igual a la
 * tensión en el centro del divisor de tensión formado por la resistencia fija de 10 kOhm (parte
 * superior) y la NTC (parte inferior).
 *
 * \f[
 *  tension = \frac{R_{ntc} * V_{cc}}{R_{1} + R_{ntc}} = \frac{3.3 * R_{ntc}}{10000 + R_{ntc}}
 * \f]
 *
 * Resolviendo para \f$R_{ntc}\f$
 *
 * \f[
 *  R_{ntc} = \frac{10000 * tension}{3.3 - tension}
 * \f]
 *
 * La relación entre la temperatura (ºC) y la resistencia de la NTC se aproxima por la ecuación de
 * Steinhart-Hart:
 *
 * \f[
 * Temp = \frac{1}{a + b * \ln(R_{ntc}) + c * \ln(R_{ntc})^3} - 273.16
 * \f]
 *
 * Tipo termistor | Termorretráctil negro |  Cinta Kapton
 * :------------: | --------------------- | ---------------
 *       a        |      1.129E-3f        | 5.089218645E-4f
 *       b        |      2.341E-4f        | 2.484818972E-4f
 *       c        |      8.767E-8f        | 1.313142875E-8f
 *
 * @note No hay información fiable sobre la NTC usada en el módulo KY-013 de Keyes. Estos
 * coeficientes están tomados de la información que circula por internet sobre el módulo.
 */
float32_t ntc_traducir_tension_a_temperatura(float32_t tension) {

  float32_t R_ntc, ln_R_ntc, temp;

  // Coeficientes Steinhart-Hart usados

  // Termorretráctil negro
  // const float32_t a = 1.129E-3f;
  // const float32_t b = 2.341E-4f;
  // const float32_t c = 8.767E-8f;

  // Cinta Kapton
  const float32_t a = 5.089218645E-4f;
  const float32_t b = 2.484818972E-4f;
  const float32_t c = 1.313142875E-8f;

  R_ntc = (10000.0f * tension) / (3.3f - tension);
  ln_R_ntc = log(R_ntc);
  temp = (1.0f / (a + (b * ln_R_ntc) + (c * powf(ln_R_ntc, 3.0f)))) - 273.16f;

  return temp;
}
