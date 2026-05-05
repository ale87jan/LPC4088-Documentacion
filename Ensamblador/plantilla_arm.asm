;===================================================================================================
; @file   plantilla_arm.asm
; @brief  Descripción breve de lo que hace la función.
;
; @author  Nombre Apellidos [EMAIL]
; @date    yyyy-mm-dd
; @version v1.0
;===================================================================================================

; Plantilla de función en ensamblador x86 de 32 bits.
;
; Convención de llamada: cdecl (x86-32)
;  · Los parámetros se pasan en la pila, de derecha a izquierda.
;  · EAX, ECX y EDX son "caller-saved" (el llamador los preserva).
;  · EBX, ESI, EDI y EBP son "callee-saved" (esta función los preserva).
;  · El valor de retorno se devuelve en EAX (32 bits) o EDX:EAX (64 bits).
;
; Mapa de pila tras el prólogo (push ebp / mov ebp, esp):
;  [ebp + 0]  → valor anterior de EBP
;  [ebp + 4]  → dirección de retorno
;  [ebp + 8]  → param1  (primer parámetro)
;  [ebp + 12] → param2  (segundo parámetro)
;  [ebp + 16] → param3  (tercer parámetro, si existe)

; === Símbolo global ===
; En Windows (COFF) los nombres de función C llevan prefijo '_'.
; En Linux   (ELF)  NO llevan prefijo.
; El preprocesador C (#ifdef) se puede usar aquí para detectar la plataforma.
  #ifdef __linux__
    %define b32_funcion  b32_funcion
  #else
    %define b32_funcion _b32_funcion
  #endif

  global b32_funcion
  section .text

;---------------------------------------------------------------------------------------------------
; int32_t b32_funcion(int32_t param1, int32_t param2)
;
; @param[in] param1 Primer número
; @param[in] param2 Segundo número
;
; @return Valor de retorno mediante EAX (32 bits)

; === Macros para mejorar la legibilidad ===
%define PARAM1   [ebp + 8]
%define PARAM2   [ebp + 12]

b32_funcion:
  ; === Prólogo ===
  push ebp             ; Guardar EBP del llamador
  mov  ebp, esp        ; Establecer marco de pila propio

  ; Preservar registros callee-saved que se vayan a usar (si aplica):
  ; push  ebx
  ; push  esi
  ; push  edi

  ; === Cuerpo ===
  ; TODO: implementar la lógica del ejercicio.
  ; Ejemplo: devolver la suma de param1 + param2
  mov eax, PARAM1     ; eax ← param1
  add eax, PARAM2     ; eax ← eax + param2

  ; El valor de retorno queda en EAX al llegar al epílogo.

  ; === Epílogo ===
  ; Restaurar registros callee-saved en orden inverso (si se guardaron):
  ; pop   edi
  ; pop   esi
  ; pop   ebx

  pop ebp   ; Restaurar EBP del llamador
  ret       ; Retornar (dirección de retorno en [esp])
