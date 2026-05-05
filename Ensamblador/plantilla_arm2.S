/* =================================================================================================
 * @file   plantilla_arm.s
 * @brief  Plantilla para funciones en ARM Cortex-M4 (armclang / GNU Syntax)
 *
 * @author Nombre Apellidos [EMAIL]
 * @date   2026-05-05
 * @version v1.0
 * =================================================================================================
 */

/* * Convención de llamada: AAPCS (ARM Architecture Procedure Call Standard)
 * · Parámetros: R0, R1, R2, R3 (en orden). Si hay más, van a la pila.
 * · Caller-saved: R0-R3, R12, LR (si llamas a otra función, debes guardarlos).
 * · Callee-saved: R4-R11 (esta función debe preservarlos si los usa).
 * · Retorno: El valor de retorno se devuelve siempre en R0.
 */

    .section .text, "ax"    /* Sección de código, alineada y ejecutable */
    .syntax unified          /* Sintaxis moderna compatible con Thumb-2 */
    .thumb                  /* Modo Thumb para Cortex-M4 */
    .align 2                /* Alineación a 4 bytes (2^2) */
    
    .global arm_funcion     /* Equivale a 'global' en NASM */
    .type arm_funcion, %function

/* -------------------------------------------------------------------------------------------------
 * int32_t arm_funcion(int32_t param1, int32_t param2)
 *
 * @param[in] R0: param1 (Primer número)
 * @param[in] R1: param2 (Segundo número)
 *
 * @return R0: Valor de retorno (32 bits)
 */

arm_funcion:
    /* === Prólogo === */
    /* Guardamos LR (Link Register) porque es donde está la dirección de retorno.
     * Si usamos registros callee-saved (R4-R11), los incluimos en el PUSH. */
    push    {r4, lr}        

    /* === Cuerpo === */
    /* TODO: Implementar la lógica del ejercicio.
     * Ejemplo: devolver la suma de param1 (r0) + param2 (r1)
     */
    
    /* Nota: r0 ya contiene param1 y r1 contiene param2. 
     * No hace falta leer de la pila como en x86-32. */
    
    add     r0, r0, r1      /* r0 = r0 + r1 */

    /* El valor de retorno debe quedar en R0. */

    /* === Epílogo === */
    /* Restauramos los registros guardados. 
     * Al restaurar LR directamente sobre el PC (Program Counter), la función retorna. */
    pop     {r4, pc}        

    .size arm_funcion, .-arm_funcion
    .end