;=================================================================================
; Fichero: letra_dni.s
; Función de C:
; char letra_dni (uint32_t dni)
;  r0         r0
; ==== Area de datos ============================================================
DIVISOR EQU 23
  AREA  DATOS, DATA, READONLY
LETRAS_EN_ASCII
  DCB 0x54, 0x52, 0x57, 0x41, 0x47, 0x4D, 0x59, 0x46, 0x50, 0x44, 0x58
  DCB 0x42, 0x4E, 0x4A, 0x5A, 0x53, 0x51, 0x56, 0x48, 0x4C, 0x43, 0x4B, 0x45
  EXPORT  LETRAS_EN_ASCII
; ==== Código de la función ======================================================
        THUMB
        AREA    |.text|, CODE, READONLY
        ALIGN   2
        EXPORT  letra_dni
;=================================================================================
;Función ensamblador: letra_dni
;Utilidad: Obtiene la letra correspondiente al numero de dni
;Entrada: r0: numero de dni
;Salida:  r0: letra de dni
;Modifica: r4,r5

letra_dni PROC
    ldr   r1,=LETRAS_EN_ASCII
    mov   r3,#DIVISOR

    udiv  r2,r0,r3  ; cociente = dato/divisor
    mul   r2,r2,r3  ; cociente*divisor
    subs  r2,r0,r2  ; resto = dato-cociente*divisor
    add   r1,r1,r2  ; puntero = tabla+resto
    ldrb  r0,[r1]   ; letra de la tabla

    bx    lr
    ENDP
    END
