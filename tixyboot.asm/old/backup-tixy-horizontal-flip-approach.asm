; Rick Companje, April 23-27, 2022
; experiment using HORIZONTAL FLIP of left-top corner nibble
; image data 64 bytes for 16 nibbles
; lookup table of 18 bytes for the 8 different used bit patterns
; 70 bytes of code just to mirror the nibbles horizontally
; conclusion: having 64 bytes of extra image data 
; containing the flipped nibble might be better...

; still need vertical mirror code...


cpu 8086
org 0x0

%define USE_HOR_FLIP

RED equ 0xf000
GREEN equ 0x0c00
BLUE equ 0xf400
cols equ 80
rows equ 25
lines equ 200

setup:
    call cls

draw:
    cld
    mov bp,RED
    mov es,bp
    xor di,di

    push cs
    pop ds    ; mov ds,cs

    xor ax,ax
    mov cx,16
y:  push cx
    mov cx,16
x:  
    mov ax,cx
    dec ax
    times 2 shl ax,1 ; AL*=4
    add ax,img
    xchg ax,si

    movsw
    movsw
    add di,4
    loop x
    add di,512; 192 + 320; 192=remaining space, 320=whole row
    pop cx
    loop y
    

%ifdef USE_HOR_FLIP
; horizontal mirrored copy in vram (takes 68 bytes excluding 18 bytes lut...)
    xor si,si ; start at 1st col
    mov di,4  ; start at 2nd col

    mov bp,RED  ;source ds:si (red)
    mov ds,bp
    mov bp,GREEN  ;dest es:di (green)
    mov es,bp

    mov cx,16                ; 16 cols    
mirror_copy_outer_loop:
    push cx
    mov cx,16                ; 16 cols

mirror_copy_inner_loop:
; hcopy:
    push cx
    mov cx,4                 ; 4 lines per row
lines_in_row:
    lodsb                    ; al=[ds:si++] (vram)

    push cx                  ; somehow repne scasb destroys cx
    push es
    push di

    push cs                  ; es=cs
    pop es                   ; es=cs, needed for scasb, somehow cannot use inline cs with repne/scasb

    mov cx,8                 ; repne uses cx
    mov di,lut
    repne scasb              ; cmp al,[es:di++] (lut)
    cs mov al,[di+8]         ; mirror using lut

    pop di
    pop es
    pop cx
    
    stosb                    ; [es:di++]=al (vram)

    loop lines_in_row

    pop cx
    add si,4                 ; skip 1 column
    add di,4                 ; skip 1 column

    loop mirror_copy_inner_loop
    pop cx

    add si,512                ; 192 + 320; 192=remaining space, 320=whole row
    add di,512                ; 192 + 320; 192=remaining space, 320=whole row

    loop mirror_copy_outer_loop
%endif

;final vertical copy loop

    hlt

cls:
    mov ax,GREEN
    mov cx,0x4000
    xor di,di
    mov es,ax                            ; green
    rep stosb                        
    mov ah,0xf0                          ; ax=RED
    mov es,ax                            ; red + blue 
    xor di,di
    mov ch,0x80
    rep stosb
    ret
    
img:                                     ; 64 bytes
    db 0, 0, 0, 0                        ; empty
    db 0, 0, 0, 1                        ; dot
    db 0, 0, 0, 3                        ; minus
    db 0, 0, 1, 3                        ; plus
    db 0, 0, 3, 7                        ; hat
    db 0, 0, 7, 7                        ; block
    db 0, 1, 7, 15                       ; star
    db 0, 3, 15, 15                      ; fat plus
    db 0, 15, 31, 63                   
    db 1, 31, 63, 63                     ; tol
    db 7, 31, 31, 63                     ; robot head
    db 15, 31, 63, 63
    db 15, 63, 63, 127
    db 31, 63, 127, 127
    db 31, 127, 255, 255
    db 63, 127, 255, 255

lut:                                     ; 18 bytes
    db 0,1,3,7,15,31,63,127,255          ; key
    db 0,0,128,192,224,240,248,252,254   ; value
