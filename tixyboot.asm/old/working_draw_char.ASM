; t: db 0
; i: db 0
; x: db 0
; y: db 0
; db t,i,x,y

RED equ 0xf000
GREEN equ 0x0c00
BLUE equ 0xf400

setup:
    call cls
    push cs
    pop ds
    mov ax,RED
    mov es,ax

    mov dh,0          ; t
draw:
    mov dl,0          ; i
    mov bl,0          ; y
    mov di,0          ; top left offset
    mov si,img
y:
    mov bh,0          ; x
x:
    mov ah,0
    mov al,bh
    mov cl,4
    mul cl
    mov si,ax
    add si,img



; TODO 'render' chars to mem and draw/stamp from mem

    ; mov cl,4    is already 4 from mul above            ; char is 4 nibbles
draw_char:
    lodsb                   ; use lodsb instead of movsb to keep a copy in al
    stosb                   ; draw in left top nibble
    push bx                 ; save cur x and y
    push cx                 ; cur loop counter (4,3,2,1)
    push cx
    pop bx                  ; bx = counter
    shl bx,1                ; bx *= 2
    push bx                 ; save counter*2 for right bottom
    
    cmp bx,2                ; skip top line of left bottom nibble
    je .j1
    es mov [di+bx+314-1],al ; draw in left bottom starting at line 3 instead of 4
.j1:

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

    es mov [di+3],ah        ; draw in right top nibble
    pop bx                  ; bx = counter*2
    
    cmp bx,2                ; skip top line of right bottom nibble
    je .j2
    es mov [di+bx+318-1],ah ; draw in right bottom starting at line 3 instead of 4
.j2:
    pop cx                  ; restore loop counter
    pop bx                  ; restore x and y

    loop draw_char

    %assign num $-draw_char
    %warning draw_char num bytes




;;;;;;;;;;;;;;;;;;;;;

    add di,4          ; next col
    inc dl            ; i++
    inc bh            ; x++
    cmp bh,16
    jl x

    add di,192+320    ; next row
    inc bl            ; y++
    cmp bl,16
    jl y

    inc dh            ; t++
    jmp draw          ; next frame

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

end:

    ; db 0,0,0,0,0,0,0,0
    ; db 0,0,0,1,0,0,0,0
    ; db 0,0,0,3,0,0,0,128
    ; db 0,0,1,3,0,0,0,128
    ; db 0,0,3,7,0,0,128,192
    ; db 0,0,7,7,0,0,192,192
    ; db 0,1,7,15,0,0,192,224
    ; db 0,3,15,15,0,128,224,224
    ; db 0,15,31,63,0,224,240,248
    ; db 1,31,63,63,0,240,248,248
    ; db 7,31,31,63,192,240,240,248
    ; db 15,31,63,63,224,240,248,248
    ; db 15,63,63,127,224,248,248,252
    ; db 31,63,127,127,240,248,252,252
    ; db 31,127,255,255,240,252,254,254
    ; db 63,127,255,255,248,252,254,254

    ; dit zijn mijn originele dots. die hierboven zijn symmetrischer
    ; db 0,0,0,0,  0,0,0,0, 
    ; db 0,0,0,0,  0,0,0,128
    ; db 0,0,0,1,  0,0,0,192,  
    ; db 0,0,0,1,  0,0,0,192
    ; db 0,0,0,3,  0,0,128,224,  
    ; db 0,0,0,3,  0,0,128,224
    ; db 0,0,3,7,  0,0,224,240,  
    ; db 0,0,3,7,  0,0,224,240
    ; db 0,0,7,15,  0,128,240,248,  
    ; db 0,0,7,15,  0,128,240,248
    ; db 0,3,15,31,  0,224,248,252,  
    ; db 0,7,31,31,  0,240,252,252
    ; db 0,15,31,63,  128,248,252,254,  
    ; db 0,15,63,63,  128,248,254,254
    ; db 7,31,63,127, 240,252,254,255, 
    ; db 7,63,127,127, 240,254,255,255
;

%assign num $-$$
%warning total num