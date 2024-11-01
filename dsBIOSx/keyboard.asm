INT16:  ;keyboard API
.getfun
    ;jmp short .nofun
.eshift
    ;jmp short .nofun
.entry  ;call IntPrint
    ;call CheckIt
    push bp
    push bx
    mov bp,sp
    xchg ah,al
    cmp al,1
    je .checkkey    ;check for keystroke
    jb .getkey  ;get keystroke
    cmp al,3
    je .shift   ;get shift flags
    cmp al,5
    je .store   ;store keystroke
    cmp al,9
    je .getfun  ;get keyboard functionality
    cmp al,0x10
    je .getkey  ;get enhanced keystroke
    jb .nofun
    cmp al,0x12
    ;je .eshift  ;get extended shift states
    jb .checkkey    ;check for enhanched
.nofun  xchg ah,al
.noex   pop bx
    pop bp
    iret
.getkeyptr
    cli ;clear interrupts for this operation
    cs mov bx,[BV.NextKey]
    cs cmp [BV.FirstFreeKey],bx
    ret
.checkkey
    sti ;make sure interrupts were enabled at least for a moment
    or [bp+8],byte 0x40 ;was +4 ;set zero to on ;SS
    call .getkeyptr
    je .nocheck
    cs mov ax,[bx]
    xchg ah,al
    xor [bp+8],byte 0x40 ;was +4 ;toggle zero ;SS
.nocheck
    jmp short .nofun
.getkeywaitlp
    sti ;interrupts still disabled
    hlt ;interrupts disabled until halted
.getkey
    call .getkeyptr
    je .getkeywaitlp  ;loop until we have a keypress
    cs mov ax,[bx]
    inc bx
    inc bx
    cs cmp [BV.KeyBufferEnd],bx ;do we need to loop over?
    jne .gnoloop
    cs mov bx,[BV.KeyBufferStart]
.gnoloop
    cs mov [BV.NextKey],bx
    jmp short .noex
.shift
    cs mov al,[0]   ;FIXME
    jmp short .noex
.store
    push ax
    push ds
    push cs
    pop ds
    cli ;don't want two things updating the buffer at once!
    mov bx,[BV.FirstFreeKey]
    mov [bx],cx
    lea ax,[bx+2]
    cmp [BV.KeyBufferEnd],ax    ;do we need to loop over?
    jne .noloop
    mov ax,[BV.KeyBufferStart]
.noloop ;if it was full, we'll pretend it never happened
    cmp [BV.NextKey],ax
    je .dropkey
    mov [BV.FirstFreeKey],ax
.dropkey
    pushf
    call ProcessKeys ;just in case they sent a special key
    popf
    pop ds
    pop ax
    mov ah,0    ;can't use xor here
    jne .bufnotfull
    inc ah
.bufnotfull
    jmp short .nocheck;.nofun

KeyUART: ;stack usage: 4+1 words
    cli
    push ax
    push bx
    push ds
    in al,0x3a
    test al,2
    jz .jiret
    ;ok, we know we have a key
    push cs
    pop ds
    ;let's get the character and write it to the buffer
    or al,0xf7  ;turn on all the bits besides parity in the status
    mov ah,al
    in al,0x38  ;get data byte
    mov bx,[BV.FirstFreeKey]
    mov [bx],ax
    lea ax,[byte 2+bx]
    cmp [BV.KeyBufferEnd],ax    ;do we need to loop over?
    jne .noloop
    mov ax,[BV.KeyBufferStart]
.noloop ;if it was full, we'll pretend it never happened
    cmp [BV.NextKey],ax
    je .dropkey
    mov [BV.FirstFreeKey],ax
.dropkey
    mov al,0x37
    out 0x3a,al
    call ProcessKeys
.jiret  pop ds
    pop bx
    pop ax
    iret

ProcessKeys:
    ;destroys ax,bx,ds
    mov ax,0xfe00
    mov ds,ax
    ;do locking checks
    test byte [BV.LFlags+0x2400],0xe ;is something else in progress?
    jz .doit
    or byte [BV.LFlags+0x2400],0x20 ;yes, do it later
    ret
.doit   ;start with the first used key
    mov bx,[BV.NextKey+0x2400]
.pkloop ;retrieve the key to ax
    cs mov ax,[bx]
    ror ah,1
    ror ah,1
    ror ah,1
    xor ah,0xfe ;ah is 0 for no ctrl, 1 for ctrl
    test ah,0xfe
    jnz .noproc ;key was already processed
    ;process 'special' keys here, zero ax to clear them from the buffer
    cmp ax,0x103 ;ctrl break
    jne .nobreakout
    xor ax,ax
    cs mov [bx],ax  ;store key
    jmp Menu_Breakout
.nobreakout
    shl ax,1
    xchg ax,bx
    mov bx,[bx] ;do ROM lookup
    xchg ax,bx
    cs mov [bx],ax  ;store key
.noproc ;gotta check if we're to the free keys
    cmp [BV.FirstFreeKey+0x2400],bx
    je DisplayString.jret  ;yep, get out
    inc bx
    inc bx
    ;do we need to wrap over?
    cmp [BV.KeyBufferEnd+0x2400],bx
    jne .pkloop
    mov bx,[BV.KeyBufferStart+0x2400]
    jmp short .pkloop
