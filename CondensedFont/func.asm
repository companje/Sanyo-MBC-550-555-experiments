draw_char: 
jmp .__________

    ; public
    .char db 'A'
    .ox dw 0
    .oy dw 0
    .width dw 16
    .height dw 12

    ; private
    .bpdiv8 dw 0
    .bpmod8 dw 0
    .bpdivw dw 0
    .bpmodw dw 0
    .x dw 0
    .y dw 0
    .ydiv4 dw 0
    .ymod4 dw 0
    .xdiv8 dw 0
    .xmod8 dw 0
    .src_bit dw 0
    .dst_bit dw 0
    .__________

    ;bp=width*height
    mov ax,[.width]
    mov bx,[.height]
    xor dx,dx
    mul bx
    mov bp,ax
    dec bp            ; n=length*8-1 (zero based)

    mov di,0

.loop_bits:
    
    ; --- bpdiv8, bpmod8
    mov ax,bp         ; bp = current bit index 0..192 (in case of 16x12)
    xor dx,dx
    mov cx,8
    div cx            ; ax=bp/8, dx=bp%8
    mov [.bpmod8],dx
    mov [.bpdiv8],ax

    ; --- bpdivw, bpmodw
    mov ax,bp         ; bp = current bit index 0..192 (in case of 16x12)
    xor dx,dx
    mov cx,[.width]
    div cx            ; ax=bp/w, dx=bp%w
    mov [.bpmodw],dx
    mov [.bpdivw],ax

    ; --- int x,y
    add dx,[.ox]      ; (b % w) + ox
    add ax,[.oy]      ; (b / w) + oy
    mov [.x],dx
    mov [.y],ax

    ; --- ydiv4, ymod4
    mov ax,[.y]
    xor dx,dx
    mov cx,4
    div cx
    mov [.ydiv4],ax
    mov [.ymod4],dx

    ; --- xdiv8, xmod8
    mov ax,[.x]
    xor dx,dx
    mov cx,8
    div cx
    mov [.xdiv8],ax
    mov [.xmod8],dx

    ; --- DI = (y/4) * (4*COLS) + (y%4) + ((x/8)*4);
    mov ax,[.ydiv4]
    xor dx,dx
    mov cx,4*COLS
    mul cx
    add ax,[.ymod4]
    mov cx,[.xdiv8]
    times 2 shr cx,1   ; *=4
    add ax,cx
    mov di,ax          ; destination index

    ; --- dst_bit = 128>>xmod8
    mov ax,128
    mov cx,[.xmod8]
    shr ax,cl
    mov [.dst_bit],ax  ; destination bit mask

    ; --- SI = bpdiv8
    mov si,[.bpdiv8]   ; source index
    add si, ('A'-32)*24

    ; --- src_bit = 128>>bpmod8
    mov ax,128
    mov cx,[.bpmod8]
    shr ax,cl
    mov [.src_bit],ax  ; source bit mask

    ; --- if [si] & [.src_bit]
    test [si],ax
    jnz .set
    jz .clr
.set
    mov byte al, [.dst_bit]
    or byte [es:di],al
    jmp .next
.clr  
    ; mov byte al, [.dst_bit]
    ; not al  
    ; and byte [es:di],al
    ; jmp .next

.next

    ;loop while(bp-->0)
    dec bp
    or bp,bp
    jnz .loop_bits

    ret

; ───────────────────────────────────────────────────────────────────────────
