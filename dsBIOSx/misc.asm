INT11:
    cs mov ax,[BV.Equipment]
    iret

INT12:
    cs mov ax,[BV.TotalRAM]
NoInterrupt:
    iret

Reboot:
    mov al,0xff
    out 0x3a,al ;reset keyboard UART for buggy OSes *cough*SANYO*cough*
    jmp 0xffff:0

INT15:
    push bp
    mov bp,sp
    or [bp+6],byte 1 ;set carry - helps with freedos memory detection
    pop bp
    iret
   ;call IntPrint
;   cmp ah,0xc0
;   jne NoInterrupt
;   push cs
;   pop es
;   mov bx,.table
;   xor ah,ah
;   popf
;   clc
;   retf
;.table dw .endtable-.starttable
;.starttable
;   db 0xf7 ;model
;   db 0 ;submodel
;   db 0 ;BIOS Revision
;   db 0
;   db 0x84 ;int16/ah=9 supported & non-8042 keyboard
;   db 2    ;IML System
;   db 8    ;ABIOS not supported
;   db 0
;   db "dsBIOS",0
;.endtable


INT29:  ;fast console output
    ;push ax
    push bx
    mov bl,7
    cs mov bh,[BV.CurPage]
    push si
    call OnBoardVideo.WrTT
    pop si
    pop bx
    ;pop ax
    iret

FPUInterrupt:
    int 0x75
    int 0x2
    iret

DisplayString:
    ;ds:si=string, si is incremented to character after null
    ;bl=attribute
    ;direction flag must be set as desired, this clears carry
    push ax
    push bx
.lp lodsb
    or al,al
    jz .done
    int 0x29
    jmp short .lp
.done
    pop bx
    pop ax
.jret
    ret

DisplayNAX:
    push ax
    push dx
    push cs ;high byte is zero
.clp    xor dx,dx
    cs div word [.base]
    xchg ax,dx
    add ax,0xe30
    push ax
    xchg ax,dx
    or ax,ax
    jnz .clp
.dlp    pop ax
    or ah,ah
    jz .done
    int 0x29
    jmp short .dlp
.done   pop dx
    pop ax
    ret
.base   dw 10

%ifdef PigsFly

DrawBox: ;this code is unfinished
    ;  Input:  AH=upper left row, AL=upper left col
    ;          BH=#rows (outside dimension, zero is width 1) BL=#cols
    ;Trashed:  CX, DX
    ;Internal: DX=current cursor pos

    ;Draw top line
    mov dx,al

    mov al,2 ;set cursor
    int 0x10
    mov al,201 ;upper left
    int 0x29

    mov cx,bx
    mov al,205 ;top mid
.topmid
    dec cl
    jz .notopmid
    int 0x29
    dec cl
    jmp short .topmid
.notopmid
    mov al,topright
    int 0x29

    ;now the middle portion

    inc

    ret

DisplayNAXH: ;Displays AX in hexadecimal
    push ax
    push dx
    push cs ;high byte is zero
    xor dx,dx
    cs div word [.base]
    add dx,0xe30
    push dx
    xor dx,dx
    cs div word [.base]
    add dx,0xe30
    push dx
    xor dx,dx
    cs div word [.base]
    add dx,0xe30
    push dx
    xor dx,dx
    cs div word [.base]
    add dx,0xe30
    push dx
.dlp    pop ax
    or ah,ah
    jz .done
    cmp al,0x3a
    jb .dit
    add al,7
.dit    int 0x29
    jmp short .dlp
.done   pop dx
    pop ax
    ret
.base   dw 16

IntPrint: ;meant to be called as first instruction of an interrupt handler
          ;(prints out registers and waits for a key)
    push ds
    push ax
    push si
    push cs
    pop ds
    push word [BV.CursorPos]
    mov [BV.CursorPos],word 0x1400
    mov si,MsgReg
    call DisplayString
    mov si,sp
    ss mov ax,[si+12];10]
    mov ds,ax
    ss mov si,[si+10];8]
    mov ax,[si-2]
    cs mov [BV.CursorPos],byte 4
    call DisplayNAXH
    cs mov [BV.CursorPos],byte 14
    mov si,sp
    ss mov ax,[si+4]
    call DisplayNAXH
    mov ax,bx
    call DisplayNAXH
    mov ax,cx
    call DisplayNAXH
    mov ax,dx
    call DisplayNAXH
    cs mov [BV.CursorPos],byte 36
    ss mov ax,[si+12];10]
    call DisplayNAXH
    ss mov ax,[si+6]
    call DisplayNAXH
    mov ax,es
    call DisplayNAXH
    mov ax,ss
    call DisplayNAXH
    ss mov ax,[si+10];8]
    call DisplayNAXH
    cs pop word [BV.CursorPos]
    pushf
    push cs
    mov ax,.gkret
    push ax
    push bp
    push bx
    jmp INT16.getkey
.gkret  pop si
    pop ax
    pop ds
    ret
%endif
