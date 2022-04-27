; Rick Companje, March 29th, 2022
cpu 8086
org 0x0

; test al,2
; or ah,128

; start:

; mov ax,31 ;al=0b00001111, ah=0
; mov cl,8
; bit:
; mov bx,0x8001 ; bl=1, bh=128
; shl bl,cl
; test al,bl
; jz cont
; dec cx
; shr bh,cl
; or ah,bh
; inc cx
; cont: 
; loop bit ;continue
; xchg ah,al


;     jmp code

;     db 'Sanyo1.2'
;     db 0x00,0x02,0x02,0x01,0x00,0x02,0x70,0x00,
;     db 0xd0,0x02,0xfd,0x02,0x00,0x09,0x00,0x02,
;     db 0x00,0x00,0x00,0x00,0x00,0x1c,0x00,0xff,
;     db '       Sanyo MBC-550/555        ',0x00

cols equ 80
rows equ 25
lines equ 200
; startpos equ 4*24 + 4*cols*8

; %define t ch  ; dit werkt op zich

; setProfile:
;     mov bx,0
;     cld
; .lp:
;     mov al,bl
;     out 0x30,al            ;CRTC address port
;     mov al,[cs: bx+si+0]
;     out 0x32,al            ;CRTC data port
;     inc bx
;     cmp bl,10
;     jl .lp
;     ret

; profile25x80:
;     db 112  ;0  Horizontal Total
;     db 80   ;1  Horizontal Displayed
;     db 88   ;2  Horizontal Sync Position
;     db 0x4a ;3  Horizontal and Vertical Sync Widths
;     db 65   ;4  Vertical Total
;     db 0    ;5  Vertical Total Adjust
;     db 50   ;6  Vertical Displayed
;     db 56   ;7  Vertical Sync position
;     db 0    ;8  Interlace and Skew
;     db 3    ;9  Maximum Raster Address


setup:
    call clearScreen

draw:
    mov bp,0xf000
    mov es,bp
    ; mov di,0
    ; mov al,255
    ; stosb

    cld
    mov di,0
    push cs
    pop ds
    
    mov cl,10
    ; cli
; repeatX:
    mov al,cl

;idee is nu om de 16 cirkels naast elkaar af te beelden met 8px ertussen horiontaal en 4 verticaal
; daarna nadat alles getekent is een mirror/flip routine uitvoeren op hetgeen in het vram
    times 2 shl al,1
    xchg si,ax
    add si,img

    ; loop repeatX

    ; add si,15
    ; mov cx,10
    ; rep movsw
    ; mov al,255
    ; stosb

    movsw
    movsw

    add di,4

    ; add di,320-4
    ; dec si
    ; movsb
    ; times 2 dec si
    ; movsb
    ; times 2 dec si
    ; movsb
    ; times 2 dec si
    ; movsb

    ; sub di,320
    ; mov si,img
    ; lodsb
    ; call flip_bits
    ; stosb
    ; lodsb
    ; call flip_bits
    ; stosb
    ; lodsb
    ; call flip_bits
    ; stosb
    ; lodsb
    ; call flip_bits
    ; stosb


    ; movsw
    ; movsw
    ; sub si,8
    ; ; call flip_bits


; flip from video mem
; lastig moet ook ds:si gepushed en aangepast




    ; add di,320-4
    ; movsb
    ; times 2 dec si
    ; movsb
    ; times 2 dec si
    ; movsb
    ; times 2 dec si
    ; movsb
    
    ; times 2 dec si
    ; movsb
    ; or byte [es:di-320],0xff


    ; movsb
    ; std
    ; sub si,16
    ; add di,320-8
    ; movsw
    ; movsw
    ; ; movsw
    ; movsw
    ; movsw

    ; mov si,ax
    ; add si,img+128
    ; movsw
    ; movsw
    ; movsw
    ; movsw

    ; mov bp,0x0c00
    ; mov di,9*4*cols+cols 
    ; call dot

    jmp draw

flip_bits:        ; flip the bits of al
    mov cl,8
    mov ah,0
.bit: 
    mov bx,0x8001 ; bl=1, bh=128
    shl bl,cl
    test al,bl
    jz .cont
    dec cx
    shr bh,cl
    or ah,bh
    inc cx
.cont:
    loop .bit ;continue
    mov al,ah
    ret

img:
    ; db 0x00,0x00,0x00,0x00,0x00  ; 0 leeg
    ; db 0x00,0x00,0x00,0x00,0x01  ; 1 stipje
    ; db 0x00,0x00,0x00,0x00,0x03  ; 2 minnetje
    ; db 0x00,0x00,0x00,0x01,0x03  ; 3 plusje
    ; db 0x00,0x00,0x00,0x03,0x07  ; 4 hoofdje
    ; db 0x00,0x00,0x00,0x07,0x07  ; 5 blokje
    ; db 0x00,0x00,0x01,0x07,0x0F  ; 6 sterretje
    ; db 0x00,0x00,0x03,0x0F,0x0F  ; 7 rode kruis
    ; db 0x00,0x00,0x07,0x0F,0x1F  ; 8 ..
    ; db 0x00,0x01,0x0F,0x1F,0x1F  ; 9 ..
    ; db 0x00,0x07,0x1F,0x1F,0x3F  ; 10 ..
    ; db 0x00,0x0F,0x1F,0x3F,0x3F  ; 11 ..
    ; db 0x01,0x1F,0x3F,0x7F,0x7F,0x01  ; 12 groot met puntje
    ; db 0x07,0x1F,0x3F,0x7F,0x7F  ; 13 ..
    ; db 0x0F,0x3F,0x7F,0xFF,0xFF  ; 14 ..
    ; db 0x1F,0x7F,0xFF,0xFF,0xFF  ; 15 ..

db 0, 0, 0, 0
db 0, 0, 0, 1         ;punt
db 0, 0, 0, 3         ;min
db 0, 0, 1, 3         ;plus
db 0, 0, 3, 7         ;hoed
db 0, 0, 7, 7         ;blok
db 0, 1, 7, 15        ;ster
db 0, 3, 15, 15       ;dikke plus
db 0, 15, 31, 63   
db 1, 31, 63, 63      ;tol
db 7, 31, 31, 63      ;robothoofd
db 15, 31, 63, 63
db 15, 63, 63, 127
db 31, 63, 127, 127
db 31, 127, 255, 255
db 63, 127, 255, 255


; setpix:
;     32cols

; dot:
;     mov es,bp
;     mov al,255
;     stosb
;     ret

;     ; call drawchar
    
;     jmp draw

;     mov ax,0x0c00
;     mov es,ax
;     xor bp,bp
;     mov dh,0    ; t

;     mov dl,0    ; i
;     mov bl,0    ; y
;     mov di,9*4*cols+cols    ; view top left
; repeatY:
;     mov bh,0    ; x
; repeatX:
;     ; push bp
;     ; push bx
;     ; xchg bx,bp
;     ; mov bp,[bx+table]
;     ; and bp,0xff
;     ; or bp,0x100
;     ; pop bx
;     ; call bp
;     ; pop bp


    ;effect
    ; mov al,bh
    ; mul bl
    ; add al,dh


;     push bx
;     cmp al,0
;     jge white
; gray:
;     mov bx,0xf400
;     mov es,bx
;     neg al
;     call drawchar
;     mov bx,0x0c00
;     mov es,bx
;     mov al,0
;     call drawchar
;     jmp nextchar
; white:
;     mov bx,0x0c00
;     mov es,bx
;     call drawchar
;     mov bx,0xf400
;     mov es,bx
;     call drawchar

; nextchar:
;     pop bx
;     add di,8
;     inc dl        ; i++
;     inc bh        ; x++
;     cmp bh,16
;     jl repeatX
;     add di,192+320
;     inc bl        ; y++
;     cmp bl,16
;     jl repeatY


; drawchar:
;     push di
;     push ax
;     and al,15    ; limit to 4 lower bits [0..15]
;     mov cl,8
;     mul cl        ; ax=al*8

;     mov si,ax
;     add si,img
;     movsw
;     movsw
;     movsw
;     movsw
;     add di,320-8
;     mov si,ax
;     add si,img+128
;     movsw
;     movsw
;     movsw
;     movsw
; ;sub di,320-8
;     pop ax
;     pop di
;     ret

; draw:
;     mov bp,0xf000  ; red
;     mov di,0
;     call dot

;     mov bp,0x0c00  ; green
;     mov di,0
;     call dot

;     mov bp,0xf400  ; blue
;     mov di,0
;     call dot

;     jmp draw

; dot:
;     mov es,bp
;     mov al,255
;     stosb
;     ret

clearScreen:
    cld

    mov al,0    ; pattern
    mov bp,0xf000  ; red
    mov es,bp
    mov di,0
    mov cx,cols*lines
    rep stosb

    mov bp,0x0c00  ; green
    mov es,bp
    mov di,0
    mov cx,cols*lines
    rep stosb

    mov bp,0xf400  ; blue
    mov es,bp
    mov di,0
    mov cx,cols*lines
    rep stosb

    ret


; img:
;     db 0,0,0,0,  0,0,0,0,  0,0,0,0,  0,0,0,128
;     db 0,0,0,1,  0,0,0,192,  0,0,0,1,  0,0,0,192
;     db 0,0,0,3,  0,0,128,224,  0,0,0,3,  0,0,128,224
;     db 0,0,3,7,  0,0,224,240,  0,0,3,7,  0,0,224,240
;     db 0,0,7,15,  0,128,240,248,  0,0,7,15,  0,128,240,248
;     db 0,3,15,31,  0,224,248,252,  0,7,31,31,  0,240,252,252
;     db 0,15,31,63,  128,248,252,254,  0,15,63,63,  128,248,254,254
;     db 7,31,63,127, 240,252,254,255, 7,63,127,127, 240,254,255,255
    
;     db 0,0,0,0,  0,0,0,0,  0,0,0,0,  0,0,0,0
;     db 0,0,0,0,  0,0,0,0,  0,0,0,0,  0,0,0,0
;     db 0,0,0,0,  128,0,0,0,  0,0,0,0,  128,0,0,0
;     db 3,0,0,0,  224,0,0,0,  3,0,0,0,  224,0,0,0
;     db 7,0,0,0,  240,128,0,0,  7,0,0,0,  240,128,0,0
;     db 15,3,0,0,  248,224,0,0,  31,7,0,0,  252,240,0,0
;     db 31,15,0,0,  252,248,128,0,  63,15,0,0,  254,248,128,0
;     db 63,31,7,0,  254,252,240,0,  127,63,7,0,  255,254,240,0


; code:  
;     ; call setDisplayMode80x25
;     ; mov si,profile25x80
;     ; call setProfile
;     call clearScreen

; ; _loop:
; ;     jmp _loop

;     ; push cs
;     ; pop ds              ; data=code segment

; draw:
;     mov ch,0            ; t
; top:
;     mov cl,0            ; i
;     mov di,startpos
;     mov dh,0            ; y           
; repeatY:
;     mov dl,0            ; x
; repeatX:
;     ; push bx
;     ; cs call fx0
;     ; mov al,dh
    
;     ; pop bx

;     ; mov al,15
;     ; add al,ch
;     ; push bx
;     ; mov bx,buf
;     ; mov al,cl
;     ; times 4 shr al,1
;     ; sub al,7
;     ; cs xlat
;     ; pop bx

;     ; mov al,dh           ; y
;     ; times 3 shr al,1    ; /=8
;     ; ; add al,ch           ; +=t
;     ; and al,15           ; wrap (werkt dit ook voor negatieve getallen?)
;     ; ; times 2 shl al,1    ; *=4
;     ; mov bx,sin
;     ; cs xlat                ; extract sin value
;     mov al,cl
;     times 4 shr al,1    ; /=16
;     add al,ch

    

;     call draw_dot_color
;     inc dl              ; x
;     inc cl              ; i
;     add di,8
;     cmp dl,16
;     jl repeatX
;     mov dl,0
;     add di,(cols-16)*8    ; skip remaining cols
;     inc dh
;     cmp dh,16
;     jl repeatY
;     inc ch              ; t
;     jmp top



; fx0:
;     mov al,ch           ; t
;     times 2 shr al,1    ; /=2
;     and al,15           ; wrap (werkt dit ook voor negatieve getallen?)
;     times 2 shl al,1    ; *=4
;     mov bx,sin
;     cs xlat                ; extract sin value
;     ret

; draw_dot_color:
;     mov bx,0xf000    ; red
;     call draw_dot
;     or al,al
;     jns .draw_blue_green  ; check sign bit for negative number
;     mov al,0         ; clear dot on blue and green channel
; .draw_blue_green:
;     neg al
;     mov bx,0xf400    ; blue
;     call draw_dot
;     mov bx,0x0c00    ; green
;     call draw_dot
;     ret

; draw_dot:
;     push di
;     push ax
;     push cx
;     mov ah,al    
;     or al,al
;     jns .positive
;     neg al
; .positive:
;     mov es,bx    ; vram
;     and al,15    ; limit to 15 (4 bits)
;     mov cl,8
;     mul cl    ; ax=al*8
;     mov si,ax
;     add si,img
;     times 4 cs movsw
;     add di,(4*cols)-8
;     mov si,ax
;     add si,img+128
;     times 4 cs movsw
;     pop cx
;     pop ax
;     pop di
;     ret

; table: db fx0

; sin:
;     db 0x00,0x01,0x03,0x04,0x06,0x07,0x09,0x0A,0x0B,0x0C,0x0D,0x0E,0x0E,0x0F,0x0F,0x0F
;     db 0x0F,0x0F,0x0F,0x0F,0x0E,0x0E,0x0D,0x0C,0x0B,0x0A,0x09,0x07,0x06,0x04,0x03,0x01

;     db 0x00,0xFF,0xFD,0xFC,0xFA,0xF9,0xF7,0xF6,0xF5,0xF4,0xF3,0xF2,0xF2,0xF1,0xF1,0xF1
;     db 0xF1,0xF1,0xF1,0xF1,0xF2,0xF2,0xF3,0xF4,0xF5,0xF6,0xF7,0xF9,0xFA,0xFC,0xFD,0xFF

; img:
;     db 0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x80
;     db 0x00,0x00,0x00,0x01,0x00,0x00,0x00,0xC0,0x00,0x00,0x00,0x01,0x00,0x00,0x00,0xC0
;     db 0x00,0x00,0x00,0x03,0x00,0x00,0x80,0xE0,0x00,0x00,0x00,0x03,0x00,0x00,0x80,0xE0
;     db 0x00,0x00,0x03,0x07,0x00,0x00,0xE0,0xF0,0x00,0x00,0x03,0x07,0x00,0x00,0xE0,0xF0
;     db 0x00,0x00,0x07,0x0F,0x00,0x80,0xF0,0xF8,0x00,0x00,0x07,0x0F,0x00,0x80,0xF0,0xF8
;     db 0x00,0x03,0x0F,0x1F,0x00,0xE0,0xF8,0xFC,0x00,0x07,0x1F,0x1F,0x00,0xF0,0xFC,0xFC
;     db 0x00,0x0F,0x1F,0x3F,0x80,0xF8,0xFC,0xFE,0x00,0x0F,0x3F,0x3F,0x80,0xF8,0xFE,0xFE
;     db 0x07,0x1F,0x3F,0x7F,0xF0,0xFC,0xFE,0xFF,0x07,0x3F,0x7F,0x7F,0xF0,0xFE,0xFF,0xFF
;     db 0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00
;     db 0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00
;     db 0x00,0x00,0x00,0x00,0x80,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x80,0x00,0x00,0x00
;     db 0x03,0x00,0x00,0x00,0xE0,0x00,0x00,0x00,0x03,0x00,0x00,0x00,0xE0,0x00,0x00,0x00
;     db 0x07,0x00,0x00,0x00,0xF0,0x80,0x00,0x00,0x07,0x00,0x00,0x00,0xF0,0x80,0x00,0x00
;     db 0x0F,0x03,0x00,0x00,0xF8,0xE0,0x00,0x00,0x1F,0x07,0x00,0x00,0xFC,0xF0,0x00,0x00
;     db 0x1F,0x0F,0x00,0x00,0xFC,0xF8,0x80,0x00,0x3F,0x0F,0x00,0x00,0xFE,0xF8,0x80,0x00
;     db 0x3F,0x1F,0x07,0x00,0xFE,0xFC,0xF0,0x00,0x7F,0x3F,0x07,0x00,0xFF,0xFE,0xF0,0x00

; buf:
;     times 16*16 db 5

; %include "lib.asm"
; incbin "Sanyo-MS-DOS-2.11-minimal.img",($-$$)  ; include default disk image skipping first 512 bytes

