cpu 8086

; org 0x100
; r equ 99 
; color equ 100  
; rd equ r * r

; mov ax,13h 
; int 10h
; push 0a000h
; pop ds
; xor dx,dx
; xor bp,bp
; mov ax,r
; mov bx,ax 
; mov si, 1
; mov di,(rd-r)/2-1 
; lea cx,[bx+si]

; l1:
; pusha
; sub ax,r 
; mov cl,4
; l2: 
; imul di,ax,320 
; mov byte[di+bx],color
; xchg ax,bx 
; imul di,ax,320 
; mov byte[di+bx],color
; neg ax
; add ax,r*2 
; loop l2
; popa
; add bp,si 
; inc si
; lea dx,[bp+di-rd/2]
; dec bx
; cmp dx,ax 
; ja l1
; sub di,cx 
; dec cx
; inc ax 
; cmp si,cx 
; jna l1
; int 16h
; ret

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
                    mov ax,0a000h
                    ; push      0a000h
                    push ax
                    pop       es                  ;es in video segment
                    mov       dx,160              ;Xc
                    mov       di,100              ;Yc
                    mov       al,05h              ;Colour
                    mov       bx,20               ;Radius
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
                   

                    ; push ax
                    ; push cx
                    ; push bx
                    ; mov bx,di
                    ; mov ax,di
                    ; mov cx, 320
                    ; imul cx
                    ; mov di,ax
                    ; pop bx
                    ; pop cx
                    ; pop ax
                    ; add di,bx



                    imul di,320

                    ; push di
                    ; mov di,320
                    ; imul di
                    ; pop di
                    ; IMUL r16,i16

                    add       di,dx
                    mov       es:[di+bp],al
                    sub       di,bp
                    stosb
                    pop       di
                    ret
                    ; END       Start
                    