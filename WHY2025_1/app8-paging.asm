setup:
  mov di,0
  mov ax,0xc000
  mov es,ax
  mov cx,14400/2
  mov ax,0x5555
  rep stosw

  mov ax,0x0800
  mov es,ax
  mov cx,14400/2
  mov ax,0x5555
  rep stosw

draw:
  out 10h,al
  inc al
  and al,7
  mov cx,10000
  .1: loop .1
  jmp draw

%assign num $-$$
%warning total num
times (180*1024)-num db 0



