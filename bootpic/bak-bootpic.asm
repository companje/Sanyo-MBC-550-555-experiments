org 0
cpu 8086
; CPU 186

RED   equ 0xf000
GREEN equ 0x0c00
BLUE  equ 0xf400
COLS  equ 72

FONT equ 0xFF00
; FONT_BASE equ 0x1000   ; Startadres van de font-tabel in ROM
; CHAR_SIZE equ 8        ; Aantal bytes per karakter in de font-tabel
; ROW_OFFSET equ 4*COLS-4  ; Offset naar de volgende rij voor de onderste helft van een karakter

LINES_PER_ROW equ 4
COLS_PER_ROW equ 72

jmp setup

db 'Sanyo1.2',2,0,1,0,0,2,112,0,0,0,2,0,253,2,0,9,0,2,0

row: db 0
col: db 0

setup:
  call blue_bg
  hlt

  
  ; call rom_to_vram

  ; hlt
  
  ; mov bh,10
  ; mov bl,30
  ; call draw_char_at
  ; call calculate_di

  ; mov ax,GREEN           ; Laad het videosegment in ES
  ; mov es,ax 

  ; mov di,0
  ; mov cx,0x1000
  ; mov al,255
  ; rep stosb

;   mov ax,GREEN           ; Laad het videosegment in ES
;   mov es,ax
;   mov ax,1
;   mov cx,4
;   mul cx 
;   mov di,ax


;   mov cx,128
; print_loop:
;   mov al,cl
;   call draw_char
;   loop print_loop

;   ; mov al,66
;   ; call draw_char

; draw:
;   hlt

; draw_string:

; draw_char:   ; al=char
;   push cx
;   mov cx,FONT
;   mov ds,cx
;   xor ah,ah
;   mov cx,8
;   mul cx
;   xchg si,ax
;   shr cx,1     ; = mov cx,4 want cx was hiervoor 8
;   push cx
;   rep movsb
;   add di,4*COLS-4
;   pop cx
;   rep movsb
;   sub di, 4*COLS
;   pop cx
;   ret

; ; calculate_di:
;     ; Bereken BH * LINES_PER_ROW * COLS_PER_ROW
;     ; mov al, bh               ; Zet de waarde van BH in AL
;     ; cbw                      ; Zet AL naar AX (breid uit met tekenextensie)
;     ; mov cx, LINES_PER_ROW    ; Zet LINES_PER_ROW in CX
;     ; imul cx                  ; AX = BH * LINES_PER_ROW

;     ; mov cx, COLS_PER_ROW     ; Zet COLS_PER_ROW in CX
;     ; imul cx                  ; AX = AX * COLS_PER_ROW
;     ; mov di, ax               ; Zet het resultaat in DI

;     ; ; Bereken BL * COLS_PER_ROW en tel het op bij DI
;     ; mov al, bl               ; Zet kolomwaarde (BL) in AL
;     ; cbw                      ; Zet AL naar AX (tekenextensie)
;     ; imul cx                  ; AX = BL * COLS_PER_ROW
;     ; add di, ax               ; DI = DI + AX (het uiteindelijke offset)

;     ; mov ax,RED
;     ; mov es,ax
;     ; ret                      ; Keer terug, DI bevat nu het berekende adres

; ; set_pos:
; ;   mov ax, 0xFE00           ; Laad het segmentadres van de ROM in DS
; ;   mov ds, ax               ; DS = ROM-segment
; ;   mov ax, 0x0C00           ; Laad het videosegment in ES
; ;   mov es, ax               ; ES = video-segment
; ;   mov di, 0                ; Zet DI op het startadres in videogeheugen


; ; draw_char_at:
; ;   mov ax, 0xFF00       ; Laad het segmentadres van de ROM in DS
; ;   mov ds, ax           ; DS = ROM-segment
; ;   mov ax, 0x0C00       ; Laad het videosegment in ES
; ;   mov es, ax           ; ES = video-segment
; ;   mov si, 0       ; Offset voor karakter 0x01 in de font-tabel (0x01 * 8 bytes = 0x08)
  
; ;   ; add si, ax


; ;   mov di, 0             ; Zet DI op het startadres in videogeheugen voor de bovenste helft
; ;   mov cx, 4            ; Aantal bytes voor de bovenste helft
; ;   rep movsb            ; Kopieer de eerste 4 bytes van DS:SI naar ES:DI
; ;   add di, 4*COLS-4         ; Zet DI naar de positie voor de onderste helft (4 rijen verder)
; ;   mov cx, 4            ; Aantal bytes voor de onderste helft
; ;   rep movsb            ; Kopieer de volgende 4 bytes van DS:SI naar ES:DI
; ;   ret

; blue_bg:
;   mov ax,BLUE
;   push ax
;   pop es
;   mov di,0
;   mov cx,0x4000
;   mov al,255
;   rep stosb
;   ret

; rom_to_vram:
;   mov ax, 0xFE00
;   mov ds, ax       ; DS source segment
;   mov ax, 0x0C00
;   mov es, ax       ; ES dest segment
;   mov si, 0x1000   ; FONT offset in ROM
;   mov di, 0        ; dest index
;   mov cx, 0x4000   ; 8000 bytes (0x4000 in hexadecimal)
;   rep movsb        ; Kopieer CX bytes van DS:SI naar ES:DI
;   ret

; img: 
;   incbin "zwembad.pic"

%assign num $-$$

times 368640-num db  0