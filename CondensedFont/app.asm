%include "sanyo.asm"

setup:
  mov ax,RED
  mov es,ax

  mov si,font + ('A'-32)*24
  
  mov byte [draw_char.char],'B'
  mov word [draw_char.ox],0
  mov word [draw_char.oy],0
  mov word [draw_char.width],16
  mov word [draw_char.height],12
  call draw_char

  ; mov ax,4     ; x
  ; mov bx,4     ; y
  ; mov cx,16    ; width 0x10
  ; mov dx,12    ; height 0x0c

  hlt


%include "func.asm"



%include "assets.asm"

times (180*1024)-($-$$) db 0

