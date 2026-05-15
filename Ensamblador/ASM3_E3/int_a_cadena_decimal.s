; =================================================================================================
; @file  int_a_cadena_decimal.s
; @brief Convierte un entero con signo a su representación decimal en una cadena.
;
; @author  Alejandro Lara Doña [alejandro.lara@gm.uca.es]
; @date    2026
; @version v1.0
; =================================================================================================
    AREA    |.text|, CODE, READONLY
    ALIGN   4
    THUMB
    EXPORT  int_a_cadena_decimal

; -------------------------------------------------------------------------------------------------
; bool_t int_a_cadena_decimal(int32_t dato, char *ptr_buffer);
;
; @brief Convierte un entero a cadena decimal con signo ('+-' seguido de los dígitos).
; Retorna true si el ptr_buffer no es nulo, false si lo es.
;
; @note Utiliza SDIV y MLS para extraer dígitos, y escribe al revés en el buffer (de atrás hacia
; adelante), excepto el signo que siempre va al inicio.
;
; CONVENCIÓN DE LLAMADA (AAPCS):
; - Entradas: r0 = valor entero, r1 = puntero al buffer destino (mínimo 12 bytes)
; - Salida:   r0 = 1 (true, buffer válido) o 0 (false, buffer nulo)
; - Registros Callee-saved (preservar): r4
; - Registros Caller-saved (libres):    r0 a r3, r12

; === Alias de Registros (RN) ===
VALOR_ENTRADA   RN  r0  ; Parámetro de entrada: número a convertir
PTR_BUFFER      RN  r1  ; Parámetro de entrada: puntero al buffer destino
SIGNO           RN  r2  ; Registro temporal: '+' o '-'
DIVISOR         RN  r2  ; Reasignable: divisor para extracción de dígitos (10)
COCIENTE        RN  r3  ; Registro temporal: cociente de division (dígito)
DIGITO_ASCII    RN  r4  ; Callee-saved: dígito + '0' para almacenar

int_a_cadena_decimal PROC
    ; === PRÓLOGO ===
    push    {r4}    ; Guarda r4

    ; === CUERPO DE LA FUNCIÓN ===
    ; Validación del puntero al buffer
    cmp     PTR_BUFFER, #0  ; ¿Buffer nulo?
    bne     sigue           ; Si no, continúa
    mov     r0, #0          ; Si es nulo, retorna 0 (false)
    b       fin

sigue
    cmp     VALOR_ENTRADA, #0               ; ¿Número negativo, cero o positivo?
    movpl   SIGNO, #'+'                     ; Si positivo o cero, signo = '+'
    movmi   SIGNO, #'-'                     ; Si negativo, signo = '-'
    negmi   VALOR_ENTRADA, VALOR_ENTRADA    ; Si negativo: valor = -valor (lo vuelve positivo)

    strb    SIGNO, [PTR_BUFFER]             ; Almacena el signo al inicio del buffer
    add     PTR_BUFFER, PTR_BUFFER, #10     ; Posiciona puntero al final (pos 10)

    ; Extracción de dígitos
    mov     DIVISOR, #10    ; Divisor = 10

bucle
    sdiv    COCIENTE, VALOR_ENTRADA, DIVISOR                ; Cociente = valor / divisor (10)
    mls     DIGITO_ASCII, COCIENTE, DIVISOR, VALOR_ENTRADA  ; Resto = valor - cociente · divisor

    mov     VALOR_ENTRADA, COCIENTE             ; Actualiza valor para la próxima iteración
    add     DIGITO_ASCII, DIGITO_ASCII, #'0'    ; Convierte resto a carácter ASCII
    strb    DIGITO_ASCII, [PTR_BUFFER], #-1     ; Almacena dígito y retrocede puntero
    cmp     COCIENTE, #10                       ; ¿Cociente < 10? (último dígito)
    bhs     bucle                               ; Si cociente >= 10, repite

    ; Almacena el dígito más significativo
    add     DIGITO_ASCII, COCIENTE, #'0'    ; Convierte último cociente a ASCII
    strb    DIGITO_ASCII, [PTR_BUFFER]      ; Almacena el dígito más significativo

    mov     VALOR_ENTRADA, #1   ; Retorno: 1 (true)

fin
    ; === EPÍLOGO ===
    pop {r4}    ; Restaura r4
    bx  lr      ; Retorna al llamador

    ENDP
    END
