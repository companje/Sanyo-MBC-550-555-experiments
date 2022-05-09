cpu 8086
org 0x0

%define DO_DRAW

RED equ 0xf000
GREEN equ 0x0c00
BLUE equ 0xf400
cols equ 80
rows equ 25
lines equ 200

setup:
%ifdef DO_DRAW
    call cls
%endif

prepare_stamps:
    push cs
    push cs
    pop ds
    pop es
    mov si,input
    mov di,end

;     mov cx,16
; expand_all:
;     push cx

;     push si
;     push di
; expand/expand all nog niet geschikt voor meer dan 1 dot.
;si en di line 45 zijn nog gelijk telkens
;en meer wellicht...

expand:
    movsw
    movsw          ; copy the first 4 bytes (left top)
    sub si,4       ; go back 4 bytes DS:SI
    mov cx,4
hloop:             ; right top 
    lodsb
    push cx
    call flip_bits               ; result in ah 
    pop cx
    xchg al,ah
    stosb
    loop hloop

    ;left bottom + right bottom
    mov si,end+3

    hlt
    mov di,end+8
    mov cx,8
vloop1:
    movsb
    cmp cx,5
    jne cont1
    mov si,end+9
cont1:
    dec si
    dec si
    loop vloop1

    ; pop di
    ; pop si
    ; pop cx

    ; loop expand_all


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
%ifdef DO_DRAW
    mov cx,16
    mov di,0
draw16:
    call draw_dot
    loop draw16

    hlt


draw_dot:   ;di=start_pos, TODO al=-15..15
    push cx
    mov bx,RED
    mov es,bx
    mov si,end
    mov ax,0 ;tmp
    add si,ax

    mov cx,8
    rep movsb
    push di
    add di,78*4
    mov cx,8
    rep movsb
    pop di
    pop cx
    ret


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

%endif

    ; expected result (hex)
;  07 1F 1F 3F   C0 F0 F0 F8
;  3F 1F 1F 07   F8 F0 F0 C0


;right bottom
; hlt
; si=56
; di=61
    ; inc di


    ; mov di,end+8+4
;     mov cx,4
; vloop2:
;     dec si
;     dec si
;     movsb
;     loop vloop2

    hlt



; 31 0x1F
; 63 0x3F
;127 0x7F
;192 0xC0
;240 0xF0
;248 0xF8
input:
    ; db 0x07,0x1F,0x1F,0x3F ;, 0xC0,0xF0,0xF0,0xF8 ; => 7,31,31,63, = 192,240,240,248 (hor.flip)
img:                                     ; 64 bytes
    db 0, 15, 31, 63                   

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



; lut:                                     ; 18 bytes
;     db 0,1,  3,  7, 15, 31, 63,127,255   ; key
;     db 0,0,128,192,224,240,248,252,254   ; value

; expected result1:
;     db 7,31,31,63,  192,240,240,248      ; hflip lt to rt
;     db 63,31,31,7,  248,240,240,192      ; vflip t to b



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

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
    %assign num $-flip_bits
    %warning flip_bits num bytes

end:
    db 0

%assign num $-$$
%warning total num


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;






; ; Rick Companje, April 27, 2022
; ; experiment using HORIZONTAL FLIP of left-top corner nibble
; ; image data 64 bytes for 16 nibbles
; ; lookup table of 18 bytes for the 8 different used bit patterns
; ; 70 bytes of code just to mirror the nibbles horizontally
; ; conclusion: having 64 bytes of extra image data 
; ; containing the flipped nibble might be better...

; ; still need vertical mirror code but that might be an easy postprocessing step


; cpu 8086
; org 0x0

; RED equ 0xf000
; GREEN equ 0x0c00
; BLUE equ 0xf400
; cols equ 80
; rows equ 25
; lines equ 200

; setup:
;     call cls

; draw:
;     cld
;     mov bp,RED
;     mov es,bp
;     xor di,di

;     push cs
;     pop ds    ; mov ds,cs

;     ; xor ax,ax
;     mov cx,16
; y:  
;     push cx
;     mov cx,16
; x:  
;     mov ax,16
;     sub ax,cx 
;     times 3 shl ax,1 ; AL*=8
;     add ax,img
;     xchg ax,si

;     movsw
;     movsw
;     movsw
;     movsw
;     loop x

;     add di,512; 192 + 320; 192=remaining space, 320=whole row
;     pop cx
;     loop y
    
; ;v mirror

; TODO
;     hlt

; cls:
;     mov ax,GREEN
;     mov cx,0x4000                        ; =16384
;     xor di,di
;     mov es,ax                            ; es=GREEN
;     rep stosb                        
;     mov ah,0xf0                          ; ax=RED
;     mov es,ax                            ; red + blue 
;     xor di,di
;     mov ch,0x80                          ; cx=0x8000
;     rep stosb
;     ret
    
; img:
;     db 0,0,0,0,0,0,0,0
;     db 0,0,0,1,0,0,0,0
;     db 0,0,0,3,0,0,0,128
;     db 0,0,1,3,0,0,0,128
;     db 0,0,3,7,0,0,128,192
;     db 0,0,7,7,0,0,192,192
;     db 0,1,7,15,0,0,192,224
;     db 0,3,15,15,0,128,224,224
;     db 0,15,31,63,0,224,240,248
;     db 1,31,63,63,0,240,248,248
;     db 7,31,31,63,192,240,240,248
;     db 15,31,63,63,224,240,248,248
;     db 15,63,63,127,224,248,248,252
;     db 31,63,127,127,240,248,252,252
;     db 31,127,255,255,240,252,254,254
;     db 63,127,255,255,248,252,254,254

; ; lut:                                     ; 18 bytes
; ;     db 0,1,  3,  7, 15, 31, 63,127,255          ; key
; ;     db 0,0,128,192,224,240,248,252,254   ; value
