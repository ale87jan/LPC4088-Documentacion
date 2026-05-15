; =================================================================================================
; @file  mayor.s
; @brief Encuentra el elemento máximo en una tabla de halfwords sin signo.
;
; @author  Alejandro Lara Doña [alejandro.lara@gm.uca.es]
; @date    2026
; @version v1.0
; =================================================================================================
    AREA    |.text|, CODE, READONLY
    ALIGN   4
    THUMB
    EXPORT  mayor

; -------------------------------------------------------------------------------------------------
; uint16_t mayor(uint16_t *ptr_tabla, uint8_t n_elem);
;
; @brief Itera sobre una tabla y devuelve el elemento de mayor valor.
;
; @note Utiliza la instrucción MOVHI (conditional move) para actualizar el máximo encontrado.
;
; CONVENCIÓN DE LLAMADA (AAPCS):
;
; - Entradas: r0 = puntero a tabla, r1 = número de elementos
; - Salida:   r0 = elemento máximo
; - Registros Callee-saved (preservar): ninguno usado
; - Registros Caller-saved (libres):    r0 a r3 (modificados)

; === Alias de Registros (RN) ===
PTR_TABLA           RN  r0  ; Parámetro de entrada: puntero a tabla
N_ELEM              RN  r1  ; Parámetro de entrada: número de elementos
MAXIMO              RN  r2  ; Registro que guarda el máximo encontrado
ELEMENTO_ACTUAL     RN  r3  ; Registro temporal: elemento actual leído

mayor PROC
    ; === CUERPO DE LA FUNCIÓN (sin prólogo/epílogo: no usa callee-saved) ===
    tst     N_ELEM, N_ELEM          ; Verifica que n_elem > 0
    beq     fin                     ; Si n_elem == 0, salta a fin
    tst     PTR_TABLA, PTR_TABLA    ; Verifica que ptr_tabla != NULL
    beq     fin                     ; Si ptr_tabla == NULL, salta a fin

    ; Carga el primer elemento y lo usa como máximo inicial
    ldrh    MAXIMO, [PTR_TABLA],    #2  ; MAXIMO = r2 = tabla[0]
    sub     N_ELEM, N_ELEM, #1          ; Decrementa contador (quedan n_elem-1 elementos)

bucle
    ; Bucle: compara cada elemento con el máximo y actualiza si es mayor
    ldrh    ELEMENTO_ACTUAL, [PTR_TABLA], #2  ; ELEMENTO_ACTUAL = r3 = siguiente elemento

    cmp     ELEMENTO_ACTUAL, MAXIMO           ; Compara elemento actual con máximo
    movhi   MAXIMO, ELEMENTO_ACTUAL           ; Si elemento > máximo, actualiza máximo

    subs    N_ELEM, N_ELEM, #1                ; Decrementa contador y afecta flags
    bne     bucle                             ; Si quedan elementos, repite

    mov r0, MAXIMO  ; r0 = MAXIMO para retorno (AAPCS)

    bx  lr  ; Retorna al llamador

    ENDP
    END
