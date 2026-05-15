; =================================================================================================
; @file  det2x2.s
; @brief Calcula el determinante de una matriz 2x2.
;
; @author  Alejandro Lara Doña [alejandro.lara@gm.uca.es]
; @date    2026
; @version v1.0
; =================================================================================================
    AREA    |.text|, CODE, READONLY
    ALIGN   4
    THUMB
    EXPORT  det2x2

; -------------------------------------------------------------------------------------------------
; int32_t det2x2(int32_t a11, int32_t a12, int32_t a21, int32_t a22);
;
; @brief Calcula det = a11·a22 - a12·a21 usando dos multiplicaciones y una resta.
;
; @note La instrucción MLS (Multiply and Subtract) proporciona alternativa más eficiente:
; mls r0, r1, r2, r0 -> r0 = r0 - (r1 · r2). Aquí se usa la forma explícita (mul + sub) para
; claridad didáctica.
;
; CONVENCIÓN DE LLAMADA (AAPCS):
; - Entradas: r0 = a11, r1 = a12, r2 = a21, r3 = a22
; - Salida:   r0 = determinante
; - Registros Callee-saved (preservar): ninguno usado
; - Registros Caller-saved (libres):    r0 a r3 (modificados)

; === Alias de Registros (RN) ===
A11     RN  r0  ; Parámetro de entrada: elemento (1,1)
A12     RN  r1  ; Parámetro de entrada: elemento (1,2)
A21     RN  r2  ; Parámetro de entrada: elemento (2,1)
A22     RN  r3  ; Parámetro de entrada: elemento (2,2)

det2x2 PROC
    ; === CUERPO DE LA FUNCIÓN (sin prólogo/epílogo: no usa callee-saved) ===

    ; Calcula det = a11·a22 - a12·a21
    mul A11, A11, A22       ; A11 = a11 · a22
    mls A11, A12, A21, A11  ; A11 = A11 - (A12 · A21) -> det = a11·a22 - a12·a21
    ; Alternativa explícita (menos eficiente):
    ; mul     A12, A12, A21
    ; sub     A11, A11, A12

    bx  lr  ; Retorna al llamador (r0 contiene det)

    ENDP
    END
