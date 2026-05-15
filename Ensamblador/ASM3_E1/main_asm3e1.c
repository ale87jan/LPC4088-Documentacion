/**
 * @file  main_asm3e1.c
 *
 * @brief Función en ensamblador que calcula el determinante de una matriz 2x2. Recibe como
 * parámetros los cuatro elementos de la matriz (a11, a12, a21, a22) y devuelve el valor del
 * determinante.
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
int32_t det2x2(int32_t a11, int32_t a12, int32_t a21, int32_t a22);

int main(void) {

  glcd_inicializar();
  glcd_printf("%d", det2x2(1, 2, 3, 4));
  while (TRUE) {
    ;
  }
}
