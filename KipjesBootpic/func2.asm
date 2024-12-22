draw_char: 
jmp .__________
    ; public
    .char db 'A'
    .ox dw 0
    .oy dw 0
    .width dw 16
    .height dw 12
    .color1 db Color.C
    .color2 db Color.Y

    ; private
    .x dw 0
    .y dw 0
    .xx dw 0
    .yy dw 0
    .bpdiv8 dw 0
    .bpdivw dw 0
    .bpmod8 dw 0
    .bpmodw dw 0
    .di_base dw 0
    .dst_bit dw 0
    .src_bit dw 0
    .xdiv8 dw 0
    .xdiv8x4 dw 0
    .xmod8 dw 0
    .ydiv4 dw 0
    .ymod4 dw 0
    .color db 0
    .__________


    ; --- prepare si
    xor ah,ah
    mov al,[.char]
    sub al,32
    mov cx,24
    mul cx
    mov si,ax
    add si,font

    ; ---
    xor bp,bp
    mov word [.y],0
.do_y
    ;yy = y+oy
    mov ax,[.y]
    add ax,[.oy]
    mov [.yy],ax

    ;ydiv4 = yy>>2
    push ax
    times 2 shr ax,1
    mov [.ydiv4],ax

    ;ymod4 = yy&3
    pop ax
    and ax,3
    mov [.ymod4],ax
    mov bx,ax

    ;di_base = ydiv4 * (4*COLS) + ymod4
    mov ax,[.ydiv4]
    mov cx,4*COLS
    mul cx
    add ax,bx ; ymod4
    mov [.di_base],ax

    ;x=0
    mov word [.x],0
.do_x
    ;xx = x+ox
    mov ax,[.x]
    add ax,[.ox]
    mov [.xx],ax

    ;xdiv8 = xx >> 3
    mov bx,ax
    times 3 shr ax,1
    mov [.xdiv8],ax

    ;xdiv8x4 = xdiv8 << 2
    times 2 shl ax,1
    mov [.xdiv8x4],ax

    ;xmod8 = xx & 7;
    mov ax,bx
    and ax,7
    mov [.xmod8],ax

    ;bpmod8 = bp & 7;
    mov ax,bp
    and ax,7
    mov [.bpmod8],ax

    ;bpdiv8 = bp >> 3;
    mov ax,bp
    times 3 shr ax,1
    mov [.bpdiv8],ax

    ;di = di_base + xdiv8x4 ;
    mov ax,[.di_base]
    add ax,[.xdiv8x4]
    mov di,ax

    ;dh = 128 >> xmod8;  dst_bit
    mov ax,128
    mov cx,[.xmod8]
    shr ax,cl
    mov [.dst_bit],ax

    ; --- src_bit = 128>>bpmod8
    mov ax,128
    mov cx,[.bpmod8]
    shr ax,cl
    mov [.src_bit],ax  ; source bit mask
    mov dl,al
    
    ; ---
    mov bx,[.bpdiv8]   ; source index
    test byte [si+bx], al ; source bit in ax

    mov byte al,[.dst_bit]  ; load bit mask into al
    jz .clr
.set
    mov bl,al

    ; --- color gradient: work in progress
    mov al,[.y]
    cmp al,3
    jb .upper
    cmp al,6
    ja .lower
    
    ; --- middle part fade
    mov al,[.x]
    mov cl,[.y]
    xor al, cl      ; XOR x en y
    test al, 1

    jnz .lower

.upper
    mov al,[.color2]
    mov [.color],al
    jmp .red
.lower
    mov al,[.color1]
    mov [.color],al
.red
    test byte [.color], Color.R
    jz .green
    mov ax,RED
    mov es,ax
    or byte [es:di],bl

.green
    test byte [.color], Color.G
    jz .blue
    mov ax,GREEN
    mov es,ax
    or byte [es:di],bl

.blue
    test byte [.color], Color.B
    jz .while
    mov ax,BLUE
    mov es,ax
    or byte [es:di],bl
    
    jmp .while
.clr  
    not al  
    and byte [es:di],al
.while
    ; --- bp++
    inc bp
    
    ; while(++x<w)
    inc word [.x]
    mov ax,[.width]
    cmp [.x],ax
    jb .do_x

    ; --- while(++y<h)
    inc word [.y]
    mov ax,[.height]
    cmp [.y],ax
    jb .do_y

    ret

; ───────────────────────────────────────────────────────────────────────────
