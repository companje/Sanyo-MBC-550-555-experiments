%include "sanyo.asm"

setup:
  mov si,sound
  mov cx,endsound-sound

play:
  lodsb
  mov bl,8
  mov bh,1
.nextbit:
  push ax
  mov ah,al
  mov al,0
  and ah,bh
  jz .sendbit
  mov al,8
.sendbit:
  out 0x3A,al
  push cx
  mov cx,15
.wait: loop .wait
  pop cx
  pop ax
  shl bh,1
  dec bl
  jnz .nextbit
  loop play

  jmp setup

  ; ret

sound: 
  incbin "bin/beat2.bin"
endsound:

times (180*1024)-($-$$) db 0



