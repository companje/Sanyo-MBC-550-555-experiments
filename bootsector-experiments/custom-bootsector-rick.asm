; tixy512.asm by Rick Companje, 2021-2022, MIT licence
; a tribute to Martin Kleppe's beautiful https://tixy.land
; as well as a tribute to the Sanyo MBC-550/555 PC (1984)
; which forced me to be creative with code since 1994.
;
; The Sanyo MBC-55x has a very limited ROM BIOS. After some 
; hardware setup by the ROM BIOS a RAM BIOS loaded from
; floppy takes over. This means that we don't have any BIOS
; functions when running our own code from the bootsector. 
;
; The Sanyo has no display mode 13 (even with the original
; RAM BIOS). It uses a 6845 video chip with three bitmapped 
; graphics planes and is organized as 50 rows by 80 columns.
; One column consists of 4 bytes. Then the next column starts.
; After 80 columns a new row starts. A bitmap of 16x8 pixels 
; is made up of 2 columns on row 1 and 2 columns on row 2...
;
; To run this code write the compiled code to the bootsector of a
; Sanyo MBC-55x floppy or use an emulator like the one written
; in Processing/Java in this repo.
;
; Add your own visuals by adding your own functions to the fx_table.
;
; t = time
; i = index
; x = x-pos
; y = y-pos

org 0
cpu 8086
RED equ 0xf000
GREEN equ 0x0c00
BLUE equ 0xf400
top equ 9*320+10*8
effect_timeout equ 100
num_effects equ fx0-fx_table
start_effect equ 0 ; num_effects-1



%define t dh
%define i dl
%define x bh
%define y bl

setup:
    mov ax,GREEN
    mov cx,0x4000           ; 16k
    xor di,di               ; di=0
    mov es,ax               ; es=GREEN
    rep stosb               ; clear red channel     
    mov ah,0xf0             ; ax=RED
    mov es,ax               ; red + blue 
    xor di,di               ; di=0
    mov ch,0x80             ; cx=32k
    rep stosb               ; clear blue and green channel

    ; generate 16x8 bitmap data for 16 sizes of dots.
    ; because the dots are symmetric we can save at least
    ; 97 bytes by mirroring the left-top nibble
    call render_chars_once

    mov bp,start_effect     ; start with effect nr.

    xor dx,dx               ; t=i=0 (clear time and index)
draw:
    mov di,top              ; left top corner to center tixy
dot:
    mov al,i                ; al=index
    xor ah,ah               ; ah=0
    mov cl,16
    div cl                  ; calculate x and y from i
    xchg ax,bx              ; bh=x, bl=y

    push bp
    push bx
    xchg bx,bp
    mov bp,[bx+fx_table]
    and bp,0xff
    ; or bp,0x100
    pop bx
    call bp
    pop bp

    ; call fx1

draw_char_color:
    push bp
    cmp al,0
    pushf
    jge .red
    neg al
  .red:
    mov bp,RED
    call draw_char
    popf
    jge .green_blue
    xor al,al               ; if negative then just red so clear (al=0) green and blue
  .green_blue:
    mov bp,GREEN
    call draw_char
    mov bp,BLUE
    call draw_char
    pop bp                  ; restore bp (used for effect function)
  .next:  
    inc i                   ; i++
    add di,8         
    cmp x,15
    jl dot                  ; next col
    add di,512       
    cmp y,15
    jl dot                  ; next line
    inc t
    cmp t,effect_timeout
    jl draw                 ; next frame
    inc bp                  ; inc effect
    xor t,t                 ; reset time
    cmp bp,num_effects
    jl draw                 ; next effect
    mov bp,start_effect     ; reset effect
    xor t,t                 ; reset time
    jmp draw

fx_table: 
    db fx0,fx1,fx2,fx3,fx4,fx5,fx6,fx7,fx8

fx0:
    mov al,x   
    add al,t
    ret
fx1:
    mov al,x
    mul y
    add al,t
    ret
fx2:
    push bx
    mov al,t           ; t
    times 2 shr al,1    ; /=2
    and al,15           ; wrap (werkt dit ook voor negatieve getallen?)
    times 2 shl al,1    ; *=4
    mov bx,sin
    xlat                ; extract sin value
    pop bx
    ret
fx3:
    mov al,i
    times 4 shr al,1
    ret
fx4:
    mov al,y
    sub al,7
    ret
fx5:
    mov al,y
    sub al,3
    add al,t
    ret
fx6: ;y-t*4
    mov al,y
    sub al,x
    ret
fx7:
    mov al,y
    sub al,6
    xchg ah,al
    mov al,x
    sub al,6
    mul ah
    ret
fx8: ;x and y
    mov al,x
    and al,y
    test al,2
    je .done
    neg al
 .done:
    ret

draw_char:                  ; es:di=vram (not increasing), al=char 0..15, destroys cx
    push ax
    push di

    push bp
    pop es                  ; es=bp
    push cs
    pop ds                  ;ds=cs

    mov cx,4
    push cx
    push cx

    and al,15               ;limit al to 15
    cbw                     ;ah=0
   
    shl al,cl               ;al*=16
    add ax,data
    xchg si,ax              ;si = source address of rendered bitmap char

    pop cx                  ;cx=4
    rep movsw
    add di,320-8
    pop cx                  ;cx=4
    rep movsw

    pop di                    
    pop ax
    ret

render_chars_once:
    push cs
    pop ds                  ; ds:si in code segment
    push cs
    pop es                  ; es:di in code segment
    mov di,data             ; dest address of render data
    xor bh,bh
  .render_char:
    xor ah,ah
    mov al,bh
    mov cl,4                ; cl is also used below
    mul cl
    mov si,ax
    add si,.img
  .render_char_part:          ; input requirement at first time cl=4
    lodsb                   ; use lodsb instead of movsb to keep a copy in al
    stosb                   ; draw in left top nibble
    push bx                 ; save cur x and y
    push cx                 ; cur loop counter (4,3,2,1)
    push cx
    pop bx                  ; bx = counter
    shl bx,1                ; bx *= 2
    push bx                 ; save counter*2 for right bottom
    cmp bx,2                ; skip top line of left bottom nibble
    je .flip_bits
    mov [di+bx+1],al        ; draw in left bottom starting at line 3 instead of 4
  .flip_bits:                 ; flips all bits dropping highest bit
    mov cl,8                ; 8 bits to flip
    xor ah,ah
  .flip_bit:
    mov bx,0x8001           ; bl=1, bh=128  bl doubles, bh halves
    shl bl,cl
    test al,bl
    jz .next_bit
    dec cx
    shr bh,cl
    or ah,bh
    inc cx
  .next_bit:
    loop .flip_bit          ; loop 8 bits for flipping
    mov [di+3],ah           ; draw in right top nibble
    pop bx                  ; bx = counter*2
    cmp bx,2                ; skip top line of right bottom nibble
    je .flip_done
    mov [di+bx+5],ah        ; draw in right bottom starting at line 3 instead of 4
  .flip_done:
    pop cx                  ; restore loop counter
    pop bx                  ; restore x and y
    loop .render_char_part
  .clear_bottom_line:
    add di,7
    xor al,al
    stosb                   ; right bottom
    add di,3
    stosb                   ; left bottom
  .next_char:
    inc bh                  ; next char
    cmp bh,16
    jl .render_char
    ret
  .img:
    db 0,0,0,0                        ; empty
    db 0,0,0,1                        ; dot
    db 0,0,0,3                        ; minus
    db 0,0,1,3                        ; plus
    db 0,0,3,7                        ; hat
    db 0,0,7,7                        ; block
    db 0,1,7,15                       ; star
    db 0,3,15,15                      ; fat plus
    db 0,15,31,63                     ;
    db 1,31,63,63                     ; spindle
    db 7,31,31,63                     ; robot head
    db 15,31,63,63                    ;
    db 15,63,63,127                   ;
    db 31,63,127,127                  ;
    db 31,127,255,255                 ;
    db 63,127,255,255                 ; largest dot

sin:
    db 0x00,0x01,0x03,0x04,0x06,0x07,0x09,0x0a,0x0b,0x0c,0x0d,0x0e,0x0e,0x0f,0x0f,0x0f
    db 0x0f,0x0f,0x0f,0x0f,0x0e,0x0e,0x0d,0x0c,0x0b,0x0a,0x09,0x07,0x06,0x04,0x03,0x01
    db 0x00,0xff,0xfd,0xfc,0xfa,0xf9,0xf7,0xf6,0xf5,0xf4,0xf3,0xf2,0xf2,0xf1,0xf1,0xf1
    db 0xf1,0xf1,0xf1,0xf1,0xf2,0xf2,0xf3,0xf4,0xf5,0xf6,0xf7,0xf9,0xfa,0xfc,0xfd,0xff

%assign num $-render_chars_once
%warning render and img num bytes

; %assign num_eff fx0-fx_table
; %warning num_eff

%assign num $-$$
%warning total num

data:                                 ; destination for 128 bytes rendered bitmap data
