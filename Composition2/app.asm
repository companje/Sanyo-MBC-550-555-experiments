%include "sanyo.asm"

PULSE_WIDTH equ 1 ; play duration per bit
SAMPLE_RATE equ 8000
NUM_BEATS equ 16
BITS_PER_BEAT equ SAMPLE_RATE / NUM_BEATS   ; how many bits to read from the sample per beat
SONG_LEN equ NUM_BEATS * BITS_PER_BEAT

CH_1 equ music+0*SONG_LEN    ; binary sample data per channel is stored separately 
CH_2 equ music+1*SONG_LEN    ; and mixed together in play function.
CH_3 equ music+2*SONG_LEN
CH_4 equ music+3*SONG_LEN

%macro measure_beat_sample 3
  dw (%1-1)*4+(%2-1), %3
%endmacro

%macro end_channel 0
  dw 0,0
%endmacro

channel1:
  dw 0,strings
  dw 4,strings
  dw 8,strings
  dw 12,strings
  ; dw 0,choirF5,1,choirF5,2,choirF5,3,choirF5
  ; dw 4,choirC5,5,choirC5,6,choirC5,7,choirC5
  ; dw 8,choirEs5,9,choirEs5,10,choirEs5,11,choirEs5
  ; dw 12,choirA5,13,choirA5,14,choirA5,15,choirA5
end_channel

channel2:
  dw 0,beat
  ; dw 1,beat
  dw 2,beat
  ; dw 3,beat
  dw 4,beat
  ; dw 5,beat
  dw 6,beat
  dw 7,beat
  dw 8,beat
  ; dw 9,beat
  dw 10,beat
  ; dw 11,beat
  dw 12,beat
  ; dw 13,beat
  dw 14,beat
  dw 15,beat
end_channel

channel3:
  ; measure_beat_sample 1,1,hymn_bass_intro
  ; measure_beat_sample 2,1,hymn_bass_intro
  ; measure_beat_sample 3,1,hymn_bass_intro
 
end_channel

channel4:
  measure_beat_sample 1,1,hymn_voice_intro
  
end_channel

setup:
  mov si,channel1
  mov bx,CH_1
  call load_channel

  mov si,channel2
  mov bx,CH_2
  call load_channel

  mov si,channel3
  mov bx,CH_3
  call load_channel

  mov si,channel4
  mov bx,CH_4
  call load_channel

update:
  mov si,music
  mov cx,SONG_LEN  ; num bytes to play
  call play
  hlt


load_channel: ; convert notes data to bit wave
  lodsw
  mov cx,BITS_PER_BEAT
  mul cx
  add ax,bx     ; bx bevat de dst offset (bijv CH_1 of CH_2)
  mov di,ax

  ;load sample address and check for 0. if 0 return.
  lodsw
  or ax,ax
  jz .r

  push si
  mov si,ax
  mov ax,ds
  mov es,ax
  lodsw      ; load length of sample
  mov cx,ax
  rep movsb  ; load sample to es:di (song+360*beat_offset)
  pop si

  jmp load_channel
.r ret


TDM: db 0

play:
  xor bp,bp
.nextbyte:
  ; push ax


 

  ; eerste aanpak: CH_1 en CH_2 optellen met OR
  ; mov al,[CH_1+bp]
  ; mov dl,[CH_2+bp]
  ; or al,dl            ; for each bit in the byte: 00=0, 01=1, 10=1, 11=1
  ; pop bx

  ; nu wissel ik per byte van kanaal maar het moet denk ik per bit.
  ; push bx
  ; mov ax,SONG_LEN
  ; mul byte [TDM]
  ; add ax,music
  ; add ax,bp
  ; mov bx,ax
  ; mov al,[bx]
  ; pop bx





  ; mov dl,[CH_3+bp]
  ; or al,dl
  ; mov dl,[CH_4+bp]
  ; or al,dl

  mov bl,8
  mov bh,1
.nextbit:

  push bx
  mov ax,SONG_LEN
  mov bx,[TDM]
  xor bh,bh
  mul bx

  add ax,music
  add ax,bp
  mov bx,ax
  mov ah,[bx]
  pop bx

.tdm_counter:
  inc byte [TDM]
  and byte [TDM], 3


  ; push ax
  ; mov ah,al
  mov al,0
  and ah,bh
  jz .sendbit
  mov al,8
.sendbit:
  out 0x3A,al




; .tdm:
;   dec byte [TDM]
;   jns .end_tdm
;   mov byte [TDM],4
; .end_tdm:


;   push cx
;   mov cx,PULSE_WIDTH
; .wait: loop .wait
;   pop cx


  ; pop ax
  shl bh,1
  dec bl
  jnz .nextbit

  inc bp
  loop .nextbyte
  ret


; vocals: incbin "bin/vocals.bin"

choirF5: incbin "bin/b37-choir-F5.bin" ; threshold=.06
choirC5: incbin "bin/b37-choir-C5.bin" ; threshold=.06
choirEs5: incbin "bin/b37-choir-Es5.bin" ; threshold=.06
choirA5: incbin "bin/b37-choir-A5.bin" ; threshold=.06

; ; tone: incbin "bin/1khz.bin"
; ; tick: incbin "bin/tick.bin"
; pluck: incbin "bin/pluck.bin"

; sound:  


; tone: incbin "bin/1khz.bin"
; drum: incbin "bin/risset.bin"

bass: incbin "bin/falle-bass.bin"
; falle_vocals: incbin "bin/falle-vocals.bin"
; falle_clap: incbin "bin/falle-clap.bin"
beat: incbin "bin/beat2.bin"

hymn_voice_intro: incbin "bin/hymn_voice_intro.bin"
hymn_bass_intro: incbin "bin/hymn_bass_intro.bin"

bm_chord_square: incbin "bin/bm_chord_square2.bin"

strings: incbin "bin/strings-b-1-sq.bin"

; strings1: incbin "bin/strings1.bin"
; strings2: incbin "bin/strings2.bin"
; strings3: incbin "bin/strings3.bin"
; strings4: incbin "bin/strings4.bin"
; strings_end: incbin "bin/strings-end.bin"
; amenbreak: incbin "bin/amen-break.bin"      ; threshold=.09 
; hihat: incbin "bin/hi-hat.bin"                ; threshold=.01 
; bassdrum: incbin "bin/base-drum.bin"
; blakhole: incbin "bin/s1-001-blakhole.bin"
; bassline: incbin "bin/bass-line.bin"         ; threshold=.1 ? 
; choir: incbin "bin/b37-choir.bin"            ; threshold=.06
; choir2: incbin "bin/b37-choir-2.bin"
; choir3: incbin "bin/b37-choir-3.bin"
; bells: incbin "bin/bells.bin"
; bells2: incbin "bin/bells2.bin"
; bells3: incbin "bin/bells3.bin"
; effect: incbin "bin/s1-006-effect.bin"
; intro1: incbin "bin/intro1.bin"
; vocals: incbin "bin/vocals.bin"

music:








; %include "sanyo.asm"

; xx: dw 2

; setup:
;   mov cx,500
;   mov ax,GREEN
;   mov es,ax

;   ; mov ax,-1
;   ; .lp
;   mov di,10*4*COLS ; + 10*COLS 
;   ; times 2 stosw
;   ; loop .lp

;   mov si,sound
;   mov cx,-1       ; number of bytes to read

; play:


;   lodsb               ; laad byte in AL
  
;   ; push ax
;   ; push bx
;   ; mov bx,colors
;   ; mov ax,[bx+xx]
;   ; mov es,ax
;   ; pop bx
;   ; pop ax

;   stosb


;   mov bl,8            ; 8 bits
;   mov bh,1            ; bitmask = bit 0
; .nextbit:
;   push ax
;   mov ah,al
;   mov al,0
;   test ah,bh
;   jz .sendbit
;   mov al,8            
; .sendbit:
;   out 0x3A,al         ; bit 3 (byte value 8 or 0) = break bit on keyboard
  
;   push cx
;   mov cx,20           ; pulse width
; .wait: loop .wait
;   pop cx
;   ; times 10 nop

  
;   push ax
; ; push ax
;   mov al,13
;   out 48,al
;   ; pop ax
;   ; mov ax,bx
;   ; xchg ah,al
;   ; out 50,al
;   ; ; push ax
;   ; mov al,13
;   ; out 48,al
;   ; ; pop ax

;   ; mov ax,cx
;   ; xor ah,ah
;   ; push bx
;   ; mov bx,sinlut
;   ; xlat
;   ; pop bx
;   mov ax,[xx]

;   ; mov ax,bx
;   out 50,al
;   pop ax


;   pop ax
;   shl bh,1
;   dec bl


  

;   jnz .nextbit

;   test cx,16
;   jz .cont

;   ; push ax
;   ; mov ax,BLUE
;   ; mov es,ax
;   ; pop ax
;   ; mov [xx],si
;   ; push cx
;   ; mov cl,1
;   ; shl word [xx],1
;   inc word [xx]
;   ; pop cx

;   and word [xx],4

; .cont
;   loop play
;   hlt



; sinlut: db 0,25,50,70,86,96,100,96,86,70,50,25,0,-25,-50,-70,-86,-96,-100,-96,-86,-70,-50,-25,0
; colors: dw RED,GREEN,BLUE


; sound: 
; ; %include "bin/wonderful-days-1.inc"
; ; incbin "bin/wdays-vocals.bin"
; incbin "bin/8088mph4-8k.bin"
; ; incbin "bin/beat2.bin"

; ; sound: incbin "bin/falle-vocals.bin"
; ; sound: incbin "bin/reverb-pitch.bin" ; vocals
; ; ; sound: incbin "bin/falle-bass2.bin"
; ; ; sound: incbin "bin/falle-other.bin"



times (180*1024)-($-$$) db 0


