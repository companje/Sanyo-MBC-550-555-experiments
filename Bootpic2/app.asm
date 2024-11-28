%include "sanyo.asm"

; RED   equ 0xf000
; GREEN equ 0x1c00
; BLUE  equ 0xf400

; jmp bootloader

; db 'Sanyo1.2',2,0,1,0,0,2,112,0,0,0,2,0,253,2,0,9,0,2,0

setup:
  mov ax, RED
  mov es, ax
  xor di, di
  mov ax, 0
  mov cx, 2000h
  rep stosw

  mov ax, GREEN
  mov es, ax
  xor di, di
  mov ax, 0
  mov cx, 2000h
  rep stosw
  
  mov ax, BLUE
  mov es, ax
  xor di, di
  mov ax, 0xffff
  mov cx, 2000h
  rep stosw
  hlt

times (360*1024)-($-$$) db 0


; ; bootloader:
; ; hlt
;   ; mov ax, 0x38
;   ; mov es, ax
;   ; xor di, di
;   ; add di,512
;   ; mov ax, 0x0f0f
;   ; mov cx, 1000h
;   ; rep stosw
  
;   ; hlt
; ;   jmp continue ;0x38:0x200

; ; %assign cnum $-$$
; ; times 511-cnum db 1


; continue:
;   hlt

; 	mov	ax, GREEN
; 	mov	es, ax
; 	xor di, di
; 	mov ax, 0xf4f4
; 	mov	cx, 2000h
; 	rep stosw

; 	hlt
	
; ; 	push cs
; ;   pop ds      ; ds=cs

; ; ; alle jumps zijn relatief dus die werken wel. 
; ; ; De mov si,72 verwijst naar een absoluut adres binnen het DS segment
; ; ; Je zou willen dat setup op DST:0 staat.. is dat ook zo? daar gaat wel de jmp naar toe vanuit de bootloader
; ; ; maar de assembler maakt die een ander adres van het label img2. ja denk t wel

; ; ; maar waarom het er nu ook gek uitziet bij mov si,72.
; ; ; dat lijkt alsof er code of stack over de afbeelding heen loopt..


; ; 	; mov si, img2
; ;   mov si, 72 ;ds:img2
; ;   ; verschil tussen img2 adres en 72 is: 9620, dat komt bijna overeen (4 bytes verschil)
; ;   ; met de onverklaarbaarbare serie nullen aan het eind van de bootloader...
; ; ; hlt

; ;   mov bh,4 ; cols 
; ;   mov bl,4 ; rows
; ;   call draw_pic


; ;   xor di,di
; ;   add di,4*4
; ;   mov si, 72 + 192 ;ds:img2
; ; 	mov bh,4 ; cols 
; ;   mov bl,4 ; rows
; ;   call draw_pic

; ; 	hlt


; ; ; img2: 
; ; ;   db 0,112,127,112,255,255,255,255,245,250,253,250,0,14,254,14
; ; ;   db 56,28,7,0,255,127,255,255,253,250,245,255,28,56,224,0
; ; ;   db 0,0,0,0,15,3,3,3,240,192,192,128,0,0,0,0
; ; ;   db 0,0,0,0,3,7,63,127,192,176,212,234,0,0,0,0
; ; ;   db 0,96,117,96,255,255,255,255,160,208,232,208,0,4,234,4
; ; ;   db 48,24,7,0,255,127,127,191,232,208,224,215,8,16,224,0
; ; ;   db 0,0,0,0,15,3,3,3,160,192,128,128,0,0,0,0
; ; ;   db 0,0,0,0,3,7,63,127,128,144,196,226,0,0,0,0
; ; ;   db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
; ; ;   db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
; ; ;   db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
; ; ;   db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0



; ; draw_pic:
; ;   mov ax, RED
; ;   call draw_channel
; ;   mov ax, GREEN
; ;   call draw_channel
; ;   mov ax, BLUE
; ;   call draw_channel
; ;   ret

; ; draw_channel:
; ;   mov es,ax
; ;   ; push di
; ;   xor di,di
; ;   xor cx,cx  
; ;   mov cl,bl        ; rows (bl)
; ; .rows push cx
; ;   xor cx,cx
; ;   mov cl,bh        ; cols (bh)
; ; .cols times 2 movsw
; ;   loop .cols
; ;   add di,COLS*4-4*4
; ;   pop cx
; ;   loop .rows
; ;   ; pop di
; ;   ret	


; ; img3: 
; ;   db 0,112,127,112,255,255,255,255,245,250,253,250,0,14,254,14
; ;   db 56,28,7,0,255,127,255,255,253,250,245,255,28,56,224,0
; ;   db 0,0,0,0,15,3,3,3,240,192,192,128,0,0,0,0
; ;   db 0,0,0,0,3,7,63,127,192,176,212,234,0,0,0,0
; ;   db 0,96,117,96,255,255,255,255,160,208,232,208,0,4,234,4
; ;   db 48,24,7,0,255,127,127,191,232,208,224,215,8,16,224,0
; ;   db 0,0,0,0,15,3,3,3,160,192,128,128,0,0,0,0
; ;   db 0,0,0,0,3,7,63,127,128,144,196,226,0,0,0,0
; ;   db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
; ;   db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
; ;   db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
; ;   db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0

; ; ; img4: 
; ; ;   db 0,112,127,112,255,255,255,255,245,250,253,250,0,14,254,14
; ; ;   db 56,28,7,0,255,127,255,255,253,250,245,255,28,56,224,0
; ; ;   db 0,0,0,0,15,3,3,3,240,192,192,128,0,0,0,0
; ; ;   db 0,0,0,0,3,7,63,127,192,176,212,234,0,0,0,0
; ; ;   db 0,96,117,96,255,255,255,255,160,208,232,208,0,4,234,4
; ; ;   db 48,24,7,0,255,127,127,191,232,208,224,215,8,16,224,0
; ; ;   db 0,0,0,0,15,3,3,3,160,192,128,128,0,0,0,0
; ; ;   db 0,0,0,0,3,7,63,127,128,144,196,226,0,0,0,0
; ; ;   db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
; ; ;   db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
; ; ;   db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
; ; ;   db 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0




