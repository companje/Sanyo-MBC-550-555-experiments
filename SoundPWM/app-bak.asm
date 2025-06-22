%include "sanyo.asm" 

count EQU 5730
threshold EQU 12

setup:
    mov si,sound + 44
    mov cx,count

play:
    lodsb

    cmp al,128 ; ok dit werkt omdat op dit punt de zerocrossings zijn
    mov al,8    ; alleen bij zerocrossings verandert de waarde op de poort
    ja .next    ; van hoog naar laag of andersom. dus out 8 betekent NIET hoge amp en out 0 lage amp
    mov al,0
   
    ; het betekent alleen dat er een trilling naar de speaker gaat wanneer de waarde veranderd
    ; dus telkens wanneer het nog boven 128 is wordt dezelfde waarde over de poort verstuurd.
    ; pas bij een zero crossing verandert de output waarde en krijg je dus een puls.
    ; als je dus ook een threshold wilt zodat bijv 127 en 129 niet mee tellen moeten we misschien die 128 dynamisch maken
    ; als 
.next:
    out 0x3a,al

    push cx
    mov cx,40
    .wait loop .wait
    pop cx

    loop play
    jmp setup


sound: incbin "data/drums4000Hz.wav" ;1khz-4000Hz.wav"

times (180*1024)-($-$$) db 0


;     mov cx,50000
;     mov si,sound

; main_loop:
;     push cx
;     lodsb

;     ; push ax
;     ; push cx
;     ; lodsb
;     xor ch,ch
;     times 3 shr al,1
;     mov cl,al

;     mov dl,255>>3
;     sub dl,al

;     ; push cx
;     ; mov al, [bx]          ; laad sample (0–255)
;     ; mov ah, al    ; put sound value in ah, used as MSB for delay loop

;     ; HIGH fase
;     ; in  al, 0x3A
;     ; or  ah, 00001000b     ; bit 1 hoog = speaker aan


;     mov al,8
;     out 0x3A, al
;     ; rep aam
    
;     ; times 4 shr cl,1
; .wait_hi: 
;     loop .wait_hi

;     mov al,0
;     out 0x3A, al

;     xchg cl,dl
; .wait_lo: loop .wait_lo


;     ; mov cl,255
;     ; sub cl,dl
;     ; ; shr cl,1
;     ; times 4 shr cl,1
; ; .wait_lo: 
; ;     loop .wait_lo



;     pop cx
;     loop main_loop

;     hlt


    ; mov cl
    ; mov al,1
    ; shl al,cl

;     mov ah, [bx]
;     ; mov ah,0
;     ; mov ah, [bx]

;     ; mov cx,1
;     ; shl ax,cl
;     mov cx,ax ; cx**5

; .wait_hi: loop .wait_hi

;     mov al,8
;     out 0x3A, al

;     mov al, 255
;     sub al, [bx]
;     ; not al
;     mov ah,0
;     xchg ah,al

    ; mov cx,1
;     ; shl ax,cl
;     mov cx,ax ; cx**5

;     ; ; not ax
;     ; times 5 shl ax,1
;     ; mov cx,ax
; .wait_lo: loop .wait_lo



;     mov si, 0             ; SI = teller voor HIGH fase
; high_loop:
;     cmp si, ax
;     jae low_phase
;     inc si
;     jmp high_loop

; low_phase:
;     ; in  al, 0x3A
;     ; xchg ah,al
;     mov al, 0
;     ; and al, 11111101b     ; bit 1 laag = speaker uit
;     out 0x3A, al
;     mov si, ax
;     not si                ; LOW tijd = ~sample (255-sample)

; low_loop:
;     cmp si, 0
;     je  next
;     dec si
;     jmp low_loop

; next:
;     inc bx                ; volgende sample

 

; sound: incbin "data/1khz.raw"
; sound: incbin "data/drums.raw"
; sound: incbin "data/chirp.raw"
