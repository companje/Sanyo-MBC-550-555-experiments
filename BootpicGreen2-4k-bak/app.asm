%include "sanyo.asm"

setup:
  push cs
  pop ds

  mov si,img1+4000
  mov bp,4000
  mov ax,GREEN
  mov es,ax

draw:
  push si
  call draw_frame
  pop si
  add si,bp

  cmp si,8000
  jbe .n
  cmp si,13*4000
  jb draw
.n:
  neg bp

  
  jmp draw

  hlt

draw_frame:
  xor di,di
  mov cx,2000
  xor bh,bh
.lp:
  lodsw ; al 0..31
  ; shl ax,1
  ; shl ax,1
  ; shl ax,1
  ; shl ax,1
  ; shl ax,1

  mov bl,al
  push si
  lea si,[bx+pal]
  movsw
  movsw
  mov bl,ah
  lea si,[bx+pal]
  movsw
  movsw
  pop si
  loop .lp
  ret

pal: incbin "data/vertical-gradient-256x8-hcenter.bin"


img1: incbin "data/frame1.bin"  ; 4k per frame, 1 byte per cell value 0..31
img2: incbin "data/frame2.bin"
img3: incbin "data/frame3.bin"
img4: incbin "data/frame4.bin"
img5: incbin "data/frame5.bin"
img6: incbin "data/frame6.bin"
img7: incbin "data/frame7.bin"
img8: incbin "data/frame8.bin"
img9: incbin "data/frame9.bin"
img10: incbin "data/frame10.bin"
img11: incbin "data/frame11.bin"
img12: incbin "data/frame12.bin"
img13: incbin "data/frame13.bin"
img14: incbin "data/frame14.bin"


times (180*1024)-($-$$) db 0



