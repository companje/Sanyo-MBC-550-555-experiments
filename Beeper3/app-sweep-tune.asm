; mov dx,0x3a
push cs
pop ds
push cs
pop es

MAX_DELAY equ 200

setup:
  ; mov si,data
  ; xor ch,ch
  ; xor bh,bh

  mov cx,400
  call sweep
  hlt

sweep:    ; cx start-note
  mov bx,cx   ; note
  mov dx,300    ; duration
  push cx
  mov bx,cx
  call play

  mov cx,10000
  .lp aam 
  loop .lp

  pop cx
  sub cx,1
  jns sweep
  ret


play:             ; bx=note, dx=duration
   mov cx,bx
   mov ax,0x35
.a xor al,8       ; toggle 'break' bit
   out 0x3a,al    ; USART
.b dec ah
   jnz .c
   dec dx
   jz .d
.c loop .b
   mov cx,bx      ; reset note
   jmp .a
; .d ret
.d xor al,8       ; toggle 'control' bit
   cmp al,0x35    ; 'break' now on?
   jnz .e         ; jump if not
   out 0x3A,al    ; reset USART
.e ret


; play_tone:
;   out 0x3a,al
;   call pulse_delay
;   xor al,8    ;toggle bit
;   dec bx      ;tone length
;   jnz play_tone
;   ret

; pulse_delay:
;   push cx
;   mov dx, 200 ; max delay
;   sub dx, cx
;   mov cx, dx
; .d: loop .d
;   pop cx
;   ret

; pulse_delay:
;   push cx
;   .d: loop .d     ;pulse delay (tone)
;   pop cx
;   ret

data: ; alleen bootsector wordt geladen. dus voor een clear moet je een loop doen in de setup
  db  200, 50   ; pulse delay (tone), tone_length
  ; db  100, 50
  ; db  255, 50

end_data: ; music ends when pulse delay cx=0

%assign num $-$$
%warning total num
times (180*1024)-num db 0


