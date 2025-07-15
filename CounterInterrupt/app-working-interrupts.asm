ticks EQU 20000 

G3  equ 0xFD  ; = 196Hz
C4  equ 0xBE  ; = 262Hz
E4  equ 0x96  ; = 330Hz
B3  equ 0xC9  ; = 247Hz
D4  equ 0xA8  ; = 294Hz
A3  equ 0xE1  ; = 220Hz
F4  equ 0x8E  ; = 349Hz

setup:
  ;interrupt handler
  mov ax,0
  mov ds,ax
  mov word [ds:0xF8*4+0],onTimer0   ; 0xF8 timer0 interrupt handler
  mov word [ds:0xF8*4+2],cs

  ;interrupt controller
  mov al,0x13 ; ICW1
  out 0x00,al
  mov al,0xf8 ; ICW2
  out 0x02,al
  mov al,0x0f ; ICW4
  out 0x02,al
  mov al,0x96 ; mask
  out 0x02,al

  ;timer 0
  mov al, 0x34        ; timer0
  out 0x26, al
  mov al, ticks & 0xff
  out 0x20, al        ; timer0 lobyte
  mov al, ticks >> 8
  out 0x20, al        ; timer0 hibyte

  push cs
  pop ds

  sti ; enable interrupt

update:
  ;....
  jmp update

onTimer0:
  mov bx,bp
  and bx,31
  mov bl,[bx+song]

  mov dx,100
  call play

  inc bp
  iret


times 300 db 0   ; dit is nodig omdat de interrupt table overlapt met deze code.
                 ; eigenlijk zou de code moeten beginnen op 0040:0000 ip 0038:0000


play:             ; bx=note, dx=duration
    mov cx,bx
    mov ax,0x35
.a: xor al,8       ; toggle 'break' bit
    out 0x3a,al    ; USART
.b: dec ah
    jnz .c
    dec dx
    jz .e
.c: loop .b
    mov cx,bx      ; reset note
    jmp .a
.e: ret

song:
db G3,C4,E4,C4
db G3,C4,E4,C4
db G3,B3,D4,B3
db G3,B3,D4,B3
db A3,D4,F4,D4
db A3,D4,F4,D4
db A3,C4,E4,C4
db A3,C4,E4,C4

%assign num $-$$
%warning total num
times (180*1024)-num db 0
