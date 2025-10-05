F2C equ 350000; 198504 ; freq to cycles F2C/G3 = num cycles for G3
;    _       _        _
;  _| |_____| |______| |_____
;
; freq equ C5         ; Hz
; duty_cycle equ 10   ; percent
; duration equ 200    ; ms

; num_cycles equ freq * duration / 1000
; cycle_time equ F2C * 4 / freq
; pulse_width equ cycle_time * duty_cycle / 100
; space_width equ cycle_time - pulse_width

jmp setup

; make sure DS=CS
freq: dw 261 ; 261 ;Hz  C4
duty_cycle: dw 50 ; percent
; duty_step: dw 1
; duration: dw 50 ; ms
; cycles: dw 1000 ; count ('remaining' cycles to play)
pulse_width: dw 0
space_width: dw 0

setup:
  push cs
  pop ds
  mov si,1
  ; mov bp



update:
  ; mov bh,0
  ; lodsw

  ; push cx  
  ; call calc_num_cycles
  ; call calc_cycle_widths ; input: [freq],[duty_cycle], output: result [pulse_width],[space_width]
  ; call play_cycles
  ; pop cx
  
  scale equ 2
  min equ 1<<scale
  max equ 99<<scale

  ; and bp,63
  add bp,si
  cmp bp,min
  jg .a
  neg si
  mov bp,min
.a:
  cmp bp,max
  jl .b
  neg si
  mov bp,max
.b:



  push bp
  push cx
  ; mov word [freq],261

  mov cl,scale
  shr bp,cl
  ; mov [duty_cycle],bp

  mov [freq],bp
  add word [freq],200  

  pop cx
  pop bp

  call calc_cycle_widths


  xor ax,ax ; reset ax to prevent wrong value to USART
  call play_half_cycle ; high or low
  call play_half_cycle ; low or high

  jmp update

; play_cycles:
;     xor ax,ax ; reset ax to prevent wrong value to USART
; .p: call play_half_cycle ; high or low
;     call play_half_cycle ; low or high
;     ;update duty cycle here
;     ;call calc_cycle_widths here for if duty_cycle has changed?
    
;     call calc_cycle_widths

;     dec word [cycles]
;     jnz .p
;     ret

calc_cycle_widths:
    ; calculates pulse_width and space_width for 1 cycle
    ; input: [freq], [duty_cycle]
    ; output: cx=pulse_width, dx=space_width
    ; cycle_time equ F2C * 4 / freq  (= (F2C/freq)*4)
    ; pulse_width equ cycle_time * duty_cycle / 100
    ; space_width equ cycle_time - pulse_width
    mov ax,F2C & 0xFFFF          ; 32 bit
    mov dx,F2C >> 16
    div word [freq]              ; ax is now cycle_time
    push ax
    mul word [duty_cycle]        ; ax is now cycle_time * duty_cycle
    mov cx,100
    div cx        ; ax is now pulse_width
    mov [pulse_width],ax
    pop word [space_width]
    sub [space_width],ax
    ret

play_half_cycle:
    out 0x3a,al
    xor al,8               ; toggle break bit
    mov cx, [pulse_width] 
    xchg cx, [space_width] ; swap cx,dx every half cycle
    mov [pulse_width], cx
.d: loop .d
    ret

calc_num_cycles:
    ; input [duration],[freq], output=[cycles]
    ; num_cycles equ freq * duration / 1000
    mov ax,[duration]
    cwd
    mul word [freq]
    mov cx,1000
    div cx
    mov word [cycles],ax
    ret


%assign num $-$$
%warning total num
times (180*1024)-num db 0



