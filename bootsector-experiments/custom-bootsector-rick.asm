; Rick Companje, March 29th, 2022
cpu 8086
org 0x0

    jmp code

    db 'Sanyo1.2'
    db 0x00,0x02,0x02,0x01,0x00,0x02,0x70,0x00,
    db 0xd0,0x02,0xfd,0x02,0x00,0x09,0x00,0x02,
    db 0x00,0x00,0x00,0x00,0x00,0x1c,0x00,0xff,
    db '       Sanyo MBC-550/555        ',0x00

; cols equ 16
offsetLeftTop equ 4*24 + 4*80*8


CRTC:
.profile25x72:
   db 112  ;0  Horizontal Total
   db 72   ;1  Horizontal Displayed
   db 85   ;2  Horizontal Sync Position
   db 0x4a ;3  Horizontal and Vertical Sync Widths
   db 65   ;4  Vertical Total
   db 0    ;5  Vertical Total Adjust
   db 50   ;6  Vertical Displayed
   db 56   ;7  Vertical Sync position
   db 0    ;8  Interlace and Skew
   db 3    ;9  Maximum Raster Address

.profile25x80:
    db 112  ;0  Horizontal Total
    db 80   ;1  Horizontal Displayed
    db 88   ;2  Horizontal Sync Position
    db 0x4a ;3  Horizontal and Vertical Sync Widths
    db 65   ;4  Vertical Total
    db 0    ;5  Vertical Total Adjust
    db 50   ;6  Vertical Displayed
    db 56   ;7  Vertical Sync position
    db 0    ;8  Interlace and Skew
    db 3    ;9  Maximum Raster Address

code:  
    mov si,CRTC.profile25x72
    mov bx,0
    cld
.lp:
    mov al,bl
    out 0x30,al            ;CRTC address port
    mov al,[cs: bx+si+0]
    out 0x32,al            ;CRTC data port
    inc bx
    cmp bl,10
    jl .lp


    
    call clr

    mov ax,0x0c00
    mov es,ax

    mov ax,cs
    mov ds,ax

    mov ax,0xf400
    mov bp,ax
    xor bx,bx

    cld

top:
    mov di,offsetLeftTop
    
    mov al,-15
    call drawDotWithColor     ;
; top:
;     mov di,offsetLeftTop
;     mov si,img
; cell:

;     mov cx,32*4
;     rep movsb

;     add di,40*4
;     mov cx,32*4
;     rep movsb

    jmp top


drawDotWithColor:
    push bp
    mov bp,0xf000  ; red
    mov es,bp
    call drawDot
    mov bp,0x0c00  ; green
    mov es,bp
    call drawDot
    mov bp,0xf400  ; blue
    mov es,bp
    call drawDot
    pop bp

; wat ook kan is dat ik in drawDot altijd naar alle 3 kleuren schrijf
; en afhankelijk van het -teken schrijf ik een 0 of een karakter

drawDot:
    push di
    push ax
    push cx
    
    ; or al,al
    ; pushf

    ; jns .return

    call abs8

    mov cl,8
    mul cl        ; ax=al*8

    mov si,ax
    add si,img
    times 4 movsw

    add di,320-40
    mov si,ax
    add si,img+128
    times 4 movsw
    
    pop cx
    pop ax
    pop di
    ret


    ; mov cx,cols*4
    ; mov al,85
    ; rep stosb

    ; mov si,img
    ; mov cx,128
    ; rep movsb

    ; add di,320-128
    ; mov cx,128
    ; rep movsb

    ; add di,320-128
    ; inc bx
    ; cmp bx,16
    ; jle cell
    ; mov ax,0xf400
    ; mov es,ax
    ; cmp bx,20
    ; jle top

    hlt

;     ; set up 25x80
;     ; mov dx,0x30 ;CRTC address port
;     ; mov di,0x32 ;CRTC data port
;     ; mov si,CRTC.profile25x80
;     ; mov al,[si+6] ;get # rows*2
;     ; shr ax,1      ;divide by 2 (reg 6 has 4 scanline rows, chars are 8)
;     ; dec ax        ;subtract 1 (it's zero based)
;     ; mov [BV.ScreenRows],al
;     ; call CRTC_LoadProfile

;     ; mov al,0x4
;     ; out 0x10,al

;     ; call clr

;     mov al,0x04
;     out 0x10,al
;     mov ax,0x0c00
;     mov es,ax

;     mov ax,cs
;     mov ds,ax

;     mov ax,0xf400
;     mov bp,ax
;     xor bx,bx


;     hlt

;     ; mov al,0x4
;     ; out 0x10,al
;     ; ; mov al,0x5
;     ; ; out 0x10,al

;     ; mov ax,0x0800
;     ; mov es,ax

;     ; mov ax,cs
;     ; mov ds,ax

;     ; mov ax,0xf400
;     ; mov bp,ax
;     ; xor bx,bx

;     ; cld

; top:
;     mov di,offsetLeftTop
    
;     mov al,-8
;     call drawDotWithColor     ;
; ; top:
; ;     mov di,offsetLeftTop
; ;     mov si,img
; ; cell:

; ;     mov cx,32*4
; ;     rep movsb

; ;     add di,40*4
; ;     mov cx,32*4
; ;     rep movsb

;     jmp top


; drawDotWithColor:
;     push bp
;     mov bp,0xf000  ; red
;     mov es,bp
;     call drawDot
;     mov bp,0x0400  ; green
;     mov es,bp
;     call drawDot
;     mov bp,0xf400  ; blue
;     mov es,bp
;     call drawDot
;     pop bp

; ; wat ook kan is dat ik in drawDot altijd naar alle 3 kleuren schrijf
; ; en afhankelijk van het -teken schrijf ik een 0 of een karakter

; drawDot:
;     push di
;     push ax
;     push cx
    
;     ; or al,al
;     ; pushf

;     ; jns .return

;     call abs8

;     mov cl,8
;     mul cl        ; ax=al*8

;     mov si,ax
;     add si,img
;     times 4 movsw

;     add di,320-40
;     mov si,ax
;     add si,img+128
;     times 4 movsw
    
;     pop cx
;     pop ax
;     pop di
;     ret


;     ; mov cx,cols*4
;     ; mov al,85
;     ; rep stosb

;     ; mov si,img
;     ; mov cx,128
;     ; rep movsb

;     ; add di,320-128
;     ; mov cx,128
;     ; rep movsb

;     ; add di,320-128
;     ; inc bx
;     ; cmp bx,16
;     ; jle cell
;     ; mov ax,0xf400
;     ; mov es,ax
;     ; cmp bx,20
;     ; jle top

;     hlt


;     ; xor di,di
;     ; mov al,255
;     ; stosb
;     ; hlt

img:
    db 0,0,0,0,  0,0,0,0,  0,0,0,0,  0,0,0,128
    db 0,0,0,1,  0,0,0,192,  0,0,0,1,  0,0,0,192
    db 0,0,0,3,  0,0,128,224,  0,0,0,3,  0,0,128,224
    db 0,0,3,7,  0,0,224,240,  0,0,3,7,  0,0,224,240
    db 0,0,7,15,  0,128,240,248,  0,0,7,15,  0,128,240,248
    db 0,3,15,31,  0,224,248,252,  0,7,31,31,  0,240,252,252
    db 0,15,31,63,  128,248,252,254,  0,15,63,63,  128,248,254,254
    db 7,31,63,127, 240,252,254,255, 7,63,127,127, 240,254,255,255

    db 0,0,0,0,  0,0,0,0,  0,0,0,0,  0,0,0,0
    db 0,0,0,0,  0,0,0,0,  0,0,0,0,  0,0,0,0
    db 0,0,0,0,  128,0,0,0,  0,0,0,0,  128,0,0,0
    db 3,0,0,0,  224,0,0,0,  3,0,0,0,  224,0,0,0
    db 7,0,0,0,  240,128,0,0,  7,0,0,0,  240,128,0,0
    db 15,3,0,0,  248,224,0,0,  31,7,0,0,  252,240,0,0
    db 31,15,0,0,  252,248,128,0,  63,15,0,0,  254,248,128,0
    db 63,31,7,0,  254,252,240,0,  127,63,7,0,  255,254,240,0

; ;     stosb

; ;     mov al,128
; ;     mov si,0
; ;     mov di,0
; ; forY:
; ;     mov dx,0
; ; forX:
; ;     test dx,di
; ;     jz inc_si
; ;     mov [si],al
; ; inc_si:
; ;     add si,4
; ;     add dx,8
; ;     cmp dx,639
; ;     jl forX
    
; ;     add di,4
; ;     cmp di,199
; ;     jl forY

; ;     hlt    

; ;     mov al,0
; ;     cld
; ; top:
; ;     mov cx,0x1000
; ;     xor di,di
; ;     ; in al,0x24
; ;     inc al
; ; input:
; ;     stosb
; ;     stosb
; ;     stosb
; ;     stosb
; ;     ; add di,3
; ;     ; loop input

; ;     ; push ax
; ;     ; mov ax,0xf000
;     ; mov es,ax
;     ; pop ax

;     ; jmp top


;     ; cli
;     ; cld
;     ; mov ax,cs
;     ; mov ds,ax
;     ; mov ss,ax
;     ; mov sp,0x400
    
;     ; db 0x33,0xff                         ; xor di,di
;     ; db 0x33,0xf6                         ; xor si,si

;     ; mov ax,0x20
;     ; db 0x8E,0xC0 ; mov es,ax
;     ; mov cx,0x100
;     ; repz movsw

;     ; push es
;     ; mov ax,_0x106
;     ; push ax
;     ; retf

; ; _0x106:
; ;     mov ax,cs
; ;     mov ds,ax
; ;     mov ax,0
; ;     db 0x8E,0xC0 ; mov es,ax
; ;     db 0xBF,0x00,0x00 ; mov di,0
; ;     mov dx,0x400

; ;     test byte [cs:0x15],0x2
; ;     jnz _0x121
; ;     inc dh
; ;     inc dh
; ; _0x121:
; ;     mov cx,0x1
; ;     jmp _0x54
; ; _0x127:
; ;     mov ax,cs
; ;     mov ds,ax
; ;     db 0x33,0xC0  ; xor ax,ax
; ;     db 0x8E,0xC0  ; mov es,ax
; ;     db 0x8B,0xF8  ; mov di,ax
; ;     db 0x8B,0xD8  ; mov bx,ax
; ;     mov dl,0xf
; ; _0x135:
; ;     mov si,0xd1
; ;     jmp short _0x143
; ; _0x13a:
; ;     db 0x0A,0xDB; or bl,bl
; ;     jnz _0x15b
; ;     mov bl,0x1
; ; _0x140:
; ;     db 0xBE,0xDC,0x00  ;mov si,0xdc
; ; _0x143:
; ;     db 0x8B,0xEF  ;mov bp,di
; ;     mov cx,0xb
; ;     repe cmpsb
; ;     db 0x8B,0xFD ; mov di,bp
; ;     jz _0x13a
; ;     add di,byte +0x20
; ;     dec dl
; ;     jz _0x192
; ;     db 0x0A,0xDB  ;or bl,bl
; ;     jz _0x135
; ;     jmp short _0x140
; ; _0x15b:
; ;     mov byte [cs:0x1e],0x1
; ;     mov ax,0x40
; ;     db 0x8E,0xC0 ; mov es,ax
; ;     db 0xBF,0x00,0x00 ; mov di,0
; ;     mov ax,0x7
; ;     test byte [cs:0x15],0x1
; ;     jz _0x177
; ;     mov ax,0xa
; ; _0x177:
; ;     mov dl,0x8
; ;     test byte [cs:0x15],0x2
; ;     jnz _0x186
; ;     mov dl,0x9
; ;     db 0x05,0x02,0x00 ; add ax,0x2
; ; _0x186:
; ;     div dl
; ;     inc ah
; ;     db 0x8B,0xD0 ;mov dx,ax
; ;     mov cx,0x54
; ;     jmp _0x54
; ; _0x192:
; ;     db 0x2E,0x8E,0x06,0x1F,0x00 ;  mov es,[cs:0x1f]
; ;     db 0x33,0xC0  ; xor ax,ax
; ;     db 0x33,0xff                         ; xor di,di
; ;     mov cx,0x4000
; ;     rep stosw
; ;     mov al,0x5
; ;     out 0x10,al
; ;     mov ds,[cs:0x21]
; ;     mov dx,0x1b50
; ;     db 0x33,0xDB ; xor bx,bx
; ; _0x1ae:
; ;     db 0x2E,0x8A,0x87,0x23,0x00; mov al,[cs:bx+0x23]
; ;     inc bx
; ;     db 0x0A,0xC0 ;or al,al
; ; _0x1b6:
; ;     jz _0x1b6    ;  ??? endless loop? incorrect offset...?
; ;     mov cl,0x8
; ;     mul cl
; ;     db 0x8B,0xF0 ;mov si,ax
; ;     db 0x8B,0xFA; mov di,dx
; ;     mov es,[cs:0x1f]
; ;     mov ch,0x2
; ; _0x1c7:
; ;     mov cl,0x2
; ; _0x1c9:
; ;     lodsw   
; ;     mov [es:di],ax            
; ;     inc di    
; ;     inc di    
; ;     dec cl    
; ;     jnz _0x1c9        
; ;     add di,0x11c          
; ;     dec ch    
; ;     jnz _0x1c7        
; ;     add dx,byte +0x4              
; ;     jmp short _0x1ae              
; ;     loopne 0x16b     ; incorrect address...?                                     
; ;     inc si    
; ;     db 0xf0,0x8b,0x46,0xf4       ; lock mov ax,[bp-0xc]                  
; ;     mov cl,0x7        
; ;     shr ax,cl       
; ;     mov [bp-0xe],ax             
; ;     push word [bp-0x14]                 
; ;     mov bl,[0x160e]             
; ;     mov bh,0x0        
; ;     shl bx,1      
; ;     push word [bx+0xa2e]                  
; ;     ; call 0x0000:0x000a                                ; call IO.SYS  ?      
; ;     db 0x9a,0x0a,0x00   ; missing two bytes here for call . Are those bytes in IO.SYS?

%include "lib.asm"

incbin "Sanyo-MS-DOS-2.11-minimal.img",($-$$)  ; include default disk image skipping first 512 bytes

