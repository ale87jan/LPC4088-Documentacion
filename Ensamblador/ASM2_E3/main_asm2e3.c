/**
 * @file  main_asm2e3.c
 *
 * @brief Función en ensamblador que convierte temperaturas entre Celsius y Fahrenheit. Recibe
 * como parámetros la temperatura y un código que indica si se convierte a Fahrenheit o a
 * Celsius, devolviendo el resultado de la conversión.
 *
 * @author  Alejandro Lara Doña - alejandro.lara@uca.es
 * @date    2026
 * @version 2.0
 *
 * @copyright GNU General Public License version 3 or later
 */

#include <LPC407x_8x_177x_8x.h>
#include <stdlib.h>
#include "glcd.h"
#include "tipos.h"

// Prototipos de las funciones en ensamblador
uint32_t temperatura(uint32_t temp, uint32_t c_o_f);
uint32_t temperatura_subf(uint32_t temp, uint32_t c_o_f);

int main(void) {

  uint32_t temp_grados_original;
  uint32_t temp_farenheit;
  uint32_t temp_grados;
  uint8_t  i = 0;

  glcd_inicializar();
  glcd_seleccionar_fuente(FUENTE12X24);

  glcd_borrar(NEGRO);
  glcd_xy_texto(0, 0);
  glcd_printf("Iniciando\n");

  for (i = 0; i < 4; i++) {
    temp_grados_original = (rand() % 50);  //Temperatura en el rango de 0,50 ºC
    temp_farenheit       = temperatura(temp_grados_original, 0);  //Convierto a Farenheit
    temp_grados          = temperatura(temp_farenheit, 1);        //Convierto a Celsius
    glcd_printf("%2uC -> %2uF -> %2uC\n", temp_grados_original, temp_farenheit, temp_grados);
    
    temp_farenheit       = temperatura_subf(temp_grados_original, 0); //Convierto a Farenheit
    temp_grados          = temperatura_subf(temp_farenheit, 1);       //Convierto a Celsius
    glcd_printf("%2uC -> %2uF -> %2uC\n", temp_grados_original, temp_farenheit, temp_grados);
  }

  while (TRUE) {
    ;
  }
}
