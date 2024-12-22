%include "sanyo.asm"

char_index: db 0
hello1: db "TIMEBANDIT GRADIENT FONT",0

Color.R equ 0b100
Color.G equ 0b010
Color.B equ 0b001
Color.W equ 0b111
Color.C equ 0b011
Color.M equ 0b101
Color.Y equ 0b110
Color.K equ 0b000

draw_string:  ; input si=string offset
  mov word [draw_char.ox],0
  mov word [draw_char.oy],0
  mov word [draw_char.width],16
  mov word [draw_char.height],12
  mov byte [draw_char.color1],Color.G
  mov byte [draw_char.color2],Color.C

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

  ; call copy_red_to_green
  hlt

%include "functions.asm"

%include "assets.asm"

times (180*1024)-($-$$) db 0

