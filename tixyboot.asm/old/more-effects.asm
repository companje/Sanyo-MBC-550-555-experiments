; incbin "Sanyo-MS-DOS-2.11-minimal.img",($-$$)  ; include default disk image skipping first 512 bytes


; fx8:
;     mov al,y
;     ret

; fx0: ; X mooi
;     mov al,x
;     call sin
;     xchg al,cl
;     mov al,y
;     sub al,15
;     call sin
;     add cl,al
;     mov al,t
;     call sin
;     div cl
;     ret

; fx0: ;[1, 0, -1][i%3]
;    mov al,i
;    mov cl,3
;    div cl
;    xchg ah,al
;    dec al
;    mov cl,15
;    mul cl

; fx0: ;ook mooi
;     mov al,x
;     mov cl,y
;     mul cl
;     add al,i
;     add al,t
;     call sin
;     ret


; fx0: ; wave
;     mov al,x
;     shr al,1
;     call sin
;     xchg cl,al

;     mov al,x
;     sub al,t
;     call sin
    
;     xchg cl,al
;     sub al,cl
;     sub al,y

;     ret

; fx0: ; mooi
;     mov al,x
;     sub al,8
;     mov cl,y
;     sub cl,8
;     mul cl
;     xchg al,cl
;     mov al,t
;     call sin
;     xchg al,cl
;     sub al,cl
;     ret

; fx0: ; curtains
;     mov al,x
;     call sin
;     xchg al,cl
;     mov al,t
;     call sin
;     add cl,al
;     xchg al,cl
;     ; add al,t
;     ret

; fx2:
    ; push bx
    ; mov al,x
    ; shl al,1
    ; add al,t
    ; and al,31
    ; mov bx,sin_table
    ; xlat 
    ; pop bx
    ; ret
; fx2:
;     mov al,i
;     times 4 shr al,1
;     ret
; fx7:
;     mov al,y
;     sub al,6
;     xchg ah,al
;     mov al,x
;     sub al,6
;     mul ah
;     ret
; fx8: ;x and y
;     mov al,x
;     and al,y
;     test al,2
;     je .done
;     neg al
;   .done:
;     ret
; fx9:
;     in al,0x22
;     ret

; fx10:
;     mov al,x
;     sub al,y
;     mov cl,t
;     mul cl
;     call sin  
;     ret
