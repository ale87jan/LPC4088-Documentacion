;===============================================================================
; \file     concatenar_cadenas.s
        THUMB
        AREA    |.text|, CODE, READONLY
        ALIGN   2
        EXPORT  concatenar_cadenas

;===============================================================================
; uint32_t concatenar_cadenas(char *cadena_1, char *cadena_2, char *buffer_destino);
;    r0               r0        r1        r2
; Entrada: R0: cadena_1
;        R1: cadena_2
;      R2: buffer_destino
; Retornar: R0: longitud de la cadena concatenada
; Modifica: r4

concatenar_cadenas PROC
    push  {r4}    ;se reserva r4
        mov   r3,#0     ;contador de caracteres a 0
primera ldrb  r4,[r0],#1
    cmp   r4,#0
    beq   segunda   ;En caso de ser igual salto a la segunda cadena
    strb  r4,[r2],#1  ;almacena el caracter r4 donde dice el puntero r2
    add   r3,r3,#1  ;incrementa contador caracteres
    b   primera

segunda ldrb  r4,[r1],#1
    cmp   r4,#0
    beq   final
    strb  r4,[r2],#1
    add   r3,r3,#1
    b   segunda

final   strb  r4,[r2]   ;guardamos el 0 para final de cadena
    mov   r0,r3
    pop   {r4}    ;se recupera valor de r4
    bx    lr
        ENDP
        END