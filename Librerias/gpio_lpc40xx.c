/**
 * @file    gpio_lpc40xx.c
 * @brief   Funciones para manejar los puertos E/S digital del LPC40xx.
 *
 * @author      Alejandro Lara Doña - alejandro.lara@uca.es | Eduardo Romero
 * @date        2014/2025
 * @version     2.0
 *
 * @copyright   GNU General Public License version 3 or later
 */

#include "gpio_lpc40xx.h"
#include <LPC407x_8x_177x_8x.h>
#include "tipos.h"
#include "error.h"

/**
 * @name  Funciones de lectura y escritura en los pines
 * @brief Estas funciones se han declarado inline y están definidas en gpio_lpc40xx.h.
 * @note  Esta definición cumple con el método aplicable a las funciones inline del estándar C11
 * que es el utilizado. Se utilizará cuando el compilador decida no insertar en linea la función.
 * Al definir las funciones como extern se le dice al enlazador: "Aquí está la única versión global
 * y real de la función para usar cuando sea necesario".
 * @{
 */
extern bool_t gpio_leer_pin(const LPC_GPIO_TypeDef *gpio_regs, uint32_t mascara_pin);
extern uint32_t gpio_leer_puerto(const LPC_GPIO_TypeDef *gpio_regs);
extern void gpio_escribir_pin(LPC_GPIO_TypeDef *gpio_regs, uint32_t mascara_pin, bool_t valor);
extern void gpio_escribir_puerto(LPC_GPIO_TypeDef *gpio_regs, uint32_t valor);
extern void gpio_pin_a_1(LPC_GPIO_TypeDef *gpio_regs, uint32_t mascara_pin);
extern void gpio_pin_a_0(LPC_GPIO_TypeDef *gpio_regs, uint32_t mascara_pin);
extern void gpio_invertir_pin(LPC_GPIO_TypeDef *gpio_regs, uint32_t mascara_pin);
//!@}

/**
 * @brief   Configurar la dirección de uno o más pines.
 * @ingroup GPIO
 *
 * @param[in]  gpio_regs    Puerto del pin o pines cuya dirección se quiere ajustar.
 * @param[in]  mascara_pin  Máscara de selección del pin o pines.
 * @param[in]  direccion    Dirección: DIR_ENTRADA o DIR_SALIDA.
 */
void gpio_ajustar_dir(LPC_GPIO_TypeDef *gpio_regs, uint32_t mascara_pin, uint32_t direccion) {

  ASSERT(gpio_regs == PUERTO0 || gpio_regs == PUERTO1 || gpio_regs == PUERTO2 ||
         gpio_regs == PUERTO3 || gpio_regs == PUERTO4 || gpio_regs == PUERTO5,
         "Puerto no valido.");

  // Comprobar que si es del PUERTO5 no se supera el PIN6
  ASSERT(gpio_regs != PUERTO5 || (gpio_regs == PUERTO5 && mascara_pin < PIN6), "Pin no valido.");

  ASSERT(direccion == DIR_ENTRADA || direccion == DIR_SALIDA, "Direccion no valida.");

  if (direccion == DIR_ENTRADA) {
    gpio_regs->DIR &= ~mascara_pin;
  } else {
    gpio_regs->DIR |= mascara_pin;
  }
}

/**
 * @brief   Consultar la dirección de un pin establecida actualmente.
 * @ingroup GPIO
 *
 * @param[in]   gpio_regs     Puerto del pin cuya dirección se quiere obtener.
 * @param[in]   mascara_pin   Máscara de selección del pin.
 *
 * @return      Dirección del puerto (DIR_ENTRADA o DIR_SALIDA).
 */
uint32_t gpio_obtener_dir(const LPC_GPIO_TypeDef *gpio_regs, uint32_t mascara_pin) {

  ASSERT(gpio_regs == PUERTO0 || gpio_regs == PUERTO1 || gpio_regs == PUERTO2 ||
         gpio_regs == PUERTO3 || gpio_regs == PUERTO4 || gpio_regs == PUERTO5,
         "Puerto no valido.");

  // Comprobar que si es del PUERTO5 no se supera el PIN6
  ASSERT(gpio_regs != PUERTO5 || (gpio_regs == PUERTO5 && mascara_pin < PIN6), "Pin no valido.");

  if ((gpio_regs->DIR & mascara_pin) != 0) {
    return DIR_SALIDA;
  }

  return DIR_ENTRADA;
}
