%include "sanyo.asm"
%include "player.asm"

msg_other_key: db 'Other key   ',0
msg_spaces:    db '     ',0
msg_vx:    db 'vx: ',0

ship:
 .pos:
 .pos.x: dw 73728/2
 .pos.y: dw 51200/2 + 2000
 .vel: 
 .vel.x: dw -10
 .vel.y: dw 0
 .vel.flags: dw 0
 .acc:
 .acc.x: dw 0
 .acc.y: dw 0
 .forces:
 .forces.x: dw 0
 .forces.y: dw 0
 .angle: dw 0
 .prev_di: dw 0

color: db Color.G

img_lut: dw img_down_right, img_down, img_down_left, img_NONE, img_right, img_NONE, img_left, img_NONE, img_up_right, img_up, img_up_left

; ───────────────────────────────────────────────────────────────────────────

setup:
  xor bp,bp
  jmp draw

; ───────────────────────────────────────────────────────────────────────────

; vec_mult:   ; cx scalar, ax=x, bx=y
  
FRICTION equ 94

update_ship:
  
  ; x+=vx
  mov ax,[ship.pos.x]       ; 0..73728  (65536)
  add ax,[ship.vel.x]
  mov [ship.pos.x],ax

  ; y+=vy
  mov ax,[ship.pos.y]       ; 0..51200  (=1024*50)
  add ax,[ship.vel.y]
  mov [ship.pos.y],ax

  ; vx*=98%
  mov ax, [ship.vel.x]
  cwd                 ; Convert word to double word (sign-extend AX into DX)
  mov cx, FRICTION
  imul cx             ; Signed multiplication
  mov cx, 100
  idiv cx             ; Signed division
  mov [ship.vel.x], ax

  ; vy*=98%
  mov ax, [ship.vel.y]
  cwd                 ; Convert word to double word (sign-extend AX into DX)
  mov cx, FRICTION
  imul cx             ; Signed multiplication
  mov cx, 100
  idiv cx             ; Signed division
  mov [ship.vel.y], ax

  ; velocity flags
  mov ax,[ship.vel.x]
  or ax,0
  pushf
  pop ax
  mov cl,6
  shr al,cl
  xchg al,bl
  mov ax,[ship.vel.y]
  or ax,0
  pushf
  pop ax
  mov cl,4
  shr al,cl
  or ax,bx
  and ax,15
  mov word [ship.vel.flags],ax

  ; 0=down-right
  ; 1=down
  ; 2=down-left
  ; 3=################
  ; 4=rechts
  ; 5=#### IDLE ####
  ; 6=links
  ; 4=###############
  ; 8=up-right
  ; 9=up
  ; 10=up-left

  ret

; ───────────────────────────────────────────────────────────────────────────

draw_ship:

  mov ax,[ship.pos.x]
  mov bx,[ship.pos.y]
  call world2screen
  call calc_di_from_bx

  cmp [ship.prev_di],di
  je .return

  ; call world2screen ; ax and bx are already set by pop bx, pop ax
  ; call calc_di_from_bx

  mov di,[ship.prev_di]
  
  mov ax,RED
  mov bx,0x0808  ; rows,cols
  call clear_area

  mov ax,GREEN
  mov bx,0x0808  ; rows,cols
  call clear_area

  mov ax,BLUE
  mov bx,0x0808  ; rows,cols
  call clear_area

  mov ax,[ship.pos.x]
  mov bx,[ship.pos.y]
  call world2screen
  call calc_di_from_bx
  mov [ship.prev_di],di

  ; mov ax,GREEN
  ; mov es,ax
  ; mov ax,-1
  ; stosw
  ; stosw

  ;select sprite frame based on ship direction
  mov bp,[ship.vel.flags]
  shl bp,1 ; *=2
  mov si,[img_lut+bp]

  mov ax,[ship.pos.x]
  mov bx,[ship.pos.y]
  call world2screen ; ax and bx are already set by pop bx, pop ax
  call calc_di_from_bx

  call draw_spr
.return
  ret

; ───────────────────────────────────────────────────────────────────────────

clear_area: ; ax=channel, bx=area, di=start pos
  push bx
  push di
  mov es,ax
  xor cx,cx
  mov cl,bh        ; rows (bl)
.rows_loop:
  push cx
  xor cx,cx
  mov cl,bl        ; cols (bh)
.cols_loop:
  mov ax,0
  stosw
  stosw
  loop .cols_loop
  add di,COLS*4    ; one row down
  mov ah,0
  mov al,bl
  times 2 shl ax,1
  sub di,ax       ; di-=4*bh   ; bh cols to the left on the new row
  pop cx
  loop .rows_loop
  pop di
  pop bx
  ret
  
; ───────────────────────────────────────────────────────────────────────────

draw:
  push cs
  pop ds   ; make sure DS is set to CS for data lookups like [ship.pos.x]

  call update_ship
  call draw_ship

  call _wait

  inc bp

  set_cursor 12,45
  print "frame: "
  mov ax,bp
  call write_number_word     ; draw frame counter
  print "  "

  set_cursor 13,45
  print "vx: "
  mov ax,[ship.vel.x]  
  call write_signed_number_word
  print "  "

  set_cursor 14,45
  print "vy: "
  mov ax,[ship.vel.y]
  call write_signed_number_word     ; draw vy
  print "  "

  set_cursor 15,45
  print "flags: "
  mov ax,[ship.vel.flags]
  call write_number_word     
  print "  "

  set_cursor 16,45
  print "flags: "
  mov ax,[ship.vel.flags]
  call write_binary_word     ; flags

  call check_keys
  jnz on_key
  ;else
  jmp draw          ; this code is only getting called when no key is pressed

; ───────────────────────────────────────────────────────────────────────────

on_key:
  set_cursor 2,10
  mov ax,[key]
  call write_binary_word
  cmp ax,'w'
  je on_key_w
  cmp ax,'a'
  je on_key_a
  cmp ax,'s'
  je on_key_s
  cmp ax,'d'
  je on_key_d
  mov bx, msg_other_key             ; msg_other_key
  call print_msg
.done
  jmp draw  ; no ret here because onkey is called by jnz


STEP equ 500

; ───────────────────────────────────────────────────────────────────────────

on_key_w:
  sub word [ship.vel.y], STEP
  jmp on_key.done

; ───────────────────────────────────────────────────────────────────────────

on_key_a:
  sub word [ship.vel.x], STEP
  jmp on_key.done

; ───────────────────────────────────────────────────────────────────────────

on_key_s:
  add word [ship.vel.y], STEP
  jmp on_key.done

; ───────────────────────────────────────────────────────────────────────────

on_key_d:
  add word [ship.vel.x], STEP
  jmp on_key.done

; ───────────────────────────────────────────────────────────────────────────

print_msg:
  set_cursor 1,10
  call write_string
  ret

; ───────────────────────────────────────────────────────────────────────────

_wait:
  DELAY EQU 250
  mov cx,DELAY
  .lp aam
  loop .lp
  ret

; ───────────────────────────────────────────────────────────────────────────

world2screen:  ; input (ax,bx) = (world.x, world.y)   ; screen (row,col)
  ; WORLD:
  ;   0..73728  (65536) -> col
  ;   0..51200  (=1024*50) -> row
  ; SCREEN (ROW,COL):
  ;   0..49 (row)
  ;   0..71 (col)
  mov cl,10
  shr bx,cl   ; //bl=row 0..49
  shr ax,cl   ; 
  mov bh,al   ; //bh=col 0..71
  xchg bh,bl
  ret

; ───────────────────────────────────────────────────────────────────────────

; 180 items but full 360 range divide AX by 2 or SHR AX,1 then do XLAT
; lut_sin: db 0,3,6,10,13,17,20,24,27,30,34,37,40,43,46,50,52,55,58,61,64,66,69,71,74,76,78,80,82,84,86,88,89,91,92,93,95,96,97,97,98,99,99,99,99,100,99,99,99,99,98,97,97,96,95,93,92,91,89,88,86,84,82,80,78,76,74,71,69,66,64,61,58,55,52,50,46,43,40,37,34,30,27,24,20,17,13,10,6,3,0,-3,-6,-10,-13,-17,-20,-24,-27,-30,-34,-37,-40,-43,-46,-49,-52,-55,-58,-61,-64,-66,-69,-71,-74,-76,-78,-80,-82,-84,-86,-88,-89,-91,-92,-93,-95,-96,-97,-97,-98,-99,-99,-99,-99,-100,-99,-99,-99,-99,-98,-97,-97,-96,-95,-93,-92,-91,-89,-88,-86,-84,-82,-80,-78,-76,-74,-71,-69,-66,-64,-61,-58,-55,-52,-50,-46,-43,-40,-37,-34,-30,-27,-24,-20,-17,-13,-10,-6,-3
; lut_cos: db 100,99,99,99,99,98,97,97,96,95,93,92,91,89,88,86,84,82,80,78,76,74,71,69,66,64,61,58,55,52,49,46,43,40,37,34,30,27,24,20,17,13,10,6,3,0,-3,-6,-10,-13,-17,-20,-24,-27,-30,-34,-37,-40,-43,-46,-50,-52,-55,-58,-61,-64,-66,-69,-71,-74,-76,-78,-80,-82,-84,-86,-88,-89,-91,-92,-93,-95,-96,-97,-97,-98,-99,-99,-99,-99,-100,-99,-99,-99,-99,-98,-97,-97,-96,-95,-93,-92,-91,-89,-88,-86,-84,-82,-80,-78,-76,-74,-71,-69,-66,-64,-61,-58,-55,-52,-49,-46,-43,-40,-37,-34,-30,-27,-24,-20,-17,-13,-10,-6,-3,0,3,6,10,13,17,20,24,27,30,34,37,40,43,46,49,52,55,58,61,64,66,69,71,74,76,78,80,82,84,86,88,89,91,92,93,95,96,97,97,98,99,99,99,99

; FIXME
img_NONE: incbin "data/ship-24.spr"


img_up:
img1: incbin "data/ship-1.spr" ;up
img2: incbin "data/ship-2.spr"
img3: incbin "data/ship-3.spr"
img_up_right:
img4: incbin "data/ship-4.spr" ;up-right
img5: incbin "data/ship-5.spr"
img6: incbin "data/ship-6.spr"
img_right:
img7: incbin "data/ship-7.spr" ;right
img8: incbin "data/ship-8.spr"
img9: incbin "data/ship-9.spr"
img_down_right:
img10: incbin "data/ship-10.spr" ;down-right
img11: incbin "data/ship-11.spr"
img12: incbin "data/ship-12.spr"
img_down:
img13: incbin "data/ship-13.spr" ;down
img14: incbin "data/ship-14.spr"
img15: incbin "data/ship-15.spr"
img_down_left:
img16: incbin "data/ship-16.spr" ;down-left
img17: incbin "data/ship-17.spr"
img18: incbin "data/ship-18.spr"
img_left:
img19: incbin "data/ship-19.spr" ;left
img20: incbin "data/ship-20.spr"
img21: incbin "data/ship-21.spr"
img_up_left:
img22: incbin "data/ship-22.spr" ;up-left
img23: incbin "data/ship-23.spr"
img24: incbin "data/ship-24.spr"


times (180*1024)-($-$$) db 0



