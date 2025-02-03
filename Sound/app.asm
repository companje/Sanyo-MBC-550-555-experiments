%include "sanyo.asm"

W equ 20
W2 equ 40

key_lut: db 0,7,4,3,0,0,6,8,0,10,0,0,11,9,0,0,0,0,1,0,0,5,0,2,0,0

effect dw 0

setup:
  println " s d   g h j"
  println "z x c v b n m    ,. (fx)" 
  jmp draw

draw:
  call check_keys
  jnz on_key
  jmp draw

on_key:
  ; println_ax
  cmp ax,','
  je on_key_comma
  cmp ax,'.'
  je on_key_period

  mov bx,key_lut
  sub ax,'a'
  xor ah,ah
  xlat ; tone height based on ax contains now 0...11
  mov cx,5
  mul cx

  push ax
  mov ax,W2
  mul word [effect]
  mov bp,ax   ; offset of effect in sound table
  pop ax

  mov cx,W    ; length of sound effect 20 words
  mov dx,3
  call playEffect     ;ax contains note height (linear * 30)

.done
  jmp draw  ; no ret here because onkey is called by jnz

on_key_comma:
  dec word [effect]
  call draw_effect
  jmp on_key.done

on_key_period:
  inc word [effect]
  call draw_effect
  jmp on_key.done

draw_effect:
  call clear_green
  set_cursor 1,1
  ; println "."
  mov ax,W2
  mul word [effect]
  mov bp,ax   ; offset of effect in sound table
  mov cx,W
.lp
  mov bx,bp
  mov bx,[sound+bx]
  mov bh,cl  ; y-as
  xchg bh,bl ; swap x,y as
  sub bh,5

  push cx
  mov cl,bl
  mov bl,W
  sub bl,cl
  pop cx

  call calc_di_from_bx  ; input bl,bh [0,0,71,49]
  mov ax,-1
  stosw
  stosw

  inc bp
  inc bp
  loop .lp

  set_cursor 1,1
  mov ax,[effect]
  println_ax

  ret

play:             ; bx=note, dx=duration
   push ax
   push bx
   push cx
   push dx
   mov cx,bx
   mov ax,0x35
.a xor al,8       ; toggle 'break' bit
   out 0x3a,al    ; USART
.b dec ah
   jnz .c
   dec dx
   jz .d
.c loop .b
   mov cx,bx      ; reset note
   jmp .a
.d xor al,8       ; toggle 'control' bit
   cmp al,0x35    ; 'break' now on?
   jnz .e         ; jump if not
   out 0x3A,al    ; reset USART
.e pop dx
   pop cx
   pop bx
   pop ax
   ret

playEffect:
  mov bx,bp
  mov bx,[sound+bx]
  sub bx,ax   ; ax = note offset for tone height
  call play
  inc bp
  inc bp
  loop playEffect
  ret

sound: incbin "/Users/rick/Documents/Processing/DrawSound/waveform.dat"

times (180*1024)-($-$$) db 0



