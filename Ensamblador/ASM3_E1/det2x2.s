;===============================================================================
; \file     det2x2.s
        THUMB
        AREA    |.text|, CODE, READONLY
        ALIGN   2
        EXPORT  det2x2
;===============================================================================
; int32_t det2x2(int32_t a11, int32_t a12, int32_t a21, int32_t a22);
;    r0         r0      r1      r2        r3
; Entrada:R0: a11
;       R1: a12
;     R2: a21
;     R3: a22
; Valor retornado: R0
; DET = a11*a22-a12*a21

det2x2  PROC
        mul r0,r0,r3  ;multiplicar r0=r0(a11)*r3(a22)
    mul r1,r1,r2  ;multiplicar r1=r1(a12)*r2(a21)
    sub r0,r0,r1  ;restar r0=r0-r1
            ;mls r0,r1,r2,r0 (r0<-r0-r1*r2)

    bx  lr      ;devuelve el control al programa en c. El resultado está en r0
        ENDP
        END
