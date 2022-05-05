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
COLS equ 72
TOP equ 9*4*COLS+10*8
effect_timeout equ 255 ; unsigned
num_effects equ fx0-fx_table
start_effect equ 0 ; num_effects-1

%define t dh
%define i dl
%define x bh
%define y bl

    jmp setup

    db 'Sanyo1.2'
    dw 512     ; Number of bytes per sector
    db 2       ; Number of sectors per cluster
    db 1       ; Number of FAT copies
    dw 512     ; Number of root directory entries
    db 112     ; Total number of sectors in the filesystem
    db 0       ; Media descriptor type
    dw 512     ; Number of sectors per FAT
    dw 765     ; ? Number of sectors per track
    dw 2304    ; ? Number of heads  
    dw 512     ; Number of hidden sectors

fx_table:
    db fx0,fx1,fx2,fx3,fx4,fx5,fx6,fx7,fx8,fx9

sin_table: ;31 bytes   input ..-15..15
    db 0,-3,-6,-9,-11,-13,-15,-15,-15,-15,-13,-11,-9,-6,-3,
sin_table_half:
    db 0, 3, 6, 9, 11, 13, 15, 15, 15, 15, 13, 11, 9, 6, 3,0

    ; some how we need 42 bytes after the FAT12 table... not sure why yet
    ; fx_table and sin_table fit here. then fill up the rest.
    %assign num 42-($-fx_table) 
    times num db 0

fx0:
    ; doordat er 'and' gebruikt wordt ipv modulo herhaalt het patroon zich elke 16 dots
; inc i
    mov al,i
    ; add al,t
    ; sub al,128   ; van -128..128

    hlt

  .check:
    cmp al,15
    jg .sub16
    cmp al,-15
    jl .add16
    hlt
    ret

  .sub16:
    sub al,16
    jmp .check
  .add16:
    add al,16
    jmp .check



fx1:
    mov al,x
    mul y
    add al,t
    ret
fx2:
    ; push bx
    ; mov al,x
    ; shl al,1
    ; add al,t
    ; and al,31
    ; mov bx,sin_table
    ; xlat 
    ; pop bx
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
fx9:
    in al,0x22
    ret

hardware:
;8259A interrupt controller
    dw 0x0013, 0x02f8, 0x020f, 0x0296
;      \ICW1/  \ICW2/  \ICW4/  \mask/
;Timer init code
    dw 0x2634, 0x20bf, 0x2021 ;channel 0 (clock)
    dw 0x2674, 0x2200, 0x2200 ;channel 1 (2nd stage clock)
    dw 0x26b6, 0x245d, 0x2400 ;channel 2 (add-in serial rate)
;End hardware init
    dw 0 ;end list

setup:
    mov si,hardware
    push cs
    pop ds
    ;now process hardware init
.portloop:
    xor dx,dx
    lodsw
    test ax,ax
    jz .portdone
    xchg ah,dl
    out dx,al
    jmp short .portloop
.portdone:


    ;set video chip from 72 to 80 columns
;     mov si,profile25x80
;     mov bx,0
;     cld
; .lp:
;     mov al,bl
;     out 0x30,al            ;CRTC address port
;     mov al,[cs: bx+si+0]
;     out 0x32,al            ;CRTC data port
;     inc bx
;     cmp bl,10
;     jl .lp
    
    ;clear the screen
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
    ; 97 bytes by mirroring the left-top corner
    call render_chars_once

    mov bp,start_effect                ; start with effect nr.

    xor dx,dx               ; t=i=0 (clear time and index)
draw:
    mov di,TOP              ; left top corner to center tixy
dot:
    push dx
    mov al,i                ; al=index
    xor ah,ah               ; ah=0
    mov cl,16
    div cl                  ; calculate x and y from i
    xchg ax,bx              ; bh=x, bl=y
    pop dx

    xor ah,ah               ; ah=0  ; tijdelijk, mag later weg
    hlt 

    push bp
    push bx
    xchg bx,bp
    mov bp,[bx+fx_table]
    and bp,0xff
    pop bx
    call bp
    pop bp

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
    add di,4*COLS       
    add di,160
    cmp y,15
    jl dot                  ; next line

    ; hlt

    inc t
    cmp t,effect_timeout
    jb draw                 ; next frame
    inc bp                  ; inc effect
    xor t,t                 ; reset time
    cmp bp,8
    jl draw                 ; next effect
    mov bp,0                ; reset effect
    xor t,t                 ; reset time
    xor i,i
    jmp draw

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
    add di,4*COLS-8
    pop cx                  ;cx=4
    rep movsw

    pop di                    
    pop ax
    ret

; profile25x80:
;     db 112  ;0  Horizontal Total
;     db 80   ;1  Horizontal Displayed
;     db 88   ;2  Horizontal Sync Position
;     db 0x4a ;3  Horizontal and Vertical Sync Widths
;     db 65   ;4  Vertical Total
;     db 0    ;5  Vertical Total Adjust
;     db 50   ;6  Vertical Displayed
;     db 56   ;7  Vertical Sync position
;     db 0    ;8  Interlace and Skew
;     db 3    ;9  Maximum Raster Address

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

%assign num $-render_chars_once
%warning render and img num bytes

; sin:
;     db 0x00,0x01,0x03,0x04,0x06,0x07,0x09,0x0a,0x0b,0x0c,0x0d,0x0e,0x0e,0x0f,0x0f,0x0f
;     db 0x0f,0x0f,0x0f,0x0f,0x0e,0x0e,0x0d,0x0c,0x0b,0x0a,0x09,0x07,0x06,0x04,0x03,0x01
;     db 0x00,0xff,0xfd,0xfc,0xfa,0xf9,0xf7,0xf6,0xf5,0xf4,0xf3,0xf2,0xf2,0xf1,0xf1,0xf1
;     db 0xf1,0xf1,0xf1,0xf1,0xf2,0xf2,0xf3,0xf4,0xf5,0xf6,0xf7,0xf9,0xfa,0xfc,0xfd,0xff


%assign num $-$$
%warning total num

data:                                 ; destination for 128 bytes rendered bitmap data

incbin "Sanyo-MS-DOS-2.11-minimal.img",($-$$)  ; include default disk image skipping first 512 bytes
