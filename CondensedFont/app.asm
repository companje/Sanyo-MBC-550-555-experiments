%include "sanyo.asm"

msg: db "HELLO!",0
 
Color.R equ 100
Color.G equ 010
Color.B equ 001
Color.W equ 111
Color.C equ 011
Color.M equ 101
Color.Y equ 110
Color.K equ 000

color: db Color.G

setup:
  jmp draw

; ───────────────────────────────────────────────────────────────────────────

; draw_bitmap:

;   ; mov ax,0b0111111111000000

;   xor bp,bp

;   mov cx,4
; .lp1
;   lodsw
;   xor [es:di+bp+0],al
;   xor [es:di+bp+4],ah
;   inc bp
;   loop .lp1

;   add bp,COLS*4-4

;   mov cx,4
; .lp2
;   lodsw
;   xor [es:di+bp+0],al
;   xor [es:di+bp+4],ah
;   inc bp
;   loop .lp2

;   add bp,COLS*4-4

;   mov cx,4
; .lp3
;   lodsw
;   xor [es:di+bp+0],al
;   xor [es:di+bp+4],ah
;   inc bp
;   loop .lp3

;   ret

; set_pixel: # bl,bh = x,y     al=3 bit color 
  
;   ret

draw_bitmap:
;   ; mov ax,0b0111111111000000

update_pix_in_channel:
  mov al,dl       ; restore al
  mov es,bp
  test [color], dh    ; deze checkt of de gewenste kleur rood bevat en of deze pixel in het rode kanaal dus aan of uit moet staan.
  jnz .on
  not al
  and [es:di],al
  jmp .done
.on
  or [es:di],al   ; turn on pixel
.done
  ret

setpix: 
  ;bx,dx = x,y
  ;di = (y\4)*(4*COLS) + (y%4) + (x\8)*4
  ;[es:di] |= 2^(7-(x mod 8))
  mov ax,dx        ; y
  xor dx,dx        ; dx=0
  mov cl,4         
  div cx           ; ax=y/4, dx=y%4
  mov di,dx        ; vram offset (dx=y%4)
  mov cx,4*COLS    ; 4 rows * num_cols
  mul cx           
  add di,ax        ; di+=(y/4)*320
  mov ax,bx        ; x
  xor dx,dx        ; dx=0
  mov cx,8         
  div cx           ; 8 bits per col
  mov cx,2 
  shl ax,cl        ; ax*=4       
  add di,ax        ; di+=(x/8)*4
  mov al,128       ; highest bit
  mov cl,dl        ; dl contains x%8
  shr al,cl        ; shift right number of bits to the correct pixel in char

  mov dl,al   ; save al in dl for later


  mov bp,RED
  mov dh,Color.R
  call update_pix_in_channel

  mov bp,GREEN
  mov dh,Color.G
  call update_pix_in_channel

  mov bp,BLUE
  mov dh,Color.B
  call update_pix_in_channel

  ret 


draw:

  mov ax,BLUE
  mov es,ax

  xor di,di
  mov ax,-1
  mov cx,14400/2
  rep stosw

  mov byte [color], Color.Y
  mov bx,50      ; x
  mov dx,5       ; y
  call setpix


  


  ; di=(y\4)*(4*COLS) + (y mod 4) + (x\8)*4



  ; mov bx,0x0f0f
  
  ; mov si,font+24*('A'-32)
  ; call draw_bitmap

  ; mov bx,0x0f11
  ; call calc_di_from_bx  

  ; mov si,font+24*('B'-32)
  ; call draw_bitmap


  hlt
  

; ───────────────────────────────────────────────────────────────────────────

calc_di_from_bx:  ; input bl,bh [0,0,71,49]
  mov ax,144      ; 2*72 cols
  mul bh          ; bh*=144 resultaat in AX
  shl ax,1        ; verdubbel AX
  mov di,ax       ; di=ax (=bh*288)
  shl bl,1        ; bl*=2
  shl bl,1        ; bl*=2
  mov bh,0
  add di,bx       ; di+=bl
  ret

; ───────────────────────────────────────────────────────────────────────────

_wait:
  push cx
  mov cx,1000
.lp 
  aam
  loop .lp
  pop cx
  ret

; ───────────────────────────────────────────────────────────────────────────

%include "assets.asm"

times (180*1024)-($-$$) db 0

