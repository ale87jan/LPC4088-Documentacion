; =================================================================================================
; @file  mi_funcion.s
; @brief Ejemplo de función en ensamblador para ARM Cortex-M4. Utiliza constantes definidas con
; EQU, constantes almacenadas en la sección `READONLY`, alias de registros con RN y sigue la
; convención de llamada AAPCS.
;
; @author  Alejandro Lara - alejandro.lara@uca.es
; @date    2026
; @version v1.0
; =================================================================================================

; === Definiciones de Constantes (EQU) ===
MASCARA_BYTE2 EQU 0xFF0000 ; Máscara para el segundo byte más significativo de 32 bits

; === Sección de Datos (Read-Only) ===
    AREA    CONSTANTES, DATA, READONLY
    ALIGN   4
    EXPORT  MASCARA_BYTE0
    EXPORT  MASCARA_BYTE1
    EXPORT  MASCARA_BYTE3

MASCARA_BYTE0   DCB 0xFF        ; Constante de 8 bits (byte menos significativo de 32 bits)
MASCARA_BYTE1   DCW 0xFF00      ; Constante de 16 bits (segundo byte menos significativo)
MASCARA_BYTE3   DCD 0xFF000000  ; Constante de 32 bits (byte más significativo)

; === Configuración de la sección de código ===
    AREA    |.text|, CODE, READONLY
    ALIGN   4
    THUMB
    EXPORT  mi_funcion

; -------------------------------------------------------------------------------------------------
; uint32_t mi_funcion(uint32_t param1, uint32_t param2, uint32_t param3, uint32_t param4);
;
; @brief Devuelve un dato de 32 bits formado por la concatenación de:
; - El byte menos significativo de param1 (param1 & 0xFF)
; - El segundo byte menos significativo de param2 (param2 & 0xFF00)
; - El tercer byte menos significativo de param3 (param3 & 0xFF0000)
; - El byte más significativo de param4 (param4 & 0xFF000000)
;
; Datos de ejemplo para probar la función (en hexadecimal):
;
; - param1 = 0x11111111 -> Byte3 = 0x00000011
; - param2 = 0x22222222 -> Byte2 = 0x00002200
; - param3 = 0x33333333 -> Byte1 = 0x00330000
; - param4 = 0x44444444 -> Byte0 = 0x44000000
;
; Resultado esperado: 0x44332211

; === Alias de Registros (RN) ===
PARAM1  RN  r0  ; Registro que contiene el primer parámetro de la función
PARAM2  RN  r1  ; Registro que contiene el segundo parámetro
PARAM3  RN  r2  ; Registro que contiene el tercer parámetro
PARAM4  RN  r3  ; Registro que contiene el cuarto parámetro

mi_funcion PROC
    ; === PRÓLOGO ===
    ; Guardamos los registros callee-saved que vamos a usar (r4-r7) para preservar su valor
    push    {r4-r7}

    ; === CUERPO DE LA FUNCIÓN ===
    ldr     r6, =MASCARA_BYTE2  ; r6 = Valor de MASCARA_BYTE2 cargado directamente al ser una
                                ; constante definida con EQU

    ; El primer LDR carga la dirección de memoria donde se encuentra la constante.
    ; El segundo LDR carga el valor de la constante desde esa dirección.

    ldr     r4, =MASCARA_BYTE0  ; r4 = dirección de MASCARA_BYTE0
    ldrb    r4, [r4]            ; r4 = MASCARA_BYTE0 (0xFF) cargado como byte (LDRB)

    ldr     r5, =MASCARA_BYTE1  ; r5 = dirección de MASCARA_BYTE1
    ldrh    r5, [r5]            ; r5 = MASCARA_BYTE1 (0xFF00) cargado como halfword (LDRH)

    ldr     r7, =MASCARA_BYTE3  ; r7 = dirección de MASCARA_BYTE3
    ldr     r7, [r7]            ; r7 = MASCARA_BYTE3 (0xFF000000) cargado como word (LDR)

    ; Los parámetros ya están en los registros r0-r3, por lo aplicamos las máscaras directamente
    and     r0, PARAM1, r4  ; r0 = param1 & 0xFF. Equivalente a: and PARAM1, PARAM1, r4
    and     r1, PARAM2, r5  ; r1 = param2 & 0xFF00. Equivalente a: and PARAM2, PARAM2, r5
    and     r2, PARAM3, r6  ; r2 = param3 & 0xFF0000. Equivalente a: and PARAM3, PARAM3, r6
    and     r3, PARAM4, r7  ; r3 = param4 & 0xFF000000. Equivalente a: and PARAM4, PARAM4, r7

    ; Combinamos los bytes extraídos usando OR
    orr     r4, r0, r1  ; r4 = byte de param1 + byte de param2
    orr     r4, r4, r2  ; r4 = byte de param1 + byte de param2 + byte de param3
    orr     r0, r4, r3  ; r0 = byte de param1 + byte de param2 + byte de param3 + byte de param4

    ; === EPÍLOGO ===
    ; Restauramos los registros guardados
    pop {r4-r7}
    bx  lr

    ENDP    ; Fin de la función mi_funcion
    END     ; Fin del archivo de código fuente
