%include "sanyo.asm"

W equ 72
H equ 50
x: db 0
y: db 0
w: db W
h: db H

db 0

setup:
  mov si,img.keylock    ; first image
  xor bx,bx

repeat:
  push bx
  call calc_di
  mov bh,4              ; width in cols (1 col = 8px)
  mov bl,4              ; height in rows (1 row = 4px)
  call draw_pic
  pop bx
  add bl,4
  cmp bl,4*8
  jl repeat
  mov bl,0
  add bh,4
  cmp bh,4*12
  jl repeat

  

; ; PROBLEEM: omdat si>0xfff (4095) gaat er iets mis... greenwall_1 wordt niet of niet goed getekend.
; ; heeft dat met addressering te maken of ligt het aan het laden van de floppy..
; ; of nog iets anders?
; ; je ziet een andere afbeelding in gekke kleuren.
; ; volgens mij botst het met het groene videokanaal op 1C00:0000
; ; hmmm das wel gek want dat is veel verder in het geheugen pas op absolute positie 1C000 ...
; ; zou het kunnen dat de sectoren niet helemaal logisch doorlopen op de disk? voor/achterkant disk?
; ; ik zou een diff doen op de LST-file en het werkelijke memory uit MAME?


; zou het nog helpen als ik 1 bestand ipv kleine bestanden laadt
; en daar langsloop door SI te verhogen. Dan kan ik uitsluiten dat het niet aan
; de adressen ligt maar puur aan het lezen van de sectoren van de disk

  hlt

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
  mov ax, GREEN
  call draw_channel
  mov ax, BLUE
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
  add di,COLS*4-4*4
  pop cx
  loop .rows
  pop di
  ret	



; segment data

; times (1000)-($-$$) db 0

; SECTION Assets

startAssets:
img:
  .keylock incbin "data/keylock.bin"
  .key incbin "data/key.bin"
  .owl incbin "data/owl.bin"
  .crown incbin "data/crown.bin"
  .goblet incbin "data/goblet.bin"
  .ring incbin "data/ring.bin"
  .globe incbin "data/globe.bin"
  .feather incbin "data/feather.bin"
  .totum incbin "data/totum.bin"
  .scroll incbin "data/scroll.bin"
  .building incbin "data/building.bin"
  .mirror incbin "data/mirror.bin"
  .harp incbin "data/harp.bin"
  .nar incbin "data/nar.bin"
  .computer incbin "data/computer.bin"
  .way_down incbin "data/way_down.bin"
  .way_left incbin "data/way_left.bin"
  .way_up incbin "data/way_up.bin"
  .way_right incbin "data/way_right.bin"
  .pinkbox incbin "data/pinkbox.bin"
  .greenwall_1 incbin "data/greenwall_1.bin"
  .greenwall_2 incbin "data/greenwall_2.bin"
  .greenwall_3 incbin "data/greenwall_3.bin"
  .redwall_1 incbin "data/redwall_1.bin"
  .redwall_2 incbin "data/redwall_2.bin"
  .redwall_3 incbin "data/redwall_3.bin"
  .box incbin "data/box.bin"
  .vbar incbin "data/vbar.bin"
  .hbar incbin "data/hbar.bin"
  .treetop_1 incbin "data/treetop_1.bin"
  .treetop_2 incbin "data/treetop_2.bin"
  .treetop_3 incbin "data/treetop_3.bin"
  .treething incbin "data/treething.bin"
  .treetop_a incbin "data/treetop_a.bin"
  .treetop_b incbin "data/treetop_b.bin"
  .treeroot_a incbin "data/treeroot_a.bin"
  .treeroot_b incbin "data/treeroot_b.bin"
  .cactus_top incbin "data/cactus_top.bin"
  .cactus_bottom incbin "data/cactus_bottom.bin"
  .roof_1 incbin "data/roof_1.bin"
  .roof_2 incbin "data/roof_2.bin"
  .roof_3 incbin "data/roof_3.bin"
  .house1 incbin "data/house1.bin"
  .question incbin "data/question.bin"
  .stars_1 incbin "data/stars_1.bin"
  .stars_2 incbin "data/stars_2.bin"
  .stars_3 incbin "data/stars_3.bin"
  .stars_4 incbin "data/stars_4.bin"
  .walk_bw_1 incbin "data/walk_bw_1.bin"
  .walk_bw_2 incbin "data/walk_bw_2.bin"
  .walk_fw_1 incbin "data/walk_fw_1.bin"
  .walk_fw_2 incbin "data/walk_fw_2.bin"
  .walk_left_1 incbin "data/walk_left_1.bin"
  .walk_left_2 incbin "data/walk_left_2.bin"
  .walk_left_3 incbin "data/walk_left_3.bin"
  .walk_left_4 incbin "data/walk_left_4.bin"
  .walk_right_1 incbin "data/walk_right_1.bin"
  .walk_right_2 incbin "data/walk_right_2.bin"
  .walk_right_3 incbin "data/walk_right_3.bin"
  .walk_right_4 incbin "data/walk_right_4.bin"
  .stand_1 incbin "data/stand_1.bin"
  .stand_2 incbin "data/stand_2.bin"
  .stand_3 incbin "data/stand_3.bin"
  .stand_4 incbin "data/stand_4.bin"
  .donut_1 incbin "data/donut_1.bin"
  .donut_2 incbin "data/donut_2.bin"
  .donut_3 incbin "data/donut_3.bin"
  .donut_4 incbin "data/donut_4.bin"
  .sqr_ani_1 incbin "data/sqr_ani_1.bin"
  .sqr_ani_2 incbin "data/sqr_ani_2.bin"
  .sqr_ani_3 incbin "data/sqr_ani_3.bin"
  .sqr_ani_4 incbin "data/sqr_ani_4.bin"
  .flower_1 incbin "data/flower_1.bin"
  .flower_2 incbin "data/flower_2.bin"
  .flower_3 incbin "data/flower_3.bin"
  .flower_4 incbin "data/flower_4.bin"
  .explode_1 incbin "data/explode_1.bin"
  .explode_2 incbin "data/explode_2.bin"
  .explode_3 incbin "data/explode_3.bin"
  .explode_4 incbin "data/explode_4.bin"
  .creep_1 incbin "data/creep_1.bin"
  .creep_2 incbin "data/creep_2.bin"
  .creep_3 incbin "data/creep_3.bin"
  .creep_4 incbin "data/creep_4.bin"
  .bouncer_1 incbin "data/bouncer_1.bin"
  .bouncer_2 incbin "data/bouncer_2.bin"
  .bouncer_3 incbin "data/bouncer_3.bin"
  .bouncer_4 incbin "data/bouncer_4.bin"
  .eye_1 incbin "data/eye_1.bin"
  .eye_2 incbin "data/eye_2.bin"
  .eye_3 incbin "data/eye_3.bin"
  .eye_4 incbin "data/eye_4.bin"
  .smurf_1 incbin "data/smurf_1.bin"
  .smurf_2 incbin "data/smurf_2.bin"
  .smurf_3 incbin "data/smurf_3.bin"
  .smurf_4 incbin "data/smurf_4.bin"
endAssets:


; segment .text

times (360*1024)-($-$$) db 0

