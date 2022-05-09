; t: db 0
; i: db 0
; x: db 0
; y: db 0
; db t,i,x,y

setup:
    call cls
    mov dh,0          ; t
draw:
    mov dl,0          ; i
    mov bl,0          ; y
    mov di,0          ; top left
y:
    mov bh,0
    ; push cx
    ; mov cx,16
x:
    mov al,255
    mov cx,8
    rep stosw

    inc dl            ; i++
    inc bh            ; x++
    cmp bh,16
    jl repeatX
    add di,192+320
    inc bl            ; y++
    cmp bl,16
    jl repeatY

    jmp draw


;     al=rnd*32-16
;     call drawdot
;     i++
;     x++
;     loop x
;     pop cx
;     loop y

;     t++
;     jmp draw

; drawdot:
;     mov cx,8
;     mov al,0xFFFF
;     rep stosw
;     ret

cls:
    ret