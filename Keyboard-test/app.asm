cpu 8086
org 0

GREEN equ 0x1c00
COLS equ 72
ROWS equ 50
FONT equ 0xFF00

jmp setup

cursor:
col: db 0
row: db 0

FIXME
; text: times COLS*ROW

setup:
  mov al,0
  out 0x3a,al           ; keyboard \force state/
 
  mov al,0
  out 0x3a,al           ; keyboard \force state/
  
  mov al,0xFF
  out 0x3a,al           ; keyboard \reset/
  
  mov al,0xFF
  out 0x3a,al           ; keyboard \mode/
  
  mov al,0x37
  out 0x3a,al           ; keyboard \set command

  mov al, 5
  out 10h, al           ; select address 0x1c000 as green video page
  
  call clear_green


  ; mov al,1
  ; call draw_char
  ; mov al,1
  ; call draw_char
  ; mov al,1
  ; call draw_char

  ; call rom_to_vram
  ; hlt

  cli
  
draw:


  mov cx,73
.lp
  mov al,65
  call draw_char  
  loop .lp

  hlt

  ; in al,0x3a
  ; test al,2

  ; ; jz .jiret

  ; in al,0x38  ;get data byte
  
  ; cmp al,0
  ; je draw

  ; cmp al, 0b00011111
  ; je draw

  ; ; call draw_char
  ; call draw_char

  ; mov al,0x37
  ; out 0x3a,al ; drop key


  cmp di,14400
  jb draw
  xor di,di
  jmp draw

rom_to_vram:
  mov ax, 0xFE00
  mov ds, ax       ; DS source segment
  mov ax, GREEN
  mov es, ax       ; ES dest segment
  mov si, 0x1000   ; FONT offset in ROM
  mov di, 0        ; dest index
  mov cx, 0x4000   ; 8000 bytes (0x4000 in hexadecimal)
  rep movsb        ; Kopieer CX bytes van DS:SI naar ES:DI
  ret


draw_char:   ; al=char, changes ax,di,si,ds
  mov si,FONT
  mov ds,si

  shl ax,1
  shl ax,1
  shl ax,1
  mov si,ax
  movsw
  movsw
  push di
  add di,4*COLS-4
  movsw
  movsw
  pop di

  push cs
  pop ds

  inc byte [col]

  cmp byte [col],25
  jne .done

  mov byte [col],0
  inc byte [row]     ; 1 row = 4 lines
  inc byte [row]

  push bx
  mov bx,[cursor]
  call calc_di
  pop bx


.done
  ret

calc_di:          ; input bl,bh [0,0,71,49]
  mov ax,144      ; 2*72 cols
  mul bh          ; bh*=144 resultaat in AX
  shl ax,1        ; verdubbel AX
  mov di,ax       ; di=ax (=bh*288)
  shl bl,1        ; bl*=2
  shl bl,1        ; bl*=2
  mov bh,0
  add di,bx       ; di+=bl
  ret

clear_green:
  mov cx,COLS*ROWS*2
  mov ax,GREEN
  mov es,ax
  xor di,di
  xor ax,ax
  rep stosw         ; clear screen
  xor di,di
  ret

beep:
  mov cx,3
.lp in al,0x3a
  test al,1
  jz .lp
  mov al,0x18
  out 0x38,al
  loop .lp
  ret

times (180*1024)-($-$$) db 0

