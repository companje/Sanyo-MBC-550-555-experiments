    mov al,7
    call flip_bits
    ; xor ah,ah
    ; push ax

    hlt

input:
    db 7,31,31,63

; lut:                                     ; 18 bytes
;     db 0,1,  3,  7, 15, 31, 63,127,255   ; key
;     db 0,0,128,192,224,240,248,252,254   ; value

result1:
    db 7,31,31,63,  192,240,240,248      ; hflip lt to rt
    db 63,31,31,7,  248,240,240,192      ; vflip t to b


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

flip_bits:        ; flip the bits of al
    mov cl,8
    mov ah,0
.bit: 
    mov bx,0x8001 ; bl=1, bh=128
    shl bl,cl
    test al,bl
    jz .cont
    dec cx
    shr bh,cl
    or ah,bh
    inc cx
.cont:
    loop .bit ;continue
    mov al,ah
    ret

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

