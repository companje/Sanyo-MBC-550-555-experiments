G3  equ 0xFD  ; = 196Hz
C4  equ 0xBE  ; = 262Hz
E4  equ 0x96  ; = 330Hz
B3  equ 0xC9  ; = 247Hz
D4  equ 0xA8  ; = 294Hz
A3  equ 0xE1  ; = 220Hz
F4  equ 0x8E  ; = 349Hz

setup:
    mov bx,F4
    mov dx,1000
    call play
    hlt

play:              ; bx=note, dx=duration
    mov cx,bx
    mov ax,0x35
.a: xor al,8       ; toggle 'break' bit
    out 0x3a,al    ; USART
.b: dec ah
    jnz .c
    dec dx
    jz .e
.c: loop .b
    mov cx,bx      ; reset note
    jmp .a
.e: ret


times (360*512)-($-$$) db 0


