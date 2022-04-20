; cpu 8086

; It is based on the fact that the square of X can be written as the sum
; for i=0..x-1 of (2i+1), like this :
; 1*1=1  = (2*0+1)
; 2*2=4  = (2*0+1)+(2*1+1)
; 3*3=9  = (2*0+1)+(2*1+1)+(2*2+1)
; etc
                    ; .MODEL    TINY
                    ; .286
                    ; .CODE
                    ORG       100h
Start:              mov       ax,13h
                    int       10h                 ;mode 13h
                    push      0a000h
                    pop       es                  ;es in video segment
                    

                    mov       dx,160              ;Xc
                    mov       di,100              ;Yc
                    mov       al,05h              ;Colour
                    mov       bx,1               ;Radius
                    call      Circle              ;Draw circle

                    mov       ah,0
                    int       16h                 ;Wait for key
                    mov       ax,3
                    int       10h                 ;Mode 3
                    mov       ah,4ch
                    int       21h                 ;Terminate
;*** Circle
; dx= x coordinate center
; di= y coordinate center
; bx= radius
; al= colour
Circle:             mov       bp,0                ;X coordinate
                    mov       si,bx               ;Y coordinate
c00:                call      _8pixels            ;Set 8 pixels
                    sub       bx,bp               ;D=D-X
                    inc       bp                  ;X+1
                    sub       bx,bp               ;D=D-(2x+1)
                    jg        c01                 ;>> no step for Y
                    add       bx,si               ;D=D+Y
                    dec       si                  ;Y-1
                    add       bx,si               ;D=D+(2Y-1)
c01:                cmp       si,bp               ;Check X>Y
                    jae       c00                 ;>> Need more pixels
                    ret
_8pixels:           call      _4pixels            ;4 pixels
_4pixels:           xchg      bp,si               ;Swap x and y
                    call      _2pixels            ;2 pixels
_2pixels:           neg       si
                    push      di
                    add       di,si
                   
                    imul di,320
                    add       di,dx
                    mov       es:[di+bp],al
                    sub       di,bp
                    stosb
                    pop       di
                    ret
                    