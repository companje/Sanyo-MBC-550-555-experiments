; Rick Companje, April 23, 2022
cpu 8086
org 0x0

cols equ 80
rows equ 25
lines equ 200

setup:
    call cls

draw:
    cld
    mov bp,0xf000   ;red
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
    

; horizontal mirrored copy in vram
    xor si,si ; start at 1st col
    mov di,4  ; start at 2nd col

    mov bp,0xf000  ;source ds:si (red)
    mov ds,bp
    mov bp,0x0c00  ;dest es:di (green)
    mov es,bp
    
    mov cx,16*2*4

hcopy:

    ; push cx
    ; mov cx,4
lines_in_row:
    lodsb

    push cx    ; somehow repne scasb destroys cx
    push es
    push di

    push cs   ; es=cs
    pop es    ; es=cs, needed for scasb, somehow cannot use inline cs

    mov di,lut
    repne scasb ; cmp al,es:di, inc di
    cs mov al,[di+8] ; mirror using lut

    pop di
    pop es
    pop cx
    
    stosb

    ; loop lines_in_row
    ; pop cx
    ; add si,4 ;skip 1 column
    ; add di,4 ;skip 1 column

    loop hcopy

    hlt

cls:
    mov ax,0x0c00
    mov cx,0x4000
    xor di,di
    mov es,ax    ; green
    rep stosb
    mov ah,0xf0
    mov es,ax    ;  red + blue 
    xor di,di
    mov ch,0x80
    rep stosb
    ret
    
img: 
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

lut:
    db 0,1,3,7,15,31,63,127,255
    db 0,0,128,192,224,240,248,252,254
