;=================================================================================
; Fichero: temperatura.s
; Función de C:
; uint32_t temperatura (uint32_t temp, char C_o_F)
;  r0           r0         r1
; ==== Código de la función =================================================
        THUMB
        AREA    |.text|, CODE, READONLY
        ALIGN   2
        EXPORT  temperatura
;============================================================================
;Función ensamblador: temperatura
;Utilidad: convierte un valor de temperatura de ºC a ºF o viceversa
;Entrada: r0: numero de dni
;     r1; grado origen
;Salida:  r0: valor convertido
;Modifica: r4,r5
;============================================================================
temperatura   PROC
    cmp   r1,#0
    bne   F_C

    ; conversion de ºC a ºF
    mov   r2,#5
    mov   r3,#9
    mul   r0,r0,r3  ;r0=r0*r3=temp*9
    sdiv  r3,r0,r2  ;r4=r0/r2=r0/5

    ;fase de redondedo
    mls   r0,r2,r3,r0 ;resto=dividendo-cociente*divisor
    lsl   r0,r0,#1  ;r0=r0<<1=r0*2
    cmp   r0,r2   ;comparar 2*resto y divisor
    addgt r3,r3,#1  ;si 2*resto>divisor, redondeo hacia arriba

    add   r0,r3,#32 ;r0=r0+32
    b   fin

    ; conversion de ºF a ºC
F_C   mov   r2,#9
    mov   r3,#5
    sub   r0,r0,#32 ; r0=r0-32=temp-32
    mul   r0,r0,r3  ; r0=r0*r3=r0*5
    sdiv  r3,r0,r2  ; r3=r0/r2=r0/9

    ;fase de redondedo
    mls   r0,r2,r3,r0 ;resto=dividendo-cociente*divisor
    lsl   r0,r0,#1  ;r0=r0<<1=r0*2
    cmp   r0,r2   ;comparar 2*resto y divisor
    addgt r3,r3,#1  ;si 2*resto>divisor, redondeo cociente hacia arriba
    mov   r0,r3

fin   bx    lr
    ENDP
    END