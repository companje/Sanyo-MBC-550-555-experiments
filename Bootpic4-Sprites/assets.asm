donut: 
  .size.w db 4
  .size.h db 4
  .pos.x db 0
  .pos.y db 0
  .vel.vx db 0
  .vel.vy db 0
  .frame db 0
  .frames db 4
  .framesize db 192
  .data dw img.donut_1

stars:
  .size.w db 4
  .size.h db 4
  .pos.x db 4
  .pos.y db 0
  .vel.vx db 0
  .vel.vy db 0
  .frame db 0
  .frames db 4
  .framesize db 192
  .data dw img.stars_1

sqr_ani:
  .size.w db 4
  .size.h db 4
  .pos.x db 8
  .pos.y db 0
  .vel.vx db 0
  .vel.vy db 0
  .frame db 0
  .frames db 4
  .framesize db 192
  .data dw img.sqr_ani_1

walk_fw:
  .size.w db 4
  .size.h db 4
  .pos.x db 12
  .pos.y db 0
  .vel.vx db 0
  .vel.vy db 0
  .frame db 0
  .frames db 2
  .framesize db 192
  .data dw img.walk_fw_1

walk_bw:
  .size.w db 4
  .size.h db 4
  .pos.x db 16
  .pos.y db 0
  .vel.vx db 0
  .vel.vy db 0
  .frame db 0
  .frames db 2
  .framesize db 192
  .data dw img.walk_bw_1

stand:
  .size.w db 4
  .size.h db 4
  .pos.x db 20
  .pos.y db 0
  .vel.vx db 0
  .vel.vy db 0
  .frame db 0
  .frames db 4
  .framesize db 192
  .data dw img.stand_1

walk_left:
  .size.w db 4
  .size.h db 4
  .pos.x db 24
  .pos.y db 0
  .vel.vx db 0
  .vel.vy db 0
  .frame db 0
  .frames db 4
  .framesize db 192
  .data dw img.walk_left_1

walk_right:
  .size.w db 4
  .size.h db 4
  .pos.x db 28
  .pos.y db 0
  .vel.vx db 0
  .vel.vy db 0
  .frame db 0
  .frames db 4
  .framesize db 192
  .data dw img.walk_right_1

flower:
  .size.w db 4
  .size.h db 4
  .pos.x db 32
  .pos.y db 0
  .vel.vx db 0
  .vel.vy db 0
  .frame db 0
  .frames db 4
  .framesize db 192
  .data dw img.flower_1

explode:
  .size.w db 4
  .size.h db 4
  .pos.x db 36
  .pos.y db 0
  .vel.vx db 0
  .vel.vy db 0
  .frame db 0
  .frames db 4
  .framesize db 192
  .data dw img.explode_1

creep:
  .size.w db 4
  .size.h db 4
  .pos.x db 40
  .pos.y db 0
  .vel.vx db 0
  .vel.vy db 0
  .frame db 0
  .frames db 4
  .framesize db 192
  .data dw img.creep_1

bouncer:
  .size.w db 4
  .size.h db 4
  .pos.x db 44
  .pos.y db 0
  .vel.vx db 0
  .vel.vy db 0
  .frame db 0
  .frames db 4
  .framesize db 192
  .data dw img.bouncer_1

eye:
  .size.w db 4
  .size.h db 4
  .pos.x db 48
  .pos.y db 0
  .vel.vx db 0
  .vel.vy db 0
  .frame db 0
  .frames db 4
  .framesize db 192
  .data dw img.eye_1

smurf_left:
  .size.w db 4
  .size.h db 4
  .pos.x db 52
  .pos.y db 0
  .vel.vx db 0
  .vel.vy db 0
  .frame db 0
  .frames db 2
  .framesize db 192
  .data dw img.smurf_1

smurf_right:
  .size.w db 4
  .size.h db 4
  .pos.x db 56
  .pos.y db 0
  .vel.vx db 0
  .vel.vy db 0
  .frame db 0
  .frames db 2
  .framesize db 192
  .data dw img.smurf_3

ghost:
  .size.w db 4
  .size.h db 4
  .pos.x db 52
  .pos.y db 4
  .vel.vx db 0
  .vel.vy db 0
  .frame db 0
  .frames db 4
  .framesize db 192
  .data dw img.ghost_1

lobster_right:
  .size.w db 4
  .size.h db 4
  .pos.x db 48
  .pos.y db 4
  .vel.vx db 0
  .vel.vy db 0
  .frame db 0
  .frames db 2
  .framesize db 192
  .data dw img.lobster_3

lobster_left:
  .size.w db 4
  .size.h db 4
  .pos.x db 56
  .pos.y db 4
  .vel.vx db 0
  .vel.vy db 0
  .frame db 0
  .frames db 2
  .framesize db 192
  .data dw img.lobster_1

keylock:
  .size.w db 4
  .size.h db 4
  .pos.x db 0
  .pos.y db 4
  .vel.vx db 0
  .vel.vy db 0
  .frame db 0
  .frames db 1
  .framesize db 192
  .data dw img.keylock

key:
  .size.w db 4
  .size.h db 4
  .pos.x db 4
  .pos.y db 4
  .vel.vx db 0
  .vel.vy db 0
  .frame db 0
  .frames db 1
  .framesize db 192
  .data dw img.key

owl:
  .size.w db 4
  .size.h db 4
  .pos.x db 8
  .pos.y db 4
  .vel.vx db 0
  .vel.vy db 0
  .frame db 0
  .frames db 1
  .framesize db 192
  .data dw img.owl

crown:
  .size.w db 4
  .size.h db 4
  .pos.x db 12
  .pos.y db 4
  .vel.vx db 0
  .vel.vy db 0
  .frame db 0
  .frames db 1
  .framesize db 192
  .data dw img.crown

goblet:
  .size.w db 4
  .size.h db 4
  .pos.x db 16
  .pos.y db 4
  .vel.vx db 0
  .vel.vy db 0
  .frame db 0
  .frames db 1
  .framesize db 192
  .data dw img.goblet

ring:
  .size.w db 4
  .size.h db 4
  .pos.x db 20
  .pos.y db 4
  .vel.vx db 0
  .vel.vy db 0
  .frame db 0
  .frames db 1
  .framesize db 192
  .data dw img.ring

globe:
  .size.w db 4
  .size.h db 4
  .pos.x db 24
  .pos.y db 4
  .vel.vx db 0
  .vel.vy db 0
  .frame db 0
  .frames db 1
  .framesize db 192
  .data dw img.globe

feather:
  .size.w db 4
  .size.h db 4
  .pos.x db 28
  .pos.y db 4
  .vel.vx db 0
  .vel.vy db 0
  .frame db 0
  .frames db 1
  .framesize db 192
  .data dw img.feather

totum:
  .size.w db 4
  .size.h db 4
  .pos.x db 32
  .pos.y db 4
  .vel.vx db 0
  .vel.vy db 0
  .frame db 0
  .frames db 1
  .framesize db 192
  .data dw img.totum

building:
  .size.w db 4
  .size.h db 4
  .pos.x db 36
  .pos.y db 4
  .vel.vx db 0
  .vel.vy db 0
  .frame db 0
  .frames db 1
  .framesize db 192
  .data dw img.building

mirror:
  .size.w db 4
  .size.h db 4
  .pos.x db 40
  .pos.y db 4
  .vel.vx db 0
  .vel.vy db 0
  .frame db 0
  .frames db 1
  .framesize db 192
  .data dw img.mirror

harp:
  .size.w db 4
  .size.h db 4
  .pos.x db 44
  .pos.y db 4
  .vel.vx db 0
  .vel.vy db 0
  .frame db 0
  .frames db 1
  .framesize db 192
  .data dw img.harp

nar:
  .size.w db 4
  .size.h db 4
  .pos.x db 44
  .pos.y db 4
  .vel.vx db 0
  .vel.vy db 0
  .frame db 0
  .frames db 1
  .framesize db 192
  .data dw img.harp

computer:
  .size.w db 4
  .size.h db 4
  .pos.x db 0
  .pos.y db 8
  .vel.vx db 0
  .vel.vy db 0
  .frame db 0
  .frames db 1
  .framesize db 192
  .data dw img.computer

way_down:
  .size.w db 4
  .size.h db 4
  .pos.x db 8
  .pos.y db 8
  .vel.vx db 0
  .vel.vy db 0
  .frame db 0
  .frames db 1
  .framesize db 192
  .data dw img.way_down

way_left:
  .size.w db 4
  .size.h db 4
  .pos.x db 4
  .pos.y db 8
  .vel.vx db 0
  .vel.vy db 0
  .frame db 0
  .frames db 1
  .framesize db 192
  .data dw img.way_left

way_up:
  .size.w db 4
  .size.h db 4
  .pos.x db 12
  .pos.y db 8
  .vel.vx db 0
  .vel.vy db 0
  .frame db 0
  .frames db 1
  .framesize db 192
  .data dw img.way_up

way_right:
  .size.w db 4
  .size.h db 4
  .pos.x db 16
  .pos.y db 8
  .vel.vx db 0
  .vel.vy db 0
  .frame db 0
  .frames db 1
  .framesize db 192
  .data dw img.way_right

pinkbox:
  .size.w db 4
  .size.h db 4
  .pos.x db 20
  .pos.y db 8
  .vel.vx db 0
  .vel.vy db 0
  .frame db 0
  .frames db 1
  .framesize db 192
  .data dw img.pinkbox

box:
  .size.w db 4
  .size.h db 4
  .pos.x db 24
  .pos.y db 8
  .vel.vx db 0
  .vel.vy db 0
  .frame db 0
  .frames db 1
  .framesize db 192
  .data dw img.box

vbar:
  .size.w db 4
  .size.h db 4
  .pos.x db 28
  .pos.y db 8
  .vel.vx db 0
  .vel.vy db 0
  .frame db 0
  .frames db 1
  .framesize db 192
  .data dw img.vbar

hbar:
  .size.w db 4
  .size.h db 4
  .pos.x db 32
  .pos.y db 8
  .vel.vx db 0
  .vel.vy db 0
  .frame db 0
  .frames db 1
  .framesize db 192
  .data dw img.hbar

question:
  .size.w db 4
  .size.h db 4
  .pos.x db 36
  .pos.y db 8
  .vel.vx db 0
  .vel.vy db 0
  .frame db 0
  .frames db 1
  .framesize db 192
  .data dw img.question

house1:
  .size.w db 4
  .size.h db 4
  .pos.x db 40
  .pos.y db 8
  .vel.vx db 0
  .vel.vy db 0
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

  .ghost_1 incbin "data/ghost_1.bin"
  .ghost_2 incbin "data/ghost_2.bin"
  .ghost_3 incbin "data/ghost_3.bin"
  .ghost_4 incbin "data/ghost_4.bin"

  .lobster_1 incbin "data/lobster_1.bin"
  .lobster_2 incbin "data/lobster_2.bin"
  .lobster_3 incbin "data/lobster_3.bin"
  .lobster_4 incbin "data/lobster_4.bin"
