
render_chars:
    push cs
    push cs
    pop ds                  ; ds:si in code segment
    pop es                  ; es:di in code segment
    mov di,data             ; dest address of render data
    xor bh,bh
.render_char:
    xor ah,ah
    mov al,bh
    mov cl,4
    mul cl
    mov si,ax
    add si,img
.render_char_part:          ; input requirement at first time cl=4
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
    mov [di+bx+1],al        ; draw in left bottom starting at line 3 instead of 4
.flip_bits:                 ; flips all bits dropping highest bit
    mov cl,8                ; 8 bits to flip
    xor ah,ah
.flip_bit:
    mov bx,0x8001           ; bl=1, bh=128  bl doubles, bh halves
    shl bl,cl
    test al,bl
    jz .next_bit
    dec cx
    shr bh,cl
    or ah,bh
    inc cx
.next_bit:
    loop .flip_bit          ; loop 8 bits for flipping
    mov [di+3],ah           ; draw in right top nibble
    pop bx                  ; bx = counter*2
    cmp bx,2                ; skip top line of right bottom nibble
    je .flip_done
    mov [di+bx+5],ah        ; draw in right bottom starting at line 3 instead of 4
.flip_done:
    pop cx                  ; restore loop counter
    pop bx                  ; restore x and y
    loop .render_char_part
.clear_bottom_line:
    add di,7
    xor al,al
    stosb                   ; right bottom
    add di,3
    stosb                   ; left bottom
.next_char:
    inc bh                  ; next char
    cmp bh,16
    jl .render_char
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
    db 1, 31, 63, 63                     ; spindle
    db 7, 31, 31, 63                     ; robot head
    db 15, 31, 63, 63
    db 15, 63, 63, 127
    db 31, 63, 127, 127
    db 31, 127, 255, 255
    db 63, 127, 255, 255

    %assign num $-render_chars
    %warning render and img num bytes

