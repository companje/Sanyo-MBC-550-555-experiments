%include "sanyo.asm"
%include "player.asm"

msg_a:            db '"a"         ',0
msg_shift_a:      db 'Shift+A     ',0
msg_ctrl_a:       db 'Ctrl+A      ',0
msg_ctrl_shift_a: db 'Ctrl+Shift+A',0
msg_left:         db 'LEFT        ',0
msg_right:        db 'RIGHT       ',0
msg_up:           db 'UP          ',0
msg_down:         db 'DOWN        ',0
msg_other_key:    db 'Other key   ',0

img1: incbin "data/ship-1.spr"
img2: incbin "data/ship-2.spr"
img3: incbin "data/ship-3.spr"
img4: incbin "data/ship-4.spr"
img5: incbin "data/ship-5.spr"
img6: incbin "data/ship-6.spr"
img7: incbin "data/ship-7.spr"

size equ 0
w equ 0
h equ 1
pos equ 2
x equ 2
y equ 3
vel equ 4
vx equ 4
vy equ 5
frame equ 6
frames equ 7
framesize equ 8
img_data equ 9

ship: 
  .size.w db 4
  .size.h db 4
  .pos.x db 0
  .pos.y db 0
  .vel.vx db -1
  .vel.vy db 1
  .frame db 0
  .frames db 4
  .framesize db 192
  .img_data dw img1+2


DELAY equ 4000

; img_player: incbin "data/player/Sprite-0013-32x32.spr"

; %macro set_cursor 2
;   mov di,%1 * BYTES_PER_ROW + %2 * 4  ; zero based
;   ; mov di,(%1-1) * BYTES_PER_ROW + (%2-1) * 4   ; one based
; %endmacro

%macro draw_frame 1
  set_cursor 10,10
  mov si,%1
  call draw_spr
  call _wait
%endmacro

setup:
  xor bp,bp

  jmp draw

_wait:
  mov cx,DELAY
  .lp aam
  loop .lp
  ret

draw:
  push cs
  pop ds


  draw_frame img1
  draw_frame img2
  draw_frame img3
  draw_frame img4
  draw_frame img5
  draw_frame img6
  draw_frame img7
  draw_frame img7
  draw_frame img6
  draw_frame img4
  draw_frame img3
  draw_frame img2
  draw_frame img1

  
  ; call player.update
  ; call player.draw

  inc bp
  mov ax,bp
  set_cursor 12,50
  call write_number_word     ; draw frame counter
  
  call check_keys
  jnz .onkey
  ;else
  jmp draw            ; else continue draw loop




.onkey:
  set_cursor 2,10
  mov ax,[cs:key]
  call write_binary_word

  cmp ax,CTRL+'a'
    je .on_key_ctrl_a
  cmp ax,CTRL+'A'
    je .on_key_ctrl_shift_a
  cmp ax,'a'
    je .on_key_a
  cmp ax,'A'
    je .on_key_shift_a
  cmp ax,KEY_LEFT
    je .on_key_left
  cmp ax,KEY_RIGHT
    je .on_key_right
  cmp ax,KEY_UP
    je .on_key_up
  cmp ax,KEY_DOWN
    je .on_key_down
  ;else
    mov bx, msg_other_key             ; msg_other_key
    jmp .print_msg

.on_key_ctrl_a:
  mov bx, msg_ctrl_a                  ; msg_ctrl_a
  jmp .print_msg

.on_key_ctrl_shift_a:
  mov bx, msg_ctrl_shift_a            ; msg_ctrl_shift_a
  jmp .print_msg

.on_key_a:
  mov bx, msg_a                       ; msg_a
  jmp .print_msg

.on_key_shift_a:
  mov bx, msg_shift_a                 ; msg_shift_a
  jmp .print_msg

.on_key_left:
  mov bx, msg_left                    ; msg_left
  jmp .print_msg

.on_key_right:
  mov bx, msg_right                   ; msg_right
  jmp .print_msg

.on_key_up:
  mov bx, msg_up                      ; msg_up
  jmp .print_msg

.on_key_down:
  mov bx, msg_down                    ; msg_down
  jmp .print_msg

.print_msg:
  set_cursor 1,10
  call write_string

  jmp draw


%include "assets.asm"
; kipjes: incbin "data/bg/200x176.bin"



times (180*1024)-($-$$) db 0



