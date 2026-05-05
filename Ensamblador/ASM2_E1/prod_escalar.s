;=================================================================================
; Fichero: prod_escalar.s
; Función de C:
; uint32_t prod_escalar (uint32_t *vector1, uint32_t *vector2, uint32_t dim)
;  r0           r0            r1        r2
; ==== Código de la función ======================================================
        THUMB
        AREA    |.text|, CODE, READONLY
        ALIGN   2
        EXPORT  prod_escalar
;=================================================================================
;Función ensamblador: prod_escalar
;Utilidad: Producto escalar de dos vectores
;Entrada: r0: puntero a vector 1
;     r1: puntero a vector 2
;     r2: dimension de los vectores
;Salida:  r0: resultado
;Modifica: r4,r5

prod_escalar PROC
  push  {r4,r5}
  mov   r3, #0
bucle_producto
  ldr   r4, [r0], #4
  ldr   r5, [r1], #4
  mla   r3, r4, r5, r3    ; Sin usar mla sería:
              ; mul   r4, r4, r5
              ; add r3, r3, r4
              ; mla realmente hace ese proceso de una sola vez
              ; r3=r4*r5+r3
  subs  r2, r2, #1
  bne   bucle_producto
  mov   r0, r3
  pop   {r4,r5}
  bx    lr
  ENDP
  END
