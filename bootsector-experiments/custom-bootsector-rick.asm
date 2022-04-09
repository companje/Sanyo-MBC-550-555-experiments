; Rick Companje, March 29th, 2022
cpu 8086
org 0x0

    jmp code

    db 'Sanyo1.2'
    db 0x00,0x02,0x02,0x01,0x00,0x02,0x70,0x00,
    db 0xd0,0x02,0xfd,0x02,0x00,0x09,0x00,0x02,
    db 0x00,0x00,0x00,0x00,0x00,0x1c,0x00,0xff,
    db '       Sanyo MBC-550/555        ',0x00

cols equ 80
offsetLeftTop equ 4*24 + 4*cols*8

col: db 0
row: db 0
index: dw 0
; cursorIndex: db 0

t: db 0
i: db 0
x: db 0
y: db 0


code:  
    mov si,CRTC.profile25x80
    call CRTC.setProfile
    call clearScreen

draw:
    mov di,0   ; 0*4*cols

    mov bx,0x0c00
    mov es,bx
    mov di,0
    
    mov al,0
charset:
    call putChar
    inc al
    add di,4
    ; call nextChar

    cmp al,85
    jl charset

    ; add di,cols*4


    hlt

; nextChar:
;     push ax
;     push dx
;     cs inc word [index]
;     cs mov ax,[index]
;     inc ax
;     mov dx,cols
;     div dx
;     cmp dx,0
;     jne .nextCol
; .nextLine:
;     add ax,cols*4
; .nextCol:
;     add ax,4
;     mov di,ax
;     pop dx
;     pop ax
    

setCursor:
    ;bh,bl = row,col

putChar:               ; draw char with code al to es:di, di increases with 8. 
    push ax
    push bx
    mov bx,0xfd00      ; ROM charset
    mov ds,bx
    cbw                ; extend al into ax, clear ah
    shl ax,1
    shl ax,1
    shl ax,1           
    mov si,ax          ; si=charcode*8
    movsw
    movsw
    add di,cols*4-4    ; next nibble below current
    movsw
    movsw
    sub di,cols*4+4    ; return to nibble above
    pop bx
    pop ax
    ret

; updateCursor:

    ; inc byte [col]

; getCharShape:          ; al=char code, output point to char in DS:SI
    

    ; lodsw

;     mov dl,0    ; i
;     mov bl,0    ; y
;     ; mov di,9*(4*cols)+cols ; view topleft
;     mov di,8 + 8*cols
; repeatY:
;     mov bh,0    ; x
; repeatX:
    ; push bp
    ; push bx
    ; xchg bx,bp
    ; mov bp,[bx+table]
    ; and bp,0xff
    ; or bp,0x0100
    ; pop bx
    ; call bp
    ; pop bp

    ; call fx0

;     cld
;     mov cx,8
; asdf:
;     mov al,15

;     push bx
;     mov bx,0xf000    ; red
;     call drawchar
;     ; mov bx,0x0c00    ; green
;     ; call drawchar
;     ; mov bx,0xf400    ; blue
;     ; call drawchar
;     pop bx

;     add di,8

;     loop asdf


;     jmp draw


    ; add di,8

    ; inc dl    ; i++
    ; inc bh    ; x++
    ; cmp bh,16
    ; jl repeatX
    ; add di,(cols-16)*8
    ; inc bl    ; y++
    ; cmp bl,16
    ; jl repeatY

    ; inc dh    ; t++

; drawchar:
;     push di
;     push ax
;     mov es,bx ; vram
;     and al,15    
;     mov cl,8
;     mul cl    ; ax=al*8
;     mov si,ax
;     add si,img
;     times 4 cs movsw
;     add di,(4*cols)-8
;     mov si,ax
;     add si,img+128
;     times 4 cs movsw
;     pop ax
;     pop di
;     ret

; table: db fx0

; fx0:
;     mov al,15
;     ; mul bl
;     ; add al,dh
;     ret

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

%include "lib.asm"

incbin "Sanyo-MS-DOS-2.11-minimal.img",($-$$)  ; include default disk image skipping first 512 bytes

