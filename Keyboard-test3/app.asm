%include "sanyo.asm"

msg_a:            db '"a"         ',0
msg_shift_a:      db 'Shift+A     ',0
msg_ctrl_a:       db 'Ctrl+A      ',0
msg_ctrl_shift_a: db 'Ctrl+Shift+A',0
msg_other_key:    db 'Other key   ',0


setup:
  xor bp,bp
  jmp draw

draw:
  inc bp
  mov ax,bp
  set_cursor_row 6
  call write_number_word
  
  call check_keys
  jnz .onkey
  ;else
  jmp draw            ; else continue draw loop

.onkey:
  set_cursor_row 0
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

.print_msg:
  set_cursor_row 1
  call write_string

  jmp draw




times (180*1024)-($-$$) db 0

