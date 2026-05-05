/*****************************************************************************
 * \file    main.c
 * \brief   Función main para ejercicio1 practica 10
 */

#include <LPC407x_8x_177x_8x.h>
#include "glcd.h"

/* Prototipos de las funciones en ensamblador */
uint16_t mayor(uint16_t *tabla, uint8_t n_elem);

/******************************************************************************/
int main(void){

	uint16_t tabla[]= {67,83,45,567,26,3,345,0};
	uint8_t n_elem=8, i;

	glcd_inicializar();
	glcd_seleccionar_fuente(FUENTE12X24);

	glcd_printf("Tabla: \n");
  for(i=0;i<n_elem;i++) {
		glcd_printf("%3u ",tabla[i]);
	}

  glcd_printf("\n\nMayor elemento: %3u",mayor(tabla,8));	 

	while(TRUE);
}
