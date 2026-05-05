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
    push  {r4,r5,lr}
    mov   r2,#5
    mov   r3,#9

    cmp   r1,#0
    bne   F_C

    ; conversion de ºC a ºF
    mul   r0,r0,r3  ;r0=r0*r3=temp*9
    sdiv  r4,r0,r2  ;r4=r0/r2=r0/5
    bl    redondeo
    add   r0,r0,#32 ;r0=r4+32
    b   fin

    ; conversion de ºF a ºC
F_C   sub   r0,r0,#32 ; r0=r0-32=temp-32
    mul   r0,r0,r2  ; r0=r0*r2=r0*9
    mov   r2,#9
    sdiv  r4,r0,r2
    bl      redondeo

fin   pop   {r4,r5,lr}
    bx    lr
    ENDP

;Entrada: r0,r2,r4
;Salida: r0
redondeo PROC
    mls   r0,r4,r2,r0 ;resto=dividendo-cociente*divisor
    lsl   r0,#1   ;multip. x 2
    cmp   r0,r2
    addge   r0,r4,#1  ;si 2*resto > divisor, r0=cociente+1
    movlt r0,r4   ;r0=cociente
    bx    lr
    ENDP
    END
