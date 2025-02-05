%include "sanyo.asm"

menu_frame: db 0
selected_menu_item: db 0


setup:
  mov byte [textWide],1

  set_cursor 2,20
  mov byte [textColor], Color.G
  print "*** MAIN MENU *** "

  call draw_menu_items

  jmp draw

set_menu_item_color:
  cmp byte al,[selected_menu_item]
  je .eq
  mov byte [textColor], Color.Y
  jmp .done
.eq
  mov byte [textColor], Color.B
.done
  ret

draw_menu_items:
  mov al,0
  call set_menu_item_color
  call calc_menuitem_pos
  print "Start game"

  mov al,1
  call set_menu_item_color
  call calc_menuitem_pos
  print "Load game"

  mov al,2
  call set_menu_item_color
  call calc_menuitem_pos
  print "Save game"

  mov al,3
  call set_menu_item_color
  call calc_menuitem_pos
  print "Return to game"

  mov al,4
  call set_menu_item_color
  call calc_menuitem_pos
  print "Exit to DOS"
  ret

draw:
  call draw_ship

  call check_keys
  jnz on_key

  jmp draw

on_key:
  cmp ax,'w'
  je on_key_w
  cmp ax,'s'
  je on_key_s
.done
  jmp draw

undraw_menu_item:
  push ax
  mov al,[selected_menu_item]
  call calc_menuitem_pos
  mov bx,021Ch ; 2 rows, 28 cols
  call clear_rect
  pop ax
  ret

on_key_s:
  mov al,[selected_menu_item]
  inc al
  cmp al,4
  jg on_key.done
  call bleep
  call undraw_ship
  call undraw_menu_item ; clear channels of old menu item
  mov [selected_menu_item],al
  call undraw_menu_item ; clear channels of new menu item
  call draw_menu_items
  jmp on_key.done

on_key_w:
  mov al,[selected_menu_item]
  dec al
  js on_key.done
  call bleep
  call undraw_ship
  call undraw_menu_item ; clear channels of old menu item
  mov [selected_menu_item],al
  call undraw_menu_item ; clear channels of new menu item
  call draw_menu_items
  jmp on_key.done

bleep:
; ret
  push ax
  mov bp,12
  mov ax,10
  mov cx,20    ; length of sound effect 20 words
  mov dx,2 ; 3 
  call playEffect
  pop ax
  ret

set_rect: ; di=pos, bh=rows, bl=cols, si=address of 4 byte pattern
  push si
  push es
  push ax
  mov ax,RED
  mov es,ax
  call fill_rect
  mov ax,GREEN
  mov es,ax
  call fill_rect
  mov ax,BLUE
  mov es,ax
  call fill_rect
  pop ax
  pop es
  pop si
  ret

clear_rect: ; di=pos, bh=rows, bl=cols
  mov si,fill_rect.p0
  call set_rect
  ret

draw_ship:
  push ax
  call calc_ship_pos
  mov si,menu_ship
  mov al,[menu_frame]
  and al,3
  mov ah,98
  mul ah     ; ah gets cleared by mul
  add si,ax
  call draw_spr
  inc byte [menu_frame]
  pop ax
  ret

undraw_ship:
  push ax
  push bx
  call calc_ship_pos
  mov bx,0204h
  call clear_rect
  pop bx
  pop ax
  ret

calc_ship_pos:
  mov al,[selected_menu_item]
  shl al,1
  shl al,1
  mov bh,al
  add bh,16
  mov bl,17
  call calc_di_from_bx
  ret

calc_menuitem_pos: ; al=menu_itenm index
  shl al,1
  shl al,1
  mov bh,al
  add bh,16
  mov bl,24
  call calc_di_from_bx
  ret

menu_ship:
 incbin "data/MenuShip-0001.spr"
 incbin "data/MenuShip-0002.spr"
 incbin "data/MenuShip-0003.spr"
 incbin "data/MenuShip-0004.spr"


playEffect:
  mov bx,bp
  mov bx,[sound+bx]
  sub bx,ax   ; ax = note offset for tone height
  call play
  inc bp
  inc bp
  loop playEffect
  ret

sound: incbin "/Users/rick/Documents/Processing/DrawSound/waveform.dat"



times (180*1024)-($-$$) db 0
