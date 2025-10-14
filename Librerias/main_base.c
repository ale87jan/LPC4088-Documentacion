/**
 * @file  main_base.c
 *
 * @brief Ejemplo de uso de interrupciones que usa la interrupción del TIMER0 para mostrar un
 * cronómetro con horas, minutos y segundos.
 *
 * @author      Alejandro Lara Doña - alejandro.lara@uca.es
 * @date        2025
 * @version     2.0
 *
 * @copyright   GNU General Public License version 3 or later
 */

#include <LPC407x_8x_177x_8x.h>
#include <stdio.h>
#include "tipos.h"
#include "glcd.h"
#include "timer_lpc40xx.h"
#include "gpio_lpc40xx.h"
#include "joystick.h"
#include "leds.h"

int main(void) {

  // Inicializar el LCD
  glcd_inicializar();

  // Imprimir el reloj por primera vez
  glcd_xprintf(0, 0, BLANCO, NEGRO, FUENTE16X32, "00:00:00");

  // Inicializar los LEDs
  leds_inicializar();

  // Inicializar el TIMER0
  timer_inicializar(TIMER0);

  // Configuración del TIMER0 en el NVIC
  NVIC_ClearPendingIRQ(TIMER0_IRQn);
  NVIC_SetPriority(TIMER0_IRQn, 1);
  NVIC_EnableIRQ(TIMER0_IRQn);

  // Borrar peticiones de interrupción de los pines 25 y 27 del puerto 2
  LPC_GPIOINT->CLR2 = PIN25 | PIN27;

  // Programar que los pines generen flancos de bajada
  LPC_GPIOINT->ENF2 |= PIN25 | PIN27;

  // Configuración del GPIO en el NVIC
  NVIC_ClearPendingIRQ(GPIO_IRQn);
  NVIC_SetPriority(GPIO_IRQn, 0);
  NVIC_EnableIRQ(GPIO_IRQn);

  // Habilitar globalmente las interrupciones
  __enable_irq();

  // Iniciar la generación de ciclos de 1 segundo con el TIMER0
  timer_iniciar_ciclos_ms(TIMER0, 1000);

  while (TRUE) {
    // Si el joystick se pulsa hacia el centro, encender el LED1, si no, apagarlo
    if (joystick_leer() == JOYSTICK_CENTRO) {
      leds_encender(LED1);

    } else {
      leds_apagar(LED1);
    }
  }
}

/**
 * @brief   Rutina de servicio de interrupción del TIMER0.
 */
void TIMER0_IRQHandler(void) {

  // Variables estáticas para mantener el tiempo
  static uint32_t horas = 0;
  static uint32_t minutos = 0;
  static uint32_t segundos = 0;

  segundos++;

  if (segundos > 59) {
    segundos = 0;
    minutos++;

    if (minutos > 59) {
      minutos = 0;
      horas++;

      if (horas > 23) {
        horas = 0;
      }
    }
  }

  glcd_xprintf(0, 0, BLANCO, NEGRO, FUENTE16X32, "%02d:%02d:%02d", horas, minutos, segundos);

  TIMER0->IR = 1;
}

/**
 * @brief   Manejador de interrupción del GPIO (pines de los puertos P0 y P2).
 */
void GPIO_IRQHandler(void) {

  // Comprobar si la interrupción la ha generado el P2[25]->Joystick Arriba
  if (LPC_GPIOINT->STATF2 & PIN25) {
    LPC_GPIOINT->CLR2 = PIN25;
    TIMER0->TCR = 1;
  }

  // Comprobar si la interrupción la ha generado el P2[27]->Joystick Abajo
  if (LPC_GPIOINT->STATF2 & PIN27) {
    LPC_GPIOINT->CLR2 = PIN27;
    TIMER0->TCR = 0;
  }

  NVIC_ClearPendingIRQ(GPIO_IRQn);
}
