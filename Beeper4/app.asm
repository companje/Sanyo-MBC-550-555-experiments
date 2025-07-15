jmp setup

G3  equ 0xFD  ;253 = 196Hz
A3  equ 0xE1  ;225 = 220Hz
B3  equ 0xC9  ;201 = 247Hz
; -----
C4  equ 0xBE  ;190 = 262Hz
D4  equ 0xA8  ;168 = 294Hz
E4  equ 0x96  ;150 = 330Hz
F4  equ 0x8E  ;142 = 349Hz
G4  equ 0x7E  ;    = 393Hz
Gs4 equ 0x77  ;    = 416Hz
A4  equ 0x70  ;    = 442Hz
As4 equ 0x6A  ;    = 466Hz
B4  equ 0x64  ;    = 494Hz
; -----
C5  equ 0x5e  ;    = 527Hz
D5  equ 0x54  ;    = 588Hz
Ds5 equ 0x4F  ;    = 625Hz
E5  equ 0x4B  ;    = 658Hz
F5  equ 0x47  ;    = 695Hz
Fs5 equ 0x43  ;    = 736Hz
G5  equ 0x3F  ;    = 782Hz 
Gs5 equ 0x3B  ; 
A5  equ 0x37  ;    = 881Hz
B5  equ 0x34  ;    = ????
; ----
C6  equ 0x2F  ;    = ???

; G3  equ 0xFD  ; = 196Hz
; C4  equ 0xBE  ; = 262Hz
; E4  equ 0x96  ; = 330Hz
; B3  equ 0xC9  ; = 247Hz
; D4  equ 0xA8  ; = 294Hz
; A3  equ 0xE1  ; = 220Hz
; F4  equ 0x8E  ; = 349Hz

NUM equ 32 ; wonderful days
PULSE_W equ 60
T equ 2*NUM

song: ; wonderful days
db G3,C4,E4,C4
db G3,C4,E4,C4
db G3,B3,D4,B3
db G3,B3,D4,B3
db A3,D4,F4,D4
db A3,D4,F4,D4
db A3,C4,E4,C4
db A3,C4,E4,C4

; song:
; db C4,C4
; db G5,G5,G5,G5,G5,G5

; db G3,C4,E4,0
; db G3,B3,D4,0
; db G3,B3,D4,0

times 48 db 0

couplet: db 0
maat: db 0
noot: db 0

setup:
    push cs
    pop ds
    mov si,song
    mov ax,0x0800
    mov es,ax
update:
    inc bp

    test bp,1
    jz .ch2
.ch1:
    mov bh,0
    lodsb
    mov bl,al
    cmp bp,T
    jb .done_ch
    mov dx,10
    call play
    jmp .done_ch
.ch2:
    push cx
    mov cx,bp
    mov al,[mm]
    xor ah,ah
    and cx,ax
    shl bx,cl
    pop cx
    mov dx,[dv]
    shr bx,1    ; higher
    call play
    mov al,[mm]
    cmp bp,1*T
    jne .xx
    mov word [dv],PULSE_W-10
.xx:
    cmp bp,6*T-T/5 ;4*T+T/2+5
    jg .q
    cmp bp,5*T
    jg .p
    cmp bp,4*T
    jg .o
    cmp bp,3*T
    jg .z
    cmp bp,2*T
    jg .x
    cmp bp,1*T
    jg .z
    jmp .done_ch
.q: hlt
.p: add word [dv],3
.o: ror al,1
.x: rol al,1
    rol al,1
.z: mov [mm],al
.done_ch:
    call draw
  
    cmp si,song+NUM
    jb update
    mov si,song
    jmp update

play:             ; bx=note, dx=duration
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

draw:
ret

    push si
    push ds
    mov ax,0xff00
    mov ds,ax

;     xor di,di

;     mov si,8
;     lodsw

    test bp,1
    jz .xx
    xor ax,ax

;     mov cx,14400
;     rep stosb
.xx:


    push cx
    mov cx,14400/64
    .lp:
    stosw
    ; movsw
    ; add di,3
    add di,bp

    cmp di,14400
jna .x
    sub di,14400
    ; xor di,di

push cx
    mov cx,14400/16
    xor ax,ax
    rep stosw
pop cx

    xor di,di

; push ax
; push cx
; push di
;     mov cx,14400
;     mov ax,0
;     .lp2
;     stosw
;     add di,bp
;     cmp di,14400
;     jna .xx
;     sub di,14400
;   .xx:
;     loop .lp2

; pop di
; pop cx
; pop ax
    ; sub di,14400
    
.x:

    ; add di,8
    loop .lp
    pop cx
    pop ds
    pop si
    ret



mm: db 1
dv: dw PULSE_W

%assign num $-$$
%warning total num
times (180*1024)-num db 0


