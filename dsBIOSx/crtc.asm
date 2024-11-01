CRTC_LoadProfile:
    ;  Input:  DS:SI = address of config buffer
               ;(10 bytes) - Config data for CRTC
               ;geometry info is automatically extracted and set up
    ;          DX = CRTC Address port
    ;          DI = CRTC Data port
    ; Output:  SI is incremented by 10
    ;Trashed:  AX
    xor ax,ax
    cs mov al,[si+1] ;get # columns
    cs mov [BV.ScreenCols],ax
CRTC_LoadProfileNoSetup:
    push bx
    cld
    mov al,0
.lp out dx,al   ;write config byte number
    xchg ax,bx
    xchg dx,di
    lodsb
    out dx,al   ;write config byte
    xchg dx,di
    xchg ax,bx
    inc ax
    cmp al,10   ;written 10 bytes?
    jb .lp
    pop bx
    ret

CRTC_SetDisplayAddress:
    ;  Input:  SI = Display offset
    ;          DX = CRTC Address port
    ;          DI = CRTC Data port
    ;Trashed:  AL
    mov al,13
.do2nd
    out dx,al
    xchg dx,di
    xchg ax,si
    out dx,al
    xchg ah,al
    xchg ax,si
    xchg dx,di
    dec ax
    jp .do2nd ;going to hell for this one
    ret

CRTC_GetDisplayAddress:
    ;  Input:  DX = CRTC Address port
    ;          DI = CRTC Data port
    ; Output:  SI = Display offset
    ;Trashed:  AL
    mov al,13
.do2nd
    out dx,al
    xchg dx,di
    xchg ax,si
    in al,dx
    xchg ah,al
    xchg ax,si
    xchg dx,di
    dec ax
    jp .do2nd ;window seat please
    ret


;Register Index/Register Name
;  0  Horizontal Total
;  1  Horizontal Displayed
;  2  Horizontal Sync Position
;  3  Horizontal and Vertical Sync Widths
;  4  Vertical Total
;  5  Vertical Total Adjust
;  6  Vertical Displayed
;  7  Vertical Sync position
;  8  Interlace and Skew
;  9  Maximum Raster Address
;  10  Cursor Start Raster
;  11  Cursor End Raster
;  12  Display Start Address (High)
;  13  Display Start Address (Low)
;  14  Cursor Address (High)
;  15  Cursor Address (Low)
;  16  Light Pen Address (High)
;  17  Light Pen Address (Low)

CRTC:
;.profile25x72
;    db 112  ;0  Horizontal Total
;    db 72   ;1  Horizontal Displayed
;    db 85   ;2  Horizontal Sync Position
;    db 0x4a ;3  Horizontal and Vertical Sync Widths
;    db 65   ;4  Vertical Total
;    db 0    ;5  Vertical Total Adjust
;    db 50   ;6  Vertical Displayed
;    db 56   ;7  Vertical Sync position
;    db 0    ;8  Interlace and Skew
;    db 3    ;9  Maximum Raster Address

.profile25x80
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

.profile6x34 ;Possibly for future use in breakout menu
    db 112  ;0  Horizontal Total
    db 34   ;1  Horizontal Displayed
    db 66   ;2  Horizontal Sync Position
    db 0x4a ;3  Horizontal and Vertical Sync Widths
    db 65   ;4  Vertical Total
    db 0    ;5  Vertical Total Adjust
    db 12   ;6  Vertical Displayed
    db 37   ;7  Vertical Sync position
    db 0    ;8  Interlace and Skew
    db 3    ;9  Maximum Raster Address

;These are the modes that the ROM bootstrap can set

;SW 2 ON
;65505348690264640003000000000000
;65=101 0  Horizontal Total
;50=80  1  Horizontal Displayed
;53=83  2  Horizontal Sync Position
;48     3  Horizontal and Vertical Sync Widths
;69=105 4  Vertical Total
;02     5  Vertical Total Adjust
;64=100 6  Vertical Displayed
;64=100 7  Vertical Sync position
;00     8  Interlace and Skew
;03     9  Maximum Raster Address
;00     10  Cursor Start Raster
;00     11  Cursor End Raster
;00     12  Display Start Address (High)
;00     13  Display Start Address (Low)
;00     14  Cursor Address (High)
;00     15  Cursor Address (Low)

;SW 2 OFF
;7048554A410032380003000000000000
;70=112  0  Horizontal Total
;48=72   1  Horizontal Displayed
;55=85   2  Horizontal Sync Position
;4a      3  Horizontal and Vertical Sync Widths
;41=65   4  Vertical Total
;00      5  Vertical Total Adjust
;32=50   6  Vertical Displayed
;38=56   7  Vertical Sync position
;00      8  Interlace and Skew
;03      9  Maximum Raster Address
;00      10  Cursor Start Raster
;00      11  Cursor End Raster
;00      12  Display Start Address (High)
;00      13  Display Start Address (Low)
;00      14  Cursor Address (High)
;00      15  Cursor Address (High)
