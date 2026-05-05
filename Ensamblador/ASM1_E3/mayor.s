;=================================================================================
; Fichero: mayor.s
; Función de C:
; uint32_t mayor (uint32_t *tabla, uint8_t n_elem)
;  r0           r0          r1
; ==== Código de la función ======================================================
        THUMB
        AREA    |.text|, CODE, READONLY
        ALIGN   2
        EXPORT  mayor
;=================================================================================
;Función ensamblador: mayor
;Utilidad: Obtener el mayor elemento de una tabla de words sin signo
;Entrada: r0: tabla
;         r1: numero de elementos
;Salida:  r0: resultado
;Modifica: -
mayor   PROC
    ldrh  r2,[r0],#2  ; primer elemento de la tabla
    sub   r1,r1,#1  ; n_elem-1

bucle ldrh  r3,[r0],#2  ; siguiente elemento de la tabla
    cmp   r3,r2   ; r2 donde estará el mayor elemento de la tabla
    movhi r2,r3   ; equivale a ... if(r2<r3) r2=r3;
    subs  r1,r1,#1  ; si no pone s no afecta a los indicadores
        bne   bucle

    mov   r0,r2     ; se almacena el valor de r2 en r0, para el retorno
        bx    lr          ; Retorno
        ENDP
        END

