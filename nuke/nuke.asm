    cpu 8086
    org 0x00

    jmp setup

    db 'Sanyo1.2'
    db 0x00,0x02,0x02,0x01,0x00,0x02,0x70,0x00
    db 0xd0,0x02,0xfd,0x02,0x00,0x09,0x00,0x02
    db 0x00,0x00,0x00,0x00,0x00,0x1c,0x00
    db 0xff,'       Sanyo MBC-550/555        ',0x00

RED   equ 0xf000
GREEN equ 0x0c00
BLUE  equ 0xf400

setup:

    mov ax,GREEN
    mov es,ax
    mov bh,0     ; time

draw:
    xor di,di
    mov cx,1440  ; cx=3600..0 (72x50=3600)
lp:
    mov ax,di    ; ax=di=0..4*3600
    shr ax,1     ; /=2
    shr ax,1     ; /=2

    mov bl,72
    div bl        ; ah=ax/72, al=ax%72

    add al,bh     ; animate time
    add al,bh     ; animate time

    and al,ah     ; x&y
    mov al,255
    mov ah,255
    jz dot
    mov al,1+4+16+64
    mov ah,2+8+32+128
dot:
    times 2 stosw
    loop lp

    inc bh        ; time
    jmp draw

%assign num $-$$
%warning total num
times 368640-num db 0                 ; fill up with zeros until file size=360k


