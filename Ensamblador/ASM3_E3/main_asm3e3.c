/***************************************************************************//**
 * \file    main.c
 *
 * \brief   Función main para la práctica sobre interfaz C - ensamblador.
 */

#include <LPC407x_8x_177x_8x.h>
#include "glcd.h"

bool_t int_a_cadena_decimal(int32_t dato, char *buffer);

int main(void)
{ int32_t dato=-1234;
	char buffer[12]="00000000000"; //Longitud 12 caracteres
																 //1 signo + 10 num + '\0'
	
	glcd_inicializar();
	
  if (int_a_cadena_decimal(dato,buffer)){
		glcd_printf ("%d, %s",dato,buffer);
	}

	while(TRUE);
}
