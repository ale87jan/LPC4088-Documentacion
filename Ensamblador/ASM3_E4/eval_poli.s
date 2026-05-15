; =================================================================================================
; @file  eval_poli.s
; @brief Evalúa un polinomio usando el método de Horner para máxima eficiencia.
;
; @author  Alejandro Lara Doña [alejandro.lara@gm.uca.es]
; @date    2026
; @version v1.0
; =================================================================================================
    AREA    |.text|, CODE, READONLY
    ALIGN   4
    THUMB
    EXPORT  eval_poli

; -------------------------------------------------------------------------------------------------
; int32_t eval_poli(int32_t x, int32_t *ptr_coeficientes, uint32_t grado);
;
; @brief Evalúa P(x) = a0 + a1·x + a2·x^2 + ... + a_n·x^n usando el algoritmo de Horner:
;        P(x) = (...((a_n·x + a_(n-1))·x + a_(n-2))·x + ... + a1)·x + a0
;
; @note El método de Horner es mucho más eficiente que calcular potencias explícitas,
; ya que usa solo (n) multiplicaciones en lugar de (n + n(n+1)/2) operaciones.
;
; CONVENCIÓN DE LLAMADA (AAPCS):
; - Entradas: r0 = x, r1 = puntero a array de coeficientes (de mayor a menor grado),
;             r2 = grado del polinomio
; - Salida:   r0 = P(x)
; - Registros Callee-saved (preservar): r4
; - Registros Caller-saved (libres):    r0 a r3, r12

; === Alias de Registros (RN) ===
VAR_X           RN  r0  ; Parámetro de entrada: variable x
PTR_COEF        RN  r1  ; Parámetro de entrada: puntero a coeficientes
GRADO           RN  r2  ; Parámetro de entrada: grado del polinomio
ACUMULADOR      RN  r3  ; Registro temporal: acumulador de Horner
COEF_ACTUAL     RN  r4  ; Callee-saved: coeficiente actual leído

eval_poli PROC
    ; === PRÓLOGO ===
    push    {r4}    ; Guarda r4

    ; === CUERPO DE LA FUNCIÓN ===
    ; Carga coeficiente inicial (a0) como valor de inicio del acumulador
    ldr     ACUMULADOR, [PTR_COEF], #4 ; ACUMULADOR = coef[0] = coef. a_n

bucle
    ; Bucle de Horner: procesa cada coeficiente posterior
    ldr     COEF_ACTUAL, [PTR_COEF], #4                 ; Carga siguiente coeficiente
    mla     ACUMULADOR, ACUMULADOR, VAR_X, COEF_ACTUAL  ; MLA: acum = acum·x + coef_actual

    subs    GRADO, GRADO, #1    ; Decrementa grado, afecta flags
    bne     bucle               ; Si grado > 0, repite

    ; === EPÍLOGO ===
    mov r0, ACUMULADOR   ; r0 = ACUMULADOR para retorno (AAPCS)

    pop {r4}    ; Restaura r4
    bx  lr      ; Retorna al llamador

    ENDP
    END
