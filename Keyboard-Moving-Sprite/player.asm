; %include "sprite.asm"

; player:

; .mode dw .walk_left 

; .update:


;   ret

; .draw:
;   ; xor di,di
;   ; push cs
;   ; pop ds
;   ; mov si, img.stand_1
;   ; mov bh,4 ; cols 
;   ; mov bl,4 ; rows
;   ; call draw_pic
;   ; ret

;   push cs
;   pop ds

;   push bp
;   mov bp,[.mode]

;   mov bx,[bp+pos]
;   call calc_di_from_bx
;   mov si,[bp+img_data]
;   mov cl,[bp+framesize]
;   mov byte al,[bp+frame]
;   mul cl
;   add si,ax
;   mov bx,[bp+size]
;   call draw_pic
;   call .next_frame
;   pop bp
;   ret

; .next_frame:
;   ; mov bp, .stand
;   inc byte [bp+frame]
;   mov cl,[bp+frames]
;   cmp byte [bp+frame],cl
;   jb .done
;   mov byte [bp+frame],0
; .done
;   ret

; ; ───────────────────────────────────────────────────────────────────────────


; player.stand:
;   .size.w db 4
;   .size.h db 4
;   .pos.x db 5
;   .pos.y db 36
;   .vel.vx db 1
;   .vel.vy db -1
;   .frame db 0
;   .frames db 4
;   .framesize db 192
;   .data dw img.stand_1

; player.walk_fw:
;   .size.w db 4
;   .size.h db 4
;   .pos.x db 42
;   .pos.y db 5
;   .vel.vx db -1
;   .vel.vy db 1
;   .frame db 0
;   .frames db 2
;   .framesize db 192
;   .data dw img.walk_fw_1

; player.walk_bw:
;   .size.w db 4
;   .size.h db 4
;   .pos.x db 38
;   .pos.y db 29
;   .vel.vx db -1
;   .vel.vy db 1
;   .frame db 0
;   .frames db 2
;   .framesize db 192
;   .data dw img.walk_bw_1

; player.walk_left:
;   .size.w db 4
;   .size.h db 4
;   .pos.x db 31
;   .pos.y db 19
;   .vel.vx db 1
;   .vel.vy db 1
;   .frame db 0
;   .frames db 4
;   .framesize db 192
;   .data dw img.walk_left_1

; player.walk_right:
;   .size.w db 4
;   .size.h db 4
;   .pos.x db 29
;   .pos.y db 13
;   .vel.vx db 1
;   .vel.vy db -1
;   .frame db 0
;   .frames db 4
;   .framesize db 192
;   .data dw img.walk_right_1
