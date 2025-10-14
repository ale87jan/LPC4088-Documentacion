/**
 * @file  main_lm75b.c
 * @brief Programa principal de acceso a un sensor de temperatura LM75B mediante la interfaz I2C0.
 *
 * @author      Alejandro Lara Doña - alejandro.lara@uca.es
 * @date        2025
 * @version     1.0
 *
 * @copyright   GNU General Public License version 3 or later
 */

#include <LPC407x_8x_177x_8x.h>
#include "glcd.h"
#include "gpio_lpc40xx.h"
#include "timer_lpc40xx.h"
#include "i2c_lpc40xx.h"
#include "lm75b_lpc40xx.h"

int main(void) {

  float32_t grados;
  glcd_inicializar();
  lm75b_inicializar(I2C0,             // Interfaz I2C del LPC40xx a utilizar
                    100000,           // Frecuencia SCL
                    PUERTO0, PIN27,   // Puerto y pin SDA
                    PUERTO0, PIN28,   // Puerto y pin SCL
                    LM75B_DIR_I2C);   // Dirección I2C del LM75B

  timer_inicializar(TIMER0);
  timer_iniciar_ciclos_ms(TIMER0, 1000);

  while (1) {
    grados = lm75b_leer_temperatura();
    glcd_printf("Temperatura = %3.3f\n", grados);
    timer_esperar_fin_ciclo(TIMER0);
  }
}
