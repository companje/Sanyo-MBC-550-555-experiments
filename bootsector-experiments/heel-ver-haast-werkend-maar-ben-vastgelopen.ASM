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

    ; call render_chars


    mov ax,RED
    push ax
    pop es
    push cs
    pop ds

    ; mov si,img2
    ; mov di,0

    ; mov cx,16*16
    ; rep movsb

    hlt


    mov dh,0          ; t
draw:
    mov dl,0          ; i
    mov bl,0          ; y
    mov di,640        ; top left offset  keep 1st 8 lines safe for now
    ; mov si,img
y:
    mov bh,0
x:

    ; mov al,1
    ; and al,15
    ; cbw                ;ah=0
    ; xchg si,ax

    ; mov cl,4
    ; shl si,cl
    ; add si,0

    mov si,0    ; steps of 16 (4 nibbles * 4 lines)

    inc cl
    rep movsw
    push di
    push si
    add di,320-8
    ; add si,320-8
    mov cl,4
    rep movsw
    pop si
    pop di
    
    inc dl            ; i++
    inc bh            ; x++
    cmp bh,16
    jl x

    ; add di,4
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

; TODO 'render' chars to mem and draw/stamp from mem
render_chars:
    ; push cs
    push cs
    pop ds
    ; pop es

    mov ax,RED
    mov es,ax

    mov di,0          ; dest address of render data
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
    call render_char   ; input cl=4

    add di,4*3          ; next col
    inc bh            ; x++
    cmp bh,16
    jl render16
    ret

    ; mov cl,4    is already 4 from mul above            ; char is 4 nibbles
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
    je .j1
    es mov [di+bx+8-7],al ; draw in left bottom starting at line 3 instead of 4
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
    es mov [di+bx+8-3],ah ; draw in right bottom starting at line 3 instead of 4
.j2:
    pop cx                  ; restore loop counter
    pop bx                  ; restore x and y

    loop render_char
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

img2:
    db 0,0,0,0,  0,0,0,0,  0,0,0,0,  0,0,0,128
    db 0,0,0,1,  0,0,0,192,  0,0,0,1,  0,0,0,192
    db 0,0,0,3,  0,0,128,224,  0,0,0,3,  0,0,128,224
    db 0,0,3,7,  0,0,224,240,  0,0,3,7,  0,0,224,240
    db 0,0,7,15,  0,128,240,248,  0,0,7,15,  0,128,240,248
    db 0,3,15,31,  0,224,248,252,  0,7,31,31,  0,240,252,252
    db 0,15,31,63,  128,248,252,254,  0,15,63,63,  128,248,254,254
    db 7,31,63,127, 240,252,254,255, 7,63,127,127, 240,254,255,255
    db 0,0,0,0,  0,0,0,0,  0,0,0,0,  0,0,0,0
    db 0,0,0,0,  0,0,0,0,  0,0,0,0,  0,0,0,0
    db 0,0,0,0,  128,0,0,0,  0,0,0,0,  128,0,0,0
    db 3,0,0,0,  224,0,0,0,  3,0,0,0,  224,0,0,0
    db 7,0,0,0,  240,128,0,0,  7,0,0,0,  240,128,0,0
    db 15,3,0,0,  248,224,0,0,  31,7,0,0,  252,240,0,0
    db 31,15,0,0,  252,248,128,0,  63,15,0,0,  254,248,128,0
    db 63,31,7,0,  254,252,240,0,  127,63,7,0,  255,254,240,0


end:
    times 2000 db 255

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