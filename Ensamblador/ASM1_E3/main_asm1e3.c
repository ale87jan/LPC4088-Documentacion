/**
 * @file  main_asm1e3.c
 *
 * @brief Función en ensamblador que busca el valor máximo en un bloque de n datos de 16 bits sin
 * signo almacenados en memoria. La tabla de valores se pasa como primer parámetro y el número de
 * elementos n como segundo. El resultado se devuelve como retorno de la función.
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
uint16_t mayor(uint16_t *ptr_tabla, uint8_t n_elem);


int main(void) {

  uint16_t tabla[] = {67, 83, 45, 567, 26, 3, 345, 0};
  uint8_t  n_elem  = 8;
  uint8_t  i;

  glcd_inicializar();
  glcd_seleccionar_fuente(FUENTE12X24);

  glcd_printf("Tabla: \n");

  for (i = 0; i < n_elem; i++) {
    glcd_printf("%3u ", tabla[i]);
  }

  glcd_printf("\n\nMayor elemento: %3u", mayor(tabla, 8));

  while (TRUE) {
    ;
  }
}
