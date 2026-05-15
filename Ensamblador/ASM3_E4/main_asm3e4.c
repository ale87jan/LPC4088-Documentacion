/**
 * @file  main_asm3e4.c
 *
 * @brief Función en ensamblador que evalúa un polinomio. Recibe como parámetros el valor de x,
 * un puntero al array de coeficientes (empezando por el de mayor grado) y el grado del polinomio,
 * devolviendo el resultado de la evaluación.
 *
 * @author  Alejandro Lara Doña - alejandro.lara@uca.es
 * @date    2026
 * @version 2.0
 *
 * @copyright GNU General Public License version 3 or later
 */

#include <LPC407x_8x_177x_8x.h>
#include <stdint.h>
#include "glcd.h"
#include "tipos.h"

int32_t eval_poli(int32_t x, int32_t *ptr_coeficientes, uint8_t grado);

int main(void) {

  int32_t coefs[5]  = {1, 2, -3, -4, 5};
  int32_t x         = 2;
  uint8_t grado     = sizeof(coefs) / sizeof(coefs[0]) - 1;
  int32_t resultado = coefs[0];
  uint8_t i;

  glcd_inicializar();

  glcd_seleccionar_fuente(FUENTE12X24);

  for (i = 0; i <= grado; i++) {
    glcd_printf("%+dx^%u ", coefs[i], 4 - i);
  }

  glcd_printf("\n\nResultado:%d", eval_poli(x, coefs, grado));

  for (i = 1; i <= grado; i++) {
    resultado = resultado * x + coefs[i];
  }

  glcd_printf("\nHorner C:%d", resultado);

  while (TRUE) {
    ;
  }
}
