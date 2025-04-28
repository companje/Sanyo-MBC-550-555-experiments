%include "sanyo.asm"
%include "fills.asm"

FRAME_DELAY EQU 2000

play:             ; bx=note, dx=duration
   push ax
   push bx
   push cx
   push dx
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
.d xor al,8       ; toggle 'control' bit
   cmp al,0x35    ; 'break' now on?
   jnz .e         ; jump if not
   out 0x3A,al    ; reset USART
.e pop dx
   pop cx
   pop bx
   pop ax
   ret


;;;;;;;;;;;;;;;;;;;
;;
;; ipv toon + duration  ->  sample (meerdere tonen+duration) + speed
;; 
;;

SND EQU RED
LEN EQU 1500

clear:
  mov ax,SND
  mov es,ax
  mov cx,LEN
  mov ax,0
  rep stosw
  ret

setup:
  call clear

  ; mov ax,0xFF00 ; font
  ; mov ax,0x38 ; ROM BIOS
  ; mov ax,0x0 ; 

  mov ax,SND ; free space
  mov ds,ax
  mov si,0
  mov cx,LEN

.lp
  mov byte bl,[ds:si+1]      ; tone
  mov byte dl,[ds:si+0]      ; duration
  add si,2

  or dl,1 ; prevent 0 duration
  and dl,31 ; limit duration to 7

  ; and bl,31

  xor bh,bh
  xor dh,dh
  call play

  xor di,di
  mov ax,si
  
  ; de print functie kost tijd waardoor de toonhoogte veranderd.
  ; 1 extra teken op het scherm zorgt al voor een andere toon.
  ; ik ga nu verder in een ander experiment om de play functie op
  ; constante snelheid te laten lopen ongeacht welke toonhoogte of duration

  call print_debug



  loop .lp

  println "done"

  hlt

print_debug:
  print "DS:SI="
  println_ds_si
  print "BX="
  println_bx
  print "DX="
  println_dx
  ret

  ; mov ax,BLUE
  ; call fill

  ; call fill_pink
  ; set_pos 1,1
  ; set_size 10,10
  ; call fill_pink
  ; call _wait
  ; call fill_pink2
  ; call _wait
  ; call fill_pink3
  ; call _wait
  ; call fill_pink4
  ; call _wait
  ; call fill_pink3
  ; call _wait
  ; call fill_pink2
  ; call _wait
  ; jmp setup

  hlt

  ; mov cx,0
  ; div cx
  ; call intF8
  
  ; mov di,0f8h*4-4
  ; register_interrupt intF8

 ; init other hardware
  ; mov al,0
  ; out 0x3a,al           ; keyboard \force state/
  ; out 0x3a,al           ; keyboard \force state/
  ; mov al,0xFF
  ; out 0x3a,al           ; keyboard \reset/
  ; out 0x3a,al           ; keyboard \mode/
  ; mov al,0x37
  ; out 0x3a,al           ; keyboard \set command

  ; mov ax,0
  ; mov es,ax
  ; cli                             ; interrupts tijdelijk uitschakelen
  ; ; mov word [es:4*0F8h+0], intF8      ; offset
  ; ; mov word [es:4*0F8h+2], 0x38        ; segment
  ; sti                             ; interrupts weer inschakelen

 
  ; ; ICW1
  ; mov al,0x00
  ; out 0x13,al

  ; ; ICW2
  ; mov al,0x02
  ; out 0xf8,al

  ; ; ICW4
  ; mov al,0x02
  ; out 0x0f,al

  ; ; mask
  ; mov al,0x02
  ; out 0x96,al


  ;channel 0 (clock)
  ; mov al,0x34
  ; out 0x26,al
  ; mov al,0xbf
  ; out 0x20,al
  ; mov al,0x21
  ; out 0x20,al

  ; ;channel 1 (2nd stage clock)   
  ; mov al,0x74
  ; out 0x26,al
  ; mov al,0x00
  ; out 0x22,al
  ; mov al,0x00
  ; out 0x22,al

  ; ;channel 2 (add-in serial rate)
  ; mov al,0xb6
  ; out 0x26,al
  ; mov al,0x5d
  ; out 0x24,al
  ; mov al,0x00
  ; out 0x24,al



  ; jmp draw

; intF8:
;   cld
;   mov ax,RED
;   mov es,ax
;   xor di,di
;   mov cx,7200
;   mov ax,-1
;   rep stosw

;   ; print "x"
;   hlt
;   iret

draw:
  call check_keys
  jnz on_key
  jmp draw

on_key:
  ; println_ax
  cmp ax,','
  je on_key_comma
  cmp ax,'.'
  je on_key_period
  
.done
  jmp draw  ; no ret here because onkey is called by jnz

on_key_comma:
  println ","
  mov dx,10
  mov ax,10
  mov bp,1
  mov cx,10
  call play_effect

  jmp on_key.done

on_key_period:
  println "."
  jmp on_key.done


play_effect:
  mov bx,bp
  mov bx,[sound+bx]
  sub bx,ax   ; ax = note offset for tone height
  call play
  inc bp
  inc bp
  loop play_effect
  ret

sound: incbin "/Users/rick/Documents/Processing/DrawSound/waveform.dat"

times (180*1024)-($-$$) db 0



