/**
 * @file    ntc.h
 * @brief   Conversión de la tensión en un termistor NTC a la temperatura correspondiente mediante
 * un divisor de tensión.
 *
 * @author      Alejandro Lara Doña - alejandro.lara@uca.es
 * @date        2025
 * @version     2.0
 *
 * @copyright   GNU General Public License version 3 or later
 */

#ifndef NTC_H
#define NTC_H

#include "tipos.h"

// ===== NTC - Funciones públicas =====
float32_t ntc_traducir_tension_a_temperatura(float32_t V_s);

#endif  // NTC_H
