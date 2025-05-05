%include "sanyo.asm"

BEAT_LEN equ 360
SONG_LEN equ 16*BEAT_LEN

song:
dw 0,choirF5,1,choirF5,2,choirF5,3,choirF5
dw 4,choirC5,5,choirC5,6,choirC5,7,choirC5
dw 8,choirEs5,9,choirEs5,10,choirEs5,11,choirEs5
dw 12,choirA5,13,choirA5,14,choirA5,15,choirA5

dw 0,0

load_song:
  lodsw
  mov cx,BEAT_LEN
  mul cx
  add ax,sound
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

  jmp load_song
.r ret

setup:
  xor di,di
  xor bx,bx
  mov si,song
  call load_song

.repeat:
  mov dx,20 ; length per bit (20=default)
  mov si,sound
  mov cx,SONG_LEN; ; 0xffff ; num bytes to play
  call play
  jmp .repeat



play:
  lodsb
  mov bl,8
  mov bh,1
.nextbit:
  push ax
  mov ah,al
  mov al,0
  and ah,bh
  jz .sendbit
  mov al,8
.sendbit:
  out 0x3A,al
  push cx
  mov cx,dx
.wait: loop .wait
  pop cx
  pop ax
  shl bh,1
  dec bl
  jnz .nextbit
  loop play
  ret



choirF5: incbin "bin/b37-choir-F5.bin" ; threshold=.06
choirC5: incbin "bin/b37-choir-C5.bin" ; threshold=.06
choirEs5: incbin "bin/b37-choir-Es5.bin" ; threshold=.06
choirA5: incbin "bin/b37-choir-A5.bin" ; threshold=.06


sound:



; tone: incbin "bin/1khz.bin"
; drum: incbin "bin/risset.bin"
; incbin "bin/b37-choir-F5.bin" ; threshold=.06
; incbin "bin/b37-choir-F5.bin" ; threshold=.06
; incbin "bin/b37-choir-F5.bin" ; threshold=.06

; incbin "bin/b37-choir-C5.bin" ; threshold=.06
; incbin "bin/b37-choir-C5.bin" ; threshold=.06
; incbin "bin/b37-choir-C5.bin" ; threshold=.06
; incbin "bin/b37-choir-C5.bin" ; threshold=.06


; incbin "bin/b37-choir-F5.bin" ; threshold=.06
; incbin "bin/b37-choir-F5.bin" ; threshold=.06
; incbin "bin/b37-choir-F5.bin" ; threshold=.06

; incbin "bin/b37-choir-C5.bin" ; threshold=.06
; incbin "bin/b37-choir-C5.bin" ; threshold=.06
; incbin "bin/b37-choir-C5.bin" ; threshold=.06
; incbin "bin/b37-choir-C5.bin" ; threshold=.06

; incbin "bin/b37-choir-E5s.bin" ; threshold=.06
; incbin "bin/b37-choir-E5s.bin" ; threshold=.06
; incbin "bin/b37-choir-E5s.bin" ; threshold=.06
; incbin "bin/b37-choir-E5s.bin" ; threshold=.06

; incbin "bin/b37-choir-A5.bin" ; threshold=.06
; incbin "bin/b37-choir-A5.bin" ; threshold=.06
; incbin "bin/b37-choir-A5.bin" ; threshold=.06
; incbin "bin/b37-choir-A5.bin" ; threshold=.06

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
endsound:

times (180*1024)-($-$$) db 0



