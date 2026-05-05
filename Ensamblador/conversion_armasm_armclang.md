Aquí tienes la conversión de la lógica de `letras_dni.s` y la estructura de tu plantilla original a un formato **Markdown** limpio y profesional, ideal para que se lo entregues a tus alumnos como guía de referencia.

---

# Guía de Ensamblador ARM Cortex-M4 (armclang)

Esta guía presenta la estructura estándar para realizar funciones en ensamblador compatibles con **Cortex-M4**, migrando los conceptos desde x86-32 y el antiguo ensamblador `armasm`.

## 1. Plantilla Base de Función
A diferencia de x86, en ARM los parámetros no se buscan en la pila, sino que ya residen en los registros al iniciar la función.

```armasm
/* =================================================================================================
 * @file   ejercicio_dni.s
 * @brief  Cálculo de la letra del DNI para Cortex-M4
 * =================================================================================================
 */

@ === 1. Definiciones y Constantes ===
.equ DIVISOR, 23        @ Reemplaza al EQU de armasm o %define de NASM

@ === 2. Alias de Registros (Legibilidad) ===
DNI      .req r0        @ r0 es el primer parámetro de entrada
TABLA    .req r1        
RESTO    .req r2        
TEMP     .req r3        

@ === 3. Sección de Datos (Read-Only) ===
    .section .rodata, "a"
    .align 2
LETRAS_EN_ASCII:
    .byte 0x54, 0x52, 0x57, 0x41, 0x47, 0x4D, 0x59, 0x46, 0x50, 0x44, 0x58
    .byte 0x42, 0x4E, 0x4A, 0x5A, 0x53, 0x51, 0x56, 0x48, 0x4C, 0x43, 0x4B, 0x45

@ === 4. Sección de Código ===
    .section .text, "ax"
    .syntax unified     @ Sintaxis moderna unificada
    .thumb              @ Modo de ejecución para Cortex-M
    .align 2
    .global letra_dni
    .type letra_dni, %function

letra_dni:
    @ --- PRÓLOGO ---
    @ Salvaguardamos LR (Link Register) para poder retornar
    push    {lr}

    @ --- CUERPO ---
    @ Carga de dirección de memoria usando registros de 16 bits (evita errores de relocalización)
    movw    TABLA, #:lower16:LETRAS_EN_ASCII
    movt    TABLA, #:upper16:LETRAS_EN_ASCII
    mov     TEMP, #DIVISOR

    @ Cálculo: RESTO = DNI % 23
    udiv    RESTO, DNI, TEMP    @ cociente = dni / 23
    mul     RESTO, RESTO, TEMP  @ r2 = cociente * 23
    sub     RESTO, DNI, RESTO   @ resto = dni - (cociente * 23)

    @ Acceso a tabla: letra = TABLA[RESTO]
    ldrb    r0, [TABLA, RESTO]  @ Cargamos 1 byte. Resultado queda en r0 para retornar

    @ --- EPÍLOGO ---
    pop     {pc}                @ Retornamos cargando el LR guardado en el PC

    .align 2
    .ltorg                      @ Pool de literales (necesario para gestión de direcciones)
    .size letra_dni, .-letra_dni
    .end
```

---

## 2. Equivalencias Críticas (Cheat Sheet)

| Concepto | x86-32 (NASM) | ARM (armasm) | ARM (armclang) |
| :--- | :--- | :--- | :--- |
| **Comentarios** | `;` | `;` | `@` |
| **Paso de Parámetro 1** | `[ebp + 8]` | `r0` | `r0` |
| **Retorno de función** | `eax` | `r0` | `r0` |
| **Definir Constante** | `%define` | `EQU` | `.equ` |
| **Alias de Registro** | *No nativo* | `EQU` | `.req` |
| **Alineación (4 bytes)** | `align 4` | `ALIGN 4` | `.align 2` ($2^2=4$) |
| **Llamar Función** | `call` | `bl` | `bl` |
| **Retorno** | `ret` | `bx lr` | `pop {pc}` (si hubo push lr) |

---

## 3. Notas de Implementación para Alumnos

* **Identación**: Se recomienda usar **4 espacios** para separar etiquetas de instrucciones.
* **Registros Callee-saved**: Si se usan de `r4` a `r11`, deben incluirse en el `push` inicial y en el `pop` final para no corromper el programa principal.
* **Instrucciones de carga**: Dado que las instrucciones son de tamaño fijo, no se puede cargar una dirección de 32 bits directamente. Se debe usar el par `movw/movt` o la pseudoinstrucción `ldr rX, =etiqueta` (siempre que se use `.ltorg`).
* **Directivas finales**: `.size` y `.ltorg` son fundamentales para que el depurador funcione correctamente y el compilador no genere errores de rango de memoria.