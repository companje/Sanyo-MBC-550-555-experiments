; sqrt: ; ax should be unsigned 16 bit number
;   mov [.input],ax
;   mov [.end],ax

; .do:
;   ; int mid = start + (end - start) / 2;
;   ; int midmid = mid*mid;

;   mov ax,[.end]
;   sub ax,[.start]
;   shr ax,1
;   add ax,[.start]
;   mov [.mid],ax

;   println_ax

;   mul ax    ; AX=midmid DX:AX

;   println_ax

;   cmp ax,[.input]
;   je .found   ; break

;   jb .store_closest         ; unsigned <

;   ;else:  (end=mid-1)
;   mov ax,[.mid]
;   dec ax
;   mov [.end],ax
;   jmp .endif

; .store_closest:
;   println "store_closest"
;   mov ax,[.mid]
;   inc ax
;   mov [.result],ax

; .endif:

;   ; } while (start<=end)
;   mov ax,[.start]
;   cmp ax,[.end]
;   jbe .do  ; while

; .found:
;   mov ax,[.mid]
;   ; mov ax,[.result]
;   ret

;   .mid: dw 0
;   .midmid: dd 0 ; 32 bit
;   .start: dw 0
;   .end: dw 0
;   .input: dw 0
;   .result: dw 0


; sqrt:
;   push si
;   push bx
;   push cx
;   push dx
;   mov bx, 0           ; Start of range
;   mov cx, ax          ; End of range
;   xor dx, dx          ; Result placeholder
;   mov [.number], ax    ; Save the input number

; .lp1:
;   mov dx, bx          ; Calculate mid-point: DX = (BX + CX) / 2
;   add dx, cx
;   shr dx, 1
  
;   mov si, dx          ; SI = mid-point
;   mov ax, si
;   mul si              ; DX:AX = SI * SI
  
;   cmp dx, 0           ; Check if result overflows 16 bits
;   jne .too_large       ; If overflow, mid^2 is too large
  
;   cmp ax, word [.number] ; Compare mid^2 with the input number
;   je .done             ; If exact match, we're done
  
;   jl .update_low       ; If mid^2 < number, adjust lower bound
;   mov cx, si          ; Else, adjust upper bound
;   dec cx              ; CX = SI - 1
;   cmp bx, cx          ; Check if range has collapsed
;   jg .done
;   jmp .lp1

; .update_low:
;   mov bx, si          ; BX = SI
;   inc bx              ; BX = SI + 1
;   cmp bx, cx          ; Check if range has collapsed
;   jg .done
;   jmp .lp1

; .too_large:
;   mov cx, si          ; If overflow, adjust upper bound
;   dec cx
;   cmp bx, cx
;   jg .done
;   jmp .lp1

; .done:
;   mov ax, si          ; Result is in SI
;   pop dx
;   pop cx
;   pop bx
;   pop si
;   ret

; .number: dw 0          ; Placeholder for input number




; sqrt:
;   push si
;   push bx
;   push cx
;   push dx
;   mov bx, 0           ; Start of range
;   mov cx, ax          ; End of range
;   xor dx, dx          ; Result placeholder
;   mov [.number], ax

; .lp1:
;   mov dx, bx          ; Store current mid in DX
;   add dx, cx          ; DX = (BX + CX)
;   shr dx, 1           ; DX = (BX + CX) / 2, mid-point
  
;   mov si, dx          ; Save mid-point in SI
;   mov ax, si
;   mul si              ; DX:AX = SI * SI
;   cmp dx, 0           ; Check for overflow
;   jne .overflow       ; Exit if overflow occurs
  
;   cmp ax, word [.number] ; Compare mid^2 with the number
;   je .done             ; If exact match, we're done
  
;   jl .update_low       ; If mid^2 < number, adjust lower bound
;   mov cx, si          ; Else, adjust upper bound
;   dec cx              ; CX = SI - 1
;   cmp bx, cx          ; Check if range has collapsed
;   jg .done
;   jmp .lp1

; .update_low:
;   mov bx, si          ; BX = SI
;   inc bx              ; BX = SI + 1
;   cmp bx, cx          ; Check if range has collapsed
;   jg .done
;   jmp .lp1

; .overflow:
;   mov si, -1          ; Indicate overflow with -1

; .done:
;   mov ax, si          ; Result is in SI
;   pop dx
;   pop cx
;   pop bx
;   pop si
;   ret

; .number: dw 0         ; Placeholder for input number



rnd:
  push bx
  push cx
  push dx
  mov cx, 16
.lp
  mov ax,[.seed]
  xor dx, dx           ; DX wordt gebruikt om het nieuwe bit te berekenen
  mov bx, ax           ; Kopieer de huidige waarde van AX naar BX
  ; shr bx, 0            ; Feedback van het laagste bit (bit 0)
  xor dl, bl           ; Voeg de laagste bit aan DX toe

  shr bx, 1            ; Feedback bit 1
  xor dl, bl

  push cx
  mov cl,4
  shr bx, cl           ; Feedback bit 4
  xor dl, bl

  mov cl,15 
  shr bx, cl           ; Feedback bit 15
  xor dl, bl

  shl ax, 1            ; Verschuif de registerwaarde in AX
  or ax, dx            ; Voeg de berekende bit toe

  pop cx
  loop .lp        ; Herhaal totdat CX 0 is

  mov [.seed],ax
  pop dx
  pop cx
  pop bx
  ret
  .seed dw 0B400h


sin: ; ax in degrees
  push cx
  mov cx,100
  cbw
  imul cx
  add ax,45
  mov cx,9
  cbw
  idiv cx
  pop cx

  ///////////RET ????

cos: ; ax in degrees
  push cx;
  mov cx,ax
  mov ax,90
  sub ax,cx
  mov cx,100
  cbw
  imul cx
  add ax,45
  mov cx,9
  cbw
  idiv cx
  pop cx

  ///////////RET ????

atan2: ; input bx=y, ax=x
  cmp ax,0
  jnz .x_not_0
  cmp bx,0
  jl .y_lte_0
  mov ax,90
  jmp .ret

.y_lte_0:
  mov ax,-90
  jmp .ret

.x_not_0:
  push ax
  push ax   ; keep a copy of x
  mov ax,bx
  mov cx,111
  cwd       ; dx=0
  imul cx
  pop cx;   ; restore x



  ; mov word [debug.ax], ax
  ; mov word [debug.bx], bx
  ; mov word [debug.cx], cx
  ; mov word [debug.dx], dx

;   set_cursor 10,1
;   print "AX="
;   call write_number_word
;   print "   "

; ; 13441

;   call new_line  
;   print "CX="
;   mov ax,cx
;   call write_number_word
;   print "   "

  ; cmp cx,0
  ; je .error_x_0
  cwd

  idiv cx   ; ax/=x
  cwd
  call atan
  pop cx;   ; restore x
  cmp cx,0
  jl .x_lt_0
  jmp .ret

.x_lt_0:
  cmp bx,0
  jge .y_gte_0
  sub ax,180
  jmp .ret

.y_gte_0:
  add ax,180
  jmp .ret

.ret:
  cmp ax,0
  jl .add360
  ret
.add360:
  add ax,360
  ret
.error_x_0
  set_cursor 1,1
  print "Division Error in atan2: x=0"
  hlt

; ───────────────────────────────────────────────────────────────────────────

atan: ; cx=z, return value in ax, bx destroyed, cx destroyed, dx destroyed
  mov cx,ax           ; z
  cwd
  cmp cx,111
  jg .z_gt_scale      ; if (z>111)
  cmp cx,-111         ; if (z<-111) 
  jl .z_lt_minus_scale
  cwd
  imul ax             ; ax *= ax  (z*z)
  mov bx,333     
  idiv bx             ; ax /= 333   Taylor-benadering
  cwd
  mov bx,ax
  mov ax,111
  sub ax,bx           ; ax-=111  
  mov bx,180
  imul bx             ; ax*=180 
  imul cx             ; ax*=z
  mov bx,111
  idiv bx             ; ax/=111
  mov bx,314
  cwd
  idiv bx             ; ax/=314
  cwd
  ret

.z_gt_scale:
  mov ax,12321        ; 12321 = 111*111 (squared scale)
  idiv cx             ; ax/=z
  call atan           ; recursion
  mov bx,ax
  mov ax,90
  sub ax,bx
  ret

.z_lt_minus_scale:
  mov ax,12321        ; 12321 = 111*111 (squared scale)
  idiv cx             ; ax/=z
  call atan           ; recursion
  mov bx,ax
  mov ax,-90
  sub ax,bx
  ret

%macro _atan2 2
  mov ax,%1
  mov bx,%2
  call __atan2
%endmacro

__atan2:
  push ax
  push bx
  print "atan2(x="
  call write_signed_number_word
  print ",y="
  pop ax
  push bx
  call write_signed_number_word
  print ")="
  pop bx
  pop ax
  call atan2
  call write_signed_number_word
  mov al,' '
  call write_char
  call new_line
  ret


