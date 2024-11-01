OnBoardVideo:   ;interrupt handler
    push si
    cld
    mov si,ax
    mov al,ah
    test al,0xf0
    cbw ;clear ah
    xchg ax,si
    jnz .OutOfRange
    shl si,1
    ;cs or [BV.LFlags],byte 1
    cli ;reentrant?  hah!
    cs call [si+.jmptable]
.OutOfRange
    pop si
    ;cs and [BV.LFlags],byte 0xfe
    ;cs test [BV.LFlags],byte 0x40
    ;jnz .DoBIOSMenu
    iret
;.DoBIOSMenu
;    push ax
;    mov al,'#'
;    int 0x29
;    pop ax
;    call Menu_Breakout
;    iret
.SetGetCursor
    ;push bx
    ;mov bl,bh
    ;and bx,byte 7   ;pages not implemented in built-in video; always set page 0
    ;shl bx,1
    ;lea si,[byte BV.CursorPos+bx]
    ;pop bx
    sahf
    jnc .SetOnly
    cs mov dx,[BV.CursorPos] ;si
    cs mov cx,[BV.CEndLine]
    ret
.SetOnly
    ;hide cursor if drawn!! FIXME
    ;validate cursor position!! FIXME
    cs mov [BV.CursorPos],dx ;si for addr
    ;ret
.SetPage
    ;unimplimented for built-in video
    push di
    push dx
    push ax
    ;call InitCGA
    pop ax
    pop dx
    pop di

    ret
.SetMode
    ;hmm... not really sure about this one... let's clear the
    ;screen and reset the cursor?  The CGA will care more.
    push es
    push di
    push cx
    ;call InitCGA
    xor di,di
    cld
    mov ax,VideoSegment
    mov es,ax
    mov ax,di
    mov cx,0x2000 ;FIXME for hardware scrolling
    rep stosw
    cs mov word [BV.CursorPos],0
    pop cx
    pop di
    pop es
    mov ax,0030
    ret
.RdAttChr
    mov ax,0x0320 ;unimplimented for built-in video
.NoFunction
    ;ret
.SetCursorShape
    ;ret
.ScrollDn
    ret
.ScrollUp
    push bx
    push cx
    jmp .doscroll ;HACK HACK FIXME FIXME
    ;ret
.WrAttChr
    push ax
    push ds
    push es
    push di
    push cx
    push dx
    xchg ax,si  ;put ax in si (clears ah unless function > 127)
    cwd ;clear dx
    ;calculate dest. location
    ;xchg bh,bl
    ;mov di,bx
    ;xchg bh,bl
    ;and di,byte 7   ;max 8 pages
    ;shl di,1
    ;get the cursor data into ax and di (low=col high=row)
    cs mov ax,[BV.CursorPos];+di]
    ;take care of the row offset and swap it into di
    mov di,ax
    cs mov al,[BV.ScreenCols]
    mov dl,al
    shl dx,1
    shl dx,1
    mul ah
    shl ax,1
    xchg ax,di
    ;mask off the row
    cbw ;xor ah,ah (as long as rows < 128, this is safe)
    ;each col adds 4 to the offset
    ;add the col. offset on
    add di,ax
    times 2 shl di,1
    and si,0xff
    mov ax,VideoSegment
    mov es,ax
    mov ah,0xff
    mov ds,ax
    times 3 shl si,1
.repchr movsw
    movsw
    add di,dx ;(columns-1) * 4
    sub di,byte 4
    movsw
    lodsw
    cmp bl,1
    jne .noul
    mov ah,0xff
.noul   stosw
    sub di,dx ;columns * 4
    sub si,byte 8
    loop .repchr
    pop dx
    pop cx
    pop di
    pop es
    pop ds
    pop ax
    ret
.WrChr
    ;FIXME ideally, we read the old character and preserve the attribute?
    push bx
    mov bl,3
    call .WrAttChr
    pop bx
    ;ret
.WrPixel
    ;ret
.RdPixel
    ret

    ;WrTT starts here
.doscroll
    ;cs mov [BV.CursorPos+si],word 0
    ;xchg ax,si
    ;mov ax,1
    ;mov bh,bl
    ;xor cx,cx
    ;cs mov dl,[BV.ScreenCols]
    ;dec dx
    ;mov dh,24
    ;xchg ax,si
;.doscrollnocursor
    ;for now, just scroll up one line and blank last line
    push ax
    push ds
    push es
    ;bx, cx, and si are already preserved
    push di
    ;cld direction already cleared
    mov ax,VideoSegment
    mov es,ax
    mov ds,ax
    mov al,8
    cs mov cl,[BV.ScreenCols]
    mul cl
    mov si,ax   ;cols*8
    xor di,di
    cs mov al,[BV.ScreenRows]
    mul cl
    shl ax,1
    shl ax,1
    xchg ax,cx;cols*(rows-1)*4
    rep movsw
    xchg ax,cx
    xor ch,ch
    shl cx,1
    shl cx,1 ;cols*4
    ;xor ax,ax ;cleared from last rep movsw
    rep stosw
    pop di
    pop es
    pop ds
    pop ax
    jmp short .done

.do13   cs mov [BV.CursorPos],byte 0 ;+si for cursor pages
    pop bx
    ret
.offS   cs mov [BV.CursorPos],byte 0 ;+si
.do10   cs cmp byte [BV.CursorPos+1],24 ;+si
    je .doscroll
    cs inc byte [BV.CursorPos+1] ;+si
    pop cx
    pop bx
    ret
.doFF
    pop bx
    jmp .SetMode
.WrTT
    push bx
    ;hide cursor if drawn!! FIXME
    xchg bh,bl
    mov si,bx
    xchg bh,bl
    and si,byte 7
    shl si,1

    cmp al,13   ;cr
    ja .doNormalCX
    je .do13
    cmp al,8    ;backspace
    je .do8
    cmp al,12
    je .doFF
    push cx ;we need to keep cx at this point
    cmp al,9
    je .do9
    cmp al,10   ;lf
    je .do10
    cmp al,7    ;beep
    jne .doNormal
.do7    xchg ax,si
    mov cx,3
.lp7    in al,0x3a
    test al,1
    jz .lp7
    mov al,0x18
    out 0x38,al
    loop .lp7
    xchg ax,si
    jmp short .done

.doNormalCX
    push cx
.doNormal
    mov cx,1
    push ax
.doD    push si
    mov bl,3
    call .WrAttChr
    pop si
    pop ax
    cs add cx,[BV.CursorPos] ;+si
    ;check if past end of line
    cs cmp cl,[BV.ScreenCols]
    jae .offS
    cs mov [BV.CursorPos],cl ;normal increment +si
.done   pop cx
    pop bx
    ret
.do9    xor cx,cx
    cs mov cl,[BV.CursorPos] ;+si
    add cl,8
    and cl,0xf8
    cs sub cl,[BV.CursorPos] ;+si
    push ax
    mov al," "
    jmp short .doD
.do8    mov bl,0xff
    cs add bl,byte [BV.CursorPos] ;+si
    jnc .nobs
    cs mov [BV.CursorPos],bl ;+si
.nobs   pop bx
    ret

.GetState
    cs mov ax,[BV.CurMode]
    cs mov bh,[BV.CurPage]
    ret
.jmptable
    dw .SetMode
    dw .SetCursorShape
    dw .SetGetCursor ;set
    dw .SetGetCursor ;get
    dw .NoFunction
    dw .NoFunction ;.SetPage
    dw .ScrollUp
    dw .ScrollDn
    dw .RdAttChr
    dw .WrAttChr
    dw .WrChr
    dw .NoFunction
    dw .WrPixel
    dw .RdPixel
    dw .WrTT
    dw .GetState