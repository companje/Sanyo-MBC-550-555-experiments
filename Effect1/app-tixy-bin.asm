COLS  equ 72
TOP   equ 9*4*COLS+20*4    ; row=9,col=20
RED   equ 0xf0
GREEN equ 0x08
BLUE  equ 0xf4

effect_timeout equ 10      ; every 30 frames another effect
isqrt_table    equ 1000    ; available location in code segment

; using dx and bx registers as t,i,x,y variables
%define t dh
%define i dl
%define x bh
%define y bl

jmp setup

; some parts of FAT12 table is included here to be able to mount the binary 
; as a diskimage on Mac. This seems also to be needed for FlashFloppy to
; recognize the diskimage. The Sanyo does not need the regular bootsector 
; signature 0x55 0xAA

fx_table:      ; the 'effects' table: 8 bytes, overwriting the 'Sanyo1.2' tag
    db fx2,fx3,fx4,fx6 ; ,fx6,fx7,fx0,fx1
    ; db fx7,fx8,fx3,fx4
    ; %assign num 8-($-fx_table) 
    ; times num db 0x20

    ; db 'Sanyo1.2'
    ; dw 512     ; Number of bytes per sector
    ; db 2       ; Number of sectors per cluster
    ; db 1       ; Number of FAT copies
    ; dw 512     ; Number of root directory entries
    ; db 112     ; Total number of sectors in the filesystem
    ; db 0       ; Media descriptor type
    ; dw 512     ; Number of sectors per FAT
    ; dw 765     ; ? Number of sectors per track
    ; db 0     ; ? Number of heads   (now first byte of sine table)
    ; db 9     ; ? Number of heads  
    ; dw 512   ; Number of hidden sectors
    ; the the last 4 bytes of the FAT12 table are overwritten by the sine table

sin_table: ;31 bytes, (input -15..15 index=0..31)
    db 0,-3,-6,-9,-11,-13,-15,-15,-15,-15,-13,-11,-9,-6,-3,
    db 0, 3, 6, 9, 11, 13, 15, 15, 15, 15, 13, 11, 9, 6, 3,0  
    ; tried to mirror the second line of the sine table with code 
    ; but would take a same of amount of bytes

; fx0: ; x
;     mov al,x
;     ret

; fx1: ; y-7
;     mov al,y
;     sub al,7
;     ret

fx2: ; y+t
    mov al,y
    add al,t
    ret

fx3: ; y-t
    mov al,y
    sub al,t
    ret

fx4: ; sin(x+y+t)
    mov al,x
    add al,y
    add al,t
    call sin
    ret

; fx5: ; bitmap_data[i+t]
;     push bx
;     mov al,i
;     add al,t
;     mov bx,bitmap_data
;     xlat
;     pop bx
;     ret

fx6: ; ((y-x)*-8)+t
    mov al,y
    sub al,x
    mov cl,-8
    mul cl
    call limit
    add al,t
    ret

fx7: ; sin(sqrt(x^2+y^2))-t)
    mov al,i   ; isqrt_table[i] = sqrt(x^2+y^2)
    push bx
    mov bx,isqrt_table
    xlat
    pop bx
    sub al,t
    call sin
    ret

fx8: ; sin(t+i+x*y);
    mov al,x
    sub al,16
    push dx
    mov dl,y
    inc dl
    mul dl
    pop dx
    ; add al,i
    add al,t
    call sin
    call sin
    ret

; fx9: ;(x==0 | x==15 | y==0 | y==15)
;     cmp x,0
;     je .on
;     cmp x,15
;     je .on
;     cmp y,0
;     je .on
;     cmp y,15
;     je .on
; .off:
;     mov al,0
;     ret
; .on:
;     mov al,15
;     ret

sin: ; sine function
    call wrap
    push bx
    add al,15 ; sin(-15) = sin_table[0]
    mov bx,sin_table
    xlat 
    pop bx
    ret

wrap: ; while (al>15) al-=15; while (al<-15) al+=15
    cmp al,15
    jg .sub16
    cmp al,-15
    jl .add16
    ret
  .sub16:
    sub al,31
    jmp wrap
  .add16:
    add al,31
    jmp wrap

limit: ; if (al>15) al=15; else if (al<-15) al=-15;
    cmp al,15
    jg .pos16
    cmp al,-15
    jnl .ret
    mov al,-15
    ret
  .pos16:
    mov al,15
  .ret:
    ret

calc_isqrt_xx_yy: ; isqrt_table[i] = sqrt(x^2+y^2)
    push dx
    push di
    mov di,isqrt_table      ; di=isqrt_table[0]
    add di,dx               ; di+=i
    mov al,x
    inc al
    mul al                  ; x*x
    xchg ax,cx
    mov al,y
    inc al
    mul al                  ; y*y
    add ax,cx               ; + 
  .isqrt:  ; while((L+1)^2<=y) L++; return L
    xchg cx,ax              ; cx=y
    xor ax,ax               ; ax=L=0
  .loop:
    inc ax
    push ax
    mul ax
    cmp ax,cx
    pop ax
    jl .loop
    dec ax
  .end_isqrt:
    mov [di],al             ; store al
    pop di
    pop dx
    ret

setup:                      ; starting point of code
    ;no need to clear the screen. ROM BIOS does this already.

    ;set ds and es segments to cs
    push cs
    pop ds                  ; ds:si in code segment
    push cs
    pop es                  ; es:di in code segment

    ; generate 16x8 bitmap data for 16 sizes of dots.
    ; Because the dots are symmetric we can save at least
    ; 97 bytes by mirroring the left-top corner 3 times

    call generate_chars

    xor bp,bp               ; start with effect 0
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



    ;on the first frame calc sqrt table for every i
    ;reusing the i,x,y loop here. this saves some bytes.
    or t,t
    jnz .cont
    call calc_isqrt_xx_yy
  .cont:
   
    push bp
    push bx
    xchg bx,bp
    mov bp,[bx+fx_table]
    and bp,0xff             ; effect function needs to fit in one byte to save 8 bytes
    pop bx
    call bp                 ; call the effect function
    pop bp

draw_char_color:
    cmp al,0
    pushf


    jge .red
    neg al
  .red:
    mov cx,RED << 8              ; ch=0xf0, cl=0
    call draw_char
    popf

    ; call toggle_speaker

    

    jge .green_blue
    xor al,al               ; if negative then just red so clear (al=0) green and blue
  .green_blue:


    mov ch,GREEN
    call draw_char
    mov ch,BLUE
    call draw_char
  .next:  

    push ax
    mov ax,di
    out 0x3a,al
    pop ax

    ; push ax
    ; mov al,8
    ; out 0x3a,al
    ; pop ax

    inc i                   ; i++
    add di,8         
    cmp x,15
    jl dot                  ; next col
    add di,4*COLS       
    add di,160
    cmp y,15
    jl dot                  ; next line
    inc t



push cx
mov cx,50000
.wait 
aam
loop .wait
pop cx

    cmp t,effect_timeout
    jb draw                 ; next frame
    inc bp                  ; inc effect
    xor t,t                 ; reset time
    cmp bp,8
    jl draw                 ; next effect
    xor bp,bp               ; reset effect


    jmp draw

draw_char:                  ; es:di=vram (not increasing), al=char 0..15, destroys cx
    push ax
    push di

    push cx
    pop es                  ; es=bp (color channel now cx)
    push cs
    pop ds                  ; ds=cs

    mov cx,4
    push cx
    push cx

    and al,15               ; limit al to 15
    cbw                     ; ah=0
   
    shl al,cl               ; al*=16
    add ax,bitmap_data
    xchg si,ax              ; si = source address of rendered bitmap char

    pop cx                  ;cx=4
    rep movsw
    add di,4*COLS-8
    pop cx                  ;cx=4
    rep movsw


   
    pop di                    
    pop ax
    ret

generate_chars:
    mov di,bitmap_data      ; dest address of render data
    xor bh,bh
  .render_char:
    xor ah,ah
    mov al,bh
    mov cx,4                ; cl is also used below
    mul cl
    mov si,ax
    add si,img
  .render_char_part:        ; input requirement at first time cl=4
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

img: incbin "/Users/rick/Documents/Processing/ToTixyChars/tixy4.bin"

%assign num $-$$
%warning total num

bitmap_data:                          ; destination for 128 bytes rendered bitmap data


times (180*1024)-($-$$) db 0