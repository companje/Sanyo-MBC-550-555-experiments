Menu_Breakout:
    cld
    push ax
    push dx
    push ds
    push es
    mov ax,cs
    mov ds,ax
    mov es,ax
.clearKey
    xor ax,ax
    int 0x16
    mov ah,1
    int 0x16
    jnz .clearKey

    ;test [BV.LFlags],byte 1
    ;jz .noVideo
    ;or [BV.LFlags],byte 0x40 ;request breakout callback upon video completion    mov al,'#'
    ;int 0x29
    ;pop es
    ;pop ds
    ;pop dx
    ;pop ax
    ;ret
.noVideo

    or [BV.LFlags],byte 8
    ;mov al,[BV.LFlags]
    ;and [BV.LFlags],byte 0xbf
    ;and al,0x40
    ;int 0x29

.lp0    in al,0x3a
    test al,1
    jz .lp0
    mov al,0x18
    out 0x38,al
.keyloop
    xor ax,ax
    int 0x16
    cmp al,'r'
    jne .noReboot
    jmp Reboot
.noReboot
    cmp al,'0'
    jne .no0
    mov dl,0
    jmp short .setkey
.no0
    cmp al,'1'
    jne .no1
    mov dl,1
    jmp short .setkey
.no1
    cmp al,'c'
    jne .noc
    push si
    push di
    call InitCGA
    pop di
    pop si
.noc


.lp1    in al,0x3a
    test al,1
    jz .lp1
    mov al,0x18
    out 0x38,al

    and [BV.LFlags],byte 0xf7
    pop es
    pop ds
    pop dx
    pop ax
    ret

.setkey
    push bx
    push cx
    push si
    push di
    mov di,BV.EncKey
    call Enter_Key
    pushf
    mov bx,dx
    and bx,byte 1
    add bx,BV.DFlags
    ror byte [bx],1
    popf
    cmc
    rcl byte [bx],1
    call Generate_Subkeys
    pop di
    pop si
    pop cx
    pop bx
jmp short .lp0


Menu_SaveVideo:
;save cursor position
;save line 1
;configure for single line video
    ret

Menu_RestoreVideo:
;restore video settings
;restore line 1
;restore cursor position
    ret