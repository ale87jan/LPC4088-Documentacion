/**
 * @file  main_asm_ejemplo.c
 *
 * @brief Ejemplo de función en ensamblador ARM para armclang (GNU Assembler).
 *
 * @details La función de ejemplo implementada recibe cuatro parámetros de 32 bits, extrae un byte
 * de cada uno, los combina usando OR, y devuelve el resultado. El programa en C llama a esta
 * función con cuatro valores específicos y muestra el resultado en la pantalla LCD.
 *
 * @author  Alejandro Lara Doña - alejandro.lara@uca.es
 * @date    2026
 * @version 2.0
 *
 * @copyright GNU General Public License version 3 or later
 */

#include <LPC407x_8x_177x_8x.h>
#include "glcd.h"
#include "tipos.h"

// Prototipos de las funciones en ensamblador
uint32_t mi_funcion(uint32_t param1, uint32_t param2, uint32_t param3, uint32_t param4);
uint32_t plantilla_arm(uint32_t dato);

int main(void) {

  uint32_t resultado;

  glcd_inicializar();
  glcd_seleccionar_fuente(FUENTE12X24);

  resultado = mi_funcion(0x11111111, 0x22222222, 0x33333333, 0x44444444);

  glcd_printf("Resultado mi_funcion: 0x%8X\n", resultado);

  resultado = plantilla_arm(0);

  glcd_printf("Resultado plantilla_arm: 0x%8X\n", resultado);

  while (TRUE) {
    ;
  }
}
