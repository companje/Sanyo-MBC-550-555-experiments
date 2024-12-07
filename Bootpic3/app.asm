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

times (180*1024)-($-$$) db 0




  
; times 512 db 65
; times 512 db 66
; times 512 db 67
; times 512 db 68
; times 512 db 69
; times 512 db 70
; times 512 db 71
; times 512 db 72
; times 512 db 73
; times 512 db 74
; times 512 db 75
; times 512 db 76
; times 512 db 77
; times 512 db 78
; times 512 db 79
; times 512 db 80
; times 512 db 81
; times 512 db 82
; times 512 db 83
; times 512 db 84
; times 512 db 85
; times 512 db 86
; times 512 db 87
; times 512 db 88
; times 512 db 89
; times 512 db 90
; times 512 db 91
; times 512 db 92
; times 512 db 93
; times 512 db 94
; times 512 db 95
; times 512 db 96
; times 512 db 97
; times 512 db 98
; times 512 db 99
; times 512 db 100
; times 512 db 101
; times 512 db 102
; times 512 db 103
; times 512 db 104
; times 512 db 105
; times 512 db 106
; times 512 db 107
; times 512 db 108
; times 512 db 109
; times 512 db 110
; times 512 db 111
; times 512 db 112
; times 512 db 113
; times 512 db 114
; times 512 db 115
; times 512 db 116
; times 512 db 117
; times 512 db 118
; times 512 db 119
; times 512 db 120
; times 512 db 121
; times 512 db 122
; times 512 db 123
; times 512 db 124
; times 512 db 125
; times 512 db 126
; times 512 db 127
; times 512 db 128
; times 512 db 129
; times 512 db 130
; times 512 db 131
; times 512 db 132
; times 512 db 133
; times 512 db 134
; times 512 db 135
; times 512 db 136
; times 512 db 137
; times 512 db 138
; times 512 db 139
; times 512 db 140
; times 512 db 141
; times 512 db 142
; times 512 db 143
; times 512 db 144
; times 512 db 145
; times 512 db 146
; times 512 db 147
; times 512 db 148
; times 512 db 149
; times 512 db 150
; times 512 db 151
; times 512 db 152
; times 512 db 153
; times 512 db 154
; times 512 db 155
; times 512 db 156
; times 512 db 157
; times 512 db 158
; times 512 db 159
; times 512 db 160
; times 512 db 161
; times 512 db 162
; times 512 db 163
; times 512 db 164
; times 512 db 165
; times 512 db 166
; times 512 db 167
; times 512 db 168
; times 512 db 169
; times 512 db 170
; times 512 db 171
; times 512 db 172
; times 512 db 173
; times 512 db 174
; times 512 db 175
; times 512 db 176
; times 512 db 177
; times 512 db 178
; times 512 db 179
; times 512 db 180
; times 512 db 181
; times 512 db 182
; times 512 db 183
; times 512 db 184
; times 512 db 185
; times 512 db 186
; times 512 db 187
; times 512 db 188
; times 512 db 189
; times 512 db 190
; times 512 db 191
; times 512 db 192
; times 512 db 193
; times 512 db 194
; times 512 db 195
; times 512 db 196
; times 512 db 197
; times 512 db 198
; times 512 db 199
; times 512 db 200
; times 512 db 201
; times 512 db 202
; times 512 db 203
; times 512 db 204
; times 512 db 205
; times 512 db 206
; times 512 db 207


