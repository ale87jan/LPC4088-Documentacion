; =================================================================================================
; @file  temperatura.s
; @brief Convierte temperaturas entre Celsius y Fahrenheit con redondeo automático.
;
; @author  Alejandro Lara Doña [alejandro.lara@gm.uca.es]
; @date    2026
; @version v1.0
; =================================================================================================
    AREA    |.text|, CODE, READONLY
    ALIGN   4
    THUMB
    EXPORT  temperatura

; -------------------------------------------------------------------------------------------------
; uint32_t temperatura(uint32_t temp, char C_o_F);
;
; @brief Convierte temperatura de Celsius a Fahrenheit (C_o_F=0) o viceversa (C_o_F!=0).
;        Aplica redondeo al entero más cercano después de la división entera.
;
; @note Usa multiplicación y división entera con técnica de redondeo "round half up":
;       si 2·resto >= divisor, suma 1 al cociente.
;
; CONVENCIÓN DE LLAMADA (AAPCS):
; - Entradas: r0 = temperatura, r1 = C_o_F (0 = C->F, !=0 = F->C)
; - Salida:   r0 = temperatura convertida y redondeada
; - Registros Callee-saved (preservar): r4, r5
; - Registros Caller-saved (libres):    r0 a r3, r12

; === Alias de Registros (RN) ===
TEMP_ENTRADA    RN  r0  ; Parámetro de entrada: temperatura
TIPO_CONVERSION RN  r1  ; Parámetro de entrada: tipo (0=C->F, otro=F->C)
MULTIPLICADOR   RN  r2  ; Registro temporal: numerador de conversión
DIVISOR         RN  r3  ; Registro temporal: denominador de conversión
RESULTADO       RN  r4  ; Registro temporal (callee-saved): resultados intermedios
RESTO           RN  r4  ; Reasignable (callee-saved): resto de la división
COCIENTE        RN  r5  ; Registro temporal (callee-saved): cociente de la división

temperatura PROC
    ; === PRÓLOGO ===
    push    {r4, r5}    ; Guarda r4, r5

    ; === CUERPO DE LA FUNCIÓN ===
    cmp TIPO_CONVERSION, #0 ; Compara tipo de conversión (0=C->F, otro=F->C)
    bne F_a_C               ; Si no es 0, es F->C

; Etiqueta para Celsius a Fahrenheit (no es necesaria, pero mejora la legibilidad)
C_a_F
    ; --- Conversión de Celsius a Fahrenheit: F = (C · 9/5) + 32 ---
    mov MULTIPLICADOR,  #9  ; Numerador (para F/C)
    mov DIVISOR,        #5  ; Denominador

    mul     RESULTADO, TEMP_ENTRADA, MULTIPLICADOR  ; resultado = temp · 9
    sdiv    COCIENTE, RESULTADO, DIVISOR            ; cociente = resultado / 5

    ; Redondeo al entero más cercano
    mls     RESTO, DIVISOR, COCIENTE, RESULTADO ; resto = resultado - cociente · 5
    cmp     DIVISOR, RESTO, LSL #1              ; Compara divisor (5) con 2·resto
    addle   COCIENTE, COCIENTE, #1              ; Si divisor <= 2·resto, cociente+1

    add r0, COCIENTE, #32   ; r0 = cociente + 32
    b   fin                 ; Salto a fin

F_a_C
    ; --- Conversión de Fahrenheit a Celsius: C = (F - 32) · 5/9 ---
    mov MULTIPLICADOR,  #5  ; Numerador (para F/C)
    mov DIVISOR,        #9  ; Denominador

    sub     RESULTADO, TEMP_ENTRADA, #32        ; temp = temp - 32
    mul     RESULTADO, RESULTADO, MULTIPLICADOR ; temp = temp · 5
    sdiv    COCIENTE, RESULTADO, DIVISOR        ; cociente = temp / 9

    ; Redondeo al entero más cercano
    mls     RESTO, DIVISOR, COCIENTE, RESULTADO ; resto = resultado - cociente · 9
    cmp     DIVISOR, RESTO, LSL #1              ; Compara divisor (9) con 2·resto
    addle   COCIENTE, COCIENTE, #1              ; Si divisor <= 2·resto, cociente+1

    mov r0, COCIENTE    ; r0 = COCIENTE para retorno

fin
    ; === EPÍLOGO ===
    pop {r4, r5}    ; Restaura r4, r5
    bx  lr          ; Retorna al llamador

    ENDP
    END
