/**
 * @file  main_asm2e.c
 *
 * @brief Función en ensamblador que calcula la letra del DNI. Recibe como parámetro un número
 * de DNI de 32 bits y devuelve la letra correspondiente según el algoritmo oficial.
 *
 * @author  Alejandro Lara Doña - alejandro.lara@uca.es
 * @date    2026
 * @version 2.0
 *
 * @copyright GNU General Public License version 3 or later
 */

#include <LPC407x_8x_177x_8x.h>
#include "glcd.h"

// Prototipos de las funciones en ensamblador
char letra_dni(uint32_t dato);

int main(void) {

  uint32_t dni = 54321800;
  char     letra;

  glcd_inicializar();
  glcd_seleccionar_fuente(FUENTE12X24);

  glcd_printf("DNI: %d\n", dni);

  letra = letra_dni(dni);

  glcd_printf("Letra DNI: %c", letra);

  while (TRUE) {
    ;
  }
}
