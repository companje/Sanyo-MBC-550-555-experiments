RED equ 0xf000
GREEN equ 0x0c00
BLUE equ 0xf400

setup:
    call cls
    call render_chars

    mov di,0

    mov cx,15
y:
    push cx
    mov cx,15
x:
    mov ax,cx

    ; mov bp,draw_char
    
    mov bp,RED
    call draw_char

    mov bp,GREEN
    call draw_char

    mov bp,BLUE
    call draw_char

    add di,8
    loop x

    pop cx
    add di,520
    loop y

    hlt

draw_char:                  ;es:di=vram (not increasing), al=char 0..15
    push ax
    push cx
    push di

    push bp
    pop es                  ;es=bp
    push cs
    pop ds                  ;ds=cs

    mov cx,4
    push cx
    push cx
    shl al,cl               ;al*=16
    add ax,data
    xchg si,ax

    pop cx                  ;cx=4
    rep movsw
    add di,320-8
    pop cx                  ;cx=4
    rep movsw

    pop di                    
    pop cx                  
    pop ax
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


%include "render_chars.ASM"

%assign num $-$$
%warning total num

data:
    times 2000 db 0
