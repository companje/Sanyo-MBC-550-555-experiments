%include "sanyo.asm" 

count EQU 44000
threshold EQU 10

setup:
    mov si,sound + 44
    mov cx,count

play:
    lodsb
    cmp al,128+threshold
    mov al,8
    ja .out
    cmp al,128-threshold
    mov al,0
    ja .next
.out:
    out 0x3a,al
.next:
    push cx
    mov cx,20
    .wait loop .wait
    pop cx
    loop play
    ; hlt
    jmp setup


sound: incbin "data/CyberDreams-clip.wav"

times (360*512)-($-$$) db 0

