BITS 16

ORG 100h

push 0a000h           ;Video memory graphics segment
pop es

mov ax, 0013h         ;320x200@8bpp
int 10h

mov cx,1
circles:
push cx

push 4              ;color

mov ax,cx
times 4 shl ax,1      ; mul 16
add ax,50

; mov ax,150

push ax                ;cX
; push 100               ; cX
push 99               ;cY
; push 2             ;radius
; shr cx,1
push cx                ; Radius

call drawFilledCircle
pop cx

inc cx
cmp cx,16
jl circles

;Wait for a key
xor ah, ah
int 16h

;Restore text mode
mov ax, 0003h
int 10h

;Return
mov ax, 4c00h
int 21h


;Color
;cX
;cY
;R
drawFilledCircle:
 push bp
 mov bp, sp

 sub sp, 02h

 mov cx, WORD [bp+04h]   ;R

 

 mov ax, cx              
 mul ax                  ;AX = R^2
 mov WORD [bp-02h], ax   ;[bp-02h] = R^2



 mov ax, WORD [bp+06h]
 sub ax, cx              ;i = cY-R
 mov bx, WORD [bp+08h]
 sub bx, cx              ;j = cX-R

 shl cx, 1
 mov dx, cx              ;DX = Copy of 2R

.advance_v:
 push cx
 push bx

 mov cx,  dx

.advance_h:
  ;Save values
  push bx
  push ax
  push dx

  ;Compute (i-y) and (j-x)
  sub ax, WORD [bp+06h]
  sub bx, WORD [bp+08h]

  mul ax                  ;Compute (i-y)^2

  push ax
  mov ax, bx             
  mul ax
  pop bx                  ;Compute (j-x)^2 in ax, (i-y)^2 is in bx now

  add ax, bx              ;(j-x)^2 + (i-y)^2
  cmp ax, WORD [bp-02h]   ;;(j-x)^2 + (i-y)^2 <= R^2

  ;Restore values before jump
  pop dx
  pop ax
  pop bx

  ja .continue            ;Skip pixel if (j-x)^2 + (i-y)^2 > R^2

  ;Write pixel
  push WORD [bp+0ah]
  push bx
  push ax
  call writePx


.continue:

  ;Advance j
  inc bx
 loop .advance_h

 ;Advance i
 inc ax


 pop bx            ;Restore j
 pop cx            ;Restore counter

loop .advance_v

 add sp, 02h


 pop bp
 ret 08h



;Color
;X
;Y
writePx:
 push bp
 mov bp, sp

 push ax
 push bx

 mov bx, WORD [bp+04h]
 mov ax, bx
 shl bx, 6
 shl ax, 8
 add bx, ax       ;320 = 256 + 64

 add bx, WORD [bp+06h]
 mov ax, WORD [bp+08h]

 ;TODO: Clip

 mov BYTE [es:bx], al

 pop bx
 pop ax

 pop bp
 ret 06h