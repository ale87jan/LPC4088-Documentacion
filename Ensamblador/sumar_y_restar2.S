;===================================================================================================
; @file   sumar_y_restar.S
; @brief  Implementación en ensamblador de una función que retorna la suma y resta de 2 números.
;
; @author  Alejandro Lara - alejandro.lara@uca.es
; @date    2026-05-05
; @version v1.0
;===================================================================================================

;---------------------------------------------------------------------------------------------------
; void sumar_y_restar(uint32_t dato1, uint32_t dato2, uint32_t *ptr_suma, uint32_t *ptr_resta)
;
; @param[in]  dato1     Primer número
; @param[in]  dato2     Segundo número
; @param[out] ptr_suma  Ptr. a la variable donde almacenar la suma de dato1 y dato2
; @param[out] ptr_resta Ptr. a la variable donde almacenar la resta de dato1 y dato2
;
; @warning Modifica R4

; ==== Código de la función ==========================================
  THUMB
  AREA    |.text|, CODE, READONLY
  ALIGN   2
  EXPORT  sumar_y_restar
;=====================================================================

sumar_y_restar PROC
  ; === Prólogo ===
  ; Preservar registros callee-saved que se vayan a usar (si aplica):
  push  {r4}        ; Almacena R4 en la pila para recuperarlo más tarde
  ; R4 - R8,Variables locales,Registros de propósito general para cómputo de larga duración.
  ; R9,Variable estática / Plataforma,A veces usado como puntero de base de datos (SB) en ciertos sistemas operativos.
  ; R10 - R11,Variables locales,Comúnmente usados para datos locales adicionales. R11 a veces actúa como Frame Pointer (FP).
  ; R13 (SP),Stack Pointer,Es técnicamente callee-saved; la función debe dejar el puntero de pila exactamente donde lo encontró.
  ; push  rbx
  ; push  rsi
  ; push  rdi
  ; push  r12
  ; push  r13
  ; push  r14
  ; push  r15

  ; === Cuerpo ===
  ; TODO: implementar la lógica del ejercicio.
  ; Ejemplo: devolver la suma de param1 + param2
  mov rax, PARAM1   ; rax ← param1
  add rax, PARAM2   ; rax ← param1 + param2

  ; El valor de retorno queda en RAX al llegar al epílogo.

  
  add   r4, r0, r1  ; Sumar valores R0 y R1 y guardar resultado en R4
  str   r4, [r2]    ; Almacena resultado en memoria
  sub   r4, r0, r1  ; Restar valores R0 y R1 y guardar resultado en R4
  str   r4, [r3]    ; Almacena resultado en memoria
  
  ; === Epílogo ===
  ; Restaurar registros callee-saved (si se guardaron):
  pop   {r4}        ; Recupera el valor de R4 de la pila
  bx    lr          ; Retorno
  ENDP
  END
