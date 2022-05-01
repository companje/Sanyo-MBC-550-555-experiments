; t: db 0
; i: db 0
; x: db 0
; y: db 0
; db t,i,x,y

RED equ 0xf000
GREEN equ 0x0c00
BLUE equ 0xf400

setup:
    call cls
    push cs
    pop ds
    mov ax,RED
    mov es,ax

    mov dh,0          ; t
draw:
    mov dl,0          ; i
    mov bl,0          ; y
    mov di,0          ; top left
    mov si,img
y:
    mov bh,0          ; x
x:
    ; mov al,255
    mov ah,0
    mov al,bh
    mov cl,8
    mul cl
    mov si,ax
    add si,img
    mov cl,4
    ; push bx   
char_top:  ; leeg, punt, min, plus
    lodsw
    push ax
    stosw
    loop char_top

;;;;;;;;;;;;;;;;;;;;;;;;

    ; add di,320-2*4
    ; mov al,0
    ; times 8 stosb
    ; sub di,320

char_bottom:
    add di,318
    std
    mov cl,2
.1: pop bp
    mov al,0
    stosb
    pop ax
    ; xchg ah,al   
    stosb
    xchg ax,bp
    ; xchg ah,al   
    stosb
    ; mov al,0
    xor al,al
    stosb
    loop .1
    cld
    sub di,310

    ; hlt

    inc dl            ; i++
    inc bh            ; x++
    cmp bh,16
    jl x
    add di,192+320
    inc bl            ; y++
    cmp bl,16
    jl y

    jmp draw


;     al=rnd*32-16
;     call drawdot
;     i++
;     x++
;     loop x
;     pop cx
;     loop y

;     t++
;     jmp draw

; drawdot:
;     mov cx,8
;     mov al,0xFFFF
;     rep stosw
;     ret

cls:
    mov ax,GREEN
    mov cx,0x4000                        ; =16k
    xor di,di
    mov es,ax                            ; es=GREEN
    rep stosb                        
    mov ah,0xf0                          ; ax=RED
    mov es,ax                            ; red + blue 
    xor di,di
    mov ch,0x80                          ; cx=32k
    rep stosb
    ret

flip_bits:        ; flip the bits of al. result in AH (35 bytes)
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
    ret

img:
    ; db 0, 0, 0, 0                        ; empty
    ; db 0, 0, 0, 1                        ; dot
    ; db 0, 0, 0, 3                        ; minus
    ; db 0, 0, 1, 3                        ; plus
    ; db 0, 0, 3, 7                        ; hat
    ; db 0, 0, 7, 7                        ; block
    ; db 0, 1, 7, 15                       ; star
    ; db 0, 3, 15, 15                      ; fat plus
    ; db 0, 15, 31, 63                   
    ; db 1, 31, 63, 63                     ; tol
    ; db 7, 31, 31, 63                     ; robot head
    ; db 15, 31, 63, 63
    ; db 15, 63, 63, 127
    ; db 31, 63, 127, 127
    ; db 31, 127, 255, 255
    ; db 63, 127, 255, 255

    db 0,0,0,0,0,0,0,0
    db 0,0,0,1,0,0,0,0
    db 0,0,0,3,0,0,0,128
    db 0,0,1,3,0,0,0,128
    db 0,0,3,7,0,0,128,192
    db 0,0,7,7,0,0,192,192
    db 0,1,7,15,0,0,192,224
    db 0,3,15,15,0,128,224,224
    db 0,15,31,63,0,224,240,248
    db 1,31,63,63,0,240,248,248
    db 7,31,31,63,192,240,240,248
    db 15,31,63,63,224,240,248,248
    db 15,63,63,127,224,248,248,252
    db 31,63,127,127,240,248,252,252
    db 31,127,255,255,240,252,254,254
    db 63,127,255,255,248,252,254,254

    ; dit zijn mijn originele dots. die hierboven zijn symmetrischer
    ; db 0,0,0,0,  0,0,0,0, 
    ; db 0,0,0,0,  0,0,0,128
    ; db 0,0,0,1,  0,0,0,192,  
    ; db 0,0,0,1,  0,0,0,192
    ; db 0,0,0,3,  0,0,128,224,  
    ; db 0,0,0,3,  0,0,128,224
    ; db 0,0,3,7,  0,0,224,240,  
    ; db 0,0,3,7,  0,0,224,240
    ; db 0,0,7,15,  0,128,240,248,  
    ; db 0,0,7,15,  0,128,240,248
    ; db 0,3,15,31,  0,224,248,252,  
    ; db 0,7,31,31,  0,240,252,252
    ; db 0,15,31,63,  128,248,252,254,  
    ; db 0,15,63,63,  128,248,254,254
    ; db 7,31,63,127, 240,252,254,255, 
    ; db 7,63,127,127, 240,254,255,255
;


    ; org 0x100
; RED equ 0xf000
; GREEN equ 0x0c00
; BLUE equ 0xf400
; cols equ 80
; rows equ 25
; lines equ 200

; setup:
;     call cls
;     ; hlt
;     ; mov ax,GREEN
;     ; mov es,ax
;     ; mov ax,0xFFFF
;     ; mov di,0
;     ; stosw
;     ; hlt


;     ; mov ax,0x0002
;     ; int 0x10    ; cls + reset scroll
;     ; xor bp,bp    ; effect nr
;     mov dh,0    ; t
; draw:
;     mov dl,0    ; i
;     mov bl,0    ; y
;     mov di,9*320+80    ; view top left
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
;     ; mov al,15

; ;     push bx
; ;     cmp al,0
; ;     jge white
; ; gray:
; ;     mov bx,RED
; ;     mov es,bx
; ;     neg al
; ;     call drawchar
; ;     mov bx,GREEN
; ;     mov es,bx
; ;     mov al,0
; ;     call drawchar
; ;     jmp nextchar
; ; white:
; ;     mov bx,GREEN
; ;     mov es,bx
; ;     call drawchar
; ;     mov bx,RED
; ;     mov es,bx
; ;     call drawchar

;     mov al,255
;     stosb

; nextchar:
;     ; pop bx
;     add di,8
;     inc dl        ; i++
;     inc bh        ; x++
;     cmp bh,16
;     jl repeatX
;     add di,192+320
;     inc bl        ; y++
;     cmp bl,16
;     jl repeatY

; key:
;     ; in al,0x38
;     ; cmp al,0x1b
;     ; je end
;     ; mov ah,0
;     ; sub al,0x30
;     ; and al,7
;     ; mov bp,ax

;     inc dh        ; t++
;     jmp draw

; ; end:
; ;     mov ah,0
; ;     int 0x16
; ;     int 0x20

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

; table:      db fx1
; ; table:    db fx0,fx1,fx2,fx3,fx4,fx5,fx6,fx7

; ; fx0:            ; sierpinsky triangle
; ;     mov al,bl
; ; ;add al,dh
; ;     and al,bh
; ;     jnz fx0nz
; ;     mov al,0
; ;     ret
; ; fx0nz:
; ;     mov al,10
; ;     ret

; fx1:            ; x*y+t
;     mov al,bh
;     mul bl
;     add al,dh
;     ret

; ; fx2:            ; noise from timer
; ;     in al,0x22
; ;     ret

; ; fx3:
; ;     in al,0x20    ; 0x20 0x22 0x24 are timers
; ;     ret

; ; fx4:            ; y-x
; ;     mov al,bl
; ;     sub al,bh
; ;     ret

; ; fx5:
; ;     mov al,dl    ; al=i
; ;     mov ch,dh    ; t
; ;     mov cl,5
; ;     shr ch,cl    ; slowdown subeffect switching
; ;     mul ch        ; al=i*t/8
; ;     add al,dh    ; al+=t
; ;     ret

; ; fx6:            ; ?
; ;     mov al,dl
; ;     sub al,dh
; ;     ret

; ; fx7:            ; soort binary clock
; ;     mov al,bh
; ;     and al,dh
; ;     ret



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

; %assign num $-$$
; %warning total num