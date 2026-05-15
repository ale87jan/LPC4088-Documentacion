; =================================================================================================
; @file  prod_add.s
; @brief Calcula productos: dato·2, dato·3, dato·9, dato·17 usando solo instrucciones ADD y LSL.
;
; @author  Alejandro Lara Doña [alejandro.lara@gm.uca.es]
; @date    2026
; @version v1.0
; =================================================================================================
    AREA    |.text|, CODE, READONLY
    ALIGN   4
    THUMB
    EXPORT  prod_add

; -------------------------------------------------------------------------------------------------
; void prod_add(uint32_t dato, uint32_t *ptr_array);
;
; @brief Calcula productos de un dato (·2, ·3, ·9, ·17) y los almacena en un array.
;
; @note Demuestra técnicas de desplazamiento lógico (LSL) y suma para multiplicación sin MUL.
;
; CONVENCIÓN DE LLAMADA (AAPCS):
;
; - Entradas: r0 = dato, r1 = puntero al array (4 words)
; - Salida:   ninguna (void)
; - Registros Callee-saved (preservar): ninguno usado
; - Registros Caller-saved (libres):    r0 a r3 (modificados)

; === Alias de Registros (RN) ===
DATO            RN  r0  ; Parámetro de entrada: valor a multiplicar
PTR_ARRAY       RN  r1  ; Parámetro de entrada: puntero al array destino
TEMPORAL        RN  r2  ; Registro temporal para productos

prod_add PROC
    ; === CUERPO DE LA FUNCIÓN (sin prólogo/epílogo: no usa callee-saved) ===

    ; Producto por 2: dato · 2 = dato + dato
    lsl TEMPORAL, DATO, #1          ; TEMPORAL = r2 = dato << 1 (dato · 2)
    str TEMPORAL, [PTR_ARRAY], #4   ; Almacena en array[0]

    ; Producto por 3: dato · 3 = dato + dato · 2 = dato + (dato << 1)
    add TEMPORAL, DATO, DATO, lsl #1    ; TEMPORAL = dato + (dato << 1) = dato · 3
    str TEMPORAL, [PTR_ARRAY], #4       ; Almacena en array[1]

    ; Producto por 9: dato · 9 = dato + dato · 8 = dato + (dato << 3)
    add TEMPORAL, DATO, DATO, lsl #3    ; TEMPORAL = dato + (dato << 3) = dato · 9
    str TEMPORAL, [PTR_ARRAY], #4       ; Almacena en array[2]

    ; Producto por 17: dato · 17 = dato + dato · 16 = dato + (dato << 4)
    add TEMPORAL, DATO, DATO, lsl #4    ; TEMPORAL = dato + (dato << 4) = dato · 17
    str TEMPORAL, [PTR_ARRAY], #4       ; Almacena en array[3]

    bx  lr  ; Retorna al llamador sin modificar r0 (función void)

    ENDP
    END
