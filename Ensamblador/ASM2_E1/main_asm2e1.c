/**
 * @file  main_asm2e1.c
 *
 * @brief Función en ensamblador que calcula el producto escalar de dos vectores. Recibe como
 * parámetros dos punteros a vectores de 32 bits, la dimensión de los vectores, y devuelve el
 * resultado del producto escalar.
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
uint32_t prod_escalar(uint32_t *ptr_vector1, uint32_t *ptr_vector2, uint32_t dim);

int main(void) {

  uint32_t vector1[] = {10, 2, 5, 4};
  uint32_t vector2[] = {23, 35, 2, 10};
  uint32_t resultado;
  uint32_t dim = 4;
  uint32_t i;

  glcd_inicializar();
  glcd_seleccionar_fuente(FUENTE12X24);

  glcd_printf("Vector 1: ");

  for (i = 0; i < dim; ++i) {
    glcd_printf("%4d ", vector1[i]);
  }

  glcd_printf("\nVector 2: ");

  for (i = 0; i < dim; ++i) {
    glcd_printf("%4d ", vector2[i]);
  }

  resultado = prod_escalar(vector1, vector2, dim);

  glcd_printf("\nProducto escalar: %5d", resultado);

  while (TRUE) {
    ;
  }
}
