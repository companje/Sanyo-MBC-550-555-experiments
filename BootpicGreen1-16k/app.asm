%include "sanyo.asm"
; RED   equ 0xf000
; GREEN equ 0x1c00
; BLUE  equ 0xf400
; COLS  equ 80
; ROWS  equ 50

setup:
  ; mov al, 5
  ; out 10h, al           ; select address 0x1c000 as green video page
  
 
  push cs
  pop ds

  mov ax,GREEN
  mov es,ax

draw:
  mov si,img1
  call draw_frame

  mov si,img2
  call draw_frame

  mov si,img3
  call draw_frame
  
  ; mov si,img4
  ; call draw_frame

  ; mov si,img5
  ; call draw_frame

  ; mov si,img6
  ; call draw_frame

  ; mov si,img7
  ; call draw_frame

  ; mov si,img8
  ; call draw_frame

  ; mov si,img9
  ; call draw_frame

  ; mov si,img10
  ; call draw_frame
  
  ; mov si,img9
  ; call draw_frame

  ; mov si,img8
  ; call draw_frame

  ; mov si,img7
  ; call draw_frame

  ; mov si,img6
  ; call draw_frame

  ; mov si,img5
  ; call draw_frame
  
  ; mov si,img4
  ; call draw_frame

  ; mov si,img3
  ; call draw_frame

  mov si,img2
  call draw_frame

  jmp draw

  hlt

draw_frame:
  xor di,di
  mov cx,8000
  rep movsw
  ret

img1: incbin "frame1.bin"
img2: incbin "frame2.bin"
img3: incbin "frame3.bin"
img4: incbin "frame4.bin"
img5: incbin "frame5.bin"
img6: incbin "frame6.bin"
img7: incbin "frame7.bin"
img8: incbin "frame8.bin"
img9: incbin "frame9.bin"
img10: incbin "frame10.bin"

times (180*1024)-($-$$) db 0



