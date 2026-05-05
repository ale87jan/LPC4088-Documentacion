/*****************************************************************************
 * \file    main.c
 * \brief   Función main para ejercicio 2 practica 10
 */

#include <LPC407x_8x_177x_8x.h>
#include "glcd.h"

/* Prototipos de las funciones en ensamblador */
char letra_dni (uint32_t dato);

/******************************************************************************/
int main(void){
	
	uint32_t dni= 54321800;
	char letra;

	glcd_inicializar();
	glcd_seleccionar_fuente(FUENTE12X24);

	glcd_printf("DNI: %d\n",dni);

  letra=letra_dni (dni);
  
	glcd_printf("Letra DNI: %c",letra); 

	while(TRUE);
}
