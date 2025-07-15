; C3  equ 0x017C  ; = 131Hz
; Cs3 equ 0x0167  ; = 138Hz
; D3  equ 0x0152  ; = 147Hz
; Ds3 equ 0x013F  ; = 156Hz
; E3  equ 0x012D  ; = 165Hz
; F3  equ 0x011C  ; = 175Hz

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

T equ 4*32 

setup:
  push cs
  pop ds
  mov si,song

update:
  inc bp
  
  ; cmp bp,0x21
  ; jl .ch1
  test bp,1
  jnz .ch2

;#########
.ch1:
    mov bh,0
    lodsb
    mov bl,al
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

    call play

    mov al,[mm]

 
    cmp bp,(5+1/2)*T
    jg .q

    cmp bp,4*T
    jg .p

    cmp bp,3*T
    jg .z

    cmp bp,2*T
    jg .x

    cmp bp,1*T
    jg .y
    jmp .done_ch

.q: hlt

.p: add word [dv],2

.x:
    ror al,1
    ror al,1
    ror al,1
.y:
    rol al,1
.z:
    mov [mm],al

.done_ch:

  cmp si,song+32
  jb update
  mov si,song
  jmp update

mm: db 1
dv: dw 60

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
; dw C4,E4,G4, C5,E5,G5   ;C
; dw C4,E4,G4, C5,E5,G5   ;C

; dw G3,B3,D4, G4,B4,D5   ;G
; dw G3,B3,D4, G4,B4,D5   ;G

; dw A3,C4,E4, A4,C5,E5   ;Am
; dw A3,C4,E4, A4,C5,E5   ;Am

; dw E3,G3,B3, E4,G4,B4   ;Em
; dw E3,G3,B3, E4,G4,B4   ;Em

; dw F3,A3,C4, F4,A4,C5   ;F
; dw F3,A3,C4, F4,A4,C5   ;F

; dw C4,E4,G4, C5,E5,G5   ;C
; dw C4,E4,G4, C5,E5,G5   ;C

; dw F3,A3,C4, F4,A4,C5   ;F
; dw F3,A3,C4, F4,A4,C5   ;F

; dw G3,B3,D4, G4,B4,D5   ;G
; dw G3,B3,D4, G4,B4,D5   ;G


; ; zelfde maar rechter hand in andere volgorde
; ; C - G - Am - Em - F - C - F - G

; ; C
; dw C4,E4,G4 ; linker hand
; dw C5,E5,G5,C6,G5,E5,  C5    ; rechterhand >>>> <<
; dw G4,E4 ; linker hand

; ; G
; dw G3,B3,D4 ; linker hand
; dw G4,B4,D5,G5,D5,B4,  G4    ; rechter hand
; dw D4,B3 ; linker hand

; ; Am
; dw A3,C4,E4 ; linker hand
; dw A4,C5,E5,A5,E5,C5,  A4    ; rechter hand
; dw E4,C4 ; linker hand

; ; Em
; dw E3,G3,B3 ; linker hand
; dw E4,G4,B4,E5,B4,G4,  E4  ; rechter hand
; dw B3,G3 ; linker hand

; ; F
; dw F3,A3,C4 ; linker hand
; dw F4,A4,C5,F5,C5,A4,  F4  ; rechter hand
; dw C4,A3 ; linker hand

; ; C 
; dw C4,E4,G4 ; linker hand
; dw C5,E5,G5,C6,G5,E5,  C5 ; rechterhand >>>> <<
; dw G4,E4 ; linker hand

; ; F
; dw F3,A3,C4 ; linker hand
; dw F4,A4,C5,F5,C5,A4,  F4  ; rechter hand
; dw C4,A3 ; linker hand

; ; G
; dw G3,B3,D4 ; linker hand
; dw G4,B4,D5,G5,D5,B4,  G4 ; rechter hand
; dw D4,B3 ; linker hand







%assign num $-$$
%warning total num
times (180*1024)-num db 0







; ; C3  equ 0x017C  ; = 131Hz
; ; Cs3 equ 0x0167  ; = 138Hz
; ; D3  equ 0x0152  ; = 147Hz
; ; Ds3 equ 0x013F  ; = 156Hz
; ; E3  equ 0x012D  ; = 165Hz
; ; F3  equ 0x011C  ; = 175Hz

; G3  equ 0xFD  ;253 = 196Hz
; A3  equ 0xE1  ;225 = 220Hz
; B3  equ 0xC9  ;201 = 247Hz
; ; -----
; C4  equ 0xBE  ;190 = 262Hz
; D4  equ 0xA8  ;168 = 294Hz
; E4  equ 0x96  ;150 = 330Hz
; F4  equ 0x8E  ;142 = 349Hz
; G4  equ 0x7E  ;    = 393Hz
; Gs4 equ 0x77  ;    = 416Hz
; A4  equ 0x70  ;    = 442Hz
; As4 equ 0x6A  ;    = 466Hz
; B4  equ 0x64  ;    = 494Hz
; ; -----
; C5  equ 0x5e  ;    = 527Hz
; D5  equ 0x54  ;    = 588Hz
; Ds5 equ 0x4F  ;    = 625Hz
; E5  equ 0x4B  ;    = 658Hz
; F5  equ 0x47  ;    = 695Hz
; Fs5 equ 0x43  ;    = 736Hz
; G5  equ 0x3F  ;    = 782Hz 
; Gs5 equ 0x3B  ; 
; A5  equ 0x37  ;    = 881Hz
; B5  equ 0x34  ;    = ????
; ; ----
; C6  equ 0x2F  ;    = ???

; setup:
;   push cs
;   pop ds
;   push cs
;   pop es
;   mov si,song
;   ; mov di,data

; ; l:
; ;   mov bx,C4
; ;   mov dx,50
; ;   call play_note
; ;   jmp l

; update:
;   mov bh,0
;   lodsb
;   ; xchg ax,bx
;   mov bl,al
;   mov dx,75
;   call play_note

;   cmp si,song+32
;   jb update
;   hlt
  
;   ; mov si,song
;   ; jmp update

; ;   mov si,data

; ; play_loop:

; ;    lodsb
; ;    out 0x3a,al

; ;    mov cx,1
; ;    delay:
; ;    loop delay

; ;    cmp si,data+50000
; ;    jb play_loop

; ;    mov si,data
; ;    jmp play_loop

; ;   hlt

; play_org:             ; bx=note, dx=duration
;    ; push ax
;    ; push bx
;    ; push cx
;    ; push dx
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
; .e ret
;   ; pop dx
;   ;  pop cx
;   ;  pop bx
;   ;  pop ax
;   ;  ret


; play_note:             ; bx=note, dx=duration
;    mov cx,bx
;    ; xor ax,ax
;    mov ax,0x35
; .a xor al,8
;    out 0x3a,al
; .b dec ah
;    jnz .c
;    dec dx
;    jz .d
; .c loop .b
;    mov cx,bx      ; reset note
;    jmp .a
; .d ret

; song:
; db G3,C4,E4,C4
; db G3,C4,E4,C4
; db G3,B3,D4,B3
; db G3,B3,D4,B3
; db A3,D4,F4,D4
; db A3,D4,F4,D4
; db A3,C4,E4,C4
; db A3,C4,E4,C4

; data:

; ; C - G - Am - Em - F - C - F - G
; ; dw C4,E4,G4, C5,E5,G5   ;C
; ; dw C4,E4,G4, C5,E5,G5   ;C

; ; dw G3,B3,D4, G4,B4,D5   ;G
; ; dw G3,B3,D4, G4,B4,D5   ;G

; ; dw A3,C4,E4, A4,C5,E5   ;Am
; ; dw A3,C4,E4, A4,C5,E5   ;Am

; ; dw E3,G3,B3, E4,G4,B4   ;Em
; ; dw E3,G3,B3, E4,G4,B4   ;Em

; ; dw F3,A3,C4, F4,A4,C5   ;F
; ; dw F3,A3,C4, F4,A4,C5   ;F

; ; dw C4,E4,G4, C5,E5,G5   ;C
; ; dw C4,E4,G4, C5,E5,G5   ;C

; ; dw F3,A3,C4, F4,A4,C5   ;F
; ; dw F3,A3,C4, F4,A4,C5   ;F

; ; dw G3,B3,D4, G4,B4,D5   ;G
; ; dw G3,B3,D4, G4,B4,D5   ;G


; ; ; zelfde maar rechter hand in andere volgorde
; ; ; C - G - Am - Em - F - C - F - G

; ; ; C
; ; dw C4,E4,G4 ; linker hand
; ; dw C5,E5,G5,C6,G5,E5,  C5    ; rechterhand >>>> <<
; ; dw G4,E4 ; linker hand

; ; ; G
; ; dw G3,B3,D4 ; linker hand
; ; dw G4,B4,D5,G5,D5,B4,  G4    ; rechter hand
; ; dw D4,B3 ; linker hand

; ; ; Am
; ; dw A3,C4,E4 ; linker hand
; ; dw A4,C5,E5,A5,E5,C5,  A4    ; rechter hand
; ; dw E4,C4 ; linker hand

; ; ; Em
; ; dw E3,G3,B3 ; linker hand
; ; dw E4,G4,B4,E5,B4,G4,  E4  ; rechter hand
; ; dw B3,G3 ; linker hand

; ; ; F
; ; dw F3,A3,C4 ; linker hand
; ; dw F4,A4,C5,F5,C5,A4,  F4  ; rechter hand
; ; dw C4,A3 ; linker hand

; ; ; C 
; ; dw C4,E4,G4 ; linker hand
; ; dw C5,E5,G5,C6,G5,E5,  C5 ; rechterhand >>>> <<
; ; dw G4,E4 ; linker hand

; ; ; F
; ; dw F3,A3,C4 ; linker hand
; ; dw F4,A4,C5,F5,C5,A4,  F4  ; rechter hand
; ; dw C4,A3 ; linker hand

; ; ; G
; ; dw G3,B3,D4 ; linker hand
; ; dw G4,B4,D5,G5,D5,B4,  G4 ; rechter hand
; ; dw D4,B3 ; linker hand







; %assign num $-$$
; %warning total num
; times (180*1024)-num db 0


