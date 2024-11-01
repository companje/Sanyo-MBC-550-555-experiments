InitCGA:
    ;Input:  CS=BIOS_SEG
    ;Destroys ax, si, di
    ;Only attempts to init CGA if it was detected during dsBIOS startup
    cs test [BV.XFlags],byte 2
    jz .noInit
    push dx
    mov dx,0x3d4 ;CGA
    mov di,0x3d5
    xor si,si
    call CRTC_SetDisplayAddress
    mov si,CGA.profile25x80
    call CRTC_LoadProfileNoSetup
    mov al,0x0d
    mov dx,0x3d8
    out dx,al ;set mode
    inc dx
    xor al,al ;set another mode
    out dx,al
    pop dx
.noInit
    ret

CGA: ;This actually makes up a (wrong) mode table linked to by INT 0x1d
.profile25x80
%rep 4
%ifdef use_built_in_video_modes
    db 0x71 ;0  Horizontal Total
    db 0x50 ;1  Horizontal Displayed
    db 0x57 ;0x5a ;2  Horizontal Sync Position
    db 0x0a ;0x0a ;3  Horizontal and Vertical Sync Widths
    db 0x1f ;4  Vertical Total
    db 0x06 ;5  Vertical Total Adjust
    db 0x19 ;6  Vertical Displayed
    db 0x1c ;7  Vertical Sync position
    db 0x02 ;8  Interlace and Skew
    db 0x07 ;9  Maximum Raster Address
    db 6    ;cursor start
    db 7    ;cursor end
    db 0
    db 0
    db 0
    db 0
%elseif
    db 0x71,0x50,0x5a,0xa,0x1f,0x06,0x19,0x1c,0x2,0x7,0x6,0x7,0,0,0,0
%endif
%endrep
    dw 0x800
    dw 0x1000
    dw 0x4000
    dw 0x4000
    times 8 db 80
    times 8 db 0xd