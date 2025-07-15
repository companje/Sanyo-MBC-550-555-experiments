setup:
  push cs
  pop ds
  push cs
  pop es
  
  mov al,0x35
  out 0x3a,al


  mov si,tones
  mov cx,1
.lp:
  lodsw
  push cx
  push si
  push di
  mov si,ax
  call make_tone
  call fade_in
  call play_tone
  pop di
  pop si
  pop cx
  loop .lp

  hlt

tones: dw 196,207,220,233,246,261,277,293,311,329,349,369,392,415,440,466,493,523,554,587,622,659,698,739,783,830,880,932,987,1046
fade_cycles dw 2500              ; aantal cycli waarover je fade-in doet
samples_per_halfcycle dw 0      ; initieel zetten vanuit make_tone (BX)


make_tone:
  xor dx,dx
  mov cx,16000
  mov ax,cx
  ; shr si,1
  div si
  mov di,data
  mov bx,ax ; aantal stosb per fase
  mov dx,ax
  mov al,8
.next:
  stosb
  dec dx
  jnz .skip_toggle
  xor al,8
  mov dx,bx
.skip_toggle:
  loop .next
  ret

play_tone:
  mov cx,16000
  mov si,data
.next:
  lodsb
  out 0x3a,al
  ; pulse delay
  push cx
  mov cx,3
.delay:
  loop .delay
  pop cx
  ; end delay
  loop .next
  ret

fade_in:
  mov si, data                  ; SI = start van golfdata
  mov cx, 0                     ; CX = cyclus teller

.next_cycle:
  cmp cx, [fade_cycles]
  jae .end_fade                 ; als we buiten fade-gebied zitten, stop

  ; Bereken duty-percentage = (cx * 50) / fade_cycles
  mov ax, cx
  mov bx, 50
  mul bx                        ; AX = cx * 50
  mov bx, [fade_cycles]
  div bx                        ; AX = duty %, bv. 5, 10, ..., 50
  push ax                       ; duty % bewaren

  ; Bereken max aantal 8'jes (max_on) = samples_per_halfcycle
  mov ax, [samples_per_halfcycle]
  pop bx                        ; BX = duty %
  mul bx                        ; AX = duty% * max_on
  mov bx, 100
  div bx                        ; AX = aantal 8'jes die blijven
  mov bx, ax                    ; BX = remaining 'on' samples

  ; Loop door 'aan'-segment
.scan_on:
  cmp byte [si], 8
  jne .done_cycle
  cmp bx, 0
  je .zero_it
  dec bx
  inc si
  jmp .scan_on

.zero_it:
  mov byte [si], 0
  inc si
  jmp .scan_on

.done_cycle:
  ; Skip de 'uit'-fase
.skip_zero:
  cmp byte [si], 0
  jne .found_next
  inc si
  jmp .skip_zero

.found_next:
  inc cx
  cmp si, data + 8000
  jb .next_cycle

.end_fade:
  ret






data:


%assign num $-$$
%warning total num
times (180*1024)-num db 0
