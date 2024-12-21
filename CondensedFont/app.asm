%include "sanyo.asm"

char_index: db 0
hello1: db "FIEP EN SIENE ZIJN LIEF",0

draw_string:  ; input si=string offset
  mov word [draw_char.ox],0
  mov word [draw_char.oy],0
  mov word [draw_char.width],16
  mov word [draw_char.height],12

.lp
  push si ; string offset
  lodsb
  or al,al
  jz .done

  mov byte [draw_char.char],al
  call draw_char
  inc byte [char_index]
  add word [draw_char.ox],12
  pop si
  inc si
  jmp .lp
.done
  pop si
  ret


setup:
  mov ax,RED
  mov es,ax
  mov si,hello1
  call draw_string

  hlt


%include "func.asm"


%include "assets.asm"

times (180*1024)-($-$$) db 0

