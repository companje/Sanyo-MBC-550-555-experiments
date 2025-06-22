%include "sanyo.asm" 

%define t dh
%define i dl
%define x bh
%define y bl

GREEN2 equ 0x0800

TOP   equ 9*4*COLS+20*4    ; row=9,col=20
BOTTOM equ TOP+4608

effect_timeout equ 30      ; every 30 frames another effect
isqrt_table    equ 3000    ; available location in code segment

ticks EQU 10 ; 100Hz (10ms)

setup:
    ; clear offscreen buffer
    push ax
    mov di,0
    mov ax,GREEN2
    mov es,ax
    mov cx,7200
    mov ax,0
    rep stosw
    pop ax

mov al, 0x34
  out 0x26, al

  mov al, ticks & 0xff
  out 0x20, al        ; lobyte

  mov al, ticks >> 8
  out 0x20, al        ; hibyte

; mov dx,0
; xor di,di
; mov ax,GREEN
; mov es,ax
; ; mov cx,50
; .lp1
;   mov al, 0x00        ; Command: latch counter 0
;   out 0x26, al        ; Command register on 0x26

;   in al, 0x20         ; read lobyte of counter 0
;   xchg ah,al          ; store al in ah

;   in al, 0x20         ; read hibyte of counter 0
;   xchg al,ah          ; swap hi and lo byte

;   cmp ax,10
;   jnl .lp1

;   println_ax 
  ; "<10 "

;   cmp ax,dx
; pushf
;   print_char '.'
; popf
;   jl .lp1

;   print "x"

    ; println_ax
; loop .lp1
; hlt

    xor bp,bp               ; start with effect 0
    xor dx,dx               ; t=i=0 (clear time and index)

draw:
    mov di,TOP              ; left top corner to center tixy
dot:

    ;aha, 16x16 grid past in 1 byte. als ik groter wil moet ik naar 16bits hieronder
    push dx
    mov al,i                ; al=index
    ; xor ah,ah               ; ah=0
    ; mov cl,16
    ; div cl                  ; calculate x and y from i

    mov cl,4
    mov ah, al       ; kopieer AL naar AH om later de rest te berekenen
    shr al, cl        ; deel AL door 16 (quotiënt komt in AL)
    and ah, 0Fh  


    xchg ax,bx              ; bh=x, bl=y
    pop dx

    ;on the first frame calc sqrt table for every i
    ;reusing the i,x,y loop here. this saves some bytes.
    or t,t
    jnz .cont
    call calc_isqrt_xx_yy
  .cont:

;;;;;;
; draw something
;;;;;;

    ; call fx0

    push ax
    mov ax,GREEN2
    mov es,ax
    pop ax


    ; times 4 stosw
    ; add di,4*COLS-8
    ; times 4 stosw

; let op al is -16..16 terwijl intensity rekent op 0..8

    ; xor ah,ah
    ; or al,128
    ; shl al,1    ; get rid of the highest bit (sign)
    ; shr al,1    
    ; shr al,1  
    ; and ax,127
    ; shr al,1 ; /=2  
    ; shl al,1
    ; shl al,1

    ; mov ax,7*4
    ; xor ah,ah
    ; mov al,t
    ; neg al

call fx7

    and ax,7
    shl al,1
    shl al,1
    add ax,intensity
    mov si,ax

    ; mov si,intensity+f*4
    movsw
    movsw
    ; sub di,4

    ; mov word [es:di], 
    ; mov word [es:di+2], intensity+f*4+2

    ; push ax
    ; mov ax,-1
    ; stosw
    ; stosw
    ; ; add di,3
    ; pop ax



    ; set_cursor 1,1
    ; xor ah,ah
    ; print_ax
    ; mov al,' '
    ; call write_char

    inc i                   ; i++
    ; add di,8         
    cmp x,15
    jl dot                  ; next col
    ; add di,4*COLS       
    add di,160 + 16*4
    cmp y,15
    jl dot                  ; next line
    inc t



; .timer:
; in al,0x22
; or al,al
; jnz .timer



mov al, 4
out 10h, al

; .timer_wait
;   mov al, 0x00        ; Command: latch counter 0
;   out 0x26, al        ; Command register on 0x26
;   in al, 0x20         ; read lobyte of counter 0
;   xchg ah,al          ; store al in ah
;   in al, 0x20         ; read hibyte of counter 0
;   xchg al,ah          ; swap hi and lo byte

;   cmp ax,10          ; wait for time to reset to redraw
;   jnl .timer_wait




push cx
push si
push di
push ds

mov si,TOP
mov di,TOP
mov ax,GREEN2
mov ds,ax
mov ax,GREEN
mov es,ax
mov cx,BOTTOM-TOP
rep movsw
pop ds
pop si
pop di
pop cx

mov al, 5
out 10h, al

    ; cmp t,effect_timeout
    ; jb draw                 ; next frame
    ; inc bp                  ; inc effect
    ; xor t,t                 ; reset time
    ; cmp bp,8
    ; jl draw                 ; next effect
    ; xor bp,bp               ; reset effect


; push cx
; mov cx,5000
; .wait 
; aam
; loop .wait
; pop cx


    jmp draw


  hlt


; draw:
; ;     mov ax,GREEN
; ;     mov es,ax
; ;     mov cx,7200
; ;     xor di,di
; ; .cell:
; ;     mov si,intensity+5*4
; ;     movsw
; ;     movsw

; ;     loop .cell

;     mov t,0
;     mov i,0
;     mov x,0
;     mov y,0
;     call fx7

;     println_ax_hex


    hlt

fx7: ; sin(sqrt(x^2+y^2))-t)
    mov al,i   ; isqrt_table[i] = sqrt(x^2+y^2)
    push bx
    mov bx,isqrt_table
    xlat
    pop bx
    sub al,t
    call sin
    ret

zoom: db 1
ox: db 0
oy: db 0

fx0: ; x
    mov al,t
    call sin
    mov [zoom],al

    ; float ox = (x-COLS/2) * zoom;
    ; float oy = (y-ROWS/2) * zoom;
    mov [ox],x
    sub byte [ox],8
    mov al,[ox]
    mul byte [zoom]
    mov [ox],al

    mov [oy],y
    sub byte [oy],8
    mov al,[oy]
    mul byte [zoom]
    mov [oy],al

    mov al,[ox]
    mul byte [oy]

    call sin

    ; mov al,t
    ; add al,i
    ; add al,x
    ; add al,y
    ; call sin
    ; add al,i
    ; add al,x
    ; shr al,1
    ; or al,y
    ret


sin: ; sine function
    call wrap
    push bx
    add al,15 ; sin(-15) = sin_table[0]
    mov bx,sin_table
    xlat 
    pop bx
    ret

wrap: ; while (al>15) al-=15; while (al<-15) al+=15
    cmp al,15
    jg .sub16
    cmp al,-15
    jl .add16
    ret
  .sub16:
    sub al,31
    jmp wrap
  .add16:
    add al,31
    jmp wrap

limit: ; if (al>15) al=15; else if (al<-15) al=-15;
    cmp al,15
    jg .pos16
    cmp al,-15
    jnl .ret
    mov al,-15
    ret
  .pos16:
    mov al,15
  .ret:
    ret

calc_isqrt_xx_yy: ; isqrt_table[i] = sqrt(x^2+y^2)
    push dx
    push di
    mov di,isqrt_table      ; di=isqrt_table[0]
    add di,dx               ; di+=i
    mov al,x
    inc al
    mul al                  ; x*x
    xchg ax,cx
    mov al,y
    inc al
    mul al                  ; y*y
    add ax,cx               ; + 
  .isqrt:  ; while((L+1)^2<=y) L++; return L
    xchg cx,ax              ; cx=y
    xor ax,ax               ; ax=L=0
  .loop:
    inc ax
    push ax
    mul ax
    cmp ax,cx
    pop ax
    jl .loop
    dec ax
  .end_isqrt:
    mov [di],al             ; store al
    pop di
    pop dx
    ret

intensity: db 0,0,0,0,136,0,34,0,170,0,170,0,170,17,170,68,170,85,170,85,85,238,85,187,119,255,221,255,255,255,255,255

sin_table: ;31 bytes, (output -15..15 index=0..31)
    db 0,-3,-6,-9,-11,-13,-15,-15,-15,-15,-13,-11,-9,-6,-3,
    db 0, 3, 6, 9, 11, 13, 15, 15, 15, 15, 13, 11, 9, 6, 3,0  

times (180*1024)-($-$$) db 0

