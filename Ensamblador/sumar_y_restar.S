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
  
  ; === Cuerpo ===
  ; Implementar la lógica de la función
  add   r4, r0, r1  ; Sumar valores R0 y R1 y guardar resultado en R4
  str   r4, [r2]    ; Almacena resultado en la dirección de memoria que apunta R2 (ptr_suma)
  sub   r4, r0, r1  ; Restar valores R0 y R1 y guardar resultado en R4
  str   r4, [r3]    ; Almacena resultado en la dirección de memoria que apunta R3 (ptr_resta)
  
  ; === Epílogo ===
  ; Restaurar registros callee-saved (si se guardaron):
  pop   {r4}  ; Recupera el valor de R4 de la pila
  bx    lr    ; Retorno a la dirección de donde llamaron a la función
  
  ENDP
  END
