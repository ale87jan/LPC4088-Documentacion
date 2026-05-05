/* =================================================================================================
 * @file   letra_dni.s
 * @brief  Obtiene la letra del DNI a partir de su número (Cálculo del resto módulo 23)
 * =================================================================================================
 */

@ === Constantes (.equ) ===
.equ DIVISOR, 23

@ === Alias de Registros (.req) ===
DNI      .req r0    @ Registro de entrada (número de DNI)
TABLA    .req r1    @ Puntero a la tabla de letras
RESTO    .req r2    @ Resultado de la operación módulo
TEMP     .req r3    @ Registro para el divisor y cálculos intermedios

@ === Sección de Datos (Read-Only) ===
    .section .rodata, "a"
    .align 2
    .global LETRAS_EN_ASCII
LETRAS_EN_ASCII:
    .byte 0x54, 0x52, 0x57, 0x41, 0x47, 0x4D, 0x59, 0x46, 0x50, 0x44, 0x58
    .byte 0x42, 0x4E, 0x4A, 0x5A, 0x53, 0x51, 0x56, 0x48, 0x4C, 0x43, 0x4B, 0x45

@ === Sección de Código ===
    .section .text, "ax"
    .syntax unified
    .thumb
    .align 2
    .global letra_dni
    .type letra_dni, %function

letra_dni:
    @ === PRÓLOGO ===
    @ En esta función no llamamos a otras (leaf function) y no usamos r4-r11,
    @ por lo que no es estrictamente necesario hacer push/pop de lr.
    @ Sin embargo, lo mantenemos por consistencia académica.
    push    {lr}

    @ === CUERPO DE LA FUNCIÓN ===
    
    @ 1. Cargar dirección de la tabla y el valor del divisor
    movw    TABLA, #:lower16:LETRAS_EN_ASCII
    movt    TABLA, #:upper16:LETRAS_EN_ASCII
    mov     TEMP, #DIVISOR

    @ 2. Calcular el resto (DNI % 23)
    @ Nota: Cortex-M4 tiene UDIV pero no tiene una instrucción directa para el resto (MOD)
    udiv    RESTO, DNI, TEMP    @ r2 = DNI / 23 (cociente)
    mul     RESTO, RESTO, TEMP  @ r2 = cociente * 23
    sub     RESTO, DNI, RESTO   @ r2 = DNI - (cociente * 23) -> Este es el RESTO

    @ 3. Obtener la letra de la tabla
    @ Sumamos el resto al puntero base para indexar la tabla
    ldrb    r0, [TABLA, RESTO]  @ r0 = TABLA[RESTO]. Cargamos un byte (carácter ASCII)

    @ === EPÍLOGO ===
    pop     {pc}

    @ Desvinculamos los alias de los registros para evitar conflictos
    .unreq DNI
    .unreq TABLA
    .unreq RESTO
    .unreq TEMP

    .align 2
    .ltorg
    .size letra_dni, .-letra_dni
    .end