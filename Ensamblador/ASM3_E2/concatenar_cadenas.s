; =================================================================================================
; @file  concatenar_cadenas.s
; @brief Concatena dos cadenas null-terminated en un buffer destino.
;
; @author  Alejandro Lara Doña [alejandro.lara@gm.uca.es]
; @date    2026
; @version v1.0
; =================================================================================================
    AREA    |.text|, CODE, READONLY
    ALIGN   4
    THUMB
    EXPORT  concatenar_cadenas

; -------------------------------------------------------------------------------------------------
; uint32_t concatenar_cadenas(char *ptr_cadena_1, char *ptr_cadena_2, char *ptr_buffer_destino);
;
; @brief Copia cadena_1 al buffer, luego cadena_2 y añade null-terminator. Devuelve longitud total.
;
; @note Procesa carácter a carácter, comparando con 0 para detectar fin de cadena.
;
; CONVENCIÓN DE LLAMADA (AAPCS):
;
; - Entradas: r0 = cadena_1, r1 = cadena_2, r2 = buffer_destino
; - Salida:   r0 = longitud de cadena concatenada (sin contar el '\0')
; - Registros Callee-saved (preservar): r4
; - Registros Caller-saved (libres):    r0 a r3, r12

; === Alias de Registros (RN) ===
PTR_CADENA1     RN  r0  ; Parámetro de entrada: puntero a cadena 1
PTR_CADENA2     RN  r1  ; Parámetro de entrada: puntero a cadena 2
PTR_BUFFER      RN  r2  ; Parámetro de entrada: puntero al buffer destino
CONTADOR        RN  r3  ; Registro temporal: contador de caracteres
CARACTER        RN  r4  ; Callee-saved: carácter actual leído/escrito

concatenar_cadenas PROC
    ; === PRÓLOGO ===
    push    {r4}    ; Guarda r4

    ; === CUERPO DE LA FUNCIÓN ===
    eor     CONTADOR, CONTADOR      ; Alternativa a mov para inicializar contador a 0

primera
    ; --- Bucle 1: copia cadena_1 hasta encontrar '\0' ---
    ldrb    CARACTER, [PTR_CADENA1], #1 ; Carga carácter de cadena_1
    cmp     CARACTER, #0                ; ¿Es fin de cadena?
    beq     segunda                     ; Si es, salta a cadena_2
    strb    CARACTER, [PTR_BUFFER], #1  ; Almacena carácter en el buffer destino
    add     CONTADOR, CONTADOR, #1      ; Incrementa contador
    b       primera                     ; Repite

segunda
    ; --- Bucle 2: copia cadena_2 hasta encontrar '\0' ---
    ldrb    CARACTER, [PTR_CADENA2], #1 ; Carga carácter de cadena_2
    cmp     CARACTER, #0                ; ¿Es fin de cadena?
    beq     final                       ; Si es, salta a final
    strb    CARACTER, [PTR_BUFFER], #1  ; Almacena carácter en el buffer destino
    add     CONTADOR, CONTADOR, #1      ; Incrementa contador
    b       segunda                     ; Repite


final
    ; --- Finalización: añade '\0' ---
    strb    CARACTER, [PTR_BUFFER]  ; Almacena '\0' (CARACTER = 0 del último cmp)
    mov     r0, CONTADOR            ; r0 = CONTADOR para retorno (AAPCS)

    ; === EPÍLOGO ===
    pop {r4}    ; Restaura r4
    bx  lr      ; Retorna al llamador

    ENDP
    END
