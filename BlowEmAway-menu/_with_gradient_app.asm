%include "sanyo.asm"

logo: db 50,36,14,36,14,4,12,4,12,4,14,5,10,6,10,5,(14+1),5,8,8,8,5,(16+1),32,16+4,12,4,12,(18+50),36,14,36,14+32,4,14+50+2,32,16+1
 db 34,15,5,26,5,14,5,26,5,14+1,34,15+2,32,16+50,34,16,35,15+32,4,14,36,14+32,4,14,35,15,34,16+50,4,46+50,36,14,36,14,4,12
 db 4,12,4,14,4,12,4,12,4,14+50+2,34,14+1,35,14,4,32+14,36,14,4,32+14+1,35,14+2,34,14+50+50+2,34,14+1,35,14,4,12,4,16+14,4
 db 12,4,16+14+1,35,14+2,34,14+50,34,2+14,35,1+14+32,4,14,36,14+32,4,14,35,1+14,34,2+14+50+2,34,14+1,35,14,4,12,4,16+14,4
 db 12,4,16+14+1,35,14+2,34,14+50,18,18+14,18,18+14+16,2+18,14,18,18+14,18,18+14+50
db 0

; gradient: dw 0xffff,0xeeee,0xdddd,0xcccc,0xbbbb,0xaaaa,0x9999,0x8888,0x7777,0x6666,0x5555,0x4444
grays: db 0,0,0,0, 136,0,34,0, 170,0,170,0, 170,17,170,68, 170,85,170,85, 85,238,85,187, 119,255,221,255, 255,255,255,255, 255,255,255,255, 255,255,255,255, 255,255,255,255

angle: dw 0

setup:
  xor di,di
  xor bp,bp
  jmp draw




draw:
  mov ax,GREEN
  mov es,ax
  xor di,di
  mov si,logo
  call draw_col_of_blocks
  inc bp
  and bp,15
  jmp draw


_wait:
  push cx
  mov cx,50
  .lp aam
  loop .lp
  pop cx
  ret

draw_col_of_blocks:
  mov ax,0 ; off
  mov dx,-1 ; 0b1010101010101010 ; on

.col:
  xchg cl,al ; save al
  lodsb
  or al,al
  jz .done

  ; jns .not0

; .neg:
  ; mov dx,50
  ; mov bx,200
  ; push ax
  ; push bp
  ; push bx
  ; push cx
  
  ; mov cx,1
  ; mov bp,40
  ; mov ax,1
  ; call playEffect

  ; pop cx
  ; pop bx
  ; pop bp
  ; pop ax

  ; neg al
  ; or ax,ax

; .not0:
  xchg al,cl ; restore al
.cell:
  ; call _wait

  or ax,ax
  jz .off

.on:
  ; xor bp,bp
  push ax
  push cx
  push dx
  push si

  mov si,di
    
  mov cl,10
  shr si,cl
  shl si,1

  mov ax,[grays+si+bp]
  stosw
  mov ax,[grays+si+2+bp]
  stosw

  pop si
  pop dx
  pop cx
  pop ax

  jmp .next2

.off:

  stosw
  stosw

.next2:

  add di,4*COLS-4
  cmp di,ROWS*COLS*4
  jb .next
  sub di,ROWS*COLS*4-4
.next:
  loop .cell
  xchg ax,dx
  or ax,ax
  jz .col
  jmp .col
.done:
  ret  


; play:             ; bx=note, dx=duration
;    push ax
;    push bx
;    push cx
;    push dx
;    mov cx,bx
;    mov ax,0x35
; .a xor al,8       ; toggle 'break' bit
;    out 0x3a,al    ; USART
; .b dec ah
;    jnz .c
;    dec dx
;    jz .d
; .c loop .b
;    mov cx,bx      ; reset note
;    jmp .a
; .d xor al,8       ; toggle 'control' bit
;    cmp al,0x35    ; 'break' now on?
;    jnz .e         ; jump if not
;    out 0x3A,al    ; reset USART
; .e pop dx
;    pop cx
;    pop bx
;    pop ax
;    ret


; playEffect:  ; cx length, ax=note offset, bp=effect index
;   mov bx,bp
;   mov bx,[sound+bx]
;   sub bx,ax   ; ax = note offset for tone height
;   call play
;   inc bp
;   inc bp
;   loop playEffect
;   ret



;ax!=0 overwrite with other pattern
; push cx
; push di
; mov cl,10
; shr di,cl
; mov ax,[gradient+di]
; pop di
; pop cx




; setup:
;   mov bp,120
;   jmp draw

; draw:
;   push ax
;   ; push bp
;   push bx
;   push cx
  
;   mov cx,50
;   push ds
;   push ax
;   mov ax,cs
;   mov ds,ax
;   mov bx,[ds:bp]
;   pop ax
;   pop ds
;   mov dx,50
;   call play
;   inc bp

;   mov ax,bx
;   print_ax_hex
;   print_char ' '

;   pop cx
;   pop bx
;   ; pop bp
;   pop ax

;   jmp draw


;   hlt 


  
; ; db 119,255,221,255

;   mov al,119
;   mov di,4
;   and byte [es:di],al
;   mov al,255
;   inc di
;   and byte [es:di],al
;   mov al,221
;   inc di
;   and byte [es:di],al
;   mov al,255
;   inc di
;   and byte [es:di],al


; 119,255,221,255

  ; hlt

; sound: incbin "/Users/rick/Documents/Processing/DrawSound/waveform.dat"


times (180*1024)-($-$$) db 0



