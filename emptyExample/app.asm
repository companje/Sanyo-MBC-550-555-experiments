COLS  equ 80
ROWS  equ 50
GREEN equ 0x1C00

setup:
  mov al, 5
  out 10h, al
  mov al,1
  out 0x30,al
  mov al,COLS
  out 0x32,al
  mov ax,GREEN
  mov es,ax
  ret

draw:
  jmp draw

%assign num $-$$
%warning total num
times (180*1024)-($-$$) db 0



