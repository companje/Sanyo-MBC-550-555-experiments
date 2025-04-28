%include "sanyo.asm"

ticks EQU 50 ;787 ; 100Hz (10ms)

setup:
  ; 8253 Timer
  ; Send Control Word (0x34 = 00110100) to port 0x26
  ;   Channel 0 (bits 7-6 = 00)
  ;   Access mode: lobyte/hibyte (bits 5-4 = 11)
  ;   Mode 2: rate generator (bits 3-1 = 010)
  ;   Binary mode (bit 0 = 0)
  mov al, 0x34
  out 0x26, al
  mov al, ticks & 0xff
  out 0x20, al        ; lobyte
  mov al, ticks >> 8
  out 0x20, al        ; hibyte


  ;8259A interrupt controller
  mov al, 0x13
  out 0x00, al    ; ICW1: init, edge-triggered, ICW4 nodig
  mov al, 0xF8
  out 0x02, al    ; ICW2: interrupt vector offset
  mov al, 0x0F
  out 0x02, al    ; ICW4: 8086 mode, auto EOI (end of interrupt)
  mov al, 0xFE
  out 0x02, al    ; OCW1: alleen IRQ0 ingeschakeld

; set all interrupt handlers to 0040:0040
  mov di,0
  mov es,di
  mov cx,0x200
  mov ax,0x0040
  rep stosw

; store iret at 0040:0040
  mov di,0x40
  mov es,di
  mov al,0xcf
  stosb


; set 0xF8 interrupt handler to CS:handler
  mov di,0
  mov es,di
  mov di,0xf8*4
  mov cx,1
.store:
  mov ax,handler
  stosw
  mov ax,cs
  stosw
  loop .store

  


  push cs
  pop ds

  ; mov bp,sound
  ; mov di,sound
  mov word [counter], sound

  sti

update:
  
  mov ax,GREEN
  mov es,ax
  mov cx,COLS*ROWS*2
  mov di,8*72
  mov ax,[counter]
  rep stosw         ; clear screen
  
  set_cursor 1,1
  print_ax


  jmp update



handler:
  push ax
  push bx
  mov bx,[counter]
  mov al,[bx]
  out 0x3a,al
  inc word [counter]
  pop bx
  pop ax
  cmp word [counter],endsound
  jge .reset_sound
  iret
.reset_sound:
  mov word [counter],sound
  iret


; ---------- 
;   mov ax, 0x100      ; startsegment
; .loop_segment:
;   mov es, ax
;   push ax
;   xor di, di
;   mov cx, 0xFFFF
;   mov al, 0xF4
;   rep stosb
;   pop ax
  
;   add ax, 0x10     ; volgende segment (16 bytes hoger)
;   cmp ax, 0xf000   ; laatste bruikbare segment vóór 1MB
;   jbe .loop_segment


; ---------------
  ; mov ax, 0
  ; mov es, ax

  ; mov word [es:0x380+0], 0xA70
  ; mov word [es:0x380+2], 0

  ; mov word [es:4*0xE0+0], 0xA70
  ; mov word [es:4*0xE0+2], 0

  ; mov word [es:4*0xF8+0], 0xA70
  ; mov word [es:4*0xF8+2], 0

  ; mov word [es:4*0xF9+0], 0xA70
  ; mov word [es:4*0xF9+2], 0

  ; mov word [es:4*0xFA+0], 0xA70
  ; mov word [es:4*0xFA+2], 0

  ; mov al, 0x13
  ; out 0x00, al    ; ICW1: init, edge-triggered, ICW4 nodig
  ; mov al, 0xF8
  ; out 0x02, al    ; ICW2: interrupt vector offset
  ; mov al, 0x0F
  ; out 0x02, al    ; ICW4: 8086 mode, auto EOI
  ; mov al, 0xFE
  ; out 0x02, al    ; OCW1: alleen IRQ0 ingeschakeld

;8259A interrupt controller
    ; dw 0x0013, 0x02f8, 0x020f, 0x0296
    ; 

;   sti

; update:
;   mov al, 0x00
;   out 0x26, al
;   in al, 0x20
;   mov bl, al
;   in al, 0x20
;   mov bh, al
;   mov [counter],bx
;   ; jmp update
;   hlt

; onTimer:
;   mov byte [counter],0x99
;   ; times 1000 cli
;   iret



  ; mov si,sound


; .loop:
  

;     inc si
;     cmp si,endsound
;     ja .reset_sound

;     mov al,[si]
;     ; shl al,dl
;     out 0x3A, al

;   mov cx,10
;   .delay 
;   nop
;   loop .delay

;   jmp .loop

; .reset_sound
;   mov si,sound
;   jmp .loop

counter: dw 0

; %include "1bit-1khz.inc"
%include "1bit-ramp_up_sound.inc"
endsound:



  ;   cmp bx, ticks/2
  ;   jb .low

  ; .high:
  ;   mov al, 8
  ;   out 0x3A, al
  ;   jmp .loop
  ; .low:
  ;   mov al, 0
  ;   out 0x3A, al
  ;   jmp .loop

 














; start:
 
;   mov al, 0x13
;   out 0x00, al    ; ICW1: init, edge-triggered, ICW4 nodig
;   mov al, 0xF8
;   out 0x02, al    ; ICW2: interrupt vector offset
;   mov al, 0x0F
;   out 0x02, al    ; ICW4: 8086 mode, auto EOI
;   mov al, 0xFE
;   out 0x02, al    ; OCW1: alleen IRQ0 ingeschakeld


;   ; cli
;   ; mov ax, 0
;   ; mov es, ax
;   ; mov word [es:0x3E0], onTimer
;   ; mov word [es:0x3E2], cs
  
; mov al, 0x34
;   out 0x26, al    ; Mode 2, lobyte/hibyte, counter 0
;   mov al, 11
;   out 0x20, al    ; Lobyte
;   mov al, 0
;   out 0x20, al    ; Hibyte


;   ; sti

; .lp:

  

;   mov al, 0x00        ; Command: latch counter 0
;   out 0x26, al        ; Command register is op poort 0x26

;   in al, 0x20         ; Lees lobyte van counter 0
;   mov bl, al

;   in al, 0x20         ; Lees hibyte van counter 0
;   mov bh, al

;   mov byte al, [cs:sound+bx]
;   times 3 shl al,1

;   ; mov byte cs:[counter], al

; ; inc byte cs:[counter]

;   out 0x3A, al

;   jmp .lp



;   hlt

; onTimer:
;   ; inc byte cs:[counter]
;   iret

; counter: dw 0

  


; ; ; ; play:
; ; ; ;   lodsb
; ; ; ;   mov bl,8
; ; ; ;   mov bh,1
; ; ; ; .nextbit:
; ; ; ;   push ax
; ; ; ;   mov ah,al
; ; ; ;   mov al,0
; ; ; ;   and ah,bh
; ; ; ;   jz .sendbit
; ; ; ;   mov al,8
; ; ; ; .sendbit:
; ; ; ;   out 0x3A,al
; ; ; ;   push cx
; ; ; ;   mov cx,dx
; ; ; ; .wait: loop .wait
; ; ; ;   pop cx
; ; ; ;   pop ax
; ; ; ;   shl bh,1
; ; ; ;   dec bl
; ; ; ;   jnz .nextbit
; ; ; ;   loop play
; ; ; ;   ret









;   ; cli

;   ; mov ax,RED
;   ; mov es,ax
;   ; xor di,di
;   ; mov ax,-1
;   ; stosw

;   ; call background

;   ; iret


;   ; 8259A interrupt controller
;   ; mov al,0x13
;   ; out 0x00,al ;ICW1
;   ; mov al,0xf8
;   ; out 0x02,al ;ICW2
;   ; mov al,0x0f
;   ; out 0x02,al ;ICW4
;   ; mov al,0x96
;   ; out 0x02,al ;mask

;   ; ; ;Timer init code
;   ; mov al,0x34
;   ; out 0x26,al
;   ; mov al,0xbf
;   ; out 0x20,al
;   ; mov al,0x21
;   ; out 0x20,al ;channel 0 (clock)

;   ; mov al,0x74
;   ; out 0x26,al
;   ; mov al,0x00
;   ; out 0x22,al
;   ; mov al,0x00
;   ; out 0x22,al ;channel 1 (2nd stage clock)
;   ; mov al,0xb6
;   ; out 0x26,al
;   ; mov al,0x5d
;   ; out 0x24,al
;   ; mov al,0x00
;   ; out 0x24,al ;channel 2 (add-in serial rate)


; ;   mov cx,0xff ; 0xe0
;   ; xor di,di
;   ; mov es,di
; ; .lp:
; ;   mov ax,onTimer
; ;   stosw
; ;   mov ax,cs
; ;   stosw
; ;   loop .lp

; ;   xor ax,ax
; ;   mov es,ax

; ;   mov word [es:4*0xf8+0], onTimer
; ;   mov word [es:4*0xf8+2], cs

; ;   mov word [es:4*0xf9+0], onTimer
; ;   mov word [es:4*0xf9+2], cs

; ; ; loop lp
; ;   sti

; ;   hlt



;   ; mov word [es:4*int_timer0],cs
;   ; mov word [es:4*int_timer0+2],onTimer

;   ;8259A interrupt controller
;   ; mov al,0x13
;   ; out 0x00,al ;ICW1
;   ; mov al,0xf8
;   ; out 0x02,al ;ICW2
;   ; mov al,0x0f
;   ; out 0x02,al ;ICW4
;   ; mov al,0x96
;   ; out 0x02,al ;mask

;   ; ; ;Timer init code
;   ; mov al,0x34
;   ; out 0x26,al
;   ; mov al,0xbf
;   ; out 0x20,al
;   ; mov al,0x21
;   ; out 0x20,al ;channel 0 (clock)

;   ; mov al,0x74
;   ; out 0x26,al
;   ; mov al,0x00
;   ; out 0x22,al
;   ; mov al,0x00
;   ; out 0x22,al ;channel 1 (2nd stage clock)
;   ; mov al,0xb6
;   ; out 0x26,al
;   ; mov al,0x5d
;   ; out 0x24,al
;   ; mov al,0x00
;   ; out 0x24,al ;channel 2 (add-in serial rate)

;   ; sti

;   ; hlt

;   ; ; cli

;   ; call background

;   ; hlt

;   ; .j jmp .j



; ; background:
; ;   mov ax,RED
; ;   mov es,ax
; ;   mov cx,1 ; 72*25*4
; ;   xor di,di
; ;   mov ax,-1
; ;   rep stosw
; ;   ret





; ; hlt

; ; RED   equ 0xf000
; ; GREEN equ 0x1c00
; ; BLUE  equ 0xf400


; ; ; mov si, 0x0000
; ; ; mov ax, 0x0038
; ; ; mov ds, ax
; ; ; mov di, 0x0000
; ; ; mov ax, 0x1000
; ; ; mov es, ax
; ; ; mov cx, 512
; ; ; rep movsb

; ; ; cs jmp setup

; ; ; setup:



; ; ; setup:


; ;   mov ax,0
; ;   mov es,ax
; ;   ; mov ds,cs
; ;   mov word [es:4*my_int],cs
; ;   mov word [es:4*my_int+2],onTimer

; ; hlt

; ;   ; mov ax,onTimer
; ;   ; mov di,4*0xf8


; ;   ;8259A interrupt controller
; ;   mov al,0x13
; ;   out 0x00,al ;ICW1
; ;   mov al,0xf8
; ;   out 0x02,al ;ICW2
; ;   mov al,0x0f
; ;   out 0x02,al ;ICW4
; ;   mov al,0x96
; ;   out 0x02,al ;mask

; ;   ;Timer init code
; ;   mov al,0x34
; ;   out 0x26,al
; ;   mov al,0xbf
; ;   out 0x20,al
; ;   mov al,0x21
; ;   out 0x20,al ;channel 0 (clock)
; ;   mov al,0x74
; ;   out 0x26,al
; ;   mov al,0x00
; ;   out 0x22,al
; ;   mov al,0x00
; ;   out 0x22,al ;channel 1 (2nd stage clock)
; ;   mov al,0xb6
; ;   out 0x26,al
; ;   mov al,0x5d
; ;   out 0x24,al
; ;   mov al,0x00
; ;   out 0x24,al ;channel 2 (add-in serial rate)


; ; ;   ; call background

; ; ;   hlt

; ; onTimer:
; ;   call background
; ;   iret


; ; background:
; ;   mov ax,RED
; ;   mov es,ax
; ;   mov cx,72*25*4
; ;   xor di,di
; ;   mov ax,-1
; ;   rep stosw
; ;   ret

; ; ; ;   mov dx,20 ; pitch (24=default)  loop delay
; ; ; ;   mov si,sound
; ; ; ;   lodsw
; ; ; ;   mov cx,endsound-sound  ; first 2 bytes loaded from sound: db (not yet for converted waves)
; ; ; ;   call play
; ; ; ;   ret

; ; ; ;   hlt


; ; ; ; play:
; ; ; ;   lodsb
; ; ; ;   mov bl,8
; ; ; ;   mov bh,1
; ; ; ; .nextbit:
; ; ; ;   push ax
; ; ; ;   mov ah,al
; ; ; ;   mov al,0
; ; ; ;   and ah,bh
; ; ; ;   jz .sendbit
; ; ; ;   mov al,8
; ; ; ; .sendbit:
; ; ; ;   out 0x3A,al
; ; ; ;   push cx
; ; ; ;   mov cx,dx
; ; ; ; .wait: loop .wait
; ; ; ;   pop cx
; ; ; ;   pop ax
; ; ; ;   shl bh,1
; ; ; ;   dec bl
; ; ; ;   jnz .nextbit
; ; ; ;   loop play
; ; ; ;   ret

; %include "assets/8bit-1khz.inc"
; ; ; endsound:

; ; sound: db 1,1,1,1,0,0,0,0,1,1,1,1,0,0,0,0,1,1,1,1,0,0,0,0,1,1,1,1,0,0,0,0,1,1,1,1,0,0,0,0,1,1,1,1,0,0,0,0,1,1,1,1,0,0,0,0,1,1,1,1,0,0,0,0,1,1,1,1,0,0,0,0,1,1,1,1,0,0,0,0,1,1,1,1,0,0,0,0,1,1,1,1,0,0,0,0,1,1,1,1,0,0,0,0,1,1,1,1,0,0,0,0,1,1,1,1,0,0,0,0,1,1,1,1,0,0,0,0,1,1,1,1,0,0,0,0,1,1,1,1,0,0,0,0,1,1,1,1,0,0,0,0,1,1,1,1,0,0,0,0,1,1,1,1,0,0,0,0,1,1,1,1,0

times (180*1024)-($-$$) db 0xf4

