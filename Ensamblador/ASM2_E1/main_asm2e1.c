/*****************************************************************************
 * \file    main.c
 * \brief   Función main para ejercicio1 practica 11
 */

#include <LPC407x_8x_177x_8x.h>
#include "glcd.h"

/* Prototipos de las funciones en ensamblador */
uint32_t prod_escalar (uint32_t *vector1, uint32_t *vector2, uint32_t dim);

/******************************************************************************/
int main(void){

	uint32_t vector1[]={10,2,5,4};
  uint32_t vector2[]={23,35,2,10};
	uint32_t resultado,dim=4,i;

	glcd_inicializar();
	glcd_seleccionar_fuente(FUENTE12X24);

	glcd_printf("Vector 1: ");
	
	for(i=0;i<dim;++i){
		glcd_printf("%4d ",vector1[i]);
	}
  
	glcd_printf("\nVector 2: ");
	
	for(i=0;i<dim;++i){
		glcd_printf("%4d ",vector2[i]);
	}

  resultado= prod_escalar (vector1,vector2,dim);
  
	glcd_printf("\nProducto escalar: %5d",resultado);	 

	while(TRUE);
}
