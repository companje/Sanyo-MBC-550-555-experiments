%include "sanyo.asm"


setup:
  mov ax,RED
  mov es,ax

  mov si,font
  mov cx,16
  mov dx,12
  mov bx,0
  mov di,0
  call draw_char_xy
  
  hlt


; Parameters:
; DS:SI - Pointer to the bitmap array
; CX - Width of the character (w)
; DX - Height of the character (h)
; BX - X offset (ox)
; DI - Y offset (oy)

draw_char_xy:
    ; Save registers that will be modified
    push bp
    push ax
    push bx
    push cx
    push dx
    push si
    push di

    xor bp, bp              ; bp = bit index (b)

.loop_bits:
    ; Calculate x = (b % w) + ox
    mov ax, bp              ; ax = b
    xor dx, dx              ; clear dx for division
    div cx                  ; ax = b / w, dx = b % w
    add dx, bx              ; dx = x

    ; Calculate y = (b / w) + oy
    mov ax, bp              ; ax = b
    xor dx, dx              ; clear dx for division
    div cx                  ; ax = b / w
    add ax, di              ; ax = y

    ; Calculate src_byte_index = b / 8
    mov si, bp              ; si = b
    shr si, 3               ; si = b / 8

    ; Calculate src_bit_index = b % 8
    mov ax, bp              ; ax = b
    and ax, 7               ; ax = b % 8
    mov bp, ax              ; bp = src_bit_index

    ; Get bit_value
    mov al, [ds:si]         ; Load byte from bitmap
    mov cl, 7               ; Start mask shift at MSB (128 = 1 << 7)
    sub cl, bp              ; Adjust shift for src_bit_index
    shr al, cl              ; Shift bit into LSB
    and al, 1               ; Isolate bit_value (0 or 1)

    ; Calculate dst_byte_index = (y / 4) * (4 * COLS) + (y % 4) + (x / 8) * 4
    ; y / 4
    mov bx, ax              ; bx = y
    shr bx, 2               ; bx = y / 4

    ; (y % 4)
    mov ax, bp              ; ax = y
    and ax, 3               ; ax = y % 4

    ; (x / 8)
    mov cx, dx              ; cx = x
    shr cx, 3               ; cx = x / 8

    ; Final calculation
    mov dx, COLS            ; dx = COLS
    shl dx, 2               ; dx = 4 * COLS
    mul dx                  ; (y / 4) * (4 * COLS)
    add ax, bx              ; Add (y % 4)
    shl cx, 2               ; (x / 8) * 4
    add ax, cx              ; Add (x / 8) * 4
    add ax, R               ; Add R offset
    mov di, ax              ; di = dst_byte_index

    ; Calculate dst_bit_index = x % 8
    mov ax, dx              ; ax = x
    and ax, 7               ; ax = x % 8
    mov bp, ax              ; bp = dst_bit_index

    ; Apply the bit_value
    mov bx, 0x80            ; bx = 128 (1 << 7)
    shr bx, bp              ; Adjust bit mask for dst_bit_index
    mov al, [es:di]         ; Load destination byte
    test al, al             ; Check bit_value
    jz .clear_bit           ; If 0, clear the bit

    xor al, bl              ; Set the bit (XOR)
    jmp .write_back

.clear_bit:
    not bx                  ; Invert mask
    and al, bx              ; Clear the bit

.write_back:
    mov [es:di], al         ; Write back to memory

    ; Increment b and repeat
    inc bp                  ; bp = b + 1
    cmp bp, cx              ; Compare b with total bits
    jl .loop_bits           ; Loop if b < total bits

    ; Restore registers
    pop di
    pop si
    pop dx
    pop cx
    pop bx
    pop ax
    pop bp
    ret



; msg: db "HELLO!",0
 
; Color.R equ 100
; Color.G equ 010
; Color.B equ 001
; Color.W equ 111
; Color.C equ 011
; Color.M equ 101
; Color.Y equ 110
; Color.K equ 000

; sprite_16x12x3: times (2*12*3) db 0 ; 2 cols, 12 lines, 3 channels
; ; char_to_sprite 'A', odd/even / align left/right
; ; draw_bitmap

; channels: dw RED,GREEN,BLUE

; params:
; color: db Color.G
; x: dw 10
; y: db 10

; ; font1: db 0b11000000, 0b01111111, 0b10101010, 0b10101010
; hello1: db 'ABCDEF',0
; char_index: db 0

; char_to_sprite:
 
;   mov di,sprite_16x12x3

;   cbw                  ; clear high part of ax
;   mov si,font          ; font table base
;   sub al,32            ; 'A'-32  convert ascii code to character index
;   mov cl,24            ; 2*12=24 bytes per character in font table
;   mul cl               ; ax=al*24 
;   add si,ax


; setup:
;   ; mov al,'A'
;   ; mov bl,0 ; left=0, right=1
;   ; call char_to_sprite

;   mov bh,4
;   mov bl,4
;   xor di,di
;   mov si,img.donut_1
;   call draw_pic

;   hlt


; draw_pic:          ; DI=offset, [BH,BL]=rows,cols
;   mov ax, RED
;   call draw_channel
;   mov ax, GREEN
;   call draw_channel
;   mov ax, BLUE
;   call draw_channel
;   ret

; ; ───────────────────────────────────────────────────────────────────────────

; draw_channel: 
;   push di
;   mov es,ax
;   xor cx,cx  
;   mov cl,bh        ; rows (bh)
; .rows push cx
;   xor cx,cx
;   mov cl,bl        ; cols (bl)
; .cols times 2 movsw
;   loop .cols
;   add di,COLS*4-4*4 ; for 32x16 ???
;   pop cx
;   loop .rows
;   pop di
;   ret 




; setup2:
;   jmp draw

; ; get_24_bits_linedata_for_2chars: ; ax='BA'
  
; draw_char_part:
;   mov cx,4
; .lp lodsw              ; ax contains now 16 horizontal bits of the char
;   ; stosb                ; draw left part

;   ; times 4 shl al,1
;   test byte [char_index],1
;   jz .l1
;   shr al,1
;   shr al,1
;   shr al,1
;   shr al,1

; .l1
;   or [es:di+0],al     ; draw left part

;   test byte [char_index],1
;   jz .l2

;   or [es:di+4],ah     ; draw right part
; .l2
;   inc di
;   loop .lp             ; draw 4 lines
;   ret


; draw_char:
;   cbw                  ; clear high part of ax
;   mov si,font          ; font table base
;   sub al,32            ; 'A'-32  convert ascii code to character index
;   mov cl,24            ; 2*12=24 bytes per character in font table
;   mul cl               ; ax=al*24 
;   add si,ax

;   test byte [char_index],1
;   jz .l1

;   sub di,4

; .l1
;   call draw_char_part  ; upper 4 lines
;   add di,COLS*4-4
;   call draw_char_part  ; middle 4 lines
;   add di,COLS*4-4
;   call draw_char_part  ; lower 2 lines
;   sub di,COLS*8-4      ; finish char, move 2 rows up
  
;   ; maybe move 'half' char to the left as well.....
;   ; 

;   ret

; draw_string:    ; input si=string offset
; .lp
;   push si
;   lodsb
;   or al,al
;   jz .done
;   call draw_char
;   inc byte [char_index]
;   pop si
;   inc si
;   jmp .lp
; .done
;   pop si
;   ret

; draw:
;   push bx
;   mov ax,RED
;   mov es,ax
;   mov si,hello1
;   mov bx,0x0f00
;   call calc_di_from_bx  
;   call draw_string
;   pop bx

;   hlt

; ; ───────────────────────────────────────────────────────────────────────────

; calc_di_from_bx:  ; input bl,bh [0,0,71,49]
;   mov ax,144      ; 2*72 cols
;   mul bh          ; bh*=144 resultaat in AX
;   shl ax,1        ; verdubbel AX
;   mov di,ax       ; di=ax (=bh*288)
;   shl bl,1        ; bl*=2
;   shl bl,1        ; bl*=2
;   mov bh,0
;   add di,bx       ; di+=bl
;   ret



; ; draw_2chars:
; ;   xor bp,bp

  
; ;   mov di,0 

; ; mov al,'B'

; ; cbw                  ; clear high part of ax
; ;   mov si,font          ; font table base
; ;   sub al,32            ; 'A'-32  convert ascii code to character index
; ;   mov cl,24            ; 2*12=24 bytes per character in font table
; ;   mul cl               ; ax=al*24 
; ;   add si,ax
  

; ; call draw_char_part  ; upper 4 lines
; ;   add di,COLS*4-4
; ;   call draw_char_part  ; middle 4 lines
; ;   add di,COLS*4-4
; ;   call draw_char_part  ; lower 2 lines
; ;   sub di,COLS*8-4      ; finish char, move 2 rows up


;   ;   lodsw
;   ; or [es:di+0],al
;   ; or [es:di+4],ah

;   ; inc di



;   ; cmp cx,8
;   ; jne .next1

;   ; add di,COLS*4-4

; ; .next1
; ;   cmp cx,4
; ;   jne .next2
  
; ;   add di,COLS*4-4

; ; .next2
; ;   loop .lp
  
; ;   inc di

;   hlt

; ; merge_to_24_bits

; ; draw_2chars:

; ;   mov di,0


; ;   mov si,hello
; ;   mov ah,1 ; line
; ;   lodsb ; al='A'
; ;   call get_12_bits
; ;   lodsb ; al='B'
; ;   call get_12_bits

; ;   hlt

;   ; bx = get_12_bits line1, 'A'
;   ; dx = get_12_bits line1, 'B'



; ;   mov si,hello
; ;   lodsw ; ax='BA'
; ;   mov bl,ah
  
; ;   mov si,font + ('A'-32)*24
; ;   xor bp,bp
; ;   mov cx,4
; ; .lp1
; ;   lodsw
; ;   ; mov si,font + ('A'-32)*24
; ;   xor [es:di+bp+0],al


; ;   ; mov bl,ah ; right 8 bits of the A
; ;   ; mov si,font + ('B'-32)*24
; ;   ; lodsw
; ;   ; and ah,0b11110000
; ;   ; or bl,ah
; ;   ; xchg bl,ah
; ;   mov ah,-1

; ;   xor [es:di+bp+4],ah
; ;   inc bp
; ;   loop .lp1

; ;   add bp,COLS*4-4

; ;   mov cx,4
; ; .lp2
; ;   lodsw
; ;   xor [es:di+bp+0],al
; ;   xor [es:di+bp+4],ah
; ;   inc bp
; ;   loop .lp2

; ;   add bp,COLS*4-4

; ;   mov cx,4
; ; .lp3
; ;   lodsw
; ;   xor [es:di+bp+0],al
; ;   xor [es:di+bp+4],ah
; ;   inc bp
; ;   loop .lp3

; ;   ret

; ; draw:
; ; ; mov si,font          ; font table base
; ; ;   sub al,32            ; 'A'-32  convert ascii code to character index
; ; ;   mov cl,24            ; 2*12=24 bytes per character in font table
; ; ;   mul cl               ; ax=al*24 
; ; ;   add si,ax

; ;   mov di,0
; ;   mov bx,hello
; ;   call draw_2chars


; ;   hlt

; ; ───────────────────────────────────────────────────────────────────────────

; ; draw_bitmap:

; ;   ; mov ax,0b0111111111000000

; ;   xor bp,bp

; ;   mov cx,4
; ; .lp1
; ;   lodsw
; ;   xor [es:di+bp+0],al
; ;   xor [es:di+bp+4],ah
; ;   inc bp
; ;   loop .lp1

; ;   add bp,COLS*4-4

; ;   mov cx,4
; ; .lp2
; ;   lodsw
; ;   xor [es:di+bp+0],al
; ;   xor [es:di+bp+4],ah
; ;   inc bp
; ;   loop .lp2

; ;   add bp,COLS*4-4

; ;   mov cx,4
; ; .lp3
; ;   lodsw
; ;   xor [es:di+bp+0],al
; ;   xor [es:di+bp+4],ah
; ;   inc bp
; ;   loop .lp3

; ;   ret

; ; set_pixel: # bl,bh = x,y     al=3 bit color 
  
; ;   ret

; ; draw_bitmap:
; ; ;   ; mov ax,0b0111111111000000

; ; ; ───────────────────────────────────────────────────────────────────────────

; ; calc_bit_for_pixel:
; ;   ;input BX,DX = x,y
; ;   ;output DI = (y\4)*(4*COLS) + (y%4) + (x\8)*4
; ;   ;output DL = 2^(7-(x % 8))

; ;   mov ax,dx        ; y
; ;   xor dx,dx        ; dx=0
; ;   mov cl,4         
; ;   div cx           ; ax=y/4, dx=y%4
; ;   mov di,dx        ; vram offset (dx=y%4)
; ;   mov cx,4*COLS    
; ;   mul cx           ; ax*=(4*COLS)
; ;   add di,ax        ; di+=ax
; ;   mov ax,bx        ; x
; ;   xor dx,dx        ; dx=0
; ;   mov cx,8         
; ;   div cx           ; 8 bits per col
; ;   mov cx,2 
; ;   shl ax,cl        ; ax*=4       
; ;   add di,ax        ; di+=(x/8)*4

; ;   mov al,128       ; highest bit
; ;   mov cl,dl        ; dl contains x%8
; ;   shr al,cl        ; shift right number of bits to the correct pixel in char
; ;   mov dl,al
; ;   ret

; ; ; ───────────────────────────────────────────────────────────────────────────

; ; update_pix_in_channel:
; ;   mov es,ax           ; color segment
; ;   mov al,dl           ; DL contains active bit pattern
; ;   test [color], dh    ; deze checkt of de gewenste kleur bevat en of deze pixel in dit kanaal dus aan of uit moet staan.
; ;   jnz .on
; ;   not al
; ;   and [es:di],al
; ;   jmp .done
; ; .on
; ;   or [es:di],al   ; turn on pixel
; ; .done
; ;   ret

; ; setpix: 

; ;   call calc_bit_for_pixel ; DI=byte for pixel, DL=bit for pixel in byte

; ;   mov ax,RED
; ;   mov dh,Color.R

; ;   call update_pix_in_channel  ; dl is not affected

; ;   mov ax,GREEN
; ;   mov dh,Color.G
; ;   call update_pix_in_channel ; dl is not affected

; ;   mov ax,BLUE
; ;   mov dh,Color.B
; ;   call update_pix_in_channel ; dl is not affected

; ;   ret 


; ; draw:

; ;   ;blue BG
; ;   mov ax,BLUE
; ;   mov es,ax
; ;   xor di,di
; ;   mov ax,-1
; ;   mov cx,7200
; ;   rep stosw

; ;   ;yellow pixel
; ;   mov byte [color], Color.Y
; ;   mov bx, 40   ; x
; ;   mov dx,5      ; y
; ;   call setpix

;   ;instead of [color] it uses cl for color and bx,ah for x,y
;   ; mov byte [color], Color.Y
;   ; mov byte [x], 40
;   ; mov byte [y], 5
;   ; call setpix


;   ; ;use stosb/stosw to store params
;   ; mov di, params
;   ; mov al, Color.Y
;   ; stosb
;   ; mov ax,40
;   ; stosw
;   ; mov al,5
;   ; stosb
;   ; call setpix

;   ; hlt
  

; ; ───────────────────────────────────────────────────────────────────────────

; ; calc_di_from_bx:  ; input bl,bh [0,0,71,49]
; ;   mov ax,144      ; 2*72 cols
; ;   mul bh          ; bh*=144 resultaat in AX
; ;   shl ax,1        ; verdubbel AX
; ;   mov di,ax       ; di=ax (=bh*288)
; ;   shl bl,1        ; bl*=2
; ;   shl bl,1        ; bl*=2
; ;   mov bh,0
; ;   add di,bx       ; di+=bl
; ;   ret

; ; ───────────────────────────────────────────────────────────────────────────

; _wait:
;   push cx
;   mov cx,1000
; .lp 
;   aam
;   loop .lp
;   pop cx
;   ret

; ; ───────────────────────────────────────────────────────────────────────────

%include "assets.asm"

times (180*1024)-($-$$) db 0

