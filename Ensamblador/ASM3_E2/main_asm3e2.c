/**
 * @file  main_asm3e2.c
 *
 * @brief Función en ensamblador que concatena dos cadenas de caracteres. Recibe como parámetros
 * dos punteros a cadenas de entrada y un puntero al buffer de destino, devolviendo la longitud
 * de la cadena concatenada.
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

uint32_t concatenar_cadenas(char *ptr_cadena_1, char *ptr_cadena_2, char *ptr_buffer_destino);

int main(void) {
  char     cad1[] = "casca";  //Tendría 6 elementos esta cadena
  char     cad2[] = "nueces";
  char     cadena_concatenada[20];
  uint32_t longitud_concatenada;

  glcd_inicializar();

  longitud_concatenada = concatenar_cadenas(cad1, cad2, cadena_concatenada);
  glcd_printf("La cadena \"%s\" tiene %u caracteres", cadena_concatenada, longitud_concatenada);

  while (TRUE) {
    ;
  }
}
