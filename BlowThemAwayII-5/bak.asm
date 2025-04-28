
; sqrt32:
;     PUSH CX
;     PUSH DX
;     PUSH BX
;     PUSH SI
;     PUSH DI

;     XOR CX, CX         ; CX wordt gebruikt als res (bovenste 16 bits)
;     XOR DI, DI         ; DI wordt gebruikt als res (onderste 16 bits)

;     MOV BX, 4000H      ; BX bevat hoogste 16 bits van (1 << 30)
;     XOR SI, SI         ; SI = onderste 16 bits van bit (start op 0)

;     ; Zoek de hoogste macht van vier ≤ x
; CHECK_BIT:
;     CMP BX, DX         ; Vergelijk BX met hoogste deel van DX:AX
;     JA  SHIFT_DOWN     ; Als BX > DX, moet bit verder verschoven worden
;     JB  START_CALC     ; BX is kleiner dan DX, dus we stoppen

;     CMP SI, AX         ; Vergelijk onderste 16 bits van bit met AX
;     JBE START_CALC     ; Bit is geschikt, start berekening

; SHIFT_DOWN:
;     SHR BX ,1            ; Verplaats hoogste 16 bits van bit >> 1
;     RCR SI, 1          ; Verschuif onderste 16 bits met carry
;     SHR BX ,1            ; Nogmaals bit >> 1
;     RCR SI, 1          ; Nogmaals onderste 16 bits met carry
;     JNZ CHECK_BIT      ; Ga door totdat we de juiste bitwaarde hebben

; START_CALC:
;     ; Iteratieve berekening van de vierkantswortel
; SQRT_LOOP:
;     TEST BX, BX
;     JZ DONE            ; Stop als bit 0 is

;     MOV DX, CX         ; DX = res (bovenste 16 bits)
;     MOV AX, DI         ; AX = res (onderste 16 bits)
;     ADD AX, BX         ; res + bit (onderste 16 bits)
;     ADC DX, SI         ; Voeg bovenste 16 bits toe

;     ; Vergelijk DX:AX met originele DX:AX
;     CMP DX, DX
;     JB NEXT_SHIFT      ; Als (res+bit) > (DX:AX), overslaan
;     JA SKIP_SUB        ; Ga naar aftrekken als DX gelijk is
;     CMP AX, AX
;     JB NEXT_SHIFT      ; Als (res+bit) > (DX:AX), overslaan

; SKIP_SUB:
;     SUB AX, DI         ; x -= (res + bit)
;     SBB DX, CX         ; Verwerk borrow
;     SHR CX  ,1           ; res >>= 1
;     RCR DI, 1          ; Laagste 16 bits verplaatsen
;     ADD DI, BX         ; res += bit
;     ADC CX, SI         ; Verwerk carry
;     JMP SHIFT_NEXT

; NEXT_SHIFT:
;     SHR CX ,1            ; res >>= 1
;     RCR DI, 1          ; Laagste 16 bits verplaatsen

; SHIFT_NEXT:
;     SHR BX ,1            ; bit >>= 1
;     RCR SI, 1          ; Laagste 16 bits verplaatsen
;     SHR BX ,1          ; bit >>= 1
;     RCR SI, 1          ; Laagste 16 bits verplaatsen
;     JMP SQRT_LOOP

; DONE:
;     MOV AX, DI         ; Zet onderste 16 bits van resultaat in AX

;     POP DI
;     POP SI
;     POP BX
;     POP DX
;     POP CX
;     RET




; sqrt16:              ; input: AX, output sqrt(AX)
;   push bx
;   push cx
;   push dx
;   mov cx, 0          ; cx = res (resultaat)
;   mov bx, 0x4000     ; startbit instellen (1 << 30 in 16-bits versie)
; .find_start:         ; zoek de hoogste macht van 4 ≤ ax
;   cmp bx, ax
;   jbe .lp
;   shr bx, 1
;   shr bx, 1
;   jnz .find_start
; .lp:
;   mov dx, cx        ; dx = res (huidige resultaat)
;   add dx, bx        ; dx = res + bit
;   cmp ax, dx
;   jb .sub_done      ; als (ax < res + bit), sla overslaan
;   sub ax, dx        ; ax -= res + bit
;   shr cx, 1         ; cx = res >> 1
;   add cx, bx        ; cx = (res >> 1) + bit
;   jmp .next
; .sub_done:
;   shr cx, 1         ; cx = res >> 1
; .next:
;   shr bx, 1
;   shr bx, 1         ; bit >>= 2
;   jnz .lp           ; herhaal zolang bx ≠ 0
;   mov ax, cx        ; opslaan van de vierkantswortel in ax
;   pop dx
;   pop cx
;   pop bx
;   ret




; sqrt32:              ; input: DX:AX, output AX=sqrt(DX:AX)
;   push bx
;   push cx
;   push dx
;   push si
;   xor cx, cx        ; cx = res (resultaat)
;   mov bx, 0x4000    ; startbit instellen (1 << 30)
; .find_start:        ; zoek de hoogste macht van 4 ≤ DX:AX
;   cmp dx, bx
;   ja .lp
;   jb .shift_down
;   cmp ax, 0
;   jae .lp
; .shift_down:
;   shr bx, 1
;   shr bx, 1
;   jnz .find_start
; .lp:
;   mov si, cx        ; si = res (huidige resultaat)
;   add si, bx        ; si = res + bit
;   mov dx, si
;   shl dx, 1
;   cmp dx, dx        ; vergelijk dubbele waarde
;   ja .sub_done
;   sub dx, si        ; DX:AX -= (res + bit)
;   sbb ax, dx
;   shr cx, 1         ; cx = res >> 1
;   add cx, bx        ; cx = (res >> 1) + bit
;   jmp .next
; .sub_done:
;   shr cx, 1         ; cx = res >> 1
; .next:
;   shr bx, 1
;   shr bx, 1         ; bit >>= 2
;   jnz .lp           ; herhaal zolang bx ≠ 0
;   mov ax, cx        ; opslaan van de vierkantswortel in ax
;   pop si
;   pop dx
;   pop cx
;   pop bx
;   ret





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





; v_from_angle: ; input: ax=angle, bx=mag, output: ax=x, bx=y
;   mov cx,360
;   add ax,cx
;   cwd         ; dx=0
;   idiv cx
;   xchg ax,dx  ; ax now contains angle wrapped to 360
;   mov cx,90
;   cwd         ; dx=0
;   idiv cx      ; dx now contains angle%90 (angle within quadrant)
;   push ax     ; save quadrant 0,1,2,3 on the stack
;   mov ax,dx   ; ax now contains angle within quadrant
;   push dx     ; save copy of the angle within quadrant for later use
;   call sin
;   cwd         ; dx=0
;   imul bx      ; ax = sin(ax)*mag
;   mov cx,bx   ; cx = mag
;   mov bx,ax   ; save ax into bx
;   pop ax      ; restore angle within quadrant
;   call cos
;   cwd         ; dx=0
;   imul cx      ; ax*=mag
;   mov dx,ax   ; dx = cos()*mag
;   pop cx      ; cx = quadrant 
;   cmp cx,0
;   je .q0
;   cmp cx,1
;   je .q1
;   cmp cx,2
;   je .q2
; .q3: ;else
;   mov ax,bx
;   mov bx,dx
;   neg bx 
;   ret
; .q2:
;   mov ax,dx
;   neg ax
;   neg bx
;   ret
; .q1:
;   mov ax,bx
;   neg ax
;   mov bx,dx
;   ret
; .q0:
;   mov ax,dx
;   ret

; FIXME: lijkt eindeloze loop bij v_limit



; deze waarden lijken erg hoog... maar missch klopt het
; test: daar weer atan2 op doen..

  ; set_cursor 6,30
  ; print_ax
  ; print " ax    "

  ; set_cursor 7,30
  ; mov ax,bx
  ; print_ax
  ; print " bx    "

  ; mov [bx],ax
  ; pop ax
  ; call sin
  ; mov [bx+2],ax
;   ret
; .x: dw 0
; .y: dw 0




; DIT WERKT MISSCHIEN WEL MISSCHIEN NIET. MAAR TIJDELIJK VERVANGEN DOOR LIMIT MET LOOP
; v_limit2: ; [bx] input vector, cx=max_length. updates [bx]
;   mov ax,cx              ; ax=cx=max_length
;   cwd
;   imul ax                ; ax*=ax
;   mov [.maxSq],ax
;   call v_mag_sq          ; ax now contains squared CUR length of [bx]
;   mov [.lenSq],ax
;   ; set_cursor 10,30
;   ; mov ax,[.maxSq]
;   ; println_ax
;   ; set_cursor 11,30
;   ; mov ax,[.lenSq]
;   ; println_ax
;   cmp word ax,[.maxSq]
;   jle .done              ; no work needed
;   mov ax,[bx]            ; x
;   cwd
;   imul word [.maxSq]     ; x*=maxSq
;   idiv word [.lenSq]     ; x/=lenSq
;   mov word [bx],ax
;   mov ax,[bx+2]          ; y
;   cwd
;   imul word [.maxSq]     ; y*=maxSq
;   idiv word [.lenSq]     ; y/=lenSq
;   mov word [bx+2],ax
; .done
;   ret
; .maxSq: dw 0
; .lenSq: dw 0





; cos: ; ax in degrees (>0)
;   ; push dx
;   ; push cx
;   ; mov cx,ax
;   ; mov ax,90
;   ; sub ax,cx
;   ; mov cx,100
;   ; cbw
;   ; imul cx
;   ; add ax,45
;   ; mov cx,9
;   ; cbw
;   ; idiv cx
;   ; pop cx
;   ; pop dx


; sin: ; input:ax 0..360, output 0.. ???
;   push dx
;   push cx
;   mov cx,100
;   cbw
;   imul cx
;   add ax,45
;   mov cx,9
;   cbw
;   idiv cx
;   pop cx
;   pop dx

