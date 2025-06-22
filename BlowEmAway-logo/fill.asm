
fill_white:
  mov ax,0xffff
  call fill_red
  call fill_green
  call fill_blue
  ret

fill_pink:
  mov ax,0xffff
  call fill_red
  mov ah,0b01010101
  mov al,0b10101010
  call fill_green
  call fill_blue
  ret

fill_pink2:
  mov ax,0xffff
  call fill_red
  mov ah,0b11001100
  mov al,0b00110011
  call fill_green
  call fill_blue
  ret

fill_pink3:
  mov ah,0b1111111111111111
  call fill_red
  mov ah,0b0001000101000100
  call fill_green
  call fill_blue
  ret

fill_pink4:
  mov ax,0b1111111111111111
  call fill_red
  mov ax,0b1111011101111111
  call fill_green
  call fill_blue
  ret

fill_red:
  mov bx,RED
  call fill_channel
  ret
fill_green:
  mov bx,GREEN
  call fill_channel
  ret
fill_blue:
  mov bx,BLUE
  call fill_channel
  ret

fill_channel: ;ax=pattern
  mov es,bx
  mov cx,COLS*ROWS*2
  xor di,di
  rep stosw
  ret