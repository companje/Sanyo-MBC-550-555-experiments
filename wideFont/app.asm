%include "sanyo.asm"

%include "fill.asm"

; no lookup yet.. just setpix

; channel: dw RED,GREEN,BLUE


; turtle:

color: db Color.G
x: dw 10
y: db 10


; style:
;   .strokeColor
;   .fillColor


setup:
  ; call fill_blue

  ;blue BG
  mov ax,BLUE
  mov es,ax
  xor di,di
  mov ax,-1
  mov cx,7200
  rep stosw

  ;yellow pixel
  mov byte [color], Color.Y
  mov bx, 100   ; x
  mov dx, 20      ; y
  call setpix


  ; call calc_di_dl_from_x_y
  ; call calc_bit_for_pixel ; DI=byte for pixel, DL=bit for pixel in byte

  hlt
  

; ───────────────────────────────────────────────────────────────────────────

calc_bit_for_pixel:
  ;input BX,DX = x,y
  ;output DI = (y\4)*(4*COLS) + (y%4) + (x\8)*4
  ;output DL = 2^(7-(x % 8))

  mov ax,dx        ; y
  xor dx,dx        ; dx=0
  mov cl,4         
  div cx           ; ax=y/4, dx=y%4
  mov di,dx        ; vram offset (dx=y%4)
  mov cx,4*COLS    
  mul cx           ; ax*=(4*COLS)
  add di,ax        ; di+=ax
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
  mov dl,al
  ret

; ───────────────────────────────────────────────────────────────────────────

update_pix_in_channel:
  mov es,ax           ; color segment
  mov al,dl           ; DL contains active bit pattern
  test [color], dh    ; deze checkt of de gewenste kleur bevat en of deze pixel in dit kanaal dus aan of uit moet staan.
  jnz .on
  not al
  and [es:di],al  ; off
  jmp .done
.on
  or [es:di],al   ; turn on pixel
.done
  ret

setpix: 

  call calc_bit_for_pixel ; DI=byte for pixel, DL=bit for pixel in byte

  mov ax,RED
  mov dh,Color.R

  call update_pix_in_channel  ; dl is not affected

  mov ax,GREEN
  mov dh,Color.G
  call update_pix_in_channel ; dl is not affected

  mov ax,BLUE
  mov dh,Color.B
  call update_pix_in_channel ; dl is not affected

  ret 


times (180*1024)-($-$$) db 0



