abs8:
    or al,al
    jns .return
    neg al
.return ret

clr:
    mov ax,0x0c00
    mov es,ax
    xor ax,ax
    ; mov ax,85
    mov di,ax
    mov cx,8000
    ; mov al,85
    ; mov ah,85
    cld 
    rep stosw
    ret