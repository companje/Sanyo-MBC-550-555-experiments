setup:
    mov bx,300
    mov dx,2000
    call play
    ; jmp setup
    hlt


play:                     ; bx=note, dx=duration (totale duur van de noot)
    ; Initialisatie fade-in
    mov si, 1             ; Begin met een zeer korte 'aan'-tijd (1 cyclus)
    mov bp, bx            ; Bewaar de oorspronkelijke BX (noot) voor de lus
    
    ; in al, 0x3a           ; Lees de huidige status van het USART control register
    ; mov bl, al            ; Sla de basiswaarde op in BL

    ; Bereken het startpunt van de fade-out
    ; Laten we zeggen dat de fade-out de laatste 10% van de duur moet zijn,
    ; of minimaal een bepaalde vaste duur (bijv. 500 'ticks').
    ; We kiezen hier voor een vaste 'fade_out_duration' van 500, maar je kunt dit aanpassen.
    mov cx, dx            ; CX = totale duur
    mov ax, 500           ; Bijvoorbeeld 500 'ticks' voor de fade-out
    cmp cx, ax            ; Is de totale duur korter dan de gewenste fade-out duur?
    jle .short_duration   ; Zo ja, dan wordt de fade-out duur gelijk aan de totale duur

    sub cx, ax            ; CX = totale duur - fade_out_duration (dit is de 'normale' speeltijd)
    mov word [fade_out_start_duration], cx ; Sla het startpunt van de fade-out op
    jmp .start_fade_in

.short_duration:
    mov word [fade_out_start_duration], 0 ; Geen normale speeltijd, direct naar fade-out
    
.start_fade_in:

; --- Fade-in gedeelte ---
.fade_loop:
    mov cx, bp            ; Reset note voor de frequentie (oorspronkelijke BX)

    ; 'Aan'-fase
    mov al, bl            ; Laad de basiswaarde van AL
    or al, 0x08           ; Zet de 'break' bit HOOG
    out 0x3a, al          ; Schrijf naar USART

    mov ax, si            ; Kopieer SI naar AX. Hierdoor komt SIL in AL.
    mov ah, al            ; Verplaats AL naar AH (AH wordt de teller)
                          
.a_on:
    dec ah
    jnz .a_on

    ; 'Uit'-fase
    mov al, bl            ; Laad de basiswaarde van AL
    and al, 0xF7          ; Zet de 'break' bit LAAG
    out 0x3a, al          ; Schrijf naar USART

    mov ax, bp            ; AX = BP
    sub ax, si            ; AX = BP - SI
    mov ah, al            ; Verplaats de lage byte van AX (AL) naar AH
.a_off:
    dec ah
    jnz .a_off

    dec dx                ; Verminder de totale duur
    jz .e                 ; Als duur 0 is, einde

    ; Controleer of we de fade-out start bereikt hebben
    cmp dx, word [fade_out_start_duration]
    jle .start_fade_out   ; Als dx <= fade_out_start_duration, begin fade-out

    ; Fade-in logic: verhoog SI geleidelijk
    inc si                ; Verhoog de 'aan'-tijd
    
    ; Stop de fade-in als SI de helft van BP bereikt (ongeveer 50% duty cycle)
    mov ax, bp
    shr ax, 1             ; AX = BP / 2 (voor 50% duty cycle)
    cmp si, ax            ; Vergelijk SI met de helft van BP
    jl .fade_loop         ; Als SI kleiner is dan de helft, ga door met fade-in

    ; Als fade-in compleet is, ga naar normale afspeelmodus
    ; Zet SI op de maximale duty cycle waarde (50% van BP)
    mov si, ax            ; SI = BP / 2 (max duty cycle)

; --- Normale afspeelmodus ---
.a_normal_play:
    mov cx, bp            ; Reset note voor de frequentie

    ; 'Aan'-fase
    mov al, 8        
    ; or al, 0x08           
    out 0x3a, al          

    mov ax, si            ; Gebruik de vaste 50% duty cycle
    mov ah, al            
.b_on_normal:
    dec ah
    jnz .b_on_normal

    ; 'Uit'-fase
    ; mov al, bl            
    ; and al, 0xF7   
    mov al,0       
    out 0x3a, al          

    mov ax, bp
    sub ax, si            
    mov ah, al            
.b_off_normal:
    dec ah
    jnz .b_off_normal

    dec dx                ; Verminder de totale duur
    jz .e                 ; Als duur 0 is, einde

    ; Controleer of we de fade-out start bereikt hebben
    cmp dx, word [fade_out_start_duration]
    jle .start_fade_out   ; Als dx <= fade_out_start_duration, begin fade-out

    jmp .a_normal_play    ; Ga door met normale weergave

; --- Fade-out gedeelte ---
.start_fade_out:
    ; SI heeft nu de max duty cycle waarde (BP/2).
    ; We gaan SI nu geleidelijk verlagen.
    
.fade_out_loop:
    mov cx, bp            ; Reset note voor de frequentie

    ; 'Aan'-fase
    ; mov al, bl            
    ; or al, 0x08  
    mov al,8         
    out 0x3a, al          

    mov ax, si            ; Gebruik de huidige (afnemende) duty cycle
    mov ah, al            
.c_on_fade_out:
    dec ah
    jnz .c_on_fade_out

    ; 'Uit'-fase
    ; mov al, bl            
    ; and al, 0xF7          
    mov al,0
    out 0x3a, al          

    mov ax, bp
    sub ax, si            
    mov ah, al            
.c_off_fade_out:
    dec ah
    jnz .c_off_fade_out

    dec dx                ; Verminder de totale duur
    jz .e                 ; Als duur 0 is, einde (nu is het echt afgelopen)

    ; Fade-out logic: verlaag SI geleidelijk
    dec si                ; Verlaag de 'aan'-tijd
    cmp si, 0             ; Is SI 0 of minder geworden?
    jg .fade_out_loop     ; Zo nee, ga door met fade-out

    ; Als SI 0 is, dan is het geluid helemaal uitgefaded.
    ; Verzeker dat de output stil is
    mov al, bl
    and al, 0xF7          ; Zorg dat de 'break' bit LAAG is
    out 0x3a, al

.e:
    ret

; Gegevenssectie (moet ergens in je .DATA of na je code, afhankelijk van je assembler)
; Declareer deze variabele buiten de functie, in het data segment.
; Bijvoorbeeld:
; .DATA
fade_out_start_duration dw 0



; play:              ; bx=note, dx=duration
;     mov cx,bx
; .a: xor al,8       ; toggle 'break' bit
;     out 0x3a,al    ; USART
; .b: dec ah
;     jnz .c
;     dec dx
;     jz .e
; .c: loop .b
; .d: mov cx,bx      ; reset note
;     jmp .a
; .e: ret
; play:                     ; bx=note, dx=duration
;     ; Nieuwe variabele voor fade-in duty cycle (bijvoorbeeld in SI)
;     mov si, 1             ; Begin met een zeer korte 'aan'-tijd (1 cyclus)
;     mov bp, bx            ; Bewaar de oorspronkelijke BX (noot) voor de lus
    
;     ; Bewaar de initiële waarde van AL. Cruciaal als andere bits van AL
;     ; belangrijk zijn voor de USART. We gebruiken BL om het op te slaan.
;     ; Als je weet dat AL altijd 0x00 is bij aanvang, kun je dit weglaten.
;     in al, 0x3a           ; Lees de huidige status van het USART control register
;     mov bl, al            ; Sla de basiswaarde op in BL

; .fade_loop:
;     mov cx, bp            ; Reset note voor de frequentie (oorspronkelijke BX)

;     ; Deel van de cyclus dat de 'break' bit hoog is (geluid aan)
;     mov al, bl            ; Laad de basiswaarde van AL
;     or al, 0x08           ; Zet de 'break' bit HOOG (bit 3)
;     out 0x3a, al          ; Schrijf naar USART

;     ; --- CORRECTIE START ---
;     mov ax,si
;     ; mov al, sil           ; Verplaats de lage byte van SI naar AL
;     mov ah, al            ; Verplaats AL naar AH (AH wordt de teller)
;     ; --- CORRECTIE EINDE ---
                          
; .a_on:
;     dec ah
;     jnz .a_on             ; Blijf hier zolang AH > 0

;     ; Deel van de cyclus dat de 'break' bit laag is (geluid uit)
;     mov al, bl            ; Laad de basiswaarde van AL
;     and al, 0xF7          ; Zet de 'break' bit LAAG (bit 3 op 0)
;     out 0x3a, al          ; Schrijf naar USART

;     ; Bereken de "uit" fase: totale periode (BP) min de "aan" fase (SI)
;     mov ax, bp            ; AX = BP
;     sub ax, si            ; AX = BP - SI (resultaat staat in AX)

;     ; --- CORRECTIE START ---
;     mov ah, al            ; Verplaats de lage byte van AX (AL) naar AH
;                           ; (AH wordt de teller voor de 'uit' fase)
;     ; --- CORRECTIE EINDE ---
; .a_off:
;     dec ah
;     jnz .a_off            ; Blijf hier zolang AH > 0

;     ; Nu de timing voor de totale duur (duration)
;     dec dx                ; Verminder de totale duur
;     jz .e                 ; Als duur 0 is, einde

;     ; Fade-in logic: verhoog SI geleidelijk
;     inc si                ; Verhoog de 'aan'-tijd
    
;     ; Stop de fade als SI de helft van BP bereikt (ongeveer 50% duty cycle)
;     ; of als SI gelijk is aan BP (100% duty cycle, maar dan is er geen "uit"-tijd meer)
;     mov ax, bp
;     shr ax, 1             ; AX = BP / 2 (voor 50% duty cycle)
;     cmp si, ax            ; Vergelijk SI met de helft van BP
;     jg .fade_finished     ; Als SI groter is dan de helft, is de fade klaar

;     jmp .fade_loop        ; Ga door met de volgende tooncyclus en verhoog SI

; .fade_finished:
;     ; Hier komen we als de fade-in voltooid is.
;     ; Nu spelen we de rest van de duur met de maximale duty cycle (50%)
;     mov cx, bp            ; Reset note voor de frequentie (BP is de nootwaarde)

;     ; Zet SI op de maximale duty cycle waarde (50% van BP)
;     mov ax, bp
;     shr ax, 1             ; AX = BP / 2
;     mov si, ax            ; Zet SI op de 50% duty cycle waarde

; .a_normal_play:
;     ; Deel van de cyclus dat de 'break' bit hoog is
;     mov al, bl            ; Laad de basiswaarde van AL
;     or al, 0x08           ; Zet de 'break' bit HOOG
;     out 0x3a, al          ; USART

;     ; --- CORRECTIE START ---
;     ; mov al, sil           ; Verplaats de lage byte van SI naar AL
;     mov ax,si
;     mov ah, al            ; Verplaats AL naar AH
;     ; --- CORRECTIE EINDE ---
; .b_on_normal:
;     dec ah
;     jnz .b_on_normal

;     ; Deel van de cyclus dat de 'break' bit laag is
;     mov al, bl            ; Laad de basiswaarde van AL
;     and al, 0xF7          ; Zet de 'break' bit LAAG
;     out 0x3a, al          ; USART

;     ; Bereken de "uit" fase voor normale weergave
;     mov ax, bp
;     sub ax, si            ; AX = BP - SI

;     ; --- CORRECTIE START ---
;     mov ah, al            ; Verplaats de lage byte van AX (AL) naar AH
;     ; --- CORRECTIE EINDE ---
; .b_off_normal:
;     dec ah
;     jnz .b_off_normal

;     dec dx                ; Verminder de totale duur
;     jz .e                 ; Als duur 0 is, einde

;     jmp .a_normal_play    ; Ga door met normale weergave

; .e:
;     ret


%assign num $-$$
%warning total num
times (180*1024)-num db 0
