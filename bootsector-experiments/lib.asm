abs8:
    or al,al
    jns .return
    neg al
.return ret

clearScreen:
    cld
    mov bp,0xf000  ; red + blue
    mov es,bp
    xor di,di
    xor ax,ax
    mov cx,16000
    rep stosw

    mov bp,0x0c00  ; green
    mov es,bp
    xor di,di
    xor ax,ax
    mov cx,8000
    rep stosw
 .return ret

; setProfile25x72:
;     mov si,CRTC.profile25x72
;     call setCrtcProfile
;     ret
; setProfile25x80:
;     mov si,CRTC.profile25x72
;     call setProfile
;     ret

CRTC:
.setProfile:
    mov bx,0
    cld
.lp:
    mov al,bl
    out 0x30,al            ;CRTC address port
    mov al,[cs: bx+si+0]
    out 0x32,al            ;CRTC data port
    inc bx
    cmp bl,10
    jl .lp
    ret

.profile25x72:
   db 112  ;0  Horizontal Total
   db 72   ;1  Horizontal Displayed
   db 85   ;2  Horizontal Sync Position
   db 0x4a ;3  Horizontal and Vertical Sync Widths
   db 65   ;4  Vertical Total
   db 0    ;5  Vertical Total Adjust
   db 50   ;6  Vertical Displayed
   db 56   ;7  Vertical Sync position
   db 0    ;8  Interlace and Skew
   db 3    ;9  Maximum Raster Address

.profile25x80:
    db 112  ;0  Horizontal Total
    db 80   ;1  Horizontal Displayed
    db 88   ;2  Horizontal Sync Position
    db 0x4a ;3  Horizontal and Vertical Sync Widths
    db 65   ;4  Vertical Total
    db 0    ;5  Vertical Total Adjust
    db 50   ;6  Vertical Displayed
    db 56   ;7  Vertical Sync position
    db 0    ;8  Interlace and Skew
    db 3    ;9  Maximum Raster Address