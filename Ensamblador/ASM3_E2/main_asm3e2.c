/***************************************************************************//**
 * \file    main.c
 *
 * \brief   Función main para la práctica sobre interfaz C - ensamblador.
 */

#include <LPC407x_8x_177x_8x.h>
#include "glcd.h"

uint32_t concatenar_cadenas(char *cadena_1, char *cadena_2, char *buffer_destino);

/*******************************************************************************/
int main(void)
{ char cad1[]="casca"; //Tendría 6 elementos esta cadena
	char cad2[]="nueces";
	char cadena_concatenada[20]="*******************";
  uint32_t longitud_concatenada;
	
	glcd_inicializar();
	
	longitud_concatenada= concatenar_cadenas(cad1,cad2,cadena_concatenada);
	glcd_printf("\n%s,%u", cadena_concatenada, longitud_concatenada); 
	
	while(TRUE);
}
