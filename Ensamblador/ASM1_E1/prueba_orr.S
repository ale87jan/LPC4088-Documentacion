; =================================================================================================
; @file  prueba_orr.s
; @brief Demuestra el funcionamiento de la operación lógica ORR (bitwise OR) con una máscara.
;
; @author  Alejandro Lara Doña [alejandro.lara@gm.uca.es]
; @date    2026
; @version v1.0
; =================================================================================================

; === Sección de Datos (Read-Only) ===
; Máscara binaria para demostración de ORR: 0b10010001 = 0x91 = (1<<7) | (1<<4) | (1<<0)
; Se exporta para que sea visible en depurador y en tests de C.
    AREA    CONSTANTES, DATA, READONLY
    ALIGN   4
    EXPORT  mascara

mascara DCD 2_10010001              ; Máscara: bits 7, 4, 0 activos

; === Configuración de la sección de código ===
    AREA    |.text|, CODE, READONLY
    ALIGN   4
    THUMB
    EXPORT  prueba_orr

; -------------------------------------------------------------------------------------------------
; uint32_t prueba_orr(uint32_t dato);
;
; @brief Realiza operación ORR (bitwise OR) entre un dato y una máscara constante.
;        Demuestra cómo los bits activados en la máscara se propagan al resultado.
;
; @note La instrucción ORR es fundamental para activar bits sin afectar los demás.
;       Útil en programación de periféricos: mascara |= bits_a_activar.
;
; CONVENCIÓN DE LLAMADA (AAPCS):
;
; - Entradas: r0 = dato
; - Salida:   r0 = dato ORR máscara
; - Registros Callee-saved (preservar): ninguno usado
; - Registros Caller-saved (libres):    r0 a r3 (modificados)

; === Alias de Registros (RN) ===
DATO_ENTRADA    RN  r0  ; Parámetro de entrada: valor a procesar
PTR_MASCARA     RN  r1  ; Registro temporal: puntero a máscara
MASCARA_VALOR   RN  r1  ; Reasignable: valor de la máscara
RESULTADO       RN  r2  ; Registro temporal: dato ORR máscara

prueba_orr PROC
    ldr  PTR_MASCARA, =mascara
    ldr  MASCARA_VALOR, [PTR_MASCARA]           ; Máscara en MASCARA_VALOR

    orr  RESULTADO, DATO_ENTRADA, MASCARA_VALOR ; Operación lógica OR entre dato y mascara,
                                                ; almacenando el resultado en RESULTADO

    mov  r0, RESULTADO  ; Se almacena el valor de RESULTADO en r0, para el retorno

    bx   lr ; Retorno al llamador

    ENDP
    END
