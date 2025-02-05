%include "sanyo.asm"

intro:
  db "The year 2674, Aliens from an other "
  db "galaxy came into our galaxy and     "
  db "wanted to destroy the earth.        "
  db "                                    "
  db "The government of all countries in  "
  db "the world decided to discus this    "
  db "problem..... BIG PROBLEM.           "
  db "They found out that they had one    "
  db "chance. It was "
  db 27,1
  dw RED
  db "The Blow'em Away/63,2"
  db 27,1
  dw GREEN
  db "an amazing space-ship with  lots    "
  db "of guns and clean nuclear engines   "
  db "created by N.A.S.A                  "
  db "But know they needed a volunteer.   "
  db "2 days later there came a volunteer "
  db "It was Conrad Mc Neill, a young     "
  db "fellow with courage and brains.     "
  db "While the Aliens space-ship came    "
  db "closer, he heard all the risks and  "
  db "learned how to handle the space-ship"
  db "When the Aliens' spaceship came very"
  db "close to the earth, it was time to  "
  db "ran of, Conrad Mc Neill climbs in   "
  db "the ship and flew away              "
  db "                                    "
  db 27,1
  dw RED
  db ".....so it's all up to you.....     "
  db 27,1
  dw GREEN
  db 0

setup:
  mov bx,intro
  call write_string_with_sound


  hlt


write_string_with_sound:
  mov al,[cs:bx]
  inc bx
  or al,al
  jz .done

  cmp al,27
  jne .done_esc

  mov al,[cs:bx]
  inc bx
  cmp al,1
  jne .done_esc

  ;27.1 = color channel
  mov ax,[cs:bx]
  mov [color_channel],ax
  inc bx
  inc bx
  jmp write_string_with_sound
  
.done_esc:
  call write_char_wide
  call row_snap

  ;sound
  push dx
  push bx
  cmp al,32
  je .wait
  mov bx,ax
  ; shl bx,1
  mov dx,3
  call play
.wait:
  push cx
  mov cx,2000
.lp: aam
  loop .lp
  pop cx
  pop bx
  pop dx
  jmp short write_string_with_sound
.done:
  ret



times (180*1024)-($-$$) db 0
