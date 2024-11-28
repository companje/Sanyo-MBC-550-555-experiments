org 0x38
cpu 8086

RED   equ 0xf000
GREEN equ 0x1c00
BLUE  equ 0xf400
CLEAR equ 0x0000
FILL  equ 0xffff

jmp setup
db 'Sanyo1.2',2,0,1,0,0,2,112,0,0,0,2,0,253,2,0,9,0,2,0

setup:
  mov al,5
  out 0x10,al 
  mov bx,CLEAR
  mov ax,GREEN
  call colorFill

_1E4A:
  mov al,0xD8           
  out 8,al           ; floppy command: 0b11011000 (0xD8)
  mov al,0x98           
  out 0x1E,al           ; PPI control: 0b10011000 (0x98) 'strobe' / disk select?

_1E52:
  in al,8            ; floppy status
  test al,1
  jnz _1E52            ; loop until bit 1 is high

_1E58:
  mov al,8
  out 8,al           ; floppy command 0b00001000
  aam                   ; wait
  aam                   ; wait
  aam                   ; wait
  aam                   ; wait

_1E64:
  in al,8            ; floppy status dx=8
  test al,1
  jnz _1E64            ; wait until bit 1 is high
  test al,0x80
  jnz _1E58            ; wait until bit 7 is high

_1E6E:
  cld                   ; clear direction flag
  mov al,1
  out 0x0C,al           ; floppy set sector bit 1
  mov ax,0xf000 ; RED video segment
  mov es,ax             ; segment for data from floppy
  mov dx,8           ; used to read floppy status
  ; mov si,0x1EA0         ; used for local jmp later on
  mov di,0
  mov bh,0
  mov ah,0
  mov al,0
  out 8,al           ; floppy
  aam
  aam
  aam
  aam


_1E91:
  in al,dx              ; floppy status dx=8
  sar al,1
  jnb _1EB2            ; floppy
  jnz _1E91            ; floppy


_1E98:
  in al,dx              ; floppy dx=8
  and al,bh             ; bit 2 (?)
  jz _1E98

_1E9D:
  in al,0x0E            ; read data from floppy
  stosb                 ; store in es:di++    
  ; jmp exit

_1EA0:
  in al,dx              ; floppy dx=8
  dec ax
  cmp al,bh             ; bh = 2 ?
  jnz _1EB2

_1EA8:
  in al,0x0E            ; read data from floppy
  stosb                 ; store in es:di++
  in al,dx
  cmp al,bh
  jz _1EA8

_1EB0:
  ; jmp si                ; jump to 0x1EA0
  jmp _1EA0

_1EB2:
  in al,dx              ; floppy status dx=8
  test al,0x1C           
  jnz _1E52            ; floppy status

_1EBC:
  jmp exit

 
colorFill:
  mov es,ax             ; input ax=segment for color channel
  mov ax,bx             ; input bx=fill or clear
  xor di,di
  mov cx,0x2000
  rep stosw
  ret

exit:
  mov bx,CLEAR
  mov ax,BLUE
  call colorFill
  mov bx,FILL
  mov ax,GREEN
  call colorFill
  mov bx,CLEAR
  mov ax,RED
  call colorFill
  hlt

%assign num $-$$
times 368640-num db  0