/***************************************************************************//**
 * \file    main.c
 *
 * \brief   Función main para la práctica sobre interfaz C - ensamblador.
 */

#include <LPC407x_8x_177x_8x.h>
#include "glcd.h"

/* Prototipos de las funciones en ensamblador */
int32_t det2x2(int32_t a11, int32_t a12, int32_t a21, int32_t a22);

/**************************************************************************/
int main(void){
	
	glcd_inicializar();
	glcd_printf("%d",det2x2(1,2,
													3,4));
	while(TRUE);
}
