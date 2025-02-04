%include "sanyo.asm"

setup:
  call draw_logo

  set_cursor 20,33
  println "Written by"

  set_cursor 22,25
  println "Rick Companje & Arno Winkel"

  set_cursor 24,22
  println "Blow'em away  Copyright (C) 1996"

  hlt

draw_logo:
  mov word [color_channel],RED
  xor di,di    ; left top
  mov si,logo
  mov es,[color_channel]
  mov ax,0     ; off
  mov dx,-1    ; on
.col:
  xchg cl,al   ; save al
  lodsb
  or al,al
  jz .done
  xchg al,cl   ; restore al
.cell:
  or ax,ax
  jz .off      ; bg fill, fg green
.on:
  push ax
  push cx
  push si
  mov si,di
  mov cl,10    ;/=1024
  shr si,cl
  shl si,1     ;*=2
  add si,gradient
  movsw
  movsw
  pop si
  pop cx
  pop ax
  jmp .next2
.off:
  add di,4
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

logo: 
 db 50,36,14,36,14,4,12,4,12,4,14,5,10,6,10,5,(14+1),5,8,8,8,5,(16+1)
 db 32,16+4,12,4,12,(18+50),36,14,36,14+32,4,14+50+2,32,16+1,34,15,5
 db 26,5,14,5,26,5,14+1,34,15+2,32,16+50,34,16,35,15+32,4,14,36,14+32
 db 4,14,35,15,34,16+50,4,46+50,36,14,36,14,4,12,4,12,4,14,4,12,4,12
 db 4,14+50+2,34,14+1,35,14,4,32+14,36,14,4,32+14+1,35,14+2,34,14+50+50+2
 db 34,14+1,35,14,4,12,4,16+14,4,12,4,16+14+1,35,14+2,34,14+50,34,2+14,
 db 35,1+14+32,4,14,36,14+32,4,14,35,1+14,34,2+14+50+2,34,14+1,35,14,4,
 db 12,4,16+14,4,12,4,16+14+1,35,14+2,34,14+50,18,18+14,18,18+14+16,2+18,
 db 14,18,18+14,18,18+14+50
 db 0

gradient: 
 db 170,0,170,0
 db 170,17,170,68 
 db 170,85,170,85 
 db 85,238,85,187 
 db 119,255,221,255
 db 255,255,255,255






times (180*1024)-($-$$) db 0
