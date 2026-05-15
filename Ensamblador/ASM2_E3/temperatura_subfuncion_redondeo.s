; =================================================================================================
; @file  temperatura_subfuncion_redondeo.s
; @brief Convierte temperaturas entre Celsius y Fahrenheit con redondeo mediante subfunción.
;
; @author  Alejandro Lara Doña [alejandro.lara@gm.uca.es]
; @date    2026
; @version v1.0
; =================================================================================================
    AREA    |.text|, CODE, READONLY
    ALIGN   4
    THUMB
    EXPORT  temperatura_subf

; -------------------------------------------------------------------------------------------------
; uint32_t temperatura(uint32_t temp, char C_o_F);
;
; @brief Convierte temperatura de Celsius a Fahrenheit (C_o_F=0) o viceversa (C_o_F!=0).
;        Utiliza una subfunción local para aplicar redondeo.
;
; @note Usa multiplicación y división entera. El redondeo se delega a la subfunción redondeo().
;
; CONVENCIÓN DE LLAMADA (AAPCS):
; - Entradas: r0 = temperatura, r1 = C_o_F (0 = C->F, !=0 = F->C)
; - Salida:   r0 = temperatura convertida y redondeada
; - Registros Callee-saved (preservar): r4, r5, lr
; - Registros Caller-saved (libres):    r0 a r3, r12

; === Alias de Registros (RN) ===
TEMP_ENTRADA    RN  r0  ; Parámetro de entrada: temperatura
TIPO_CONVERSION RN  r1  ; Parámetro de entrada: tipo (0=C->F, otro=F->C)
MULTIPLICADOR   RN  r2  ; Registro temporal: numerador de conversión
DIVISOR         RN  r3  ; Registro temporal: denominador de conversión
RESULTADO       RN  r4  ; Registro temporal (callee-saved): resultados intermedios
RESTO           RN  r4  ; Reasignable (callee-saved): resto de la división
COCIENTE        RN  r5  ; Registro temporal (callee-saved): cociente de la división

temperatura_subf PROC
    ; === PRÓLOGO ===
    push    {r4, r5, lr}    ; Guarda r4, r5, lr

    ; === CUERPO DE LA FUNCIÓN ===
    cmp TIPO_CONVERSION, #0 ; ¿C->F (0) o F->C (otro)?
    bne F_a_C               ; Si no es 0, es F->C

; Etiqueta para Celsius a Fahrenheit (no es necesaria, pero mejora la legibilidad)
C_a_F
    ; --- Conversión de Celsius a Fahrenheit: F = (C · 9/5) + 32 ---
    mov MULTIPLICADOR,  #9  ; Numerador (para F/C)
    mov DIVISOR,        #5  ; Denominador

    mul     RESULTADO, TEMP_ENTRADA, MULTIPLICADOR  ; resultado = temp · 9
    sdiv    COCIENTE, RESULTADO, DIVISOR            ; cociente = resultado / 5
    bl      redondeo                                ; Llama a redondeo (r0 = resultado redondeado)

    add r0, COCIENTE, #32   ; resultado final = cociente + 32
    b   fin                 ; Salto a fin

F_a_C
    ; --- Conversión de Fahrenheit a Celsius: C = (F - 32) · 5/9 ---
    mov MULTIPLICADOR,  #5  ; Numerador (para F/C)
    mov DIVISOR,        #9  ; Denominador

    sub     RESULTADO, TEMP_ENTRADA, #32        ; resultado = temp - 32
    mul     RESULTADO, RESULTADO, MULTIPLICADOR ; resultado = resultado · 5
    sdiv    COCIENTE, RESULTADO, DIVISOR        ; cociente = resultado / 9
    bl      redondeo                            ; Llama a redondeo (r0 = resultado redondeado)

fin
    ; === EPÍLOGO ===
    pop {r4, r5, lr}    ; Restaura r4, r5, lr
    bx  lr              ; Retorna al llamador

    ENDP    ; Fin de temperatura_subf

; -------------------------------------------------------------------------------------------------
; (Subfunción local) Redondeo al entero más cercano.
;
; @brief Redondea un cociente de división entera aplicando la regla "round half up":
;        si 2·resto >= divisor, devuelve cociente+1; si no, devuelve cociente.
;
; CONVENCIÓN LOCAL (siguen aplicandose los ALIAS de registros de temperatura_subf):
; - Entradas: r0 = dividendo, r3 = divisor, r5 = cociente
; - Salida:   r0 = cociente redondeado
; - Registros modificados: r0

redondeo PROC
    mls     RESTO, COCIENTE, DIVISOR, RESULTADO ; resto = dividendo - cociente · divisor
    cmp     DIVISOR, RESTO, LSL #1              ; Compara divisor con 2·resto
    addle   r0, COCIENTE, #1                    ; Si divisor <= 2·resto, cociente+1
    movgt   r0, COCIENTE                        ; Si no, devuelve cociente

    bx  lr  ; Retorna (r0 contiene el cociente redondeado)

    ENDP    ; Fin de redondeo
    END     ; Fin del archivo
