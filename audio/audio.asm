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

NOTE dw 400

setup:
;background(GREEN)
    mov ax,BLUE
    mov es,ax
    mov ax,-1
    mov cx,0x2000
    xor di,di
    rep stosw
    
; TODO it doesn't loop right yet.
; you only hear a short sound on boot


audio:

    cli
    mov cx,1000    ; note
    mov dx,50000   ; duration
    mov ax,0x35
    push cs
    pop ds
play:
    xor al,8
    out 0x3a,al
    dec ah
    jnz play2
    dec dx
    jz exit
play2:
    loop play

exit:
    xor al,8
    cmp al,35
    jnz exit
    out 0x3a,al

;background(GREEN)
    mov ax,RED
    mov es,ax
    mov ax,-1
    mov cx,0x2000
    xor di,di
    rep stosw

    jmp audio

    hlt


%assign num $-$$
%warning total num
times 368640-num db 0                 ; fill up with zeros until file size=360k

