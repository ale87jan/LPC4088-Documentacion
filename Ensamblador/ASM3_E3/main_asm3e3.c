/**
 * @file  main_asm3e3.c
 *
 * @brief Función en ensamblador que convierte un número entero a su representación en cadena
 * decimal. Recibe como parámetros un número de 32 bits con signo y un puntero a un buffer de
 * destino, devolviendo un booleano indicando éxito.
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

bool_t int_a_cadena_decimal(int32_t dato, char *ptr_buffer);

int main(void) {
  int32_t dato       = -1234;
  char    buffer[12] = "00000000000";  //Longitud 12 caracteres
                                       //1 signo + 10 num + '\0'

  glcd_inicializar();

  if (int_a_cadena_decimal(dato, buffer)) {
    glcd_printf("%d, %s", dato, buffer);
  }

  while (TRUE) {
    ;
  }
}
