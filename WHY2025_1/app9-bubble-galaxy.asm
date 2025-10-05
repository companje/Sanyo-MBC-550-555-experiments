%include "sanyo.asm" 

CENTER EQU 25*288+144
N EQU 10
M EQU 50

K equ 41
u: db 0
v: db 0
iBytes: db 0


setup:
  push cs
  pop ds
  mov ax,GREEN
  mov es,ax
  
draw:
  call clear_history
  ; mov ax,RED
  ; call clear
  ; mov ax,BLUE
  ; call clear
  ; mov ax,GREEN
  ; call clear

  inc bp
  and bp,255

  call iterate
  jmp draw

clear:
  mov es,ax
  xor di,di
  xor ax,ax
  mov cx,14400/2
  rep stosw
  ret

iterate:
  mov cx,N
.while_n:
  push cx
  mov ax,cx

  mov cl,K
  mul cl
  mov [iBytes],al
  mov cx,M
.while_m:
  push cx

  call calc_bl_bh
  call calc_di_dl_for_pixel

  call add_to_history

  or [es:di + CENTER],dl  ; set pixel
  pop cx
  loop .while_m
  pop cx
  loop .while_n
  ret

calc_bl_bh:
;0
  mov al,[iBytes]
  add [v],al
  mov ax,bp
  add [u],al

;1
  mov al,[u]
  call sin
  cbw        ; ax=al
  mov bx,ax

;2
  mov al,[v]
  call sin
  cbw        ; ax=al
  add ax,bx

push ax

;3
  mov al,[u]
  call cos
  cbw        ; ax=al
  mov bx,ax

;4
  mov al,[v]
  call cos
  cbw        ; ax=al
  add ax,bx

;5
  xor dx,dx
  mov cl,127
  mov bx,K
  imul bx
  idiv cl
  mov [v],al

;6
  pop ax
  xor dx,dx
  imul bx
  idiv cl
  mov [u],al

;7
  mov bl,[u]
  mov bh,[v]

  ret



clear_history:
  sub si,2
  mov di,[si]
  mov word [es:di + CENTER],0
  cmp si,indexes_ptr
  ja clear_history
  ret

add_to_history:
  test [es:di + CENTER],dl
  jnz .r
  mov word [si],di
  add si,2
.r: ret



; dot:
;   call calc_di_dl_for_pixel
;   or [es:di + CENTER],dl  ; set pixel
;   ret

; in : BL = x (signed 8-bit), BH = y (signed 8-bit)
; out: DI = (y\4)*(4*COLS) + (y%4) + ((2x)\8)*4   (relatief t.o.v. CENTER)
;      DL = 2^(7 - ((2x) % 8))
; preserves: CX
; trashes  : AX, DX, SI

calc_di_dl_for_pixel:
  push si
  push  cx

  ; ----- y uit BH: qy=floor(y/4), ry=y&3
  mov   al, bh
  cbw
  mov   si, ax              ; SI = y
  mov   di, ax
  and   di, 3               ; DI = ry
  mov   ax, si
  sar   ax, 1
  sar   ax, 1               ; AX = qy
  mov   si, ax              ; SI = qy

  ; DI += qy*(4*COLS) = qy*288 = (qy<<5) + (qy<<8)
  mov   ax, si
  mov   cl, 5
  shl   ax, cl
  add   di, ax
  mov   ax, si
  mov   cl, 8
  shl   ax, cl
  add   di, ax

  ; ----- x uit BL met aspectratio: x' = 2*x
  mov   al, bl
  cbw                        ; AX = x (signed)
  mov   si, ax               ; SI = x

  ; qx2 = floor(x'/8) = floor((2*x)/8) = floor(x/4)
  sar   ax, 1
  sar   ax, 1                ; AX = qx2

  ; rx2 = x' - qx2*8
  mov   dx, si
  shl   dx, 1                ; DX = x' = 2*x
  mov   cx, ax
  shl   cx, 1
  shl   cx, 1
  shl   cx, 1                ; CX = qx2*8
  sub   dx, cx               ; DX = rx2 (0..7)
  mov   cl, dl               ; CL = rx2
  and   cl, 7

  ; DL = bitmask 1<<(7-rx2)
  mov   dl, 128
  shr   dl, cl

  ; DI += (qx2*4)
  shl   ax, 1
  shl   ax, 1                ; AX = qx2*4
  add   di, ax

  pop   cx
  pop si
  ret

; in:  AL = hoek 0..255
; uit: AL = sin(hoek) in bereik -128..127 (feitelijk -126..126 op basis van tabel)
; gebruikt: CL, DL, BL, BX

cos:
    add  al,64
sin:
    push cx
    push bx
    mov  cl,al  ; deze ontbrak.......
    mov  al,255
    sub  al,cl   ; 0..255 ipv 255..0
    mov  dl,al          ; dl = hoek
    mov  cl,6
    shr  dl,cl          ; q = hoek>>6 (0..3)
    and  al,63          ; i = hoek & 63 (0..63 binnen kwart)
    test dl,1           ; odd quadrants (1 of 3)?
    jz   .no_reflect
    mov  bl,63
    sub  bl,al          ; i = 63 - i
    mov  al,bl
.no_reflect:
    mov  bx, qsin
    xlat                 ; al = amplitude (0..~126)
    test dl,2           ; kwadranten 2 en 3 -> negatief
    jz   .done
    neg  al
.done:
    pop  bx
    pop  cx
    ret

qsin: db 0,3,6,9,12,15,18,21,24,27,30,33,36,39,42,45,48,51,54,57,59,62,65,67,70,73,75,78,80,82,85,87,89,91,94,96,98,100,102,103,105,107,108,110,112,113,114,116,117,118,119,120,121,122,123,123,124,125,125,126,126,126,126,126



indexes_ptr: ; ...

%assign num $-$$
%warning total num
times (180*1024)-num db 0