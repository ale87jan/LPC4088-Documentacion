@ =================================================================================================
@ file   asm1e1.s
@ brief  Plantilla base para funciones en ensamblador ARM (Sintaxis armclang)
@
@ author  Nombre Apellidos [EMAIL]
@ date    yyyy-mm-dd
@ version v1.0
@ =================================================================================================

@ === Constantes (.equ) ===
@ Usamos .equ para valores que no cambian
.equ MASCARA_BITS,  1
    
@ === Sección de Datos (Read-Only) ===
    .section .rodata, "a"
    .align 2
    .global LETRAS_EN_ASCII
LETRAS_EN_ASCII:
    .byte 0x54, 0x52, 0x57, 0x41, 0x47, 0x4D, 0x59, 0x46, 0x50, 0x44, 0x58
    .byte 0x42, 0x4E, 0x4A, 0x5A, 0x53, 0x51, 0x56, 0x48, 0x4C, 0x43, 0x4B, 0x45

@ === Configuración de la sección de código ===
    .section .text, "ax"            @ Sección de código (text), alineada (a) y ejecutable (x)
    .syntax unified                 @ Usa la sintaxis moderna unificada de ARM
    .thumb                          @ Obligatorio para Cortex-M (instrucciones Thumb-2)
    .align 2                        @ Alinea el código a 4 bytes (2^2)

    .global mi_funcion              @ Hace que la función sea visible desde archivos C
    .type   mi_funcion, %function   @ Indica que prueba_orr es una función

@ -------------------------------------------------------------------------------------------------
@ int32_t mi_funcion(int32_t param1, int32_t param2, int32_t param3, int32_t param4)
@
@ CONVENCIÓN DE LLAMADA (AAPCS):
@ - Entradas: r0 = param1, r1 = param2, r2 = param3, r3 = param4
@ - Salida:   r0 = resultado de la función
@ - Registros Callee-saved (preservar): r4 a r11
@ - Registros Caller-saved (libres):    r0 a r3, r12
@ -------------------------------------------------------------------------------------------------

@ === Alias de Registros (.req) ===
@ Mejoran la legibilidad del código
PARAM1  .req    r0    @ Registro que contiene el primer parámetro de la función
PARAM2  .req    r1    @ Registro que contiene el segundo parámetro
PARAM3  .req    r2    @ Registro que contiene el tercer parámetro
PARAM4  .req    r3    @ Registro que contiene el cuarto parámetro

mi_funcion:
    @ === PRÓLOGO ===
    @ Si usas registros r4-r11, inclúyelos aquí. Ejemplo: push {r4, r5}
    push    {r4}

    @ === CUERPO DE LA FUNCIÓN ===
    @ Los parámetros ya están en los registros r0-r3
    
    add     r4, r0, r1            @ r4 = param1 + param2
    and     r0, r4, #MASCARA_BITS @ Resultado final en r0 (registro de retorno)

    @ === EPÍLOGO ===
    @ Restauramos los registros guardados
    pop {r4}
    bx lr
    
    @ Desvinculamos los alias de los registros para evitar conflictos
    .unreq PARAM1
    .unreq PARAM2
    .unreq PARAM3
    .unreq PARAM4

    @ .ltorg: El "pool" o "almacén" de literales donde el ensamblador guarda direcciones que genere 
    @ durante la compilación
    @
    @ No es obligatorio, pero sí recomendable.
    @
    @ Evita errores de compilación cuando el código crece y los datos no se almacenan cerca de
    @ la instrucción que la utiliza
    .align 2
    .ltorg

    @ .size: Calcula automáticamente el tamaño en bytes que ocupa la función
    @ No es obligatorio, pero sí recomendable.
    @
    @ Depuración: Cuando el alumno esté usando el depurador y vea el código desensamblado, el IDE 
    @ (como uVision) sabrá exactamente dónde termina la función y podrá mostrar los símbolos 
    @ correctamente.
    @
    @ Optimización: Si el enlazador (linker) intenta eliminar funciones que no se usan para ahorrar 
    @ espacio, necesitará saber el tamaño exacto para no borrar de más o de menos.
    .size mi_funcion, .-mi_funcion
    
    .end