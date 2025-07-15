ticks EQU 16000 

G3  equ 0xFD  ; = 196Hz
C4  equ 0xBE  ; = 262Hz
E4  equ 0x96  ; = 330Hz
B3  equ 0xC9  ; = 247Hz
D4  equ 0xA8  ; = 294Hz
A3  equ 0xE1  ; = 220Hz
F4  equ 0x8E  ; = 349Hz
G4  equ 0x7E  ; = 393Hz
Gs4 equ 0x77  ; = 416Hz
A4  equ 0x70  ; = 442Hz
As4 equ 0x6A  ; = 466Hz
B4  equ 0x64  ; = 494Hz
; -----
C5  equ 0x5e  ; = 527Hz
D5  equ 0x54  ; = 588Hz
Ds5 equ 0x4F  ; = 625Hz
E5  equ 0x4B  ; = 658Hz
F5  equ 0x47  ; = 695Hz
Fs5 equ 0x43  ; = 736Hz
G5  equ 0x3F  ; = 782Hz 
Gs5 equ 0x3B  ; 
A5  equ 0x37  ; = 881Hz
B5  equ 0x34  ; = ????
; ----
C6  equ 0x2F  ; = ???

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


times 50 db 0     ; dit is nodig omdat de interrupt table overlapt met deze code.
                  ; eigenlijk zou de code moeten beginnen op 0040:0000 ipv 0038:0000

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


onTimer0:
  mov bx,bp
  and bx,63
  
  cmp bp,63
  ja .pattern3

  cmp bp,31
  ja .pattern2

.pattern1:

  ; cmp bp,48
  ; ja .pattern1b
  mov dx,20
  call play_chord
  jmp .c

; .pattern1b:  ; hier de snaredrum
;   mov dx,3
;   mov bx,C4
;   mov dx,3
;   mov bx,B5
;   call play_chord
;   jmp .c

.pattern2:
  mov dx,10
  call play_chord
  mov dx,3
  call beat
  ; mov dx,3
  ; call play_chord
  jmp .c

.pattern3:
  mov dx,3
  call beat
  mov dx,5
  call play_chord
  mov dx,13
  call play_melody

  ; mov dx,10
  ; call play_melody

.c:


  ; mov dx,12
  ; call beat
  ; mov dx,5
  ; call play_chord
  ; mov dx,5
  ; call play_melody

  ; mov dx,10
  ; call play_melody


  inc bp
  iret


beat:
  push bx

  mov ax,bx
  xor ah,ah
  mov cl,16
  div cl
  mov [tel],ah
  mov [maat],al


  mov bx,1000 ; wel geluid
  test byte [tel],1   ; elke hele tel
  jz .drr
  cmp byte [tel],15   ; plus de laatste tel extra 5-6-7-8'en-1-2-3-4
  je .drr
  xor bx,bx   ; geen geluid, wel constante tijd

.drr:
  push bp
  push bx
  mov dx,25
  call play
  pop bx
  pop bp
.dr:

  pop bx
  ret

play_chord:
  push bp
  push bx
  mov bl,[bx+chords]
  call play
  pop bx
  pop bp
  ret

play_melody:
  push bp
  push bx
  mov bl,[bx+melody]
  call play
  pop bx
  pop bp
  ret


maat: db 0
tel: db 0

chords:
db F4,As4,D5,As4
db F4,As4,D5,As4
db F4,A4,C5,A4
db F4,A4,C5,A4
db G4,C5,Ds5,C5
db G4,C5,Ds5,C5
db G4,As4,D5,As4
db G4,As4,D5,As4

db F4,As4,D5,As4
db F4,As4,D5,As4
db F4,A4,C5,A4
db F4,A4,C5,A4
db G4,C5,Ds5,C5
db G4,C5,Ds5,C5
db G4,As4,D5,As4
db G4,As4,D5,As4

melody:
db D5,F5,0,D5,F5,0,D5,0
db C5,F5,0,C5,F5,0,0,0
db Ds5,G5,0,Ds5,G5,0,Ds5,0
db D5,G5,0,D5,G5,0,0,0
db D5,F5,0,D5,F5,0,D5,0
db C5,F5,0,F5,F5,0,0,0
db Ds5,Ds5,Ds5,Ds5,0,0
db D5,C5,C5,As4,As4,As4
db 0,0,0,0,0

; drums:
; db G3

; play_fade:                     ; bx=note, dx=duration (totale duur van de noot)
;     ; Initialisatie fade-in
;     mov si, 1             ; Begin met een zeer korte 'aan'-tijd (1 cyclus)
;     mov bp, bx            ; Bewaar de oorspronkelijke BX (noot) voor de lus
    
;     in al, 0x3a           ; Lees de huidige status van het USART control register
;     mov bl, al            ; Sla de basiswaarde op in BL

;     ; Bereken het startpunt van de fade-out
;     ; Laten we zeggen dat de fade-out de laatste 10% van de duur moet zijn,
;     ; of minimaal een bepaalde vaste duur (bijv. 500 'ticks').
;     ; We kiezen hier voor een vaste 'fade_out_duration' van 500, maar je kunt dit aanpassen.
;     mov cx, dx            ; CX = totale duur
;     mov ax, 500           ; Bijvoorbeeld 500 'ticks' voor de fade-out
;     cmp cx, ax            ; Is de totale duur korter dan de gewenste fade-out duur?
;     jle .short_duration   ; Zo ja, dan wordt de fade-out duur gelijk aan de totale duur

;     sub cx, ax            ; CX = totale duur - fade_out_duration (dit is de 'normale' speeltijd)
;     mov word [fade_out_start_duration], cx ; Sla het startpunt van de fade-out op
;     jmp .start_fade_in

; .short_duration:
;     mov word [fade_out_start_duration], 0 ; Geen normale speeltijd, direct naar fade-out
    
; .start_fade_in:

; ; --- Fade-in gedeelte ---
; .fade_loop:
;     mov cx, bp            ; Reset note voor de frequentie (oorspronkelijke BX)

;     ; 'Aan'-fase
;     mov al, bl            ; Laad de basiswaarde van AL
;     or al, 0x08           ; Zet de 'break' bit HOOG
;     out 0x3a, al          ; Schrijf naar USART

;     mov ax, si            ; Kopieer SI naar AX. Hierdoor komt SIL in AL.
;     mov ah, al            ; Verplaats AL naar AH (AH wordt de teller)
                          
; .a_on:
;     dec ah
;     jnz .a_on

;     ; 'Uit'-fase
;     mov al, bl            ; Laad de basiswaarde van AL
;     and al, 0xF7          ; Zet de 'break' bit LAAG
;     out 0x3a, al          ; Schrijf naar USART

;     mov ax, bp            ; AX = BP
;     sub ax, si            ; AX = BP - SI
;     mov ah, al            ; Verplaats de lage byte van AX (AL) naar AH
; .a_off:
;     dec ah
;     jnz .a_off

;     dec dx                ; Verminder de totale duur
;     jz .e                 ; Als duur 0 is, einde

;     ; Controleer of we de fade-out start bereikt hebben
;     cmp dx, word [fade_out_start_duration]
;     jle .start_fade_out   ; Als dx <= fade_out_start_duration, begin fade-out

;     ; Fade-in logic: verhoog SI geleidelijk
;     inc si                ; Verhoog de 'aan'-tijd
    
;     ; Stop de fade-in als SI de helft van BP bereikt (ongeveer 50% duty cycle)
;     mov ax, bp
;     shr ax, 1             ; AX = BP / 2 (voor 50% duty cycle)
;     cmp si, ax            ; Vergelijk SI met de helft van BP
;     jl .fade_loop         ; Als SI kleiner is dan de helft, ga door met fade-in

;     ; Als fade-in compleet is, ga naar normale afspeelmodus
;     ; Zet SI op de maximale duty cycle waarde (50% van BP)
;     mov si, ax            ; SI = BP / 2 (max duty cycle)

; ; --- Normale afspeelmodus ---
; .a_normal_play:
;     mov cx, bp            ; Reset note voor de frequentie

;     ; 'Aan'-fase
;     mov al, bl            
;     or al, 0x08           
;     out 0x3a, al          

;     mov ax, si            ; Gebruik de vaste 50% duty cycle
;     mov ah, al            
; .b_on_normal:
;     dec ah
;     jnz .b_on_normal

;     ; 'Uit'-fase
;     mov al, bl            
;     and al, 0xF7          
;     out 0x3a, al          

;     mov ax, bp
;     sub ax, si            
;     mov ah, al            
; .b_off_normal:
;     dec ah
;     jnz .b_off_normal

;     dec dx                ; Verminder de totale duur
;     jz .e                 ; Als duur 0 is, einde

;     ; Controleer of we de fade-out start bereikt hebben
;     cmp dx, word [fade_out_start_duration]
;     jle .start_fade_out   ; Als dx <= fade_out_start_duration, begin fade-out

;     jmp .a_normal_play    ; Ga door met normale weergave

; ; --- Fade-out gedeelte ---
; .start_fade_out:
;     ; SI heeft nu de max duty cycle waarde (BP/2).
;     ; We gaan SI nu geleidelijk verlagen.
    
; .fade_out_loop:
;     mov cx, bp            ; Reset note voor de frequentie

;     ; 'Aan'-fase
;     mov al, bl            
;     or al, 0x08           
;     out 0x3a, al          

;     mov ax, si            ; Gebruik de huidige (afnemende) duty cycle
;     mov ah, al            
; .c_on_fade_out:
;     dec ah
;     jnz .c_on_fade_out

;     ; 'Uit'-fase
;     mov al, bl            
;     and al, 0xF7          
;     out 0x3a, al          

;     mov ax, bp
;     sub ax, si            
;     mov ah, al            
; .c_off_fade_out:
;     dec ah
;     jnz .c_off_fade_out

;     dec dx                ; Verminder de totale duur
;     jz .e                 ; Als duur 0 is, einde (nu is het echt afgelopen)

;     ; Fade-out logic: verlaag SI geleidelijk
;     dec si                ; Verlaag de 'aan'-tijd
;     cmp si, 0             ; Is SI 0 of minder geworden?
;     jg .fade_out_loop     ; Zo nee, ga door met fade-out

;     ; Als SI 0 is, dan is het geluid helemaal uitgefaded.
;     ; Verzeker dat de output stil is
;     mov al, bl
;     and al, 0xF7          ; Zorg dat de 'break' bit LAAG is
;     out 0x3a, al

; .e:
;     ret

; ; Gegevenssectie (moet ergens in je .DATA of na je code, afhankelijk van je assembler)
; ; Declareer deze variabele buiten de functie, in het data segment.
; ; Bijvoorbeeld:
; ; .DATA
; fade_out_start_duration dw 0


%assign num $-$$
%warning total num
times (180*1024)-num db 0
