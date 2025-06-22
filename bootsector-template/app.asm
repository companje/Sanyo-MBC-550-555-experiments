org 0
cpu 8086
bits 16
default rel

COLS  equ 72
TOP   equ 9*4*COLS+20*4    ; row=9,col=20
RED   equ 0xf0
GREEN equ 0x08
BLUE  equ 0xf4

; using dx and bx registers as t,i,x,y variables
%define t dh
%define i dl
%define x bh
%define y bl

jmp setup

; sin_table: ;31 bytes, (input -15..15 index=0..31)
;     db 0,-3,-6,-9,-11,-13,-15,-15,-15,-15,-13,-11,-9,-6,-3,
;     db 0, 3, 6, 9, 11, 13, 15, 15, 15, 15, 13, 11, 9, 6, 3,0

sin_table: ; 32 bytes, input 0..31
    db 15, 12, 9, 6, 4, 2, 0, 0, 0, 0, 2, 4, 6, 9, 12, 15
    db 15, 18, 21, 24, 26, 28, 30, 30, 30, 30, 28, 26, 24, 21, 18, 15

fx_table:
    ; db fx_bar, fx_pulse, fx_spinner, fx_spinner, fx_checker, fx_checker, fx_sphere, fx_sphere, fx_pulse
    times 8 db fx_bar

fx_bar:
    and al,15
    add al,x 

    mov bx,sin_table
    xlat

fx_pulse:
    ret

fx_spinner:
    sub x, 8
    mul x
    add al, y
    ret

fx_checker:
    mov al,x
    xor al,y
    add al,t
    ret

fx_sphere:
    mov al,x
    inc al
    mul y
    add al,t
    ret

setup:                      ; starting point of code
                            ; generate_chars
    push cs
    pop ds                  ; ds:si in code segment
    push cs
    pop es                  ; es:di in code segment

    ; We're building 16 characters, of which 8 are copies, and 2 empty
    ; 1st character is pre-made, 8th character is empty
    ; generate 7 characters, then copy and flip

    mov cl, 7
    mov si, bitmap_data         ; original character
    mov di, bitmap_data + (4*4) ; new character
.character:
    push cx
    mov cl, 8       ; copy 8 16bit values, characters are 4 * 4 bytes
    rep movsw

    push si         ; We've copied the previous character, si now points at our new character
    mov cl, 2
.shrink_half:       ;shrink top and bottom half of character
    push cx
    mov cl, 4
.stripe:            ; shrink even and uneven lines
    shr byte [si+0], 1
    shl byte [si+4], 1
    inc si
    loop .stripe
    pop cx

    add si, 4
    loop .shrink_half

    pop si
    pop cx
    loop .character

    mov cl, 8
.reverse:       ; copy characters in reverse
    push cx
    mov cl, 8
    rep movsw
    sub si, 16*2
    pop cx
    loop .reverse

    ; AL is still 0 here, use it to make an empty character
    mov cl, 16
    rep stosb

init:
    xor bp,bp
    xor dx,dx               ; t=i=0 (clear time and index)

draw:
    and bp,7                ; wrap fx index
    push bp
    mov bl,[byte ds:bp+fx_table] ;change bp from index to address
    xor bh,bh
    push bx
    pop bp

    mov di,TOP              ; left top corner to center tixy
dot:
    mov al,i                ; al=index
    mov bl,t
    xor ah,ah               ; ah=0
    mov cl,16
    div cl                  ; calculate x and y from i
    xchg bx,ax               ; bh = x : bl = y, al = t


    push bx
    ; cx is free, ah = 0, al = t, bx used for X and Y
    call bp                 ; call the effect function
    pop bx
    and al,15 ;maybe 31?

draw_char_color:
    cmp al, 8 ; maybe 15?
    pushf
  .red:
    mov cl, 4
    and al,15           ; limit al to 15
    cbw                 ; ah=0
    shl al,cl           ; al*=16
    add ax,bitmap_data
    mov cl, 0

    mov ch, RED
    call draw_char

    popf
    jge .blue_green
    mov ax, bitmap_data + 16 * 16  ; swap to an empty character so green and blue are cleared, leaving only red

  .blue_green:
    mov ch, BLUE
    call draw_char
    mov ch, GREEN
    call draw_char

  .next:
    inc i                   ; i++

    add di,8
    cmp x,15
    jl dot                  ; next col
    add di,4*COLS+160
    cmp y,15
    jl dot                  ; next line
    inc t
    and t,31
    pop bp                  ; change bp back to index
    jnz draw                ; next frame
    inc bp                  ; inc effect
    jmp draw                ; next frame

draw_char:                  ; es:di=vram (not increasing), al=char 0..15, destroys cx
    push di

    push cx
    pop es                  ; es (color channel was in cx)

    mov si,ax              ; si = source address of rendered bitmap char

    mov cx,4
    push cx
    rep movsw

    add di,4*COLS-8         ; move 2 rows down, and back by 8 bytes back.
    pop cx                  ;cx=4
    rep movsw

    pop di
    ret

bitmap_data:                ; destination for 128 bytes rendered bitmap data, initial character filled
    ;db 00000000b, 00000111b, 00011111b, 01111111b, 00000000b, 11100000b, 11111000b, 11111110b
    ;db 01111111b, 00011111b, 00000111b, 00000000b, 11111110b, 11111000b, 11100000b, 00000000b
    db 00000000b, 00001111b, 00111111b, 11111111b, 00000000b, 11110000b, 11111100b, 11111111b
    db 11111111b, 00111111b, 00001111b, 00000000b, 11111111b, 11111100b, 11110000b, 00000000b


%assign num $-$$
%warning total num
; %if num > 256
;     %error program too large
; %endif

times (180*1024)-num db  0                 ; fill up with zeros until file size=180k
