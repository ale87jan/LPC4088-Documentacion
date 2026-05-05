;===============================================================================
; \file     eval_poli.s
        THUMB
        AREA    |.text|, CODE, READONLY
        ALIGN   2
        EXPORT  eval_poli

;===============================================================================
; int32_t eval_poli(int32_t x, int32_t *coeficientes, uint32_t grado);
; r0          r0        r1          r2
; Entrada: R0: x
;        R1: coeficientes
;      R2: grado
; Salida:  R0: resultado evaluación

eval_poli   PROC
    push  {r4}
    ldr   r3,[r1],#2_00000100
bucle ldr   r4,[r1],#4
    mla   r3,r3,r0,r4
    subs  r2,r2,#1
    bne   bucle
    mov   r0,r3
    pop   {r4}
    bx    lr
        ENDP
        END