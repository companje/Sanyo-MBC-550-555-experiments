G3  equ 0xFD  ;253 = 196Hz
A3  equ 0xE1  ;225 = 220Hz
B3  equ 0xC9  ;201 = 247Hz
; -----
C4  equ 0xBE  ;190 = 262Hz
D4  equ 0xA8  ;168 = 294Hz
E4  equ 0x96  ;150 = 330Hz
F4  equ 0x8E  ;142 = 349Hz
G4  equ 0x7E  ;    = 393Hz
Gs4 equ 0x77  ;    = 416Hz
A4  equ 0x70  ;    = 442Hz
As4 equ 0x6A  ;    = 466Hz
B4  equ 0x64  ;    = 494Hz
; -----
C5  equ 0x5e  ;    = 527Hz
D5  equ 0x54  ;    = 588Hz
Ds5 equ 0x4F  ;    = 625Hz
E5  equ 0x4B  ;    = 658Hz
F5  equ 0x47  ;    = 695Hz
Fs5 equ 0x43  ;    = 736Hz
G5  equ 0x3F  ;    = 782Hz 
Gs5 equ 0x3B  ; 
A5  equ 0x37  ;    = 881Hz
B5  equ 0x34  ;    = ????
; ----
C6  equ 0x2F  ;    = ???

E3 equ E4 ; hack
F3 equ F4 ; hack

NUM equ 32 ; wonderful days
; NUM equ 16*6 ; C - G - Am - Em - F - C - F - G
T equ 2*NUM
PULSE_W equ 90

setup:
  push cs
  pop ds
  mov si,song

update:
  inc bp
  
  ; cmp bp,0x21
  ; jl .ch1
  test bp,1
  jz .ch2

;#########
.ch1:
    mov bh,0
    lodsb
    mov bl,al

    cmp bp,T
    jb .done_ch

    mov dx,10
    call play
    jmp .done_ch

.ch2:
    push cx
    mov cx,bp
    mov al,[mm]
    xor ah,ah
    and cx,ax

    shl bx,cl
    pop cx
    mov dx,[dv]

    shr bx,1

    call play

    mov al,[mm]

    cmp bp,1*T
    jne .xx
    mov word [dv],PULSE_W-10
.xx:


 
    cmp bp,6*T-T/5 ;4*T+T/2+5
    jg .q

    cmp bp,5*T
    jg .p

    cmp bp,4*T
    jg .o

    cmp bp,3*T
    jg .z

    cmp bp,2*T
    jg .x

    cmp bp,1*T
    jg .y
    jmp .done_ch

.q: hlt

.p: add word [dv],3

.o: ror al,1
    ; ror al,1

.x:
    rol al,1
    rol al,1
    ; ror al,1

.y:
    ; 
.z:
    mov [mm],al

.done_ch:

  cmp si,song+NUM
  jb update
  mov si,song
  jmp update

mm: db 1
dv: dw PULSE_W

play:             ; bx=note, dx=duration
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
.d 
; xor al,8       ; toggle 'control' bit
;    cmp al,0x35    ; 'break' now on?
;    jnz .e         ; jump if not
;    out 0x3A,al    ; reset USART
.e ret

song:
db G3,C4,E4,C4
db G3,C4,E4,C4
db G3,B3,D4,B3
db G3,B3,D4,B3
db A3,D4,F4,D4
db A3,D4,F4,D4
db A3,C4,E4,C4
db A3,C4,E4,C4

; ch2:
; db G3,G3,G3,G3
; db G3,G3,G3,G3
; db G3,G3,G3,G3
; db G3,G3,G3,G3
; db G3,G3,G3,G3
; db G3,G3,G3,G3
; db G3,G3,G3,G3
; db G3,G3,G3,G3

; C - G - Am - Em - F - C - F - G
; db C4,E4,G4, C5,E5,G5   ;C
; db C4,E4,G4, C5,E5,G5   ;C

; db G3,B3,D4, G4,B4,D5   ;G
; db G3,B3,D4, G4,B4,D5   ;G

; db A3,C4,E4, A4,C5,E5   ;Am
; db A3,C4,E4, A4,C5,E5   ;Am

; db E3,G3,B3, E4,G4,B4   ;Em
; db E3,G3,B3, E4,G4,B4   ;Em

; db F3,A3,C4, F4,A4,C5   ;F
; db F3,A3,C4, F4,A4,C5   ;F

; db C4,E4,G4, C5,E5,G5   ;C
; db C4,E4,G4, C5,E5,G5   ;C

; db F3,A3,C4, F4,A4,C5   ;F
; db F3,A3,C4, F4,A4,C5   ;F

; db G3,B3,D4, G4,B4,D5   ;G
; db G3,B3,D4, G4,B4,D5   ;G


; ; zelfde maar rechter hand in andere volgorde
; ; C - G - Am - Em - F - C - F - G

; C
db C4,E4,G4 ; linker hand
db C5,E5,G5,C6,G5,E5,  C5    ; rechterhand >>>> <<
db G4,E4 ; linker hand

; G
db G3,B3,D4 ; linker hand
db G4,B4,D5,G5,D5,B4,  G4    ; rechter hand
db D4,B3 ; linker hand

; Am
db A3,C4,E4 ; linker hand
db A4,C5,E5,A5,E5,C5,  A4    ; rechter hand
db E4,C4 ; linker hand

; Em
db E3,G3,B3 ; linker hand
db E4,G4,B4,E5,B4,G4,  E4  ; rechter hand
db B3,G3 ; linker hand

; F
db F3,A3,C4 ; linker hand
db F4,A4,C5,F5,C5,A4,  F4  ; rechter hand
db C4,A3 ; linker hand

; C 
db C4,E4,G4 ; linker hand
db C5,E5,G5,C6,G5,E5,  C5 ; rechterhand >>>> <<
db G4,E4 ; linker hand

; F
db F3,A3,C4 ; linker hand
db F4,A4,C5,F5,C5,A4,  F4  ; rechter hand
db C4,A3 ; linker hand

; G
db G3,B3,D4 ; linker hand
db G4,B4,D5,G5,D5,B4,  G4 ; rechter hand
db D4,B3 ; linker hand







%assign num $-$$
%warning total num
times (180*1024)-num db 0


