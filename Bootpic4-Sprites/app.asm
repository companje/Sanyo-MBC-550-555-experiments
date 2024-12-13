%include "sanyo.asm"

%macro draw_sprite 1
  mov bp,%1
  call _draw_sprite
%endmacro

%macro clear_block 1
  mov es,ax
  mov bx,%1
  call calc_di_from_bx  
  mov cx,18 * 4
  mov ax,0
  rep stosw
%endmacro


size equ 0
w equ 0
h equ 1
pos equ 2
x equ 2
y equ 3
vel equ 4
vx equ 4
vy equ 5
frame equ 6
frames equ 7
framesize equ 8
img_data equ 9

max_x equ 60
max_y equ 44


time: db 0
osc: db 20

hello1: db "  < PARTY TIME @  ",0
hello2: db "  > RICKYBOYII >  ",0
  
hello3: db "  SATURDAY@20:00  ",0
hello4: db "  SCHUTSTRAAT 89  ",0
 
glitcher: db 20

all_sprites: 
  ; dw bouncer, pinkbox, bouncer
  dw donut, stars, sqr_ani, walk_fw, walk_bw, stand, walk_left, walk_right
  dw flower, explode, creep, bouncer, eye, smurf_left, smurf_right, ghost
  dw lobster_left, lobster_right, keylock, key, owl, crown, goblet, ring
  dw globe, feather, totum, building, mirror, harp, nar, computer, way_down
  dw way_left, way_up, way_right, pinkbox, box, vbar, hbar, house1, question

sin_table: ;31 bytes, (input -15..15 index=0..31)
    db 0,-3,-6,-9,-11,-13,-15,-15,-15,-15,-13,-11,-9,-6,-3,
    db 0, 3, 6, 9, 11, 13, 15, 15, 15, 15, 13, 11, 9, 6, 3,0  

setup:
  jmp draw

; ───────────────────────────────────────────────────────────────────────────

update_sprite_pos:
    ; Update X positie
    mov al, [bp+vx]
    add [bp+x], al

    ; Check of x buiten grenzen gaat
    mov al, [bp+x]
    cmp al, 0
    jge .check_x_upper
    
    ; Negatief, bounce terug
    mov al, [bp+vx]
    neg al
    mov [bp+vx], al
    mov byte [bp+x], 0
    jmp .update_y

.check_x_upper
    cmp al, max_x
    jle .update_y
    
    ; Groter dan 65, bounce terug
    mov al, [bp+vx]
    neg al
    mov [bp+vx], al
    mov byte [bp+x], max_x

.update_y
    ; Update Y positie
    mov al, [bp+vy]
    add [bp+y], al

    ; Check of y buiten grenzen gaat
    mov al, [bp+y]
    cmp al, 0
    jge .check_y_upper
    
    ; Negatief, bounce terug
    mov al, [bp+vy]
    neg al
    mov [bp+vy], al
    mov byte [bp+y], 0
    jmp .done

.check_y_upper
    cmp al, max_y
    jle .done
    
    ; Groter dan 40, bounce terug
    mov al, [bp+vy]
    neg al
    mov [bp+vy], al
    mov byte [bp+y], max_y

.done
    ret


_undraw_sprite:
  mov bx,[bp+pos]
  call calc_di_from_bx
  mov ax,0
  mov cx,8
  rep stosw
  
  add di,COLS*4-4*4
  mov cx,8
  rep stosw
  
  add di,COLS*4-4*4
  mov cx,8
  rep stosw

  add di,COLS*4-4*4
  mov cx,8
  rep stosw

  ret

_draw_sprite:

  mov ax,GREEN
  mov es,ax
  call _undraw_sprite
  mov ax,RED
  mov es,ax
  call _undraw_sprite
  mov ax,BLUE
  mov es,ax
  call _undraw_sprite


  call update_sprite_pos


  mov bx,[bp+pos]
  call calc_di_from_bx
  mov si,[bp+img_data]
  mov cl,[bp+framesize]
  mov byte al,[bp+frame]
  mul cl
  add si,ax
  mov bx,[bp+size]
  call draw_pic
  call next_frame
  ret

; ───────────────────────────────────────────────────────────────────────────

next_frame:
  inc byte [bp+frame]
  mov cl,[bp+frames]
  cmp byte [bp+frame],cl
  jb .done
  mov byte [bp+frame],0
.done
  ret

; ───────────────────────────────────────────────────────────────────────────

draw_char_part:
  mov cx,4
.lp lodsw              ; ax contains now 16 horizontal bits of the char
  stosb                ; draw left part
  mov [es:di+3],ah     ; draw right part
  loop .lp             ; draw 4 lines
  ret
  
; ───────────────────────────────────────────────────────────────────────────

draw_char:
  cbw                  ; clear high part of ax
  mov si,font          ; font table base
  sub al,32            ; 'A'-32  convert ascii code to character index
  mov cl,24            ; 2*12=24 bytes per character in font table
  mul cl               ; ax=al*24 
  add si,ax
  call draw_char_part  ; upper 4 lines
  add di,COLS*4-4
  call draw_char_part  ; middle 4 lines
  add di,COLS*4-4
  call draw_char_part  ; lower 2 lines
  sub di,COLS*8-4      ; finish char, move 2 rows up
  ret

; ───────────────────────────────────────────────────────────────────────────

draw_string:    ; input si=string offset
.lp
  push si
  lodsb
  or al,al
  jz .done
  call draw_char
  pop si
  inc si
  jmp .lp
.done
  pop si
  ret

; ───────────────────────────────────────────────────────────────────────────



draw:
  call _wait

  mov cx,0
  mov cl,[glitcher]
  .lp
    push cx
    mov bp,cx
    ; dec bp
    shl bp,1
    add bp,all_sprites
    mov bp,[bp]
    call _draw_sprite
    pop cx
    loop .lp


    ; mov ax,RED
    ; clear_block 0x0e00
    ; clear_block 0x0f00
    ; clear_block 0x1000
    ; clear_block 0x1100
    ; clear_block 0x1200
    ; clear_block 0x1300
    ; clear_block 0x1400
    ; clear_block 0x1500
    ; clear_block 0x1600
    ; clear_block 0x1700
    ; clear_block 0x1800
    ; clear_block 0x1900
    ; clear_block 0x1a00
    ; clear_block 0x1b00


  push bx
  mov ax,RED
  mov es,ax
  mov si,hello1
  mov bx,0x0f00
  mov bl,[osc]
  call calc_di_from_bx  
  call draw_string
  pop bx

  mov ax,GREEN
  mov es,ax
  mov si,hello2
  mov bx,0x1200
  mov bl,[osc]
  call calc_di_from_bx
  call draw_string

; cyan
  mov ax,BLUE
  mov es,ax
  mov si,hello3
  mov bx,0x1500
  mov bl,[osc]
  call calc_di_from_bx
  call draw_string

  mov ax,GREEN
  mov es,ax
  mov si,hello3
  mov bx,0x1500
  mov bl,[osc]
  call calc_di_from_bx
  call draw_string

; yellow
  mov ax,RED
  mov es,ax
  mov si,hello4
  mov bx,0x1800
  mov bl,[osc]
  call calc_di_from_bx
  call draw_string

  mov ax,GREEN
  mov es,ax
  mov si,hello4
  mov bx,0x1800
  mov bl,[osc]
  call calc_di_from_bx
  call draw_string

  inc byte [time]

  mov byte al,[time]
  mov bx,sin_table
  xlat 

  add al,20
  mov [osc], al  

  cmp byte [time],30
  jna draw
  mov byte [time],0  
  mov byte [osc],20

  ; mov byte [glitcher], 42

  jmp draw


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
  ret

; ───────────────────────────────────────────────────────────────────────────

draw_pic:          ; DI=offset, [BH,BL]=rows,cols
  mov ax, RED
  call draw_channel
  mov ax, GREEN
  call draw_channel
  mov ax, BLUE
  call draw_channel
  ret

; ───────────────────────────────────────────────────────────────────────────

draw_channel: 
  push di
  mov es,ax
  xor cx,cx  
  mov cl,bh        ; rows (bh)
.rows push cx
  xor cx,cx
  mov cl,bl        ; cols (bl)
.cols times 2 movsw
  loop .cols
  add di,COLS*4-4*4
  pop cx
  loop .rows
  pop di
  ret 

; ───────────────────────────────────────────────────────────────────────────

_wait:
  push cx
  mov cx,1000
.lp 
  aam
  loop .lp
  pop cx
  ret

; ───────────────────────────────────────────────────────────────────────────

%include "assets.asm"

times (180*1024)-($-$$) db 0

