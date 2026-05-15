/**
 * @file  main_asm1e2.c
 *
 * @brief Ejemplo de uso de la instrucción ADD con desplazamiento de operando. Llama a una función
 * en ensamblador que multiplica un dato de 32 bits por 2, 3, 9 y 17 usando instrucciones ADD con
 * ADD con op2 desplazado, y almacena los cuatro resultados en un array.
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
void prod_add(uint32_t dato, uint32_t *ptr_array);

int main(void) {

  uint32_t mul[] = {2, 3, 9, 17};
  uint32_t resultado[4];
  uint32_t dato = 20;
  uint32_t i;

  glcd_inicializar();
  glcd_seleccionar_fuente(FUENTE12X24);

  glcd_printf("Dato: %5d\n", dato);

  prod_add(dato, resultado);

  glcd_printf("Resultado:\n");

  for (i = 0; i < 4; i++) {
    glcd_printf("por_%d: %5d\n", mul[i], resultado[i]);
  }

  while (TRUE) {
    ;
  }
}
