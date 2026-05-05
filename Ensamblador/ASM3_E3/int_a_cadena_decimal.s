;========================================================================
; \file     int_a_cadena_decimal.s
        THUMB
        AREA    |.text|, CODE, READONLY
        ALIGN   2
        EXPORT  int_a_cadena_decimal

;========================================================================
; bool_t int_a_cadena_decimal(int32_t dato, char *buffer);
; r0                r0        r1
int_a_cadena_decimal PROC
    push  {r4,r5}
    cmp   r1,#0 ;se comprueba si puntero es nulo
    bne   sigue
    mov   r0,#0
    b   fin

sigue mov   r2,#'+'   ;poner signo
    mov   r3,#'-'

    cmp   r0,#0
    strbpl  r2,[r1]   ;si positivo o zero, coloco el signo + en el buffer
    strbmi  r3,[r1]   ;si negativo, coloco el signo - en el buffer
    negmi r0,r0   ;si negativo, r0=-r0, similar a r0=0-r0
    add   r1,#10    ;poner puntero cadena al final pos 10

;obtencion digitos
    mov   r4,#10    ;cargo a R4 el divisor
bucle sdiv  r3,r0,r4  ;cociente = dato/10
              ;      r3 =   r0/r4

    mls   r2,r3,r4,r0 ;resto = dato - cociente * 10
              ;   r2 =   r0 -       r3 * r4

    mov   r0,r3   ;actualiza dato (dividendo)
        add   r5,r2,#'0'  ;caracter del resto
    strb  r5,[r1],#-1 ;guarda resto
    cmp   r3,#10
    bhs   bucle   ;repite mientras cociente >= divisor

    add   r5,r3,#'0'
    strb  r5,[r1]   ;guarda cociente

    mov   r0,#1

fin   pop   {r4,r5}   ;recupero r4 y r5
    bx    lr
        ENDP
        END
