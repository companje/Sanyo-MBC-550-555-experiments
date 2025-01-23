%include "sanyo.asm"
%include "atan.asm"

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
FRICTION equ 94

setup:
  set_cursor 1,1

  _atan2 100, 0
  _atan2 96, 25
  _atan2 86, 50
  _atan2 70, 70
  _atan2 49, 86
  _atan2 25, 96
  _atan2 0, 100
  _atan2 -25, 96  
  _atan2 -50, 86  
  _atan2 -70, 70 
  _atan2 -86, 50 
  _atan2 -96, 25 
  _atan2 -100, 0 
  _atan2 -96, -25 
  _atan2 -86, -49 
  _atan2 -70, -70 
  _atan2 -49, -86 
  _atan2 -25, -96 
  _atan2 0, -100 
  _atan2 25, -96 
  _atan2 49, -86 
  _atan2 70, -70 
  _atan2 86, -50 
  _atan2 96, -25 





  ; mov ax,1234
  ; call write_signed_number_word

  ; xor di,di
  ; mov cx,1000
  ; mov ax,FONT
  ; mov ds,ax
  ; ; mov ax,-1
  ; rep movsw



;   cli
;   cld
; push cs
; pop ds
; xor bx,bx
; xor dx,dx
; xor cx,cx
; xor ax,ax
; xor bp,bp

;   hlt
;   xor dx,dx
;   add di,3*8

;   mov cx,10
;   div cx
;   ; push ax
;   push ax ;xxxxx

  ; mov ax,88
  ; call write_number_word
  ; print "  "
  ; xor di,di
  ; mov ax,'X'
  ; push ax
  ; mov ax,GREEN
  ; mov es,ax
  ; mov ax,FONT
  ; mov ds,ax
  ; pop ax
  ; mov ah,8
  ; mul ah        ; al*=ah
  ; mov si,ax
  ; movsw
  ; movsw
  ; add di,0x11c
  ; movsw
  ; movsw
  ; sub di,0x120

  ; mov ax,'8'
  ; push ax
  ; mov ax,GREEN
  ; mov es,ax
  ; mov ax,FONT
  ; mov ds,ax
  ; pop ax
  ; mov ah,8
  ; mul ah        ; al*=ah
  ; mov si,ax
  ; movsw
  ; movsw
  ; add di,0x11c
  ; movsw
  ; movsw
  ; sub di,0x120




  hlt
  
  xor bp,bp
  jmp draw

; ───────────────────────────────────────────────────────────────────────────





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
  
  mov bx,0x0808  ; rows,cols
  ; call fill_rect_black

  mov ax,[ship.pos.x]
  mov bx,[ship.pos.y]
  call world2screen
  call calc_di_from_bx
  mov [ship.prev_di],di


  mov si,img_up
  mov ax,[ship.pos.x]
  mov bx,[ship.pos.y]
  call world2screen ; ax and bx are already set by pop bx, pop ax
  call calc_di_from_bx
  call draw_spr

.return
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



