;This file needs a rewrite, but mostly works
;(some problems switching between disk geometries in freedos)

Readsector:
    ;pushing done in function selector

    ;INPUT
    ;AH = 02h
    ;AL = number of sectors to read (must be nonzero)
    ;CH = low eight bits of cylinder number
    ;CL = sector number 1-63 (bits 0-5)
    ;     high two bits of cylinder (bits 6-7, hard disk only)
    ;DH = head number
    ;DL = drive number (bit 7 set for hard disk)
    ;ES:BX -> data buffer
    ;-----
    ;during operation:
    ;BH = total sectors
    ;BL = sectors read
    ;ES:BP = data buffer
.rslp   call FDC.SpinSeek
    cli
.rsnsl  ;inc bl
    ;cmp bl,bh
    ;je .doOpDoneNE

    push cx
    mov di,BV.SectorBuffer
    mov ax,512
    xchg ax,cx ;sector size
    out 0xc,al ;sector number
    mov al,0x80 ;read sector
    call FDC.CmdDelay ;command
    ;retrieve it from the FDC
    jmp short .bytelp
.erchk test al,3
    jz .doOpError
.bytelp
    in al,8
    test al,2
    jz .erchk
    in al,0xe
    mov [di],al ;store byte from FDC
    inc di
    loop .bytelp
    in al,8
    test al,0x9e
    jnz .doOpError

    ;do decryption
    mov di,dx
    and di,byte 1
    test [BV.DFlags+di],byte 1
    jz .nodec
    pop cx
    call Decrypt_Sector
    push cx
.nodec

    ;store
    mov di,bp
    mov si,BV.SectorBuffer
    mov cx,256
    rep movsw
    mov bp,di
    pop cx

    mov si,dx
    and si,byte 1

    cmp cx,byte 1
    jne .noReadSectorCount
    or dh,dh
    jnz .noReadSectorCount
    mov al,[BV.SectorBuffer+0x18]
    inc al
    mov [BV.SectorsPerTrack+si],al
.noReadSectorCount
    inc bl
    cmp bl,bh
    je .doOpDoneNE

    inc cx ;find next sector
    cmp cl,[BV.SectorsPerTrack+si]
    jb .rsnsl
    mov cl,1
    xor dh,1
    jnz .rslp
    inc ch
    jmp short .rslp

.doOpDoneNE
    jmp INT13.OpDoneNE
.doOpError
    jmp INT13.OpError

Writesector:
    ;pushing done in function selector

    ;INPUT
    ;AH = 03h
    ;AL = number of sectors to write (must be nonzero)
    ;CH = low eight bits of cylinder number
    ;CL = sector number 1-63 (bits 0-5)
    ;     high two bits of cylinder (bits 6-7, hard disk only)
    ;DH = head number
    ;DL = drive number (bit 7 set for hard disk)
    ;ES:BX -> data buffer
    ;-----
    ;during operation:
    ;BH = total sectors
    ;BL = sectors read
    ;ES:BP = data buffer
.rslp   call FDC.SpinSeek
    cli
.rsnsl  ;inc bl
    ;cmp bl,bh
    ;je Readsector.doOpDoneNE

    push cx
    xchg ax,cx
    out 0xc,al ;sector number

    ;load from memory to buffer
    push es
    mov ax,es
    mov ds,ax ;ds=source
    mov ax,cs
    mov es,ax ;es=buffer

    mov si,bp
    mov di,BV.SectorBuffer
    mov cx,256
    rep movsw
    mov bp,si

    mov ax,cs
    mov ds,ax ;restore ds
    pop es

    ;do encryption
    mov si,dx
    and si,byte 1
    test [BV.DFlags+si],byte 1
    jz .nodec
    pop cx
    call Encrypt_Sector
    push cx
.nodec

    mov si,BV.SectorBuffer
    ;mov cx,512 ;byte counting isn't important when writing
    ;mov al,0xa0 ;write sector
    ;call FDC.CmdDelay ;command
    push bp
    push dx
    mov bp,.bytelp
    mov dx,8
    mov ah,0;2
    lodsb
    mov di,ax
    mov al,0xa0 ;write sector
    push bx
    mov bx,0xf602
    call FDC.CmdDelay ;command
    mov ah,0;xf6
    ;write it to the FDC

.startlp
    in al,dx
    shr al,1
    jnc .wdone ;not busy -> error
    jnz .startlp ;waiting for busy only
.waitdata
    in al,dx
    test al,bh ;ah=f6 ;ignore CRC error?!?
    jz .waitdata ;wait for data request
    ;jmp short .writeagain
    xchg ax,di
    out 0xe,al
    jmp short .loadnext

.bytelp
    in al,dx
    dec ax
    jz .bytelp
    cmp al,bl
    jne .wdone
.writeagain
    xchg ax,di
    out 0xe,al
.loadnext
    lodsb ;get next byte
    xchg di,ax
    in al,dx
    and al,bl ;bl=2
    jnz .writeagain
    jmp bp


.wdone
    pop bx
    in al,dx
    or al,al
    ;cmp al,0xff;0x9e
    pop dx
    pop bp
    jnz INT13.OpError

    pop cx

    inc bl
    cmp bl,bh
    je Readsector.doOpDoneNE

    mov si,dx
    and si,byte 1

    inc cx ;find next sector
    cmp cl,[BV.SectorsPerTrack+si]
    jb .rsnsl
    mov cl,1
    xor dh,1
    jnz .rslp
    inc ch
    jmp .rslp

INT13:
.OpError
    ;   error exit
    ;xor ah,ah
    ;xor bx,bx
    ;call DisplayNAX
    ;xor ax,ax
    ;int 0x29
    ;xchg ax,cx
    ;call DisplayNAX
;.self  jmp short .self
    pop cx
    mov ah,4
    ;jmp short INT13.OpDone
    db 0xbb ;ignore next 2 bytes (mov bx,xxxx)
.OpDoneNE
    mov ah,0
.OpDone
    mov al,0xd0 ;immediate interrupt
    out 8,al
    mov al,0xd2 ;capture not-ready
    out 8,al
    pop bp
    pop di
    pop si
    pop dx
    pop cx
    pop bx
    or ah,ah ;cmp ah,0
    ;jz .noerr
    jnz .errex

.noerr  mov ds,bx
    mov bx,sp
    ss and [bx+6],byte 0xfe ;turn carry off
    mov bx,ds
.ex cs and [BV.LFlags],byte 0xfb ;unlock
    cs mov [BV.DiskLastStatus],ah
    cs test [BV.LFlags],byte 0x20 ;need to run keyclick?
    jz .nokc
    cs and [BV.LFlags],byte 0xdf ; no more keyclick
    push ax
    push bx
    call ProcessKeys
    pop bx
    pop ax
.nokc
    pop ds
    iret

.entry
    push ds
    push cs
    pop ds
    cld
    or [BV.LFlags],byte 4 ;lock
    cmp dl,1
    ja .unsupported ;invalid drive
    cmp ah,5
    je .format
    ja .gr5
    cmp ah,1
    jb .noerr ;0 .reset
    je .getstatus ;1
    cmp ah,3
    ja .unsupported; .verify
    push bx
    push cx
    push dx
    push si
    push di
    push bp
    mov bp,bx
    mov bh,al
    mov bl,0
    je Writesector; 3
    jmp Readsector ;2
.gr5
    cmp ah,8
    je .getparam ;8
    cmp ah,0x15 ;get disk type
    je .disktype
    cmp ah,0x16
    je .diskchg
    ;6, 7 are fixed disk format
.verify
.format
.unsupported
    mov ah,1 ;unsupported
.errex  mov ds,bx
    mov bx,sp
    ss or [bx+6],byte 0x01 ;turn carry on
    mov bx,ds
    jmp short .ex

.getparam
    ;mov ah,7 ;drive param error
    ;test dl,1
    ;ja .errex ;drive out of range
    mov bl,1 ;360KB
    mov cx,40*0x100+9
    mov dx,0x101 ;2 heads, 1 drive
    ;check if we really have 2 drives
    mov ah,[BV.Equipment]
    rcl ah,1
    rcl ah,1
    adc dl,0
    xor ah,ah

    ;FIXME need to set drive param table
    jmp .noerr

;.reset
;   jmp short .noerr

.getstatus
    cs mov ah,[BV.DiskLastStatus]
    or ah,ah
    jz .noerr
    jmp short .errex
.diskchg
    push bx
    mov bx,ax
    in al,0x1c
    and al,0x3
    cmp al,dl
    mov al,bl
    pop bx
    jne .errex
    jmp .noerr

.disktype
    mov ah,1 ;floppy, no changeline support
    jmp .noerr
FDC:
.SpinSeek
    ;in: dl=drive number, ch=track, dh=head number
    ;    ds=0x40
    ;push ax
    push bx
    mov al,0xd0 ;force interrupt
    out 8,al
    xor bx,bx

    ;figure out if the right drive/side was set
    in al,0x1c
    mov ah,al
    and al,7 ;mask off all but the drive/side
    xor al,dl ;dl is desired drive number
    times 2 ror al,1
    xor al,dh ;dh is desired head number
    ;al now has different bits set from drive/side
    jz .ssSameDS
    inc bx ;make sure we exit at an index pulse
    ;inc bx ;and a little more for 10spt
.ssSameDS
    times 2 rol al,1
    xor al,ah ;this is so fucking genius, it amazes me
    out 0x1c,al ;set desired drive/side

    ;is the drive still ready?
    in al,8
    shl al,1
    jnc .ssNoSpinDelay
    mov bl,4 ;the drive wasn't spinning - let's go 3-4 revolutions
.ssNoSpinDelay
    mov [BV.FloppyIntCount],bl
    or bx,bx ;if bx is non-zero, we must have changed sides/tracks
    mov bl,dl
    lea bx,[bx+BV.DTrack] ;don't touch flags
    ;load track from memory
    mov al,[bx]
    jnz .doSeek
    cmp al,ch ;is the drive on the same track?
    jz .noSeek
.doSeek ;do seek to track
    out 0xa,al ;set current track
    mov al,ch
    out 0xe,al ;set track number
    mov [bx],al ;update track number
    mov al,0x18 ;seek track, load head
    call .CmdDelay ;command
.ccWait in al,8
    test al,1
    jnz .ccWait
    mov al,0xd4 ;capture index pulse
    ;mov bl,[BV.FloppyIntCount]
    sti ;process interrupts
    out 8,al

.ssWait cmp byte [BV.FloppyIntCount],0
    jg .ssWait
    ;cmp bl,4
    ;jb .countSectors
.noSeek pop bx
    ;pop ax
    ret
.CmdDelay
    out 8,al
.Delay
    times 4 aam
    ret
.WaitFinished
    in al,8
    test al,1
    jnz .WaitFinished
    ret


FloppyDetect:
    ;Strategy:  Step down up to 45 times until TR00 is detected, else give up
    ;           Step up 1 time, verify TR00=0
    ;           Step down 1 time, verify TR00=1
    ;Returns with zero flag set if only one drive is found
    mov cx,45 ; max tracks
.tryAgain
    mov al,0x68 ;step down, 6ms delay
    call .CWT
    loopz .tryAgain ;loop if no TR00
    jz .done
    mov al,0x4a ;step up, 20ms delay
    call .CWT
    mov al,0x6a ;step down, 20ms delay (0x6a AND 4 is zero for error exit)
    jnz .errdone
.CWT
    call FDC.CmdDelay
    call FDC.WaitFinished
.errdone
    test al,4
.done
    ret

FloppyInt:
    ;purpose is to decrement event count if in disk code
    ;otherwise select drive 3 and unload head if no longer ready
    cli
    push ax
    in al,8 ;clear interrupt
    cs test byte [BV.LFlags],4
    jz .notdisk
    cs dec byte [BV.FloppyIntCount] ;in disk code
    pop ax
    iret
.notdisk
    in al,0x1c
    mov ah,al
    or al,7 ;select drive 3
    xor ah,al
    jz .done ;drive 3 was already selected
    out 0x1c,al

    in al,0xa ;get track
    out 0xe,al ;seek to current track
    mov al,0x10 ;seek and unload head
    out 8,al ;floppy command
.done   pop ax
    iret