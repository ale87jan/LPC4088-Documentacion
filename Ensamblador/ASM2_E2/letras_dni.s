; =================================================================================================
; @file  letras_dni.s
; @brief Calcula la letra de validación del DNI español usando la tabla legal de 23 letras.
;
; @author  Alejandro Lara Doña [alejandro.lara@gm.uca.es]
; @date    2026
; @version v1.0
; =================================================================================================

; === Definición de Constantes (EQU) ===
DIVISOR EQU 23  ; Divisor del DNI (23 letras válidas de 0 a 22)

; === Sección de Datos (Read-Only) ===
; Tabla de correspondencia: posición 0-22 = letra. Orden oficial del DNI español.
; Códigos ASCII: T=0x54, R=0x52, W=0x57, A=0x41, G=0x47, M=0x4D, Y=0x59, F=0x46,
;                P=0x50, D=0x44, X=0x58, B=0x42, N=0x4E, J=0x4A, Z=0x5A, S=0x53,
;                Q=0x51, V=0x56, H=0x48, L=0x4C, C=0x43, K=0x4B, E=0x45
    AREA    DATOS, DATA, READONLY
    ALIGN   4
    EXPORT  TABLA_LETRAS

TABLA_LETRAS
    ; DCB 0x54, 0x52, ... sería equivalente pero es menos legible que usar caracteres literales.
    DCB 'T', 'R', 'W', 'A', 'G', 'M', 'Y', 'F', 'P', 'D', 'X'
    DCB 'B', 'N', 'J', 'Z', 'S', 'Q', 'V', 'H', 'L', 'C', 'K', 'E'

; === Configuración de la sección de código ===
    AREA    |.text|, CODE, READONLY
    ALIGN   4
    THUMB
    EXPORT  letra_dni

; -------------------------------------------------------------------------------------------------
; char letra_dni(uint32_t dni);
;
; @brief Obtiene la letra de control del DNI calculando dni % 23 e indexando en la tabla.
;
; @note Los números de DNI válidos tienen rango [0, 99999999]. El algoritmo no valida este rango.
; La tabla es ordenada según la normativa oficial española.
;
; CONVENCIÓN DE LLAMADA (AAPCS):
;
; - Entradas: r0 = número DNI
; - Salida:   r0 = letra de validación (carácter ASCII)
; - Registros Callee-saved (preservar): ninguno usado
; - Registros Caller-saved (libres):    r0 a r3 (modificados)

; === Alias de Registros (RN) ===
NUMERO_DNI      RN  r0  ; Parámetro de entrada: número de DNI
PTR_TABLA       RN  r1  ; Registro temporal: puntero a tabla de letras
DIVISOR_REG     RN  r2  ; Registro temporal: divisor (23)
COCIENTE        RN  r3  ; Registro temporal: cociente para cálculo del resto
RESTO           RN  r3  ; Reasignable: resto (índice en tabla)

letra_dni PROC
    ; === CUERPO DE LA FUNCIÓN (sin prólogo/epílogo: no usa callee-saved) ===

    ldr     PTR_TABLA, =TABLA_LETRAS    ; Carga dirección base de la tabla
    mov     DIVISOR_REG, #DIVISOR       ; DIVISOR_REG = r2 = 23

    ; Calcula DNI % 23: método = DNI - (DNI / 23) · 23
    udiv    COCIENTE, NUMERO_DNI, DIVISOR_REG  ; COCIENTE = DNI / 23
    mls     RESTO, COCIENTE, DIVISOR_REG, NUMERO_DNI ; RESTO = DNI - (COCIENTE · 23)
    ; MLS (Multiply-Subtract) es más eficiente que hacer la multiplicación y resta por separado

    ; Indexa en la tabla y obtiene la letra
    add     PTR_TABLA, PTR_TABLA, RESTO ; Dirección tabla + resto = TABLA_LETRAS[resto]
    ldrb    r0, [PTR_TABLA]             ; Carga el carácter ASCII correspondiente en r0

    bx  lr  ; Retorna al llamador (r0 contiene la letra)

    ENDP
    END
