/** 
 * @file   asm1e1.s
 * @brief  Aprender el funcionamiento de la instruccion ORR.
 * 
 * @author  Alejandro Lara - alejandro.lara UCA
 * @date    2026-05-05
 * @version v2.0
 */

// === Constantes (.equ) ===
// Usamos .equ para valores que no cambian
.equ MASCARA_BITS, 0b10010001   @ (1u << 7) | (1u << 4) | (1u << 0)

@ === Configuración de la sección de código ===
    .section .text, "ax"            @ Sección de código (text), alineada (a) y ejecutable (x)
    .syntax unified                 @ Usa la sintaxis moderna unificada de ARM
    .thumb                          @ Obligatorio para Cortex-M (instrucciones Thumb-2)
    .align 2                        @ Alinea el código a 32bits -> 4 bytes (2^2)

    .global prueba_orr              @ Hace que la función sea visible desde archivos C
    .type   prueba_orr, %function   @ Indica que prueba_orr es una función

@ -------------------------------------------------------------------------------------------------
@ int32_t prueba_orr(int32_t param1, int32_t param2, int32_t param3, int32_t param4)
@
@ CONVENCIÓN DE LLAMADA (AAPCS):
@ - Entradas: r0 = param1, r1 = param2, r2 = param3, r3 = param4
@ - Salida:   r0 = resultado de la función
@ - Registros Callee-saved (preservar): r4 a r11
@ - Registros Caller-saved (libres):    r0 a r3, r12
@ -------------------------------------------------------------------------------------------------

@ === Alias de registros para mejorar la legibilidad ===
@ Los parámetros llegan en registros, les asignamos un alias para utilizarlos más facilmente
DATO    .req    r0

prueba_orr:
    @ === PRÓLOGO ===
    @ No utilizamos ningun registro callee-saved (r4-r11)

    @ === CUERPO DE LA FUNCIÓN ===
    @ Dato ya está en el registro r0 y puedo leerlo también con el alias que creamos
    
    orr  r0, DATO, #MASCARA_BITS    @ Realiza el OR directamente sobre r0 = r0 | MASCARA_BITS
                                    @ Resultado final ya en r0 (registro de retorno)

    @ === EPÍLOGO ===
    @ Restauramos los registros guardados.
    
    @ Salto incondicional a lr
    bx  lr
    
    @ Desvinculamos los alias de los registros para evitar conflictos
    .unreq DATO
    
    .end
