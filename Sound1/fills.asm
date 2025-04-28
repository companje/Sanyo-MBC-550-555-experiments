; fill_16:
  
;   db 

fill_red:
  mov ax,-1
  call fill_red_channel
  mov ax,0
  call fill_green_channel
  call fill_blue_channel
  ret

fill_blue:
  mov ax,0
  call fill_red_channel
  call fill_green_channel
  mov ax,-1
  call fill_blue_channel
  ret

fill_green:
  mov ax,0
  call fill_red_channel
  call fill_blue_channel
  mov ax,-1
  call fill_green_channel
  ret

fill_white:
  mov ax,-1
  call fill_red_channel
  call fill_green_channel
  call fill_blue_channel
  ret

fill_pink:
  mov ax,0xffff
  call fill_red_channel
  mov ah,0b01010101
  mov al,0b10101010
  call fill_green_channel
  call fill_blue_channel
  ret

fill_pink2:
  mov ax,0xffff
  call fill_red_channel
  mov ah,0b11001100
  mov al,0b00110011
  call fill_green_channel
  call fill_blue_channel
  ret

fill_pink3:
  mov ax,0xffff
  call fill_red_channel
  mov ah,0b00010001
  mov al,0b01000100
  call fill_green_channel
  call fill_blue_channel
  ret

fill_pink4:
  mov ax,0xffff
  call fill_red_channel
  mov ah,0b11110111
  mov al,0b01111111
  call fill_green_channel
  call fill_blue_channel
  ret

fill_dark_blue:
  mov ax,0
  call fill_red_channel
  mov ah,0b01010101
  mov al,0b10101010
  call fill_blue_channel
  mov ax,0
  call fill_green_channel
  ret

fill_dark_red:
  mov ax,0
  call fill_blue_channel
  call fill_green_channel
  mov ah,0b01010101
  mov al,0b10101010
  call fill_red_channel
  ret

fill_red_channel:
  mov bx,RED
  call fill_channel
  ret
fill_green_channel:
  mov bx,GREEN
  call fill_channel
  ret
fill_blue_channel:
  mov bx,BLUE
  call fill_channel
  ret

fill_channel: ;ax=pattern, bx=channel
  mov es,bx
  mov cx,COLS*ROWS*2
  xor di,di
  rep stosw
  ret

; fill_rect: ;ax=pattern, bx=channel, di=start_index, dx=w[0..72],h[0..50] ????
  

