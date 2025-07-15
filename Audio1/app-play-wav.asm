%include "sanyo.asm" 

count EQU -1
threshold EQU 30
delay EQU 70

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
    mov cx,delay
    .wait loop .wait
    pop cx
    loop play
    ; hlt
    jmp setup


sound: incbin "data/2000.wav"

times (180*1024)-($-$$) db 0

