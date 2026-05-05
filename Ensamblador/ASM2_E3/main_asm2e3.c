/*****************************************************************************
 * \file	main.c
 * \brief	Función main para ejercicio 3 practica 10
 */

#include <LPC407x_8x_177x_8x.h>
#include <stdlib.h>
#include "glcd.h"

// Prototipos de las funciones en ensamblador
uint32_t temperatura(uint32_t temp, uint32_t C_o_F);

/******************************************************************************/
int main(void){
	
	uint32_t temp, temp2, temp3, C_o_F; //C_o_F==0->ºC; C_o_F==1->ºF
	uint8_t i = 0;
	char buffer[10], grados_F[] = "ºF", grados_C[] = "ºC";

	glcd_inicializar();
	glcd_seleccionar_fuente(FUENTE12X24);
	
	glcd_borrar(NEGRO);
	glcd_xy_texto(0,0);
	glcd_printf("Iniciando\n");
	
	for(i=0;i<5;i++){
		temp = (rand()%50);				//Temperatura en el rango de 0,50 ºC
		temp2 = temperatura(temp,0);	//Convierto a Farenheit
		temp3 = temperatura(temp2,1);	//Convierto de nuevo en Celsius
		glcd_printf("%2uºC -> %2uºF -> %2uºC\n", temp, temp2, temp3);
	}
	
	while(TRUE){
		;
	}
}
