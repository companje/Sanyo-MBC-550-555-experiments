org 0
cpu 8086

COLS  equ 72
TOP   equ 9*4*COLS+20*4    ; row=9,col=20
RED   equ 0xf000
GREEN equ 0x0800
BLUE  equ 0xf400

effect_timeout equ 20      ; every 30 frames another effect
isqrt_table    equ 3000    ; available location in code segment

; using dx and bx registers as t,i,x,y variables
%define t dh
%define i dl
%define x bh
%define y bl

setup:
  push cs
  pop ds

draw:

  mov ax,GREEN
  mov es,ax
  mov cx,15
.lp:

  mov ax,cx
  sub ax,15
  call sin
  mov bx,ax

  mov ax,cx
  sub ax,8
  call sin
  shr ax,1
  mov dx,ax
  
  ; mov bx,0
  ; mov dx,cx

  add bx,288
  add dx,40

  call calc_bit_for_pixel
  or [es:di], dl

  loop .lp

  ; mov si,img + 6*16
  ; mov di,0
  ; mov cx,4
  ; rep movsw
  ; add si,4

  hlt

sin: ; sine function
    call wrap
    push bx
    add al,15 ; sin(-15) = sin_table[0]
    mov bx,sin_table
    xlat 
    pop bx
    ret

wrap: ; while (al>15) al-=15; while (al<-15) al+=15
    cmp al,15
    jg .sub16
    cmp al,-15
    jl .add16
    ret
  .sub16:
    sub al,31
    jmp wrap
  .add16:
    add al,31
    jmp wrap


calc_bit_for_pixel:
  ;input BX,DX = x,y
  ;output DI = (y\4)*(4*COLS) + (y%4) + (x\8)*4
  ;output DL = 2^(7-(x % 8))
  push cx
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
  pop cx
  ret

; ───────────────────────────────────────────────────────────────────────────

; update_pix_in_channel:
;   mov es,ax           ; color segment
;   mov al,dl           ; DL contains active bit pattern
;   test [color], dh    ; deze checkt of de gewenste kleur bevat en of deze pixel in dit kanaal dus aan of uit moet staan.
;   jnz .on
;   not al
;   and [es:di],al
;   jmp .done
; .on
;   or [es:di],al   ; turn on pixel
; .done
;   ret

; setpix: 

;   call calc_bit_for_pixel ; DI=byte for pixel, DL=bit for pixel in byte

;   mov ax,RED
;   mov dh,Color.R

;   call update_pix_in_channel  ; dl is not affected

;   mov ax,GREEN
;   mov dh,Color.G
;   call update_pix_in_channel ; dl is not affected

;   mov ax,BLUE
;   mov dh,Color.B
;   call update_pix_in_channel ; dl is not affected

;   ret 


; setpix: 
;     ;bx,di = x,y
;     ;dx:si = 3c00:0000
;     ;si=(y//4)*(4*80))+(y%4)+(x//8)*4
;     ;[si]|=2^(7-(x%8))
;     mov ax,di
;     xor dx,dx
;     mov cl,4
;     div cx
;     mov si,dx
;     mov cx,320
;     mul cx
;     add si,ax
;     mov ax,bx
;     mov cx,8
;     div cx
;     mov cx,2
;     shl ax,cl
;     add si,ax
;     mov al,80
;     mov cl,dl
;     shr al,cl
;     or [ds:si],dl
;     ret

crt_init:
  xor bx,bx
  .lp:
  mov al,bl
  out 0x30,al           ; address / register select
  mov al,[iosys+bx]
  out 0x32,al           ; data
  inc bx
  cmp bl,13
  jne .lp
  ret

iosys: db 0x70,0x50,0x59,0x48,0x41,0x00,0x32,0x38,0x00,0x03,0x00,0x00,0x00,0x00,0x00,0x00

;   mov es,ax
;   mov cx,16
; .rows
;   push cx
;   mov ax,cx
;   mov cx,576
;   mul cx
;   add ax,TOP
;   mov di,ax

;   mov si,img

;   ; mov bx,5
;   ; times 3 shr bx
;   ; xlat


;   mov cx,16*4
;   rep movsw

;   ; mov di,ax
;   ; add di,288
;   ; mov si,img
;   ; mov cx,16*4
;   ; .lp
;   ; rep movsw
;   ; loop .lp

;   pop cx

;   loop .rows
;   ret

; ------------------------

    ; mov di,TOP+576
    ; mov si,img
    ; mov cx,16*4
    ; rep movsw


    ; mov ds,ax
    ; mov di,TOP+1*288
    ; mov si,TOP
    ; mov cx,16*2
    ; .lp:
    ; ; mov ax,-1
    ; ; stosb
    ; movsb
    ; add si,3
    ; add di,3
    ; movsb

    ; mov cx,16*4

    ; mov ax,-1
    ; rep stosw
    ; mov al,[es:di-288+2]
    ; stosb
    ; mov al,[es:di-288+3]
    ; stosb
    ; ; mov al,[es:di-288-1]
    ; mov al,0
    ; stosb
    ; mov al,0
    ; stosb
    ; stosw
    ; loop .lp

;     hlt


; fx2: ; y+t
;     mov al,y
;     add al,t
;     ret

; fx3: ; y-t
;     mov al,y
;     sub al,t
;     ret

; fx4: ; sin(x+y+t)
;     mov al,x
;     add al,y
;     add al,t
;     call sin
;     ret

; fx5: ; bitmap_data[i+t]
;     push bx
;     mov al,i
;     add al,t
;     mov bx,bitmap_data
;     xlat
;     pop bx
;     ret

; fx6: ; ((y-x)*-8)+t
;     mov al,y
;     sub al,x
;     mov cl,-8
;     mul cl
;     ; call limit
;     and al,15  
    
;     add al,t
;     ret



; ; img:
; ;   dw 0x0000,0x0000,0x0000,0x0000
; ;   dw 0x0000,0x0100,0x0000,0x8000
; ;   dw 0x0000,0x0300,0x0000,0xc000
; ;   dw 0x0000,0x0301,0x0000,0xc080
; ;   dw 0x0000,0x0703,0x0000,0xe0c0
; ;   dw 0x0000,0x0f07,0x0000,0xf0e0
; ;   dw 0x0300,0x1f0f,0xc000,0xf8f0
; ;   dw 0x0700,0x3f1f,0xe000,0xfcf8
; ;   dw 0x0f01,0x3f3f,0xf080,0xfcfc
; ;   dw 0x1f03,0x3f3f,0xf8c0,0xfcfc
; ;   dw 0x1f07,0x7f3f,0xf8e0,0xfefc
; ;   dw 0x1f07,0x7f7f,0xf8e0,0xfefe
; ;   dw 0x3f07,0x7f7f,0xfce0,0xfefe
; ;   dw 0x3f0f,0x7f7f,0xfcf0,0xfefe
; ;   dw 0x3f0f,0xff7f,0xfcf0,0xfffe
; ;   dw 0x7f1f,0xffff,0xfef8,0xffff

;   ; wanneer ik de eerste 4 regels full width cirkels neem en die alleen verticaal spiegel
;   ; kan ik in 124 bytes bitmap data (zonder de eerste) de dots inladen.
;   ; nu is het 48 bytes aan data maar met veel code om te flippen enzo

;   ; wanneer ik het verticaal spiegelen helemaal aan het eind van elk frame doe kan het
;   ; sneller en kleiner! want ik hoef dan maar 16x 3 beeldlijnen te kopieren met movsw+movsb

; fx_table:
;     db fx2,fx3,fx4,fx5,fx6

   
sin_table: ;31 bytes, (input -15..15 index=0..31)
    db 0,-3,-6,-9,-11,-13,-15,-15,-15,-15,-13,-11,-9,-6,-3,
    db 0, 3, 6, 9, 11, 13, 15, 15, 15, 15, 13, 11, 9, 6, 3,0  
;     ; tried to mirror the second line of the sine table with code 
;     ; but would take a same of amount of bytes


%assign num $-$$
%warning total num

bitmap_data:                          ; destination for 128 bytes rendered bitmap data

times (180*1024)-($-$$) db 0