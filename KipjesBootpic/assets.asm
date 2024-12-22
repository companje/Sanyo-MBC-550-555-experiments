kipjes: incbin "data/bg/kipjes576.bin"


font:
  incbin "data/font/chr32.bin"
  ; times 12 db 0b11111111,0b11100000 ; spatie is tijdelijk een blok
  incbin "data/font/chr33.bin"
  incbin "data/font/chr34.bin"
  incbin "data/font/chr35.bin"
  incbin "data/font/chr36.bin"
  incbin "data/font/chr37.bin"
  incbin "data/font/chr38.bin"
  incbin "data/font/chr39.bin"
  incbin "data/font/chr40.bin"
  incbin "data/font/chr41.bin"
  incbin "data/font/chr42.bin"
  incbin "data/font/chr43.bin"
  incbin "data/font/chr44.bin"
  incbin "data/font/chr45.bin"
  incbin "data/font/chr46.bin"
  incbin "data/font/chr47.bin"
  incbin "data/font/chr48.bin"
  incbin "data/font/chr49.bin"
  incbin "data/font/chr50.bin"
  incbin "data/font/chr51.bin"
  incbin "data/font/chr52.bin"
  incbin "data/font/chr53.bin"
  incbin "data/font/chr54.bin"
  incbin "data/font/chr55.bin"
  incbin "data/font/chr56.bin"
  incbin "data/font/chr57.bin"
  incbin "data/font/chr58.bin"
  incbin "data/font/chr59.bin"
  incbin "data/font/chr60.bin"
  incbin "data/font/chr61.bin"
  incbin "data/font/chr62.bin"
  incbin "data/font/chr63.bin"
  incbin "data/font/chr64.bin"
  incbin "data/font/chr65.bin"
  incbin "data/font/chr66.bin"
  incbin "data/font/chr67.bin"
  incbin "data/font/chr68.bin"
  incbin "data/font/chr69.bin"
  incbin "data/font/chr70.bin"
  incbin "data/font/chr71.bin"
  incbin "data/font/chr72.bin"
  incbin "data/font/chr73.bin"
  incbin "data/font/chr74.bin"
  incbin "data/font/chr75.bin"
  incbin "data/font/chr76.bin"
  incbin "data/font/chr77.bin"
  incbin "data/font/chr78.bin"
  incbin "data/font/chr79.bin"
  incbin "data/font/chr80.bin"
  incbin "data/font/chr81.bin"
  incbin "data/font/chr82.bin"
  incbin "data/font/chr83.bin"
  incbin "data/font/chr84.bin"
  incbin "data/font/chr85.bin"
  incbin "data/font/chr86.bin"
  incbin "data/font/chr87.bin"
  incbin "data/font/chr88.bin"
  incbin "data/font/chr89.bin"
  incbin "data/font/chr90.bin" ; Z

; donut: 
;   .size.w db 4
;   .size.h db 4
;   .pos.x db 0
;   .pos.y db 0
;   .vel.vx db -1
;   .vel.vy db 1
;   .frame db 0
;   .frames db 4
;   .framesize db 192
;   .data dw img.donut_1

; stars:
;   .size.w db 4
;   .size.h db 4
;   .pos.x db 4
;   .pos.y db 0
;   .vel.vx db 1
;   .vel.vy db 1
;   .frame db 0
;   .frames db 4
;   .framesize db 192
;   .data dw img.stars_1

; sqr_ani:
;   .size.w db 4
;   .size.h db 4
;   .pos.x db 8
;   .pos.y db 0
;   .vel.vx db 1
;   .vel.vy db -1
;   .frame db 0
;   .frames db 4
;   .framesize db 192
;   .data dw img.sqr_ani_1

; walk_fw:
;   .size.w db 4
;   .size.h db 4
;   .pos.x db 12
;   .pos.y db 0
;   .vel.vx db -1
;   .vel.vy db 1
;   .frame db 0
;   .frames db 2
;   .framesize db 192
;   .data dw img.walk_fw_1

; walk_bw:
;   .size.w db 4
;   .size.h db 4
;   .pos.x db 16
;   .pos.y db 0
;   .vel.vx db -1
;   .vel.vy db 1
;   .frame db 0
;   .frames db 2
;   .framesize db 192
;   .data dw img.walk_bw_1

; stand:
;   .size.w db 4
;   .size.h db 4
;   .pos.x db 20
;   .pos.y db 0
;   .vel.vx db 1
;   .vel.vy db -1
;   .frame db 0
;   .frames db 4
;   .framesize db 192
;   .data dw img.stand_1

; walk_left:
;   .size.w db 4
;   .size.h db 4
;   .pos.x db 24
;   .pos.y db 0
;   .vel.vx db 1
;   .vel.vy db 1
;   .frame db 0
;   .frames db 4
;   .framesize db 192
;   .data dw img.walk_left_1

; walk_right:
;   .size.w db 4
;   .size.h db 4
;   .pos.x db 28
;   .pos.y db 0
;   .vel.vx db 1
;   .vel.vy db -1
;   .frame db 0
;   .frames db 4
;   .framesize db 192
;   .data dw img.walk_right_1

; flower:
;   .size.w db 4
;   .size.h db 4
;   .pos.x db 32
;   .pos.y db 0
;   .vel.vx db 1
;   .vel.vy db 1
;   .frame db 0
;   .frames db 4
;   .framesize db 192
;   .data dw img.flower_1

; explode:
;   .size.w db 4
;   .size.h db 4
;   .pos.x db 36
;   .pos.y db 0
;   .vel.vx db 1
;   .vel.vy db 1
;   .frame db 0
;   .frames db 4
;   .framesize db 192
;   .data dw img.explode_1

; creep:
;   .size.w db 4
;   .size.h db 4
;   .pos.x db 40
;   .pos.y db 0
;   .vel.vx db -1
;   .vel.vy db -1
;   .frame db 0
;   .frames db 4
;   .framesize db 192
;   .data dw img.creep_1

; bouncer:
;   .size.w db 4
;   .size.h db 4
;   .pos.x db 44
;   .pos.y db 0
;   .vel.vx db 1
;   .vel.vy db 1
;   .frame db 0
;   .frames db 4
;   .framesize db 192
;   .data dw img.bouncer_1

; eye:
;   .size.w db 4
;   .size.h db 4
;   .pos.x db 48
;   .pos.y db 0
;   .vel.vx db -1
;   .vel.vy db 1
;   .frame db 0
;   .frames db 4
;   .framesize db 192
;   .data dw img.eye_1

; smurf_left:
;   .size.w db 4
;   .size.h db 4
;   .pos.x db 52
;   .pos.y db 0
;   .vel.vx db 1
;   .vel.vy db 1
;   .frame db 0
;   .frames db 2
;   .framesize db 192
;   .data dw img.smurf_1

; smurf_right:
;   .size.w db 4
;   .size.h db 4
;   .pos.x db 56
;   .pos.y db 0
;   .vel.vx db 1
;   .vel.vy db 1
;   .frame db 0
;   .frames db 2
;   .framesize db 192
;   .data dw img.smurf_3

; ghost:
;   .size.w db 4
;   .size.h db 4
;   .pos.x db 52
;   .pos.y db 4
;   .vel.vx db -1
;   .vel.vy db 1
;   .frame db 0
;   .frames db 4
;   .framesize db 192
;   .data dw img.ghost_1

; lobster_right:
;   .size.w db 4
;   .size.h db 4
;   .pos.x db 48
;   .pos.y db 4
;   .vel.vx db 1
;   .vel.vy db 1
;   .frame db 0
;   .frames db 2
;   .framesize db 192
;   .data dw img.lobster_3

; lobster_left:
;   .size.w db 4
;   .size.h db 4
;   .pos.x db 56
;   .pos.y db 4
;   .vel.vx db -1
;   .vel.vy db 1
;   .frame db 0
;   .frames db 2
;   .framesize db 192
;   .data dw img.lobster_1

; keylock:
;   .size.w db 4
;   .size.h db 4
;   .pos.x db 0
;   .pos.y db 4
;   .vel.vx db 1
;   .vel.vy db -1
;   .frame db 0
;   .frames db 1
;   .framesize db 192
;   .data dw img.keylock

; key:
;   .size.w db 4
;   .size.h db 4
;   .pos.x db 4
;   .pos.y db 4
;   .vel.vx db 1
;   .vel.vy db 1
;   .frame db 0
;   .frames db 1
;   .framesize db 192
;   .data dw img.key

; owl:
;   .size.w db 4
;   .size.h db 4
;   .pos.x db 8
;   .pos.y db 4
;   .vel.vx db 1
;   .vel.vy db 1
;   .frame db 0
;   .frames db 1
;   .framesize db 192
;   .data dw img.owl

; crown:
;   .size.w db 4
;   .size.h db 4
;   .pos.x db 12
;   .pos.y db 4
;   .vel.vx db -1
;   .vel.vy db 1
;   .frame db 0
;   .frames db 1
;   .framesize db 192
;   .data dw img.crown

; goblet:
;   .size.w db 4
;   .size.h db 4
;   .pos.x db 16
;   .pos.y db 4
;   .vel.vx db 1
;   .vel.vy db -1
;   .frame db 0
;   .frames db 1
;   .framesize db 192
;   .data dw img.goblet

; ring:
;   .size.w db 4
;   .size.h db 4
;   .pos.x db 20
;   .pos.y db 4
;   .vel.vx db 1
;   .vel.vy db 1
;   .frame db 0
;   .frames db 1
;   .framesize db 192
;   .data dw img.ring

; globe:
;   .size.w db 4
;   .size.h db 4
;   .pos.x db 24
;   .pos.y db 4
;   .vel.vx db 1
;   .vel.vy db 1
;   .frame db 0
;   .frames db 1
;   .framesize db 192
;   .data dw img.globe

; feather:
;   .size.w db 4
;   .size.h db 4
;   .pos.x db 28
;   .pos.y db 4
;   .vel.vx db -1
;   .vel.vy db 1
;   .frame db 0
;   .frames db 1
;   .framesize db 192
;   .data dw img.feather

; totum:
;   .size.w db 4
;   .size.h db 4
;   .pos.x db 32
;   .pos.y db 4
;   .vel.vx db 1
;   .vel.vy db 1
;   .frame db 0
;   .frames db 1
;   .framesize db 192
;   .data dw img.totum

; building:
;   .size.w db 4
;   .size.h db 4
;   .pos.x db 36
;   .pos.y db 4
;   .vel.vx db 1
;   .vel.vy db 1
;   .frame db 0
;   .frames db 1
;   .framesize db 192
;   .data dw img.building

; mirror:
;   .size.w db 4
;   .size.h db 4
;   .pos.x db 40
;   .pos.y db 4
;   .vel.vx db 1
;   .vel.vy db -1
;   .frame db 0
;   .frames db 1
;   .framesize db 192
;   .data dw img.mirror

; harp:
;   .size.w db 4
;   .size.h db 4
;   .pos.x db 44
;   .pos.y db 4
;   .vel.vx db 1
;   .vel.vy db 1
;   .frame db 0
;   .frames db 1
;   .framesize db 192
;   .data dw img.harp

; nar:
;   .size.w db 4
;   .size.h db 4
;   .pos.x db 44
;   .pos.y db 4
;   .vel.vx db 1
;   .vel.vy db 1
;   .frame db 0
;   .frames db 1
;   .framesize db 192
;   .data dw img.harp

; computer:
;   .size.w db 4
;   .size.h db 4
;   .pos.x db 0
;   .pos.y db 8
;   .vel.vx db -1
;   .vel.vy db 1
;   .frame db 0
;   .frames db 1
;   .framesize db 192
;   .data dw img.computer

; way_down:
;   .size.w db 4
;   .size.h db 4
;   .pos.x db 8
;   .pos.y db 8
;   .vel.vx db -1
;   .vel.vy db -1
;   .frame db 0
;   .frames db 1
;   .framesize db 192
;   .data dw img.way_down

; way_left:
;   .size.w db 4
;   .size.h db 4
;   .pos.x db 4
;   .pos.y db 8
;   .vel.vx db 1
;   .vel.vy db 1
;   .frame db 0
;   .frames db 1
;   .framesize db 192
;   .data dw img.way_left

; way_up:
;   .size.w db 4
;   .size.h db 4
;   .pos.x db 12
;   .pos.y db 8
;   .vel.vx db 1
;   .vel.vy db 1
;   .frame db 0
;   .frames db 1
;   .framesize db 192
;   .data dw img.way_up

; way_right:
;   .size.w db 4
;   .size.h db 4
;   .pos.x db 16
;   .pos.y db 8
;   .vel.vx db -1
;   .vel.vy db 1
;   .frame db 0
;   .frames db 1
;   .framesize db 192
;   .data dw img.way_right

; pinkbox:
;   .size.w db 4
;   .size.h db 4
;   .pos.x db 20
;   .pos.y db 8
;   .vel.vx db 1
;   .vel.vy db 1
;   .frame db 0
;   .frames db 1
;   .framesize db 192
;   .data dw img.pinkbox

; box:
;   .size.w db 4
;   .size.h db 4
;   .pos.x db 24
;   .pos.y db 8
;   .vel.vx db 1
;   .vel.vy db 1
;   .frame db 0
;   .frames db 1
;   .framesize db 192
;   .data dw img.box

; vbar:
;   .size.w db 4
;   .size.h db 4
;   .pos.x db 28
;   .pos.y db 8
;   .vel.vx db 1
;   .vel.vy db 1
;   .frame db 0
;   .frames db 1
;   .framesize db 192
;   .data dw img.vbar

; hbar:
;   .size.w db 4
;   .size.h db 4
;   .pos.x db 32
;   .pos.y db 8
;   .vel.vx db -1
;   .vel.vy db -1
;   .frame db 0
;   .frames db 1
;   .framesize db 192
;   .data dw img.hbar

; question:
;   .size.w db 4
;   .size.h db 4
;   .pos.x db 36
;   .pos.y db 8
;   .vel.vx db 1
;   .vel.vy db 1
;   .frame db 0
;   .frames db 1
;   .framesize db 192
;   .data dw img.question

; house1:
;   .size.w db 4
;   .size.h db 4
;   .pos.x db 40
;   .pos.y db 8
;   .vel.vx db 1
;   .vel.vy db 1
;   .frame db 0
;   .frames db 1
;   .framesize db 192
;   .data dw img.house1


donut: 
  .size.w db 4
  .size.h db 4
  .pos.x db 12
  .pos.y db 23
  .vel.vx db -1
  .vel.vy db 1
  .frame db 0
  .frames db 4
  .framesize db 192
  .data dw img.donut_1

stars:
  .size.w db 4
  .size.h db 4
  .pos.x db 33
  .pos.y db 8
  .vel.vx db 1
  .vel.vy db 1
  .frame db 0
  .frames db 4
  .framesize db 192
  .data dw img.stars_1

sqr_ani:
  .size.w db 4
  .size.h db 4
  .pos.x db 20
  .pos.y db 17
  .vel.vx db 1
  .vel.vy db -1
  .frame db 0
  .frames db 4
  .framesize db 192
  .data dw img.sqr_ani_1

walk_fw:
  .size.w db 4
  .size.h db 4
  .pos.x db 42
  .pos.y db 5
  .vel.vx db -1
  .vel.vy db 1
  .frame db 0
  .frames db 2
  .framesize db 192
  .data dw img.walk_fw_1

walk_bw:
  .size.w db 4
  .size.h db 4
  .pos.x db 38
  .pos.y db 29
  .vel.vx db -1
  .vel.vy db 1
  .frame db 0
  .frames db 2
  .framesize db 192
  .data dw img.walk_bw_1

stand:
  .size.w db 4
  .size.h db 4
  .pos.x db 5
  .pos.y db 36
  .vel.vx db 1
  .vel.vy db -1
  .frame db 0
  .frames db 4
  .framesize db 192
  .data dw img.stand_1

walk_left:
  .size.w db 4
  .size.h db 4
  .pos.x db 31
  .pos.y db 19
  .vel.vx db 1
  .vel.vy db 1
  .frame db 0
  .frames db 4
  .framesize db 192
  .data dw img.walk_left_1

walk_right:
  .size.w db 4
  .size.h db 4
  .pos.x db 29
  .pos.y db 13
  .vel.vx db 1
  .vel.vy db -1
  .frame db 0
  .frames db 4
  .framesize db 192
  .data dw img.walk_right_1

flower:
  .size.w db 4
  .size.h db 4
  .pos.x db 60
  .pos.y db 34
  .vel.vx db 1
  .vel.vy db 1
  .frame db 0
  .frames db 4
  .framesize db 192
  .data dw img.flower_1

explode:
  .size.w db 4
  .size.h db 4
  .pos.x db 47
  .pos.y db 11
  .vel.vx db 1
  .vel.vy db 1
  .frame db 0
  .frames db 4
  .framesize db 192
  .data dw img.explode_1

creep:
  .size.w db 4
  .size.h db 4
  .pos.x db 50
  .pos.y db 21
  .vel.vx db -1
  .vel.vy db -1
  .frame db 0
  .frames db 4
  .framesize db 192
  .data dw img.creep_1

bouncer:
  .size.w db 4
  .size.h db 4
  .pos.x db 39
  .pos.y db 14
  .vel.vx db 1
  .vel.vy db 1
  .frame db 0
  .frames db 4
  .framesize db 192
  .data dw img.bouncer_1

eye:
  .size.w db 4
  .size.h db 4
  .pos.x db 22
  .pos.y db 9
  .vel.vx db -1
  .vel.vy db 1
  .frame db 0
  .frames db 4
  .framesize db 192
  .data dw img.eye_1

smurf_left:
  .size.w db 4
  .size.h db 4
  .pos.x db 14
  .pos.y db 28
  .vel.vx db 1
  .vel.vy db 1
  .frame db 0
  .frames db 2
  .framesize db 192
  .data dw img.smurf_1

smurf_right:
  .size.w db 4
  .size.h db 4
  .pos.x db 61
  .pos.y db 15
  .vel.vx db 1
  .vel.vy db 1
  .frame db 0
  .frames db 2
  .framesize db 192
  .data dw img.smurf_3

ghost:
  .size.w db 4
  .size.h db 4
  .pos.x db 46
  .pos.y db 31
  .vel.vx db -1
  .vel.vy db 1
  .frame db 0
  .frames db 4
  .framesize db 192
  .data dw img.ghost_1

lobster_right:
  .size.w db 4
  .size.h db 4
  .pos.x db 35
  .pos.y db 40
  .vel.vx db 1
  .vel.vy db 1
  .frame db 0
  .frames db 2
  .framesize db 192
  .data dw img.lobster_3

lobster_left:
  .size.w db 4
  .size.h db 4
  .pos.x db 9
  .pos.y db 12
  .vel.vx db -1
  .vel.vy db 1
  .frame db 0
  .frames db 2
  .framesize db 192
  .data dw img.lobster_1

keylock:
  .size.w db 4
  .size.h db 4
  .pos.x db 17
  .pos.y db 25
  .vel.vx db 1
  .vel.vy db -1
  .frame db 0
  .frames db 1
  .framesize db 192
  .data dw img.keylock

key:
  .size.w db 4
  .size.h db 4
  .pos.x db 27
  .pos.y db 37
  .vel.vx db 1
  .vel.vy db 1
  .frame db 0
  .frames db 1
  .framesize db 192
  .data dw img.key

owl:
  .size.w db 4
  .size.h db 4
  .pos.x db 31
  .pos.y db 5
  .vel.vx db 1
  .vel.vy db 1
  .frame db 0
  .frames db 1
  .framesize db 192
  .data dw img.owl

crown:
  .size.w db 4
  .size.h db 4
  .pos.x db 40
  .pos.y db 18
  .vel.vx db -1
  .vel.vy db 1
  .frame db 0
  .frames db 1
  .framesize db 192
  .data dw img.crown

goblet:
  .size.w db 4
  .size.h db 4
  .pos.x db 13
  .pos.y db 39
  .vel.vx db 1
  .vel.vy db -1
  .frame db 0
  .frames db 1
  .framesize db 192
  .data dw img.goblet

ring:
  .size.w db 4
  .size.h db 4
  .pos.x db 8
  .pos.y db 20
  .vel.vx db 1
  .vel.vy db 1
  .frame db 0
  .frames db 1
  .framesize db 192
  .data dw img.ring

globe:
  .size.w db 4
  .size.h db 4
  .pos.x db 5
  .pos.y db 35
  .vel.vx db 1
  .vel.vy db 1
  .frame db 0
  .frames db 1
  .framesize db 192
  .data dw img.globe

feather:
  .size.w db 4
  .size.h db 4
  .pos.x db 32
  .pos.y db 8
  .vel.vx db -1
  .vel.vy db 1
  .frame db 0
  .frames db 1
  .framesize db 192
  .data dw img.feather

totum:
  .size.w db 4
  .size.h db 4
  .pos.x db 25
  .pos.y db 13
  .vel.vx db 1
  .vel.vy db 1
  .frame db 0
  .frames db 1
  .framesize db 192
  .data dw img.totum

building:
  .size.w db 4
  .size.h db 4
  .pos.x db 18
  .pos.y db 30
  .vel.vx db 1
  .vel.vy db 1
  .frame db 0
  .frames db 1
  .framesize db 192
  .data dw img.building

mirror:
  .size.w db 4
  .size.h db 4
  .pos.x db 12
  .pos.y db 29
  .vel.vx db 1
  .vel.vy db -1
  .frame db 0
  .frames db 1
  .framesize db 192
  .data dw img.mirror

harp:
  .size.w db 4
  .size.h db 4
  .pos.x db 36
  .pos.y db 27
  .vel.vx db 1
  .vel.vy db 1
  .frame db 0
  .frames db 1
  .framesize db 192
  .data dw img.harp

nar:
  .size.w db 4
  .size.h db 4
  .pos.x db 24
  .pos.y db 31
  .vel.vx db 1
  .vel.vy db 1
  .frame db 0
  .frames db 1
  .framesize db 192
  .data dw img.harp

computer:
  .size.w db 4
  .size.h db 4
  .pos.x db 7
  .pos.y db 40
  .vel.vx db -1
  .vel.vy db 1
  .frame db 0
  .frames db 1
  .framesize db 192
  .data dw img.computer

way_down:
  .size.w db 4
  .size.h db 4
  .pos.x db 44
  .pos.y db 9
  .vel.vx db -1
  .vel.vy db -1
  .frame db 0
  .frames db 1
  .framesize db 192
  .data dw img.way_down

way_left:
  .size.w db 4
  .size.h db 4
  .pos.x db 35
  .pos.y db 26
  .vel.vx db 1
  .vel.vy db 1
  .frame db 0
  .frames db 1
  .framesize db 192
  .data dw img.way_left

way_up:
  .size.w db 4
  .size.h db 4
  .pos.x db 22
  .pos.y db 30
  .vel.vx db 1
  .vel.vy db 1
  .frame db 0
  .frames db 1
  .framesize db 192
  .data dw img.way_up

way_right:
  .size.w db 4
  .size.h db 4
  .pos.x db 9
  .pos.y db 25
  .vel.vx db -1
  .vel.vy db 1
  .frame db 0
  .frames db 1
  .framesize db 192
  .data dw img.way_right

pinkbox:
  .size.w db 4
  .size.h db 4
  .pos.x db 16
  .pos.y db 13
  .vel.vx db 0
  .vel.vy db 0
  .frame db 0
  .frames db 1
  .framesize db 192
  .data dw img.pinkbox

box:
  .size.w db 4
  .size.h db 4
  .pos.x db 23
  .pos.y db 16
  .vel.vx db 1
  .vel.vy db 1
  .frame db 0
  .frames db 1
  .framesize db 192
  .data dw img.box

vbar:
  .size.w db 4
  .size.h db 4
  .pos.x db 11
  .pos.y db 28
  .vel.vx db 1
  .vel.vy db 1
  .frame db 0
  .frames db 1
  .framesize db 192
  .data dw img.vbar

hbar:
  .size.w db 4
  .size.h db 4
  .pos.x db 30
  .pos.y db 8
  .vel.vx db -1
  .vel.vy db -1
  .frame db 0
  .frames db 1
  .framesize db 192
  .data dw img.hbar

question:
  .size.w db 4
  .size.h db 4
  .pos.x db 8
  .pos.y db 36
  .vel.vx db 1
  .vel.vy db 1
  .frame db 0
  .frames db 1
  .framesize db 192
  .data dw img.question

house1:
  .size.w db 4
  .size.h db 4
  .pos.x db 18
  .pos.y db 15
  .vel.vx db 1
  .vel.vy db 1
  .frame db 0
  .frames db 1
  .framesize db 192
  .data dw img.house1



greenwall_1:

greenwall_2:

greenwall_3:

redwall_1:

redwall_2:

redwall_3:

treetop_1:

treetop_2:

treetop_3:

treething:

treetop_a:

treetop_b:

treeroot_a:

treeroot_b:

cactus_top:

cactus_bottom:

roof_1:

roof_2:

roof_3:



img:
  .keylock incbin "data/sprites/keylock.bin"
  .key incbin "data/sprites/key.bin"
  .owl incbin "data/sprites/owl.bin"
  .crown incbin "data/sprites/crown.bin"
  .goblet incbin "data/sprites/goblet.bin"
  .ring incbin "data/sprites/ring.bin"
  .globe incbin "data/sprites/globe.bin"
  .feather incbin "data/sprites/feather.bin"
  .totum incbin "data/sprites/totum.bin"
  .scroll incbin "data/sprites/scroll.bin"
  .building incbin "data/sprites/building.bin"
  .mirror incbin "data/sprites/mirror.bin"
  .harp incbin "data/sprites/harp.bin"
  .nar incbin "data/sprites/nar.bin"
  .computer incbin "data/sprites/computer.bin"
  .way_down incbin "data/sprites/way_down.bin"
  .way_left incbin "data/sprites/way_left.bin"
  .way_up incbin "data/sprites/way_up.bin"
  .way_right incbin "data/sprites/way_right.bin"
  .pinkbox incbin "data/sprites/pinkbox.bin"
  .greenwall_1 incbin "data/sprites/greenwall_1.bin"
  .greenwall_2 incbin "data/sprites/greenwall_2.bin"
  .greenwall_3 incbin "data/sprites/greenwall_3.bin"
  .redwall_1 incbin "data/sprites/redwall_1.bin"
  .redwall_2 incbin "data/sprites/redwall_2.bin"
  .redwall_3 incbin "data/sprites/redwall_3.bin"
  .box incbin "data/sprites/box.bin"
  .vbar incbin "data/sprites/vbar.bin"
  .hbar incbin "data/sprites/hbar.bin"
  .treetop_1 incbin "data/sprites/treetop_1.bin"
  .treetop_2 incbin "data/sprites/treetop_2.bin"
  .treetop_3 incbin "data/sprites/treetop_3.bin"
  .treething incbin "data/sprites/treething.bin"
  .treetop_a incbin "data/sprites/treetop_a.bin"
  .treetop_b incbin "data/sprites/treetop_b.bin"
  .treeroot_a incbin "data/sprites/treeroot_a.bin"
  .treeroot_b incbin "data/sprites/treeroot_b.bin"
  .cactus_top incbin "data/sprites/cactus_top.bin"
  .cactus_bottom incbin "data/sprites/cactus_bottom.bin"
  .roof_1 incbin "data/sprites/roof_1.bin"
  .roof_2 incbin "data/sprites/roof_2.bin"
  .roof_3 incbin "data/sprites/roof_3.bin"
  .house1 incbin "data/sprites/house1.bin"
  .question incbin "data/sprites/question.bin"
  .stars_1 incbin "data/sprites/stars_1.bin"
  .stars_2 incbin "data/sprites/stars_2.bin"
  .stars_3 incbin "data/sprites/stars_3.bin"
  .stars_4 incbin "data/sprites/stars_4.bin"
  .walk_bw_1 incbin "data/sprites/walk_bw_1.bin"
  .walk_bw_2 incbin "data/sprites/walk_bw_2.bin"
  .walk_fw_1 incbin "data/sprites/walk_fw_1.bin"
  .walk_fw_2 incbin "data/sprites/walk_fw_2.bin"
  .walk_left_1 incbin "data/sprites/walk_left_1.bin"
  .walk_left_2 incbin "data/sprites/walk_left_2.bin"
  .walk_left_3 incbin "data/sprites/walk_left_3.bin"
  .walk_left_4 incbin "data/sprites/walk_left_4.bin"
  .walk_right_1 incbin "data/sprites/walk_right_1.bin"
  .walk_right_2 incbin "data/sprites/walk_right_2.bin"
  .walk_right_3 incbin "data/sprites/walk_right_3.bin"
  .walk_right_4 incbin "data/sprites/walk_right_4.bin"
  .stand_1 incbin "data/sprites/stand_1.bin"
  .stand_2 incbin "data/sprites/stand_2.bin"
  .stand_3 incbin "data/sprites/stand_3.bin"
  .stand_4 incbin "data/sprites/stand_4.bin"
  .donut_1 incbin "data/sprites/donut_1.bin"
  .donut_2 incbin "data/sprites/donut_2.bin"
  .donut_3 incbin "data/sprites/donut_3.bin"
  .donut_4 incbin "data/sprites/donut_4.bin"
  .sqr_ani_1 incbin "data/sprites/sqr_ani_1.bin"
  .sqr_ani_2 incbin "data/sprites/sqr_ani_2.bin"
  .sqr_ani_3 incbin "data/sprites/sqr_ani_3.bin"
  .sqr_ani_4 incbin "data/sprites/sqr_ani_4.bin"
  .flower_1 incbin "data/sprites/flower_1.bin"
  .flower_2 incbin "data/sprites/flower_2.bin"
  .flower_3 incbin "data/sprites/flower_3.bin"
  .flower_4 incbin "data/sprites/flower_4.bin"
  .explode_1 incbin "data/sprites/explode_1.bin"
  .explode_2 incbin "data/sprites/explode_2.bin"
  .explode_3 incbin "data/sprites/explode_3.bin"
  .explode_4 incbin "data/sprites/explode_4.bin"
  .creep_1 incbin "data/sprites/creep_1.bin"
  .creep_2 incbin "data/sprites/creep_2.bin"
  .creep_3 incbin "data/sprites/creep_3.bin"
  .creep_4 incbin "data/sprites/creep_4.bin"
  .bouncer_1 incbin "data/sprites/bouncer_1.bin"
  .bouncer_2 incbin "data/sprites/bouncer_2.bin"
  .bouncer_3 incbin "data/sprites/bouncer_3.bin"
  .bouncer_4 incbin "data/sprites/bouncer_4.bin"
  .eye_1 incbin "data/sprites/eye_1.bin"
  .eye_2 incbin "data/sprites/eye_2.bin"
  .eye_3 incbin "data/sprites/eye_3.bin"
  .eye_4 incbin "data/sprites/eye_4.bin"
  .smurf_1 incbin "data/sprites/smurf_1.bin"
  .smurf_2 incbin "data/sprites/smurf_2.bin"
  .smurf_3 incbin "data/sprites/smurf_3.bin"
  .smurf_4 incbin "data/sprites/smurf_4.bin"

  .ghost_1 incbin "data/sprites/ghost_1.bin"
  .ghost_2 incbin "data/sprites/ghost_2.bin"
  .ghost_3 incbin "data/sprites/ghost_3.bin"
  .ghost_4 incbin "data/sprites/ghost_4.bin"

  .lobster_1 incbin "data/sprites/lobster_1.bin"
  .lobster_2 incbin "data/sprites/lobster_2.bin"
  .lobster_3 incbin "data/sprites/lobster_3.bin"
  .lobster_4 incbin "data/sprites/lobster_4.bin"

