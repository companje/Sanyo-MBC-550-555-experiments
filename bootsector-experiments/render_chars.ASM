
render_chars:
    push cs
    push cs
    pop ds              ; ds:si in code segment
    pop es              ; es:di in code segment

    mov di,data          ; dest address of render data
    mov si,img
    mov bh,0

render16:
    mov ah,0
    mov al,bh
    mov cl,4
    mul cl
    mov si,ax
    add si,img

    ; now draw from the location where rendered to
    ; call render_char   ; input cl=4
render_char:
    lodsb                   ; use lodsb instead of movsb to keep a copy in al
    stosb                   ; draw in left top nibble
    push bx                 ; save cur x and y
    push cx                 ; cur loop counter (4,3,2,1)
    push cx
    pop bx                  ; bx = counter
    shl bx,1                ; bx *= 2
    push bx                 ; save counter*2 for right bottom
    
    cmp bx,2                ; skip top line of left bottom nibble
    je .flip_bits
    mov [di+bx+8-7],al ; draw in left bottom starting at line 3 instead of 4
.flip_bits:                 ; flips all bits dropping highest bit
    mov cl,8                ; 8 bits to flip
    mov ah,0
.bit:
    mov bx,0x8001           ; bl=1, bh=128  bl doubles, bh halves
    shl bl,cl
    test al,bl
    jz .next
    dec cx
    shr bh,cl
    or ah,bh
    inc cx
.next:
    loop .bit               ; loop 8 bits for flipping

    mov [di+3],ah           ; draw in right top nibble
    pop bx                  ; bx = counter*2
    
    cmp bx,2                ; skip top line of right bottom nibble
    je .j2
    mov [di+bx+8-3],ah ; draw in right bottom starting at line 3 instead of 4
.j2:
    pop cx                  ; restore loop counter
    pop bx                  ; restore x and y

    loop render_char

    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

    add di,4*3          ; next col
    inc bh            ; x++
    cmp bh,16
    jl render16
    ret

img:
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

    %assign num $-render_char
    %warning render and img num bytes

