
DELAY equ 4000

size equ 0
w equ 0
h equ 1
pos equ 2      ; 2x16bit
pos.x equ 2
pos.y equ 4
vel equ 6      ; 2x16bit
vel.vx equ 6  
vel.vy equ 8
frame equ 9
frames equ 10
framesize equ 11
img_data equ 12

───────────────────────────────────────────────────────────────────────────
───────────────────────────────────────────────────────────────────────────

ship: 
  .size.w db 4
  .size.h db 4
  .pos.x dw 0xffff/2     ; pos in world coordinates. in current situation in world to screen: whole world is visible on screen.
  .pos.y dw 51200/2     ; no zoom or scale yet
  .vel.vx db 0      ; vel in world coordinates
  .vel.vy db 0
  .frame db 0
  .frames db 4
  .framesize dw 768
  .img_data dw img1+2

ship.draw:
  ; set_cursor 10,10
  ; mov bp,ship
  ; mov bx,[bp+pos]
  ; call world2screen

  ;update pos from vel
  mov ax,[ship+pos.x]       ; 0..73728  (65536)
  mov bx,[ship+pos.y]       ; 0..51200  (=1024*50)
  add ax,[ship+vel.vx]
  add bx,[ship+vel.vy]
  ; mov [ship+pos.x],ax
  ; mov [ship+pos.y],bx
 
 
  push ax
  push bx
  set_cursor 4,50
  call write_number_word     ; draw world x
  set_cursor 5,50
  mov ax,bx
  call write_number_word     ; draw world y
  pop bx
  pop ax
 
  mov ax,[ship+pos.x]       ; 0..73728  (65536)
  mov bx,[ship+pos.y]       ; 0..51200  (=1024*50)
   

  call world2screen         ; scale 2x 16 bit world coordinate in (ax,bx) to 2x 8 bit row,col in (bh,bl)
  call calc_di_from_bx

  mov si,img1
  call draw_spr
  ret
