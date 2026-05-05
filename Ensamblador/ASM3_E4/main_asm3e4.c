/***************************************************************************//**
 * \file    main.c
 *
 * \brief   Función main para la práctica sobre interfaz C - ensamblador.
 */

#include <LPC407x_8x_177x_8x.h>
#include "glcd.h"

int32_t eval_poli(int32_t x, int32_t *coeficientes, uint8_t grado);

int main(void){

	int32_t coefs[5]={1,2,-3,-4,5};
	uint8_t i;

	glcd_inicializar();
	
	glcd_seleccionar_fuente(FUENTE12X24);
	
	for(i=0;i<5;i++){
		glcd_printf("%+dx^%u ",coefs[i],4-i);
	}
	
	glcd_printf("\nResultado:%d", eval_poli(2,coefs,4)); 

	while(TRUE);
}
