; %include "sanyo.asm"
; %include "header.asm"
org 0
cpu 8086
RED equ 0xf000
COLS equ 72
jmp setup

%macro set_cursor 2
  mov bl, %1           ; Zet X in BL
  mov bh, %2           ; Zet Y in BH
  call calc_di
%endmacro
 
%macro set_channel 1
  mov ax, %1
  mov es, ax
%endmacro

%macro move_down 0
  add di,YD
%endmacro

%macro move_up 0
  sub di,-YD
%endmacro

p:
.x db 32
.vx db -1
.y db 25
.vy db 1

setup:
  mov ax, cs
  mov ds, ax

  jmp draw

draw:
  set_channel RED
  mov bx, [p.x]           ; x and vx
  mov dx, [p.y]           ; y and vy

  ; Controleer x-richting
  cmp bl, 1              ; Check if x <= 10
  jg .check_x_max         ; If x > 10, skip to next check
  neg bh                  ; Reverse vx
  jmp .check_y            ; Skip y-check if x condition is met

.check_x_max:
  cmp bl, 63              ; Check if x >= 50
  jl .check_y             ; If x < 50, continue to y-check
  neg bh                  ; Reverse vx

  ; Controleer y-richting
.check_y:
  cmp dl, 1               ; Check if y <= 1
  jg .check_y_max         ; If y > 1, skip to next check
  neg dh                  ; Reverse vy
  jmp .update             ; Skip updates if y condition is met

.check_y_max:
  cmp dl, 49              ; Check if y >= 45
  jl .update              ; If y < 45, continue
  neg dh                  ; Reverse vy

.update:
  add bl, bh              ; Update x with vx
  mov [p.x], bx           ; Store the updated x and vx

  add dl, dh              ; Update y with vy
  mov [p.y], dx           ; Store the updated y and vy

  set_cursor [p.x], [p.y]
  mov ax, -1
  stosw
  stosw

  call wait_vsync

  set_cursor [p.x], [p.y]
  mov ax, 0
  stosw
  stosw

  jmp draw






flash_red:
  push es
  xor di,di
  set_channel RED
  mov cx,7200
  mov ax,-1
  rep stosw
  xor di,di
  call wait_vsync
  mov cx,7200
  mov ax,0
  rep stosw
  pop es
  ret




; draw:
  
  ; mov al,[p.vx]
  ; add byte [p.x],al
  ; inc byte [p.x]

  ; cmp byte [p.x],COLS-1
  ; je bounceX
  ; cmp byte [p.x],1
  ; je bounceX

  hlt

  ; call flash_red

  ; call wait_vsync


  ; set_cursor [p.x],[p.y]
  ; mov ax,0
  ; stosw
  ; stosw

  ; inc byte [p.x]


  ; jmp draw

  ; mov si,img    ; first image
  
  ; lodsw
  ; mov bx,ax

  ; hlt

  ; xor bx,bx
  ; call calc_di
  ; mov bl,72              ; width in cols (1 col = 8px)
  ; mov bh,16               ; height in rows (1 row = 4px)
  ; call draw_pic

  ; hlt

wait_vsync:
  cld
  mov cx,500
.w
  aam
  loop .w
  ret

calc_di:          ; input bl,bh [0,0,71,49]
  mov ax,144      ; 2*72 cols
  mul bh          ; bh*=144 resultaat in AX
  shl ax,1        ; verdubbel AX
  mov di,ax       ; di=ax (=bh*288)
  shl bl,1        ; bl*=2
  shl bl,1        ; bl*=2
  mov bh,0
  add di,bx       ; di+=bl
  ret

draw_pic:          ; DI=offset, [BH,BL]=rows,cols
  mov ax, RED
  call draw_channel
  ; mov ax, GREEN
  call draw_channel
  ; mov ax, BLUE
  call draw_channel
  ret

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
  ; cmp bl,COLS
  add di,COLS*4
  mov al,bl
  mul bh
  sub di,ax
  pop cx
  loop .rows
  pop di
  ret 



; segment data

; times (1000)-($-$$) db 0

; SECTION Assets

startAssets:
img:
  .full incbin "data/full.bin"
  ; .keylock incbin "data/keylock.bin"
  ; .key incbin "data/key.bin"
  ; .owl incbin "data/owl.bin"
  ; .crown incbin "data/crown.bin"
  ; .goblet incbin "data/goblet.bin"
  ; .ring incbin "data/ring.bin"
  ; .globe incbin "data/globe.bin"
  ; .feather incbin "data/feather.bin"
  ; .totum incbin "data/totum.bin"
  ; .scroll incbin "data/scroll.bin"
  ; .building incbin "data/building.bin"
  ; .mirror incbin "data/mirror.bin"
  ; .harp incbin "data/harp.bin"
  ; .nar incbin "data/nar.bin"
  ; .computer incbin "data/computer.bin"
  ; .way_down incbin "data/way_down.bin"
  ; .way_left incbin "data/way_left.bin"
  ; .way_up incbin "data/way_up.bin"
  ; .way_right incbin "data/way_right.bin"
  ; .pinkbox incbin "data/pinkbox.bin"
  ; .greenwall_1 incbin "data/greenwall_1.bin"
  ; .greenwall_2 incbin "data/greenwall_2.bin"
  ; .greenwall_3 incbin "data/greenwall_3.bin"
  ; .redwall_1 incbin "data/redwall_1.bin"
  ; .redwall_2 incbin "data/redwall_2.bin"
  ; .redwall_3 incbin "data/redwall_3.bin"
  ; .box incbin "data/box.bin"
  ; .vbar incbin "data/vbar.bin"
  ; .hbar incbin "data/hbar.bin"
  ; .treetop_1 incbin "data/treetop_1.bin"
  ; .treetop_2 incbin "data/treetop_2.bin"
  ; .treetop_3 incbin "data/treetop_3.bin"
  ; .treething incbin "data/treething.bin"
  ; .treetop_a incbin "data/treetop_a.bin"
  ; .treetop_b incbin "data/treetop_b.bin"
  ; .treeroot_a incbin "data/treeroot_a.bin"
  ; .treeroot_b incbin "data/treeroot_b.bin"
  ; .cactus_top incbin "data/cactus_top.bin"
  ; .cactus_bottom incbin "data/cactus_bottom.bin"
  ; .roof_1 incbin "data/roof_1.bin"
  ; .roof_2 incbin "data/roof_2.bin"
  ; .roof_3 incbin "data/roof_3.bin"
  ; .house1 incbin "data/house1.bin"
  ; .question incbin "data/question.bin"
  ; .stars_1 incbin "data/stars_1.bin"
  ; .stars_2 incbin "data/stars_2.bin"
  ; .stars_3 incbin "data/stars_3.bin"
  ; .stars_4 incbin "data/stars_4.bin"
  ; .walk_bw_1 incbin "data/walk_bw_1.bin"
  ; .walk_bw_2 incbin "data/walk_bw_2.bin"
  ; .walk_fw_1 incbin "data/walk_fw_1.bin"
  ; .walk_fw_2 incbin "data/walk_fw_2.bin"
  ; .walk_left_1 incbin "data/walk_left_1.bin"
  ; .walk_left_2 incbin "data/walk_left_2.bin"
  ; .walk_left_3 incbin "data/walk_left_3.bin"
  ; .walk_left_4 incbin "data/walk_left_4.bin"
  ; .walk_right_1 incbin "data/walk_right_1.bin"
  ; .walk_right_2 incbin "data/walk_right_2.bin"
  ; .walk_right_3 incbin "data/walk_right_3.bin"
  ; .walk_right_4 incbin "data/walk_right_4.bin"
  ; .stand_1 incbin "data/stand_1.bin"
  ; .stand_2 incbin "data/stand_2.bin"
  ; .stand_3 incbin "data/stand_3.bin"
  ; .stand_4 incbin "data/stand_4.bin"
  ; .donut_1 incbin "data/donut_1.bin"
  ; .donut_2 incbin "data/donut_2.bin"
  ; .donut_3 incbin "data/donut_3.bin"
  ; .donut_4 incbin "data/donut_4.bin"
  ; .sqr_ani_1 incbin "data/sqr_ani_1.bin"
  ; .sqr_ani_2 incbin "data/sqr_ani_2.bin"
  ; .sqr_ani_3 incbin "data/sqr_ani_3.bin"
  ; .sqr_ani_4 incbin "data/sqr_ani_4.bin"
  ; .flower_1 incbin "data/flower_1.bin"
  ; .flower_2 incbin "data/flower_2.bin"
  ; .flower_3 incbin "data/flower_3.bin"
  ; .flower_4 incbin "data/flower_4.bin"
  ; .explode_1 incbin "data/explode_1.bin"
  ; .explode_2 incbin "data/explode_2.bin"
  ; .explode_3 incbin "data/explode_3.bin"
  ; .explode_4 incbin "data/explode_4.bin"
  ; .creep_1 incbin "data/creep_1.bin"
  ; .creep_2 incbin "data/creep_2.bin"
  ; .creep_3 incbin "data/creep_3.bin"
  ; .creep_4 incbin "data/creep_4.bin"
  ; .bouncer_1 incbin "data/bouncer_1.bin"
  ; .bouncer_2 incbin "data/bouncer_2.bin"
  ; .bouncer_3 incbin "data/bouncer_3.bin"
  ; .bouncer_4 incbin "data/bouncer_4.bin"
  ; .eye_1 incbin "data/eye_1.bin"
  ; .eye_2 incbin "data/eye_2.bin"
  ; .eye_3 incbin "data/eye_3.bin"
  ; .eye_4 incbin "data/eye_4.bin"
  ; .smurf_1 incbin "data/smurf_1.bin"
  ; .smurf_2 incbin "data/smurf_2.bin"
  ; .smurf_3 incbin "data/smurf_3.bin"
  ; .smurf_4 incbin "data/smurf_4.bin"
endAssets:


; segment .text

times (360*1024)-($-$$) db 0

