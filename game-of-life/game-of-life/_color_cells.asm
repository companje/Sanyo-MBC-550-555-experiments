
; jmp setup



; setup:
;     xor dx,dx

;     mov ax,GREEN
;     push ax
;     pop es

;     push cs
;     pop ds

;     ;fill
;     push cs
;     pop es        ; dst
;     mov di,data
;     ; mov al,7
;     mov cx,DOTS
; .1:
;     mov al,ch
;     stosb
;     loop .1


; draw:

;     ; mov bp,RED
;     ; mov bl,4
;     ; call draw_per_channel

;     ; mov bp,GREEN
;     ; mov bl,2
;     ; call draw_per_channel

;     ; mov bp,BLUE
;     ; mov bl,1
;     ; call draw_per_channel

;     call draw_all_dots
;     inc dx



;     jmp draw



; ; draw_dot:  ; bh=row, bl=col, dl=color
    
; ;     ret

; draw_all_dots:
;     mov si,data
;     add si,dx
;     xor di,di
;     mov cx,ROWS*COLS
; .1:
;     lodsb
;     mov bl,al
;     mov bp,RED
;     push bp
;     pop es
;     test bl,4
;     mov al,0
;     jz .r
;     mov al,255
; .r: times 4 stosb
;     sub di,4
;     mov bp,GREEN
;     push bp
;     pop es
;     test bl,2
;     mov al,0
;     jz .g
;     mov al,255
; .g: times 4 stosb
;     sub di,4
;     mov bp,BLUE
;     push bp
;     pop es
;     test bl,1
;     mov al,0
;     jz .b
;     mov al,255
; .b: times 4 stosb
;     loop .1
;     ret


; draw_per_channel:   ; bl=bit, bp=channel segment
;     push bp
;     pop es
;     mov si,data
;     add si,dx
;     xor di,di
;     mov cx,DOTS
; .1: lodsb        ; 00000rgb
;     test al,bl    ; 
;     mov al,0
;     jz .2
;     mov al,255
; .2: times 4 stosb
;     loop .1
;     ret
