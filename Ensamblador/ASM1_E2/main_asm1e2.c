/*****************************************************************************
 * \file    main.c
 * \brief   Función main para ejercicio 2 practica 10
 */

#include <LPC407x_8x_177x_8x.h>
#include "glcd.h"

/* Prototipos de las funciones en ensamblador */
void prod_add (uint32_t dato, uint32_t *array);

/******************************************************************************/
int main(void){
	
	uint32_t dato= 20, i;
	uint32_t resultado[4],mul[]={2,3,9,17};

	glcd_inicializar();
	glcd_seleccionar_fuente(FUENTE12X24);

	glcd_printf("Dato: %5d\n",dato);

  prod_add (dato,resultado);
  
	glcd_printf("Resultado:\n");
  for(i=0;i<4;i++) glcd_printf("por_%d:	%5d\n",mul[i],resultado[i]);	 

	while(TRUE);
}
