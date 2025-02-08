%include "math.asm"

; ───────────────────────────────────────────────────────────────────────────

v_print: ; print ([bx+0],[bx+2] + "    ")
  push ax
  mov ax,[bx+0]
  print_ax
  print_char ","
  mov ax,[bx+2]
  print_ax
  print_2chars "  "
  print_2chars "  "
  pop ax
  ret

; ───────────────────────────────────────────────────────────────────────────

v_println:
  call v_print
  println " "
  ret

; ───────────────────────────────────────────────────────────────────────────


v_normalize: ; [bx]

  ; int mag = intSqrt(magSq(p));
  ; mem[p+0] = (mem[p+0] * 100) / mag;
  ; mem[p+1] = (mem[p+1] * 100) / mag;
  ret

; ───────────────────────────────────────────────────────────────────────────

v_from_angle_mag: ; input: ax=angle, cx=mag, output: bx=vector
  push dx
  call xy_from_angle ; ax = angle [any] -> ax,dx = x,y [-100..100]
  mov [bx+0],ax
  mov [bx+2],dx
  pop dx
  call v_mult  ;bx=vector, cx=scaler
  ret

; ───────────────────────────────────────────────────────────────────────────

v_clear: ; [bx]=0
  mov word [bx+0],0
  mov word [bx+2],0
  ret

; ───────────────────────────────────────────────────────────────────────────

v_if_zero: ; [bx]==0
  mov ax,[bx]
  add ax,[bx+2]
  or ax,ax
  ret

; ───────────────────────────────────────────────────────────────────────────

v_mult:  ; bx=vector, cx=scaler, output: bx=vector
  mov ax,[bx]   ; x
  cwd
  imul cx
  mov [bx],ax

  mov ax,[bx+2] ; y
  cwd
  imul cx
  mov [bx+2],ax
  ret

; ───────────────────────────────────────────────────────────────────────────

v_div:  ; bx=vector, cx=scaler
  mov ax,[bx]   ; x
  cwd
  idiv cx
  mov [bx],ax
  
  mov ax,[bx+2] ; y
  cwd
  idiv cx
  mov [bx+2],ax
  ret

; ───────────────────────────────────────────────────────────────────────────

v_scale:  ; bx=vector,  cx=scaler (x100), updates bx
  push ax
  mov ax, [bx]   ; x
  cwd
  imul cx
  push cx
  mov cx,100
  idiv cx
  pop cx
  mov [bx], ax

  mov ax, [bx+2]   ; y
  cwd
  imul cx
  push cx
  mov cx,100
  idiv cx
  pop cx
  mov [bx+2], ax
  pop ax
  ret

; ───────────────────────────────────────────────────────────────────────────

v_copy:    ; input bx=target,bp=source: copy vec bp into vec bx
  mov ax,[bp]
  mov [bx],ax
  mov ax,[bp+2]
  mov [bx+2],ax
  ret

; ───────────────────────────────────────────────────────────────────────────

v_set: ; [bx]=ax:dx
  mov [bx+0],ax
  mov [bx+2],dx
  ret

; ───────────────────────────────────────────────────────────────────────────

v_add: ; [bx]+=[bp]
  mov ax,[bx]
  add ax,[bp]     ; bx.x += bp.x
  mov [bx],ax
  mov ax,[bx+2]
  add ax,[bp+2]   ; bx.y += bp.y
  mov [bx+2],ax
  ret

; ───────────────────────────────────────────────────────────────────────────

v_sub: ; [bx]-=[bp]
  mov ax,[bx]
  sub ax,[bp]     ; bx.x -= bp.x
  mov [bx],ax
  mov ax,[bx+2]
  sub ax,[bp+2]   ; bx.y -= bp.y
  mov [bx+2],ax
  ret

; ───────────────────────────────────────────────────────────────────────────

v_heading: ; bx contains address of 4 bytes vector
  mov ax,[bx]
  mov bx,[bx+2]
  call atan2
  ret

; ───────────────────────────────────────────────────────────────────────────

v_limit: ; [bx] input vector, ax=max_length. destroys dx, updates [bx]      ; erg inefficient. zou moeten kunnen zonder loop
  push bx
  push bp
  mul ax  ; ax*=ax
  print "ax*ax="
  println_ax
  ; jz .done ; ax*ax==0 -> done

  xchg bp,ax
.lp:
  call v_mag_sq     ; ax = magSq([bx])

  ; or ax,ax   ; magSq([bx])==0 -> done  
  ; jz .done

  print "magSq="
  println_ax

  cmp ax,bp
  jle .done
  mov cx,95

  ; print_ax
  ; print " "

  call v_scale      ; bx=vector, cx=scaler (x100), updates bx
  jmp .lp
.done:
  pop bp
  pop bx
  ret

; ───────────────────────────────────────────────────────────────────────────

v_mag_sq:   ; ax=magSq([bx])
  push dx
  push cx
  mov ax,[bx]
  cwd
  imul ax   ; moet dit niet gewoon mul zijn ipv imul?
  mov cx,ax   ; use cx for tmp copy of x*x
  mov ax,[bx+2]
  cwd
  imul ax   ; moet dit niet gewoon mul zijn ipv imul?
  add ax,cx

  pop cx
  pop dx
  ret


v_mag_sq_scaled:   ; ax=magSq([bx])
push bx
push word [bx]
pop word [.tmp]
push word [bx+2]
pop word [.tmp+2]
  push dx
  push cx

mov cx,10
div [.tmp],cx


  mov ax,[tmp]
  cwd
  imul ax   ; moet dit niet gewoon mul zijn ipv imul?
  mov cx,ax   ; use cx for tmp copy of x*x
  mov ax,[tmp+2]
  cwd
  imul ax   ; moet dit niet gewoon mul zijn ipv imul?
  add ax,cx

  pop cx
  pop dx

pop bx
  ret
.tmp: dw 0,0


; v_mag_sq32:   ; ax:dx = magSq([bx])
;   push bp
;   push cx
;   mov ax, [bx]      ; Laad X in AX
;   mul ax            ; AX * AX -> resultaat in DX:AX
;   mov cx, ax        ; Bewaar laag deel (X²) in CX
;   mov bp, dx        ; Bewaar hoog deel (X²) in BP(!) (voor overloop)
;   mov ax, [bx+2]    ; Laad Y in AX
;   mul ax            ; AX * AX -> resultaat in DX:AX
;   add cx, ax        ; Voeg laag deel (Y²) toe aan CX
;   adc bp, dx        ; Voeg hoog deel (Y²) toe aan BP(!) met carry
;   mov ax, cx        ; Laag deel terugzetten in AX
;   mov dx, bp        ; Hoog deel terugzetten in DX
;   pop cx
;   pop bp
;   ret


; ───────────────────────────────────────────────────────────────────────────

; v_mag:   ; ax=sqrt(magSq([bx]))
;   call v_mag_sq32
;   call sqrt32
;   ret
  
; ───────────────────────────────────────────────────────────────────────────



