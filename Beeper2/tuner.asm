push cs
pop ds
call init_keys

update:
  mov bx,[pw]
  mov dx,100
  call play

  call check_keys
  jz update

  cmp al,'['
  je key_left
  cmp al,']'
  je key_right

  jmp update


key_left:
  inc word [pw]
  jmp update

key_right:
  dec word [pw]
  jmp update


pw: dw 0x50

init_keys:
  mov al,0
  out 0x3a,al           ; keyboard \force state/
  out 0x3a,al           ; keyboard \force state/
  mov al,0xFF
  out 0x3a,al           ; keyboard \reset/
  out 0x3a,al           ; keyboard \mode/
  mov al,0x37
  out 0x3a,al           ; keyboard \set command
  ret

check_keys:
  in al,0x3a        ; get keyboard status
  mov ah,al
  and al,0b00001000 ; keep only 1 for 'ctrl'
  mov [cs:key.ctrl],al
  test ah,2         ; keypressed flag is in ah, not in al anymore
  jz .return
  in al,0x38        ; get data byte from keyboard  
  mov [cs:key.code],al
  mov al,0x37
  out 0x3a,al       ; drop key?  
  or al,1           ; set zero flag to false to indicate a keypress
  mov ax,[cs:key]   ; ctrl status in ah, keycode in al, ZF low means a key was pressed
.return ret

key:
  .code db 0
  .ctrl db 0

play:             ; bx=note/pulse_width, dx=duration
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
.d xor al,8       ; toggle 'control' bit
   cmp al,0x35    ; 'break' now on?
   jnz .e         ; jump if not
   out 0x3A,al    ; reset USART
.e ret



%assign num $-$$
%warning total num
times (180*1024)-num db 0

