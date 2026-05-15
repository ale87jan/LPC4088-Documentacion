; =================================================================================================
; @file  prod_escalar.s
; @brief Calcula el producto escalar de dos vectores de dimensión arbitraria.
;
; @author  Alejandro Lara Doña [alejandro.lara@gm.uca.es]
; @date    2026
; @version v1.0
; =================================================================================================
    AREA    |.text|, CODE, READONLY
    ALIGN   4
    THUMB
    EXPORT  prod_escalar

; -------------------------------------------------------------------------------------------------
; uint32_t prod_escalar(uint32_t *ptr_vector1, uint32_t *ptr_vector2, uint32_t dim);
;
; @brief Calcula v1·v2 = SUM(v1[i] · v2[i]) usando la instrucción MLA para máxima eficiencia.
;
; @note La instrucción MLA (Multiply-Accumulate) combina multiplicación y suma en una sola
; operación, ganando tiempo respecto a usar MUL seguido de ADD por separado.
;
; CONVENCIÓN DE LLAMADA (AAPCS):
;
; - Entradas: r0 = vector1, r1 = vector2, r2 = dimensión
; - Salida:   r0 = producto escalar
; - Registros Callee-saved (preservar): r4, r5
; - Registros Caller-saved (libres):    r0 a r3, r12

; === Alias de Registros (RN) ===
PTR_V1          RN  r0  ; Parámetro de entrada: puntero vector 1
PTR_V2          RN  r1  ; Parámetro de entrada: puntero vector 2
DIM             RN  r2  ; Parámetro de entrada: dimensión de vectores
ACUMULADOR      RN  r3  ; Registro temporal: acumulador del producto escalar
ELEM_V1         RN  r4  ; Callee-saved: elemento actual de vector1
ELEM_V2         RN  r5  ; Callee-saved: elemento actual de vector2

prod_escalar PROC
    ; === PRÓLOGO ===
    push    {r4, r5}        ; Guarda r4, r5

    ; === CUERPO DE LA FUNCIÓN ===
    mov     ACUMULADOR, #0  ; Inicializa acumulador a 0

bucle_producto
    ; Bucle principal: por cada elemento del vector
    ldr     ELEM_V1, [PTR_V1], #4       ; Carga elemento de v1[i]
    ldr     ELEM_V2, [PTR_V2], #4       ; Carga elemento de v2[i]

    mla     ACUMULADOR, ELEM_V1, ELEM_V2, ACUMULADOR    ; MLA: acum = (v1[i] · v2[i]) + acum
    ; MLA lo hace en una instrucción => más eficiente
    ; Equivalente a:
    ; mul   ELEM_V1,    ELEM_V1,    ELEM_V2
    ; add   ACUMULADOR, ACUMULADOR, ELEM_V1

    subs    DIM, DIM, #1    ; Decrementa contador, afecta flags
    bne     bucle_producto  ; Si quedan elementos, repite

    ; === EPÍLOGO ===
    mov r0, ACUMULADOR  ; r0 = ACUMULADOR para retorno (AAPCS)

    pop {r4, r5}        ; Restaura r4, r5
    bx  lr              ; Retorna al llamador

    ENDP
    END
