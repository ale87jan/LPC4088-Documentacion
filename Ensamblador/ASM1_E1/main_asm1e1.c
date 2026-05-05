/*****************************************************************************
 * \file    main.c
 * \brief   Función main para ejercicio1 practica 10
 */

#include <LPC407x_8x_177x_8x.h>
#include "glcd.h"

/* Prototipos de las funciones en ensamblador */
uint32_t prueba_orr (uint32_t dato);

/******************************************************************************/
int main(void){

  uint32_t dato= 0;
  uint32_t resultado;

  glcd_inicializar();
  glcd_seleccionar_fuente(FUENTE12X24);

  glcd_printf("Dato: %5X\n",dato);

  resultado= prueba_orr (dato);

  glcd_printf("Resultado: %5X\n",resultado);

  while(TRUE);
}
