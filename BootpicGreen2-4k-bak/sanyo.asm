org 0
cpu 8086

jmp boot

NUM_SECTORS equ 125          ; number of sectors to read
BAR_WIDTH equ 30
COLS  equ 80
ROWS  equ 50
LINES equ 200
CENTER equ COLS*LINES/2+COLS*4/2
RED   equ 0xf000
GREEN equ 0x1c00
BLUE  equ 0xf400
DST   equ 0x38
XD    equ 4
YD    equ COLS*XD
FONT equ 0xFF00
BYTES_PER_ROW equ 8*COLS  ; 25 lines
Color.R equ 0b100
Color.G equ 0b010
Color.B equ 0b001
Color.W equ 0b111
Color.C equ 0b011
Color.M equ 0b101
Color.Y equ 0b110
Color.K equ 0b000
CTRL equ 0b0000100000000000
KEY_LEFT  equ 0b00011100
KEY_RIGHT equ 0b00011101
KEY_UP    equ 0b00011110
KEY_DOWN  equ 0b00011111

cursor:
.col: db 0
.row: db 0

key:
  .code db 0
  .ctrl db 0

%macro set_cursor 2
  ; mov di,%1 * BYTES_PER_ROW + %2 * 4  ; zero based
  mov di,(%1-1) * BYTES_PER_ROW + (%2-1) * 4   ; one based
%endmacro

%macro print 1
  push ax
  push bx
  push cx
  push dx
  jmp %%endstr 
  %%str: db %1,0
  %%endstr: 
  mov bx,%%str
  call write_string
  pop dx
  pop cx
  pop bx
  pop ax
%endmacro

%macro println 1
  print %1
  call new_line
%endmacro

%macro print_ax 0
  call write_signed_number_word
%endmacro

%macro print_ax_unsigned 0
  call write_number_word
%endmacro

%macro print_ax_hex 0
  call write_ax_hex
%endmacro

%macro print_ax_bin 0
  call write_binary_word
%endmacro

%macro print_char 1
  push ax
  mov al,%1
  call write_char
  pop ax
%endmacro

%macro print_2chars 1
  push ax
  mov ax,%1
  call write_2chars
  pop ax
%endmacro

; ------------
; println

%macro println_ax 0
  print_ax
  call write_5spaces_newline
%endmacro

%macro println_ax_unsigned 0
  print_ax_unsigned
  call write_5spaces_newline
%endmacro

%macro println_ax_hex 0
  print_ax_hex
  call write_5spaces_newline
%endmacro

%macro println_ax_bin 0
  print_ax_bin
  call write_5spaces_newline
%endmacro

write_5spaces_newline:
  push ax
  mov ax,"  "
  call write_2chars
  call write_2chars
  call write_char
  call new_line
  pop ax
  ret

write_2chars:
  call write_char
  xchg ah,al
  call write_char
  ret

%macro register_interrupt 1
  mov ax,%1
  stosw
  mov ax,cs
  stosw
%endmacro

; int0: hlt
; int1: hlt
; int2: hlt
; int3: hlt
; int4: hlt

int0:; int0: Division by zero
  cld
  mov ax,BLUE
  mov es,ax
  xor di,di
  mov cx,7200
  mov ax,-1
  rep stosw
  set_cursor 1,1
  print "Division by zero"
  set_cursor 3,1
  pop ax
  print "IP="
  println_ax_hex
  call new_line
  print "CS="
  pop ax
  println_ax_hex
  call new_line
  print "FLAGS="
  pop ax
  call write_binary_word
  hlt

int1:; int1: Single step debugging
  mov al,1
  jmp int_msg
int2:; int2: Non maskable interrupt
  mov al,2
  jmp int_msg
int3:; int3: For one-byte interrupt
  mov al,3
  jmp int_msg
  ; push ax
  ; push bx
  ; push cx
  ; push dx
  ; push si
  ; push di
  ; push bp
  ; push ds
  ; push es

  ; ; mov di,10*4
  ; ; set_cursor 5,5
  ; xor di,di
  ; print "int3:"
  ; ; mov ax,cx
  ; ; call write_number_word

  ; pop es
  ; pop ds
  ; pop bp
  ; pop di
  ; pop si
  ; pop dx
  ; pop cx
  ; pop bx
  ; pop ax
  ; iret

int4:; int4: Signed overflow
  mov al,4
  jmp int_msg
int_msg:
  mov di,500
  ; xor di,di
  ; mov ax,di
  ; mov cx,8*72  
  ; rep stosw
  ; xor di,di
  ; push ax
  ; print "int: "
  ; pop ax
  add al,'0'
  call write_char
  ; print "      "
  
  hlt

boot:
  cli
  cld
  call clear_green    

  ; init video      
  mov al, 5
  out 10h, al           ; select address 0x1c000 as green video page
 
  mov al,1
  out 0x30,al
  mov al,COLS
  out 0x32,al


  ; register interrupts
  xor di,di ; offset 0
  mov es,di ; segment 0
  register_interrupt int0
  register_interrupt int1
  register_interrupt int2
  register_interrupt int3
  register_interrupt int4


  ; init other hardware
  mov al,0
  out 0x3a,al           ; keyboard \force state/
  out 0x3a,al           ; keyboard \force state/
  mov al,0xFF
  out 0x3a,al           ; keyboard \reset/
  out 0x3a,al           ; keyboard \mode/
  mov al,0x37
  out 0x3a,al           ; keyboard \set command

  mov ax,GREEN      
  mov ds,ax                 ; GREEN video segment used for progress bar
  mov ax,DST                
  mov es,ax                 ; DST segment used for storing data read from disk
  mov di,0                  ;
  mov dl,0                  ; track=0
  mov dh,1                  ; sector=1
  mov cx,NUM_SECTORS        ; read 48h (72) sectors (36864 bytes)
  jmp move_head

; ───────────────────────────────────────────────────────────────────────────

next_sector:
  inc dh                    ; sector++
  cmp dh,10
  jb read_sector            ; if (dh<9) read_sector
  mov dh,1
  inc dl                    ; else track++ ; sector=1

move_head:
  mov al,dl
  out 0Eh,al               ; set track number
  mov al,18h     
  out 8,al                 ; seek track, load head
  mov al,0
  out 1Ch,al               ; set desired drive/side
  aam

head_moving:
  in al,8
  test al,1
  jnz head_moving

read_sector:
  mov al,dh
  out 0Ch,al                ; sector number
  mov bh,2                  ; 00000010b
  mov bl,96h                ; 10010110b
  mov ah,0
  mov al,80h
  out 8,al                  ; read sector
  times 4 aam               ; wait

check_status_1:
  in al,8                   ; read status
  sar al,1                  ; status/=2
  jnb check_status_3
  jnz check_status_1

wait_for_data:
  in al,8                   ; read status
  and al,bl                 ; 96h
  jz wait_for_data

store_byte_1:
  in al,0Eh
  stosb

check_status_2:
  in al,8                   ; read status
  dec ax                    ; status--
  jz check_status_2         ; if (status==0) repeat
  cmp al, bh                ; bh=2
  jnz check_status_3        ; if (status==1) 

store_byte_2:
  in al,0Eh  
  stosb

check_status_4:
  in al,8                   ; read status
  cmp al, bh                ; bh=2
  jz store_byte_2           ; if (status==2) repeat
  jmp check_status_2        ; else: was jmp SI

; ───────────────────────────────────────────────────────────────────────────

check_status_3:
  in al, 8                  ; read status
  test al, 1Ch              ; 00011100
  jz while_sectors
  jmp read_sector

; ───────────────────────────────────────────────────────────────────────────

while_sectors:
  call progress_bar
  loop next_sector

done_reading:
  push cs
  pop ss
  mov sp,0
  call clear_green
  push cs
  pop ds
  set_cursor 1,1 ; nodig?
  jmp setup

; ───────────────────────────────────────────────────────────────────────────

progress_bar:
  ;dit kan veel korter als NUM_SECTORS een vaste waarde heeft.
  push dx
  push bx
  xor dx,dx
  mov ax,BAR_WIDTH
  mov bx,NUM_SECTORS    
  mul cx
  div bx
  pop bx
  pop dx
  mov si,ax                 ; ax is nu 0..BAR_WIDTH
  shl si,1                  ; *=2
  shl si,1                  ; *=2  
  mov bp,CENTER+BAR_WIDTH*2
  sub bp,si
  mov byte [ds:bp],-1
  ret

; clear_red:
;   mov ax,RED
;   call clear_channel
;   ret

clear_green:
  mov ax,GREEN
  call clear_channel
  ret

; clear_blue:
;   mov ax,BLUE
;   call clear_channel
;   ret

; clear_screen:
;   call clear_red
;   call clear_green
;   call clear_blue
;   ret

clear_channel:
  mov es,ax
  mov cx,COLS*ROWS*2
  xor di,di
  xor ax,ax
  rep stosw         ; clear screen
  ret

; ───────────────────────────────────────────────────────────────────────────

; write_char:   ; ds=FONT, es=GREEN, al=charcode
;   ; zou ik hier ds moeten pushen? omdat je er vanuit wilt gaan dat DS en CS altijd gelijk zijn
;   ; je zou de huidige kleur op een adres willen bewaren. nu doet ie alleen maar groen.
;   ; deze functie zou ook korter/lichter kunnen/moeten. wellicht twee functies maken. een slimme en een domme snelle..

;   push ds
;   push es
;   push ax
;   push bx
;   push cx

;   push ax
;   mov ax,GREEN
;   mov es,ax
;   mov ax,FONT
;   mov ds,ax
;   pop ax

;   ; mov ax,65*8
;   ; mov al,'x'
;   mov ah,8
;   mul ah        ; ax=al*ah

;   mov si,ax
;   movsw
;   movsw
;   add di,0x11c
;   movsw
;   movsw
;   mov bx,288
;   sub di,bx
  
;   ; pop ax
;   ; pop es
;   ; pop ds
;   ; ret


;   ; row snap
;   xor dx,dx
;   mov ax,di
;   div bx
;   cmp dx,0
;   jne .return
;   add di,bx


;   ; wrap to top
;   cmp di,14400   ; dit later oplossen met cursor positie
;   jb .return
;   ; xor di,di      ; move to left top. change later to scroll

;   ; TODO: call scroll_down
;   ; std
;   ; push di
;   ; push cx
;   ; mov cx,4*72*24
;   ; mov ax,0
;   ; rep stosw
;   ; pop cx
;   ; pop di
;   ; cld

;   ; DONE: clear last line
;   sub di,bx
;   sub di,bx
;   push di
;   push cx
;   mov cx,COLS*ROWS*2
;   xor ax,ax
;   rep stosw         ; clear screen
;   pop cx
;   pop di

; .return
;   push bx
;   push cx
;   pop ax
;   pop es
;   pop ds
;   ret

; ; ───────────────────────────────────────────────────────────────────────────

write_char:   ; ds=FONT, es=GREEN, al=charcode
  push dx
  push ds
  push es
  push ax
  push bx
  xor dx,dx
  push ax  ; voor character pop
  mov ax,GREEN
  mov es,ax
  mov ax,FONT
  mov ds,ax
  pop ax
  mov ah,8
  mul ah        ; al*=ah
  mov si,ax  

  movsw
  movsw
  add di,0x11c
  movsw
  movsw
  sub di,0x120


  ; cmp di,14400   ; dit later oplossen met cursor positie
  ; jb .return
  ; xor di,di      ; move to left top. change later to scroll

  ; row snap
  mov bx,288   ; /////////// dit gaf problemen waarsch omdat bx niet gepushed werd
  xor dx,dx
  mov ax,di
  div bx       ; ///dit ook als BX 0 is
  cmp dx,0
  jne .return
  add di,bx

.return
  pop bx
  pop ax
  pop es
  pop ds
  pop dx
  ret

write_string:
  mov al,[cs:bx]
  inc bx
  or al,al
  jz .return
  call write_char
  jmp short write_string
.return
  ret

; ───────────────────────────────────────────────────────────────────────────

write_binary_byte:    ; input AL
  push bx
  push cx
  push ax
  mov bl, al          ; Kopieer AL naar BL (we werken op BL)
  mov cx, 8           ; We gaan 8 bits schrijven
.lp:
  rol bl, 1           ; Rotate BL naar links (hoogste bit komt in Carry Flag)
  mov ax, 0           ; AH leegmaken
  adc al, 48          ; Als Carry Flag 1 is, wordt '1', anders '0'  
  push cx             ; CX opslaan
  call write_char      ; Schrijf het karakter naar het scherm
  pop cx              ; CX herstellen
  loop .lp            ; Loop voor alle 8 bits
  pop ax
  pop cx
  pop bx
  ret

; ───────────────────────────────────────────────────────────────────────────

write_binary_word:    ; input AX
  push cx
  push ax
  push dx            ; DX opslaan (we gebruiken het later)
  mov dx, ax         ; Kopieer AX naar DX (we werken op DX)
  mov cx, 16         ; We gaan 16 bits schrijven
.lp:
  rol dx, 1          ; Rotate DX naar links (hoogste bit komt in Carry Flag)
  mov ax, 0          ; AH leegmaken
  adc al, 48         ; Als Carry Flag 1 is, wordt '1', anders '0'  
  push cx            ; CX opslaan
  call write_char    ; Schrijf het karakter naar het scherm
  pop cx             ; CX herstellen
  loop .lp           ; Loop voor alle 16 bits
  pop dx             ; DX herstellen
  pop ax
  pop cx
  ret


; ───────────────────────────────────────────────────────────────────────────

write_number_word:
    push ax
    push dx
    xor dx,dx
    push dx ;high byte is zero
.clp xor dx,dx
    cs div word [.base]
    xchg ax,dx
    add ax,0xe30
    push ax
    xchg ax,dx
    or ax,ax
    jnz .clp
.dlp pop ax
    or ah,ah
    jz .done
    call write_char
    jmp short .dlp
.done pop dx
    pop ax
    ret
.base dw 10

; ───────────────────────────────────────────────────────────────────────────


; ───────────────────────────────────────────────────────────────────────────

write_signed_number_word:  
    push ax
    or ax,ax
    jns .write_return        ; if >0 write and return
    push ax
    mov ax,'-'
    call write_char
    pop ax
    neg ax                   ; destroys ax when negative
.write_return:
    call write_number_word
    pop ax
    ret

; ───────────────────────────────────────────────────────────────────────────

check_keys:
  in al,0x3a        ; get keyboard status
  mov ah,al
  and al,0b00001000 ; keep only 1 for 'ctrl'
  mov [cs:key.ctrl],al
  test ah,2         ; keypressed flag is in ah, not in al anymore
  jz .return
  in al,0x38        ; get data byte from keyboard  
  mov [cs:key.code],al
  mov al,0x37
  out 0x3a,al       ; drop key?  
  or al,1           ; set zero flag to false to indicate a keypress
  mov ax,[cs:key]   ; ctrl status in ah, keycode in al, ZF low means a key was pressed
.return ret

; ───────────────────────────────────────────────────────────────────────────

draw_spr:
  push bx
  mov bx,[si]
  inc si
  inc si
  call draw_pic
  pop bx
  ret

draw_pic:
  push ax
  mov ax, RED
  call draw_channel
  mov ax, GREEN
  call draw_channel
  mov ax, BLUE
  call draw_channel
  pop ax
  ret

; ───────────────────────────────────────────────────────────────────────────

draw_channel:
  push di
  mov es,ax
  xor cx,cx
  mov cl,bh        ; rows (bl)
.rows_loop:
  push cx
  xor cx,cx
  mov cl,bl        ; cols (bh)
.cols_loop:
  movsw
  movsw
  loop .cols_loop
  add di,COLS*4    ; one row down
  mov ah,0
  mov al,bl
  times 2 shl ax,1
  sub di,ax       ; di-=4*bh   ; bh cols to the left on the new row
  pop cx
  loop .rows_loop
  pop di
  ret

; ───────────────────────────────────────────────────────────────────────────

calc_di_from_bx:  ; input bl,bh [0,0,71,49]
  mov ax,144      ; 2*72 cols
  mul bh          ; bh*=144 resultaat in AX
  shl ax,1        ; verdubbel AX
  mov di,ax       ; di=ax (=bh*288)
  shl bl,1        ; bl*=2
  shl bl,1        ; bl*=2
  mov bh,0
  add di,bx       ; di+=bl
  cmp di,0
  jl .clamp_top
  ret
.clamp_top
  xor di,di
  ret


; ───────────────────────────────────────────────────────────────────────────

new_line:         ; find the value of DI at start of the next line
  push ax
  push bx
  push dx
  mov bx,288
  xor dx,dx
  mov ax,di
  div bx
  xor dx,dx       ; cwd?
  mov bx,288      ; can reuse x from above?
  inc ax
  mul bx
  add ax,288      ; use bx?
  mov di,ax
  pop dx
  pop bx
  pop ax
  ret

; ───────────────────────────────────────────────────────────────────────────

write_ax_hex:
  push ax
  push dx
  xor dx,dx
  push dx ;high byte is zero
.clp xor dx,dx
  cs div word [.base]
  xchg ax,dx
  cmp al,10
  jb .l1     ; 0-9
  add al,7   ; A-F
.l1 add ax,0xe30
  push ax
  xchg ax,dx
  or ax,ax
  jnz .clp
.dlp pop ax
  or ah,ah
  jz .done
  call write_char
  jmp short .dlp
.done pop dx
  pop ax
  ret
.base dw 16

