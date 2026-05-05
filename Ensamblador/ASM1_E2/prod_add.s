;=================================================================================
; Fichero: prod_add.s
; Función de C:
; void prod_add (uint32_t dato, uint32_t *array)
;             r0      r1
; ==== Código de la función ======================================================
        THUMB
        AREA    |.text|, CODE, READONLY
        ALIGN   2
        EXPORT  prod_add
;=================================================================================
;Función ensamblador: prod_add
;Utilidad: obtener el producto de un dato por_2, por_3, por_9, por_17 solo con add
;Entrada: r0: dato
;         r1: puntero para almacenar resultados
;Salida:  ninguna
;Modifica: -
prod_add PROC
    add  r2,r0,r0     ; Sumar R0 y R0 (por_2)
    str  r2,[r1],#4   ; Se almacena el valor de R3 en el primer
              ; elemento del array
    lsl  r3,r0,#1   ; Se desplaza lógicamente a la izquierda el
              ; valor de R0 una posición
    add  r2,r0,r3   ; Sumar R0 y R4 (por_3)
    str  r2,[r1],#4   ; Se almacena el valor de R3 en el segundo elemento
              ; del array
    lsl  r3,r0,#3   ; Se desplaza lógicamente a la izquierda el
              ; valor de R0 tres posiciones
    add  r2,r0,r3       ; Sumar R0 y R4 (por_9)
    str  r2,[r1],#4   ; Se almacena el valor de R3 en el tercer elemento
              ; del array
    lsl  r3,r0,#4   ; Se desplaza lógicamente a la izquierda el
              ; valor de R0 cuatro posiciones.
    add  r2,r0,r3       ; Sumar R0 y R4 (por_17)
    str  r2,[r1]    ; Se almacena el valor de R3 en el cuarto elemento
              ; del array
        bx   lr           ; Retorno
        ENDP
        END
