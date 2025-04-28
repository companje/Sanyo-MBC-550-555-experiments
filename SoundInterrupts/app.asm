%include "sanyo.asm"

ticks EQU 30 ; 50 ;787 ; 100Hz (10ms)
len EQU 5000 ; endsound-sound
sound1bit EQU 0x4000

playhead: dw 0
prev: db 0

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
.store:        ; can remove the loop here since we're only setting 1 interrupt...
  mov ax,onTimer
  stosw
  mov ax,cs
  stosw
  loop .store


  push cs
  pop ds

  set_cursor 1,1



  call unpack



  mov si,sound1bit
  mov word [playhead], sound1bit

  mov ax,GREEN
  mov es,ax
  mov di,0

  sti

update:
  jmp update

; bit: db 1
store_bit:
  push ax
  shl al,cl
  mov al,0
  jc .a
  mov al,8
  .a stosb
  pop ax
  ret

unpack:
  mov si,sound
  mov di,sound1bit
  push cs
  pop es

  mov cx,len
  .lp
  lodsb

  push cx
  mov cl,8
  call store_bit
  pop cx

  push cx
  mov cl,7
  call store_bit
  pop cx

  push cx
  mov cl,6
  call store_bit
  pop cx

  push cx
  mov cl,5
  call store_bit
  pop cx

  push cx
  mov cl,4
  call store_bit
  pop cx

  push cx
  mov cl,3
  call store_bit
  pop cx

  push cx
  mov cl,2
  call store_bit
  pop cx

  push cx
  mov cl,1
  call store_bit
  pop cx
  loop .lp

  ; ; push cx
  ; ; mov cx,8
  ; ; shl al,1
  ; ; push ax
  ; ; mov al,0
  ; ; jc .a
  ; ; mov al,8
  ; ; .a: stosb
  ; ; pop ax
  ; ; pop cx
  ; loop .lp

  ret

; low,high,rise,fall

; wave_shape:
; rise: dw 255,128,128,128
; fall: dw 1,1,1,255
; high: dw 255,0,0,0
; low: dw 0,0,0,255

onTimer:
  lodsb
  ; mov bx,[playhead]
  ; mov al,[bx]
  ; inc word [playhead]
  out 0x3a,al  
  stosb

  cmp si,sound1bit+len
  jae .reset_sound
  iret

.reset_sound:
  xor di,di
  mov cx,7200
  xor ax,ax
  rep stosw
  xor di,di
  mov si,sound1bit
  iret

; scroll first 4 lines 1 character to left
  ; push ax
  ; push si
  ; push cx
  ; push ds
  ; push es
  ; pop ds   ; ds=GREEN
  ; mov si,0
  ; mov di,-4
  ; mov cx,4*COLS-4
  ; rep movsb
  ; pop ds
  ; pop cx
  ; pop si
  ; pop ax

  ; draw high or low bit on the right
;   set_cursor 1,71
;   or al,al
;   jz .low

; .high:
;   mov ax,-1
;   stosw
;   mov ax,0
;   stosw
;   jmp .done

; .low:
;   mov ax,0
;   stosw
;   mov ax,-1
;   stosw

.done:


  ; mov cl,3
  ; shr al,cl

  ; shl byte [history],1   ; move history to left
  ; or byte [history],al   ; 

  ; shr al,1  ; now 3rd bit is high if al==8
  ; shr al,1  ; now 2nd bit is high if al==8

  ; or al,al
  ; jz .draw_wave
  ; mov al,255
  ; .draw_wave:
  ; times 4 stosb

  ; cmp al,[prev]
  ; jb .fall
  ; ja .rise
  
  ; shr al,1
  ; mov byte [prev],al    ; store 

  ; mov ax,[playhead]
  ; print_ax_hex
  ; print_char ' '

  ; mov cl,32
  ; mul cl

  ; mov al,255

  ; 
  iret












;   test byte [bit],1
;   je .a
;   lodsb
; .a:
;   test al,[bit]
;   mov al,0
;   jz .b
;   mov al,8
; .b:

;   out 0x3a,al

;   ror byte [bit],1

;   iret

  ; setc al

;   rol byte [bit],1
;   jnz .nz
;   lodsb  ; al=[si]; si++
; .nz

;   push ax
;   and al,[bit]
;   mov al,0
;   jz .sendbit
;   mov al,8
; .sendbit
;   out 0x3a,al
;   pop ax
;   iret

;   ; mov al,[bit]
;   ; mov ah,0
;   ; set_cursor 1,1
;   ; print_ax
;   ; print_char ' '

;   pop ax
  
;   iret

  ; push ax
  ; push bx
  ; push cx

  ; mov ax,si
  ; mov cx,8
  ; div cx ; result in ax:dx  (ax=quotient, dh=0, dl=remainder 0..7)

  ; mov bx,ax
  ; add bx,sound ; offset
  ; mov al,[bx] ; get sound value

; play:
;   mov bl,8
;   mov bh,1
; .nextbit:
;   push ax
;   mov ah,al
;   mov al,0
;   and ah,bh
;   jz .sendbit
;   mov al,8
; .sendbit:
;   out 0x3A,al
;   push cx
;   mov dx,17
;   mov cx,dx
; .wait: loop .wait
;   pop cx
;   pop ax
;   shl bh,1
;   dec bl
;   jnz .nextbit

  ; iret

;   and al, [bit_counter]
;   mov al,0   ; if ah&bh==0
;   jz .sendbit
;   mov al,8   ; if ah&bh!=0
; .sendbit:


; wrap
; jnz .next1
; mov byte [bit_counter],1

; .next1:


  ; mov cl,dl
  ; shl al,cl
  ; mov al,8
  ; jc .send_bit
  ; mov al,0



  ; mov bl,8
  ; mov cl,dl
  ; mov bh,1
  ; shl bh,cl

; ; .nextbit:
;   mov ah,al
;   and ah,bh
;   mov al,0   ; if ah&bh==0
;   jz .sendbit
;   mov al,8   ; if ah&bh!=0
; .sendbit:


  ; mov cl,dl
  ; shl al,cl
  ; mov al,8
  ; jc .send_bit
  ; mov al,0

; cmp al,128
; mov al,0
; ja .send_bit
; mov al,8
; mov al,[bx]

; .send_bit:

  ; and al,[bit_counter]

  ; inc byte [bit_counter]
  ; cmp byte [bit_counter],8

  ; jmp .nextbyte


  

  ; rol byte [bit_counter],1
  ; jnz .done_inc
;   inc word [counter]
; ; .done_inc:


;   ; mov ax,[counter]
;   ; ; mov ah,0
;   ; print_ax
;   ; print_char ' '

;   ; inc word [counter]
;   ; pop cx
;   ; pop bx
;   ; pop ax
;   cmp word [counter],len*8 ; counter is de hoeveelste bit ipv byte
;   jae .reset_sound
;   iret
; .reset_sound:
;   mov word [counter],0
;   mov word [bit_counter],1
;   iret


; byte_counter: dw 0
; bit_counter: db 1

; %include "1bit-1khz.inc"
; %include "1bit-ramp_up_sound.inc"
%include "8bit-ramp_up_sound.inc"
; %include "8bit-1khz.inc"
; %include "wonderful-days-1-short.inc"
endsound:



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

; print_ax
  ; print_char ' '

  ; mov al,dl

  

  ; mov cl,8

  ; mov ah,0 ; clear hibyte

  ; div cl   ; result in al, rest in ah ?

; of een extra variabele voor de AND bit waarde 1 2 4 8 ....
; liever geen div maar een extra variabele die optelt en na elke 7 de hoofdcounter 1 omhoog doet


  ; mov ah,0
  ; mov al,dl



  ; mov bx,ax
  ; mov al,[bx] ; get byte with 8 bits

  ; mov cl,dl ; cl bevat nu 0..7 (want dl is lobyte van rest waarde van deling door 8)

  ; shl al,cl ; carry bit bevat nu 0 of 1

  ; mov ah,0

  


; mov al,8
;   jc .sendbit
; mov al,0
;   .sendbit

; bovenstaande werkt nog niet maar zou wel ongeveer het idee moeten zijn





; mov cl,dl


; volgende stap is om 8 bits per byte aan audio op te slaan...
; zie voorbeeld in Sound2? 


; mov ax,GREEN
  ; mov es,ax
  ; mov cx,COLS*ROWS*2
  ; mov di,8*72
  ; mov ax,[counter]
  ; rep stosw         ; clear screen
  

  ; set_cursor 1,1
  ; print_ax


%assign num $-$$
%warning total num

times (180*1024)-($-$$) db 0xf4

