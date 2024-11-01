InitList:
;Init interrupt table
    ;the default handler is 0x40:0x40 which points to an iret
    db 0x10
    dw OnBoardVideo
    db 0x11
    dw INT11
    db 0x12
    dw INT12
    db 0x13
    dw INT13.entry
    db 0x15
    dw INT15
    db 0x16
    dw INT16.entry
    db 0x18
    dw Reboot
    db 0x1a
    dw INT1A   ;system time api
    db 0x1d
    dw CGA ;video mode table
    db 0x29
    dw INT29
    db 0xf8    ;Timer0
    dw Timer0
    ;db 0xf9    ;Timer1
    ;dw Timer1
    ;db 0xfa
    ;dw
    db 0xfb ;Keyboard UART
    dw KeyUART
    ;db 0xfc
    ;dw
    db 0xfd ;Floppy Interrupt
    dw FloppyInt
    db 0xfe ;FPU Exception
    dw FPUInterrupt
    ;db 0xff    ;Expansion IRQ
    ;dw
    db 0 ;end list
;#############
;Hardware init list

;Video page
    dw 0x1000 ;Video @ segment 0x400
;Floppy seek track 0
    dw 0x0808 ;no verify
;keyboard controller:
    dw 0x3a00, 0x3a00, 0x3aff, 0x3aff, 0x3a37
;       \force state/  \reset/ \mode/  \set command
;8259A interrupt controller
    dw 0x0013, 0x02f8, 0x020f, 0x0296
;      \ICW1/  \ICW2/  \ICW4/  \mask/
;Timer init code
    dw 0x2634, 0x20bf, 0x2021 ;channel 0 (clock)
    dw 0x2674, 0x2200, 0x2200 ;channel 1 (2nd stage clock)
    dw 0x26b6, 0x245d, 0x2400 ;channel 2 (add-in serial rate)
;End hardware init
    dw 0 ;end list

Msg: ;IMPORTANT:  DO NOT REORDER FIRST 3 MESSAGES
; .title:
;     db "[dsBIOS] V1.02 - (C)2006 Brad Normand",0
; .HW:
;     db "       Memory:    KB",0xd,0xa
;     db "     CPU Type:",0xd,0xa
;     db "  Coprocessor:",0xd,0xa
;     db "    CGA Video:",0xd,0xa
;     ;db "     Aux Comm:",0xd,0xa
;     db "Floppy Drives:",0
; .i8088:
;     db "i8088",0
; .V20:
;     db "NEC V20",0
; .none:
;     db "None",0
; .detected:
;     db "Detected",0
; .text
;     db ", text mode initialized",0
; .keyBoot:
;     db 13,10,10,"Booting FreeDOS...",13,10,10,0
.RickyboyII:
    db "RickyboyII was here!",13,10,0

;MsgReg:    db "LAST     AX-DX                 CS-IP                     ",0
;MsgMCE db "Memory corruption detected at: 40:",0

BIOSEntry:
    ;switch to our local stack
    ;ax=0x40 at entry
    mov ss,ax
    mov sp,BV.LocalStack-24 ;extra zeros to pop
    mov ds,ax

    ;set up interrupt table - first write 0x40 to each word for segments
    pop di  ;zero from stack
    pop es  ;zero from stack
    mov ch,0x2  ;cl was cleared in first stage init
    ;direction was also cleared
    rep stosw

    ;set up 25x80
    mov dx,0x30 ;CRTC address port
    mov di,0x32 ;CRTC data port
    mov si,CRTC.profile25x80
    mov al,[si+6] ;get # rows*2
    shr ax,1      ;divide by 2 (reg 6 has 4 scanline rows, chars are 8)
    dec ax        ;subtract 1 (it's zero based)
    mov [BV.ScreenRows],al
    call CRTC_LoadProfile
    ;mov si,0x1000
    ;call CRTC_SetDisplayAddress

    ;Basic CGA initialization
;     mov dx,0x3d4 ;CGA
;     mov di,0x3d5
;     mov si,0x15ea
;     call CRTC_SetDisplayAddress
;     call CRTC_GetDisplayAddress
;     sub si,0x15ea
;     jnz .skipCGA ;if not detected
;     or [BV.XFlags],byte 2
;     call InitCGA
; .skipCGA

    ;next, step through the interrupt list and set them
    mov si,InitList
.intlp  lodsb
    and ax,0xff
    jz .intdone
    shl ax,1
    shl ax,1
    xchg ax,di
    movsw
    jmp short .intlp
.intdone

    ;now process hardware init
.portloop
    xor dx,dx
    lodsw
    test ax,ax
    jz .portdone
    xchg ah,dl
    out dx,al
    jmp short .portloop
.portdone

    ;do the title
    pop ax   ;zero from empty stack
    int 0x10 ;clear screen
    ;mov bx,1
    ;mov si,Msg.title ;SI is already set
    ; call DisplayString

    ;initialize the FDC (track 0 seek already in progress)
    mov byte [BV.DTrack],0

    ;determine CPU type
    mov ax,sp
    pusha
    nop
    cmp ax,sp
    je .nov20
    xchg ax,sp
    or [BV.XFlags],byte 1
.nov20
    ;detect math coprocessor
    fninit ;finit can't be used because it will lock if no coprocessor
    int3   ;short delay, fwait can't be used either
    fild dword [BV.LStackStart+1]
    int3
    fist dword [BV.LStackStart]
    int3
    cmp [BV.LStackStart],byte 0x5a ;did the coprocessor move the byte?
    jne .nocop
    or [BV.Equipment],byte 2    ;coprocessor detected
.nocop

    ;count RAM - start at 64KB, test 1KB blocks up to 768KB
    ;Note:  this checks for presence only - not correct operation!
    mov ax,0x1000-64
    mov cx,705  ;test up to 704 additional KB
    mov di,0x2fd    ;test pattern and address - should catch any missing chip
.ramclp add ax,byte 64
    mov es,ax
    es mov [di],di
    es cmp [di],di
    loope .ramclp   ;cx is decremented an extra time
    ;subtract the nonexistant memory from our total
    sub word [BV.TotalRAM],cx

    ;display some info
    ;mov si,Msg.HW ;SI is already set
    ;mov bx,3
    ; mov [BV.CursorPos],word 0x300
    ; call DisplayString

    ; mov [BV.CursorPos],word 0x30f
    ; int 0x12
    ; call DisplayNAX

    ; mov [BV.CursorPos],word 0x40f
    ; test [BV.XFlags],byte 1
    ; ;mov si,Msg.i8088 ;SI is already set
    ; jz .i8088
    ; mov si,Msg.V20
.i8088  
    ; call DisplayString

    ; mov [BV.CursorPos],word 0x50f
    ; test [BV.Equipment],byte 2
    ; mov si,Msg.none
    ; jz .no8087
    ; mov si,Msg.detected
.no8087 
    ; call DisplayString

    ; mov [BV.CursorPos],word 0x60f
    ; mov si,Msg.none
    ; test [BV.XFlags],byte 2
    ; jz .noCGA
    ; mov si,Msg.detected
    ; call DisplayString
.noCGA 
    ; call DisplayString

    ;generate rijndael tables
; startRijInit
; %ifdef rijndael_empty_data
;     push cs
;     pop es
;     mov di,isbox ;xtime    ;first, put log in sbox and pwr in isbox ;xtime
;     pop bx  ;zero from empty stack
; ;    push di
;     push di
;     mov al,1
;     mov cx,0xff00
; .tablp  mov bl,al
;     mov [bx+sbox],cl
;     stosb
;     ;call .xtime
;     shl al,1
;     jnc .nxor
;     xor al,0x1b
; .nxor   xor al,bl
;     inc cx
;     jnz .tablp
;     ;now, create the sbox
;     pop bx
;     xor ax,ax
;     mov di,sbox
;     push di
; .sboxl  mov ah,al
;     mov ch,4
; .makes1 rol ah,1
;     xor al,ah
;     dec ch
;     jnz .makes1
;     xor al,0x63
;     stosb
;     mov al,[di]
;     not al
;     xlat
;     loop .sboxl
;     ;now, the inverse sbox
;     xor bx,bx
;     xor ax,ax ;clear al
;     pop si  ;xtime
; .islp   mov bl,[si]
;     inc si
;     mov [bx+isbox],al
;     inc al
;     jnz .islp
; %endif
; endRijInit

    ;wait for track seek to complete
    call FDC.WaitFinished
    mov al,1 ;2nd drive, side 0
    out 0x1c,al
    call FloppyDetect
    mov al,'1'
    jz .oneFD
    or byte [BV.Equipment],0x40 ;turn on 2 drives
    inc ax ;2
.oneFD
    ; mov [BV.CursorPos],word 0x70f
    ; int 0x29 ;display # drives


    mov al,0xd2 ;capture ready->not ready
    out 8,al

    in al,0x22
    in al,0x22
    mov [BV.AuxTickCount],word 0
    sti ;ready to handle interrupts

    ;mov word [BV.CursorPos],0x0800
    ; mov si,Msg.keyBoot
    ; ;pop bx ;zero from stack
    ; call DisplayString
;    pop ax ;zero from stack
; .bootMenu
; ;    int 0x16

; .bootFD
;     mov ax,0x201    ;floppy read one sector
;     mov cx,1    ;track 0 sector 1
;     xor dx,dx   ;head 0 disk 0
;     pop es      ;load seg from empty stack
;     mov bx,0x3ce0   ;load ofs
;     int 0x13    ;read sector
;     ;es mov ax,[0x7dfe]
;     ;xor bx,bx
;     ;call DisplayNAX
;     ;cmp ax,0xaa55
; ;.noboot    jne .noboot
; ;    pop ax ;zero from stack
; ;    int 0x10
;     ;pop es ;zero from stack
;     mov di,0x3d00
;     push di ;boot offset
;     cld
;     mov ch,1 ;actually copies 2 extra bytes
;     mov si,FreeDOSBoot
;     rep movsw
;     mov ds,cx
;     mov si,0x3ceb
;     mov di,0x3d0b
;     mov cl,0xa  ;copy disk info
;     rep movsw   ;es prefix may require interrupts disabled
;     mov dl,0
;     retf ;cs from empty stack
; FreeDOSBoot:
    ; incbin "freedos.bs"
    mov si,Msg.RickyboyII
    ;pop bx ;zero from stack
    call DisplayString


    ; call OnBoardVideo.ScrollUp

    cli
    hlt

