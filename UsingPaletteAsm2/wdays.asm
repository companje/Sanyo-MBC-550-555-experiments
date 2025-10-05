G3 equ 0xFD  ;196Hz
A3 equ 0xE1  ;220Hz
B3 equ 0xC9  ;247Hz
C4 equ 0xBE  ;262Hz
D4 equ 0xA8  ;294Hz
E4 equ 0x96  ;330Hz
F4 equ 0x8E  ;349Hz

setup:
  push cs
  pop ds
  mov si,song

update:
  mov bh,0
  lodsb
  mov bl,al
  mov dx,100
  call play

  cmp si,song+32
  jb update
  mov si,song
  jmp update

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

song: ; Wonderfull Days intro
db G3,C4,E4,C4
db G3,C4,E4,C4
db G3,B3,D4,B3
db G3,B3,D4,B3
db A3,D4,F4,D4
db A3,D4,F4,D4
db A3,C4,E4,C4
db A3,C4,E4,C4

%assign num $-$$
%warning total num
times (180*1024)-num db 0
