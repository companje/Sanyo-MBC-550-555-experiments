%include "sanyo.asm" 

; DRUMS
count EQU 28500 
speed EQU 13

; OTHER (melody)
; count EQU 2*11200
; speed EQU 19


threshold EQU 4

setup:
    mov si,sound + 44
    mov cx,count

    mov di,0
    mov ax,RED
    mov es,ax
    xor bp,bp

play:
    lodsb
    xor bh,bh
    mov bl,al


    cmp al,128+threshold
    mov al,8
    ja .out
    cmp al,128-threshold
    mov al,0
    ja .next
.out:
    out 0x3a,al
.next:
    push cx
    mov cx,speed
    
    ; push cx
    ; mov ax,di
    ; mov cx,14400
    ; div cx
    ; mov ax,di
    
    ; mov ax,[es:0xb000+di+bp]
    mov ax,[es:0xF000-1000+bx+di]
; 0x0b000+0x04000
    
    mov [es:di],ax
    mov [es:di+2],ax

    mov [es:0x4000+di+4],ax
    mov [es:0x4000+di+6],ax

    ; mov ax,[es:0x0b000-0x04000+ bp]

    ; stosw
    ; stosw
    add bp,4
    ; pop cx

    add di,4612
    cmp di,14400
    jb .n1
    sub di,14400
.n1:

.wait:
    loop .wait
    pop cx

        ; xor bp,bp

    loop play
    ; hlt
    jmp setup


; sound: incbin "data/eurokeys.wav"
sound: incbin "data/eurobass.wav"
; sound: incbin "data/drums8000Hz.wav"
; sound: incbin "data/cyber-other8000.wav"

times (180*1024)-($-$$) db 0






; %include "sanyo.asm" 

; ticks EQU 787 ; 100Hz (10ms)

; start EQU 1000
; end EQU start+2000
; delay_after EQU 5000

; setup:
;   ; mov ax,0xff00
;   ; mov ds,ax
;   ; push cs
;   ; pop es
;   ; push cs
;   ; pop ds

;   mov si,0

; draw:

;   lodsb
;   out 0x3a,al

;   ; mov cl,1
;   ; shl ax,cl

;   mov cx,10
;   call delay

;   ; cmp si,end
;   ; jb draw
;   ; mov si,start

;   ; mov cx,delay_after
;   ; call delay

;   ; mov [a]

;   jmp draw

; delay:
;   aam
;   ; inc word [es:a]
;   ; and word [es:a],31

;   loop delay
;   ret

; a: dw 100

; init_timer:
;     mov al, 0x34
;     out 0x26, al
;     mov al, ticks & 0xff
;     out 0x20, al        ; lobyte
;     mov al, ticks >> 8
;     out 0x20, al        ; hibyte

; ; wait_timer:
; ;     in al,0x22
; ;     or al,al
; ;     jnz wait_timer
; ;     ret

; timer_wait:
;     xor al,al          ; Command: latch counter 0
;     out 0x26, al        ; Command register on 0x26
;     in al, 0x20         ; read lobyte of counter 0
;     xchg ah,al          ; store al in ah
;     in al, 0x20         ; read hibyte of counter 0
;     xchg al,ah          ; swap hi and lo byte
;     cmp ax,10          ; wait for time to reset to redraw
;     jnl .timer_wait
;     ret




; count EQU 11500
; threshold EQU 30

; setup:
;   ; cli

;   ; mov si,sound + 44
;   ; mov ax,0xFF00
;   ; mov ds,ax
;   ; mov si,0


;   ; 8253 Timer
;   ; Send Control Word (0x34 = 00110100) to port 0x26
;   ;   Channel 0 (bits 7-6 = 00)
;   ;   Access mode: lobyte/hibyte (bits 5-4 = 11)
;   ;   Mode 2: rate generator (bits 3-1 = 010)
;   ;   Binary mode (bit 0 = 0)
;   mov al, 0x34
;   out 0x26, al

;   mov al, ticks & 0xff
;   out 0x20, al        ; lobyte

;   mov al, ticks >> 8
;   out 0x20, al        ; hibyte

; update:
;   ; Polling the current value of the Timer 0

;   mov al, 0x00        ; Command: latch counter 0
;   out 0x26, al        ; Command register on 0x26

;   in al, 0x20         ; read lobyte of counter 0
;   xchg ah,al          ; store al in ah

;   in al, 0x20         ; read hibyte of counter 0
;   xchg al,ah          ; swap hi and lo byte

;   ; set_cursor 1,1
;   print_ax
;   mov al,' '
;   call write_char

;   jmp update




;


; sound: incbin "data/drums8000Hz.wav"

; times (180*1024)-($-$$) db 0

