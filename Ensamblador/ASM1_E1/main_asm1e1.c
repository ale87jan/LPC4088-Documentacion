/**
 * @file  main_asm1e1.c
 *
 * @brief Ejemplo de uso de la instrucción ORR. Llama a una función en ensamblador que pone a 1
 * los bits 7, 4 y 0 de un dato de 32 bits.
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
uint32_t prueba_orr(uint32_t dato);

int main(void) {

  uint32_t dato = 0;
  uint32_t resultado;

  glcd_inicializar();
  glcd_seleccionar_fuente(FUENTE12X24);

  glcd_printf("Dato: %5X\n", dato);

  resultado = prueba_orr(dato);

  glcd_printf("Resultado: %5X\n", resultado);

  while (TRUE) {
    ;
  }
}
