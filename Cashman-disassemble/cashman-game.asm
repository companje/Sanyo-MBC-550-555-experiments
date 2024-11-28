

; jmp 0xd8

; db 0x60,0x22,0xEA,0x22,0xB6,0x26,0x5D,0x24,0x00,0x24,0x6E,0x2A,0x18,0x2A,0xFE,0xC6,0x80,0xFE,0x09,0x72,0x18,0xB6,0x01,0xFE,0xC2,0x8A,0xC2

; db 'Sanyo1.2'

; _0x0b:dw 512     ; bytes per sector
; _0x0d:db 2       ; sectors per cluster
; _0x0e:dw 256     ; reserved sectors
; _0x10:db 2       ; number of FATs
; _0x11:dw 112     ; max number of root directory entries (0x70)
; _0x13:dw 720     ; total sector count
; _0x15:db 0xfd    ; ??? 'ignore according to docs' but used for something: maybe FAT ID 0xFD to indicate 360 KB?
; _0x16:dw 2       ; sectors per FAT
; _0x18:dw 9       ; sectors per track
; _0x1a:dw 2       ; number of heads
; _0x1c:db 0       ; -
; _0x1d:db 0       ; -
; _0x1e:db 0       ; - used but for what? is set to 1 

; begin:

incbin "cashman_ORG.img",($-$$) 

; times (360*1024)-($-$$) db 0




; org 0
; cpu 8086

; jmp 0xd8
; adc ax,[bx+si]
; clc
; add cl,[bx]
; add bh,bh
; add ah,[di]
; cmp dh,[si]
; adc sp,[es:bx+si]
; add sp,[bx+si]
; jz 0x3b

; db 0x60,0x22,0xEA,0x22,0xB6,0x26,0x5D,0x24,0x00,0x24,0x6E,0x2A,0x18,0x2A,0xFE,0xC6,0x80,0xFE,0x09,0x72,0x18,0xB6,0x01,0xFE,0xC2,0x8A,0xC2

; out 0xe,al
; mov al,0x18
; out 0x8,al
; mov al,0x0
; out 0x1c,al
; aam
; in al,0x8
; test al,0x1
; jnz 0x3c
; mov al,dh
; out 0xc,al
; mov bp,dx
; mov dx,0x8
; mov si,0x71
; mov bh,0x2
; mov bl,0x96
; mov ah,0x0
; mov al,0x80
; out 0x8,al
; mov sp,di
; aam
; aam
; aam
; aam
; in al,dx
; sar al,1
; jnc 0x83
; jnz 0x62
; in al,dx
; and al,bl
; jz 0x69
; in al,0xe
; stosb
; in al,dx
; dec ax
; jz 0x71
; cmp al,bh
; jnz 0x83
; in al,0xe
; stosb
; in al,dx
; cmp al,bh
; jz 0x79
; jmp si
; in al,dx
; mov dx,bp
; test al,0x1c
; jz 0x8e
; mov di,sp
; jmp short 0x42
; loop 0x23
; mov di,0x0
; mov es,di
; mov ax,0x50
; mov cx,0x200
; rep stosw
; mov ds,ax
; mov bx,ds
; mov byte [bx],0xcf
; mov di,0x3ec
; mov ax,0x2014
; stosw
; mov ax,0x7f5
; stosw
; mov bx,0x3
; xor dx,dx
; mov ax,[cs:bx]
; mov dl,ah
; out dx,al
; add bx,byte +0x2
; cmp bx,byte +0x23
; jnz 0xb4
; mov ax,0x100
; mov ss,ax
; mov sp,0x50
; mov al,0x35
; out 0x3a,al
; mov al,0xf0
; out 0x2,al
; sti
; jmp 0x7f5:0x0

; cli
; cld
; mov ax,0x1c00
; mov es,ax
; mov di,0x0
; mov ax,0x0
; mov cx,0x2000
; rep stosw
; mov al,0x5
; out 0x10,al
; mov ax,cs
; mov ds,ax
; mov ax,0x7f5
; mov es,ax
; mov di,0x0
; mov dl,0x1
; mov dh,0x1
; mov cx,0x48
; jmp 0x2e
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; mov ax,0xa00
; mov ds,ax
; call 0x214
; call 0x163a
; call 0x161a
; call 0x12da
; call 0x1dea
; mov word [0x28b],0xffff
; mov word [0x290],0x0
; mov byte [0x23a],0x0
; mov byte [0x23b],0x0
; mov sp,0x50
; call 0x1351
; call 0x164e
; call 0x151b
; call 0x51b
; call 0x1243
; call 0x1f4
; call 0x19f
; int 0xfb
; call 0x8fa
; call 0x720
; call 0xe3c
; call 0x817
; call 0xda3
; int 0xfb
; call 0x773
; call 0x1e11
; call 0x20a9
; int 0xfb
; call 0x614
; call 0x2106
; int 0xfb
; call 0xed3
; call 0xa42
; int 0xfb
; call 0xa80
; int 0xfb
; call 0x18c8
; call 0x16f8
; int 0xfb
; call 0x1917
; int 0xfb
; call 0x13e1
; int 0xfb
; call 0x24d
; call 0x1549
; jmp short 0x152
; cmp byte [0x284],0x1
; ja 0x1af
; mov al,0x1
; out 0x30,al
; mov al,0x50
; out 0x32,al
; ret
; call 0x1a5b
; mov bx,0x3e8
; xor ah,ah
; shl ax,1
; shl ax,1
; add bx,ax
; xor ah,ah
; mov al,0x1
; out 0x30,al
; mov al,ah
; out 0x32,al
; mov cx,bx
; loop 0x1c9
; inc ah
; cmp ah,0x51
; jc 0x1bf
; ret
; call 0x1a5b
; mov bx,0x3e8
; xor ah,ah
; shl ax,1
; shl ax,1
; add bx,ax
; mov ah,0x50
; mov al,0x1
; out 0x30,al
; mov al,ah
; out 0x32,al
; mov cx,bx
; loop 0x1ed
; dec ah
; jns 0x1e3
; ret
; push es
; mov di,0x141
; mov al,0xff
; mov cx,0x40
; mov dx,0x1c00
; salc
; add al,0x54
; push word 0x2065
; push sp
; imul bp,[di+0x65],word 0x4220
; popa
; outsb
; imul si,[fs:si+0x20],word 0x666f
; and [bx+0x6c],cl
; xor [fs:bx+di],dh
; xor dh,[bp+di]
; cmp [bx+si],dh
; inc bx
; inc cx
; push bx
; dec ax
; dec bp
; inc cx
; dec si
; add word [bp+di],0x6154
; jc 0x2a5
; popa
; outsb
; and [si+0x6f],ch
; outsw
; imul si,[bp+di+0x20],byte +0x66
; outsw
; jc 0x258
; inc bx
; inc cx
; push bx
; dec ax
; and [bx+si],dh
; xor [bx+si],bh
; cmp [bx],si
; xor [bx+di+0x43],al
; push dx
; dec di
; inc dx
; inc cx
; push sp
; les ax,[bx+di]
; inc dx
; imul bp,[bx+0x6e],word 0x6369
; and [di+0x61],cl
; outsb
; and [si+0x65],dl
; jnc 0x2cf
; jnc 0x27d
; push ax
; popa
; jc 0x2d5
; jnc 0x293
; xor [si],dh
; xor ax,0x3032
; inc si
; inc cx
; dec sp
; dec sp
; inc di
; push bp
; pop cx
; cmp al,0x1
; inc bx
; popa
; jo 0x2e9
; popa
; imul bp,[bp+0x20],word 0x7243
; jnz 0x2e2
; insb
; sub ax,0x2061
; inc sp
; gs insb
; jz 0x2e7
; outsb
; xor [bx+si],dh
; xor si,[bx+di]
; xor [ss:bp+si+0x55],cl
; dec bp
; push ax
; dec bp
; inc cx
; dec si
; out dx,ax
; add [bp+si],ah
; push di
; popa
; jz 0x2fe
; push word 0x7420
; push word 0x2065
; inc dx
; imul si,[bp+si+0x64],word 0x2279
; and [bp+si+0x6f],al
; bound sp,[bx+si]
; xor [bx+si],dh
; xor dh,[bp+di]
; cmp [bx+si],si
; inc dx
; pop cx
; push dx
; inc sp
; dec bp
; inc cx
; dec si
; add [edx+0x69],cl
; insw
; bound bp,[bx+0x20]
; jz 0x32b
; and [gs:bp+di+0x68],al
; imul bp,[di+0x70],word 0x6e61
; jpe 0x333
; and [gs:bx+si],ah
; xor [bx+si],dh
; xor [bx+si],si
; xor si,[bx+si]
; inc dx
; inc cx
; inc di
; inc dx
; dec di
; pop cx
; aas
; sbb [bx+si],ax
; inc bp
; jpe 0x304
; push di
; jnz 0x361
; outsw
; outsw
; outsb
; and [si+0x68],dh
; and [gs:bx+0x6f],al
; outsw
; outsb
; and [bx+si],ah
; and [bx+si],dh
; xor [bx+si],dh
; xor dh,[di]
; xor [di+0x47],al
; inc di
; dec ax
; inc bp
; inc cx
; inc sp
; or al,[bx+si]
; push sp
; push word 0x2065
; push sp
; gs jc 0x37f
; imul sp,[bp+si+0x6c],word 0x2065
; inc di
; jnz 0x383
; imul si,[bp+di+0x20],byte +0x20
; and [bx+si],ah
; xor [bx+si],dh
; xor [bx+di],dh
; xor [bx+si],dh
; dec bx
; inc cx
; push sp
; inc dx
; inc cx
; dec cx
; push sp
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add ah,bh
; add [bp+si],al
; add ah,bh
; db 0xff
; db 0xfe
; cld
; clc
; lock out 0xe4,al
; loopne 0x31d
; rol al,byte 0x80
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; db 0xfe
; inc word [bx+si]
; add dh,bh
; inc word [bx+si]
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [0xc3],al
; add [0xc3],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [0xc3],bh
; add [0xc3],bh
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [0xc3],al
; add [0xc3],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [0xc3],al
; add [0xc3],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add dh,bh
; inc word [bx+si]
; add dh,bh
; inc word [bx+si]
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add dh,bh
; db 0xff
; db 0xfe
; inc word [bx+si]
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [0x6c3],al
; ret
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; ds ret
; ds ret
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; push es
; ret
; push es
; ret
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; push es
; ret
; push es
; ret
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; db 0xfe
; db 0xff
; db 0xfe
; inc word [bx+si]
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add dh,bh
; inc word [bx+si]
; add dh,bh
; inc word [bx+si]
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add al,al
; ret
; add [bx+si],al
; rol bl,byte 0x0
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add dh,bh
; ret
; add [bx+si],al
; inc bl
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; push es
; ret
; add [bx+si],al
; push es
; ret
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; mov bl,0x0
; add dh,al
; ret
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; jng 0x4ad
; add [bx+si],al
; jng 0x4b1
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; db 0xfe
; db 0xff
; db 0xfe
; inc word [bx+si]
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add al,al
; ret
; rol bl,byte 0x0
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add dh,bh
; ret
; inc bl
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; push es
; ret
; push es
; ret
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; mov bl,0xc6
; ret
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; jng 0x519
; jng 0x51b
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bp+di],al
; add [bx+si],al
; add [bp+di],al
; pop ds
; out dx,ax
; add [bx+si],al
; pop ds
; out dx,ax
; lock add [bx+si],al
; add al,dh
; add [bx+si],al
; pop es
; add [bx+si],al
; add [bx],al
; sbb [si+0x0],ch
; add [bx+si],bl
; insb
; xor [bx+si],al
; add [bx+si],al
; xor [bx+si],al
; add [bp+di],al
; add [bx+si],al
; add [bp+di],al
; sbb [si+0x0],ch
; add [bx+si],bl
; insb
; xor [bx+si],al
; add [bx+si],al
; xor [bx+si],al
; add [bp+di],al
; add [bx+si],al
; add [bp+di],al
; sbb [si+0x0],ch
; add [bx+si],bl
; insb
; xor [bx+si],al
; add [bx+si],al
; xor [bx+si],al
; add [bp+di],al
; add [bx+si],al
; add [bp+di],al
; pop ax
; insb
; add [bx+si],al
; pop ax
; insb
; xor [bx+si],al
; add [bx+si],al
; xor [bx+si],al
; add [bx],cl
; add [bx+si],al
; add [bx],cl
; fucomip st7
; add [bx+si],al
; fucomip st7
; lock add [bx+si],al
; add al,dh
; add [bx+si],al
; add ax,[bx+si]
; add ax,[bx+si]
; add [bx],bl
; out dx,ax
; pop ds
; out dx,ax
; add [bx+si],al
; lock add al,dh
; add [bx+si],al
; add [bx+si],al
; pop es
; add [bx],al
; add [bx+si],al
; sbb [si+0x18],ch
; insb
; add [bx+si],al
; xor [bx+si],al
; xor [bx+si],al
; add [bx+si],al
; add [bp+di],al
; add [bp+di],al
; add [bx+si],al
; sbb [si+0x18],ch
; insb
; add [bx+si],al
; xor [bx+si],al
; xor [bx+si],al
; add [bx+si],al
; add [bp+di],al
; add [bp+di],al
; add [bx+si],al
; sbb [si+0x18],ch
; insb
; add [bx+si],al
; xor [bx+si],al
; xor [bx+si],al
; add [bx+si],al
; add [bp+di],al
; add [bp+di],al
; add [bx+si],al
; pop ax
; insb
; pop ax
; insb
; add [bx+si],al
; xor [bx+si],al
; xor [bx+si],al
; add [bx+si],al
; add [bx],cl
; add [bx],cl
; add [bx+si],al
; fucomip st7
; fucomip st7
; add [bx+si],al
; lock add al,dh
; add [bx+si],al
; add [bx+si],al
; pop es
; add [bx+si],al
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; mov ax,0xa00
; mov ds,ax
; call 0xf04
; call 0x232a
; call 0x230a
; call 0x1fca
; call 0x2ada
; mov word [0x28b],0xffff
; mov word [0x290],0x0
; mov byte [0x23a],0x0
; mov byte [0x23b],0x0
; mov sp,0x50
; call 0x2041
; call 0x233e
; call 0x220b
; call 0x120b
; call 0x1f33
; call 0xee4
; call 0xe8f
; int 0xfb
; call 0x15ea
; call 0x1410
; call 0x1b2c
; call 0x1507
; call 0x1a93
; int 0xfb
; call 0x1463
; call 0x2b01
; call 0x2d99
; int 0xfb
; call 0x1304
; call 0x2df6
; int 0xfb
; call 0x1bc3
; call 0x1732
; int 0xfb
; call 0x1770
; int 0xfb
; call 0x25b8
; call 0x23e8
; int 0xfb
; call 0x2607
; int 0xfb
; call 0x20d1
; int 0xfb
; call 0xf3d
; call 0x2239
; jmp short 0xe42
; cmp byte [0x284],0x1
; ja 0xe9f
; mov al,0x1
; out 0x30,al
; mov al,0x50
; out 0x32,al
; ret
; call 0x274b
; mov bx,0x3e8
; xor ah,ah
; shl ax,1
; shl ax,1
; add bx,ax
; xor ah,ah
; mov al,0x1
; out 0x30,al
; mov al,ah
; out 0x32,al
; mov cx,bx
; loop 0xeb9
; inc ah
; cmp ah,0x51
; jc 0xeaf
; ret
; call 0x274b
; mov bx,0x3e8
; xor ah,ah
; shl ax,1
; shl ax,1
; add bx,ax
; mov ah,0x50
; mov al,0x1
; out 0x30,al
; mov al,ah
; out 0x32,al
; mov cx,bx
; loop 0xedd
; dec ah
; jns 0xed3
; ret
; push es
; mov di,0x141
; mov al,0xff
; mov cx,0x40
; mov dx,0x1c00
; mov es,dx
; or [es:di],al
; mov dx,0xf400
; mov es,dx
; or [es:di],al
; add di,byte +0x4
; loop 0xeed
; pop es
; ret
; cli
; mov al,0x5
; out 0x10,al
; xor ax,ax
; mov es,ax
; mov ax,0x2014
; mov di,0x3ec
; cld
; stosw
; mov ax,cs
; stosw
; sti
; ret
; push si
; xor ch,ch
; mov si,0x21a
; cbw
; add si,ax
; add [si],cx
; add si,byte +0x6
; mov bx,si
; mov si,bx
; inc byte [si]
; cmp byte [si],0xa
; jnl 0xf37
; loop 0xf2a
; pop si
; ret
; mov byte [si],0x0
; dec si
; jmp short 0xf2c
; cmp byte [0x284],0x2
; jc 0xf62
; mov di,0x5915
; mov si,0x21c
; mov bl,0x3
; call 0xf57
; mov di,0x5925
; mov si,0x224
; mov bl,0x6
; mov cx,0x6
; test byte [si],0xff
; jnz 0xf63
; inc si
; loop 0xf5a
; ret
; lodsb
; or al,0x30
; mov [di],al
; inc di
; loop 0xf63
; mov al,bl
; jmp 0x129c
; mov di,0x4b
; mov byte [0x1aa],0xa
; test byte [di+0x18],0xff
; jns 0xfee
; mov bl,[di+0xd]
; shl bl,1
; xor bh,bh
; jmp [bx+0x24f]
; mov al,[di]
; inc ax
; sub al,[si]
; jns 0xf92
; neg al
; cmp al,0x1
; ja 0xfee
; mov al,[si+0x1]
; sub al,0x3
; sub al,[di+0x1]
; jns 0xfa2
; neg al
; cmp al,0x9
; ja 0xfee
; mov byte [si+0x2],0x0
; mov al,[di]
; inc ax
; mov [si],al
; mov al,[0x282]
; shl al,1
; neg al
; cmp al,0x2
; jnl 0xfbc
; mov al,0x2
; mov [si+0x19],al
; mov byte [di+0x18],0x1
; push si
; push di
; xor al,al
; mov dx,0x5d70
; mov ah,[si+0x20]
; and ah,0x3
; dec ah
; jz 0xfd9
; mov al,0x8
; add dx,byte +0x6c
; mov cl,0xa
; call 0xf1a
; xchg di,si
; call 0x20a8
; xchg di,si
; pop di
; pop si
; mov byte [si+0x20],0x0
; call 0x2d40
; add di,byte +0x23
; dec byte [0x1aa]
; jz 0xffa
; jmp 0xf78
; ret
; mov al,[di]
; inc ax
; cmp al,[si]
; jnz 0xfee
; mov al,[si+0x1]
; sub al,0x5
; sub al,[di+0x1]
; jns 0x100e
; neg al
; cmp al,0xa
; ja 0xfee
; mov al,[si+0x20]
; and al,0x3
; sub al,0xb
; neg al
; cmp al,[0x1aa]
; jnz 0x1042
; test byte [di+0x20],0xff
; jnz 0xfee
; mov ax,[di+0x19]
; add ax,0x3
; cmp ax,[0x281]
; ja 0xfee
; mov al,0xb
; sub al,[0x1a9]
; mov [di+0x20],al
; and byte [si+0x20],0x3
; jmp short 0xfee
; mov al,[si+0x6]
; mov [di+0x6],al
; xor al,0x1
; mov [si+0x6],al
; mov byte [di+0x2],0x7
; cmp di,byte +0x6e
; ja 0xfee
; mov bx,0x289
; jc 0x105c
; inc bx
; dec byte [bx]
; call 0x1f33
; call 0x2d4c
; jmp short 0xfee
; mov al,[di]
; inc ax
; cmp al,[si]
; jnz 0x1064
; mov al,[di+0x1]
; dec al
; sub al,[si+0x1]
; jns 0x1079
; neg al
; cmp al,0x5
; ja 0x1064
; mov byte [di+0x18],0x1
; push si
; push di
; xor al,al
; mov dx,0x5e48
; mov ah,[si+0x20]
; and ah,0x3
; dec ah
; jz 0x1097
; mov al,0x8
; add dx,byte +0x6c
; mov cl,0x19
; call 0xf1a
; xchg di,si
; call 0x20a8
; xchg di,si
; pop di
; pop si
; mov byte [si+0x20],0x0
; mov byte [si+0x2],0x0
; mov byte [si+0x19],0x3
; call 0x2d58
; jmp 0xfee
; mov di,0x4b
; mov byte [0x1aa],0xa
; test byte [di+0x18],0xff
; jns 0x1138
; mov al,[0x1a9]
; cmp al,[0x1aa]
; jz 0x1138
; mov bl,[di+0xd]
; shl bl,1
; xor bh,bh
; jmp [bx+0x23f]
; mov al,[si]
; cmp al,[di]
; jnz 0x1138
; mov al,[si+0x1]
; sub al,[di+0x1]
; jns 0x10e9
; neg al
; cmp al,0xf
; ja 0x1138
; xor byte [si+0x6],0x1
; xor byte [di+0x6],0x1
; mov byte [si+0x2],0x7
; mov byte [di+0x2],0x7
; jmp short 0x1138
; mov al,[di]
; cmp al,[si]
; jnz 0x1138
; mov al,[si+0x1]
; add al,0x2
; sub al,[di+0x1]
; jns 0x1111
; neg al
; cmp al,0xd
; ja 0x1138
; xor byte [si+0x6],0x1
; mov byte [si+0x2],0x7
; mov byte [di+0x18],0x1
; mov byte [si+0x7],0x0
; cmp si,byte +0x6e
; ja 0x1138
; mov bx,0x289
; jc 0x1130
; inc bx
; dec byte [bx]
; call 0x1f33
; call 0x2d64
; add di,byte +0x23
; dec byte [0x1aa]
; jz 0x1144
; jmp 0x10bf
; ret
; mov al,[si]
; inc ax
; cmp al,[di]
; jnz 0x1138
; mov al,[si+0x1]
; add al,0x5
; sub al,[di+0x1]
; jns 0x1158
; neg al
; cmp al,0xa
; ja 0x1138
; mov byte [di+0x18],0x1
; push si
; push di
; xor al,al
; mov dx,0x5bc0
; cmp si,byte +0x6e
; jc 0x1171
; mov al,0x8
; add dx,byte +0x6c
; mov cl,0x3
; call 0xf1a
; xchg di,si
; call 0x20a8
; xchg di,si
; pop di
; pop si
; call 0x2d70
; jmp short 0x1138
; test byte [si+0x20],0xff
; jnz 0x1138
; test byte [di+0x20],0xff
; js 0x1138
; mov al,[si]
; inc ax
; cmp al,[di]
; jnz 0x1138
; mov al,[si+0x1]
; add al,0x5
; sub al,[di+0x1]
; jns 0x11a3
; neg al
; cmp al,0xa
; ja 0x1138
; mov al,0xb
; sub al,[0x1a9]
; mov [di+0x20],al
; mov al,0xb
; sub al,[0x1aa]
; mov [si+0x20],al
; call 0x2d76
; jmp 0x1138
; mov al,[si]
; cmp al,[di]
; jnz 0x11bc
; mov al,[si+0x1]
; add al,0x3
; sub al,[di+0x1]
; jns 0x11d1
; neg al
; cmp al,0xa
; ja 0x11bc
; mov ax,[di+0x2]
; mov [si+0x2],ax
; mov byte [di+0x6],0x0
; mov ax,[di+0x6]
; mov [si+0x6],ax
; jmp 0x1138
; mov ah,[si+0x20]
; mov di,0x28
; mov al,0x23
; mul ah
; add di,ax
; or byte [di+0x20],0x80
; mov byte [di+0x2],0x7
; mov byte [di+0x3],0x0
; mov byte [si+0x20],0x0
; mov ax,[0x281]
; mov [si+0x19],ax
; ret
; mov di,0x1ab
; mov si,0x1dd
; cmp byte [0x284],0x1
; ja 0x1225
; mov si,0x1c4
; test byte [0x28f],0xff
; jns 0x1225
; mov si,0x1f6
; mov cx,0x19
; mov ax,0xa00
; mov es,ax
; rep movsb
; call 0x1236
; call 0x1285
; ret
; test byte [0x28f],0xff
; jns 0x123e
; ret
; mov al,[0x5b83]
; add al,0x12
; mov [0x1b9],al
; mov al,[0x283]
; add al,0x16
; mov [0x1c0],al
; cmp byte [0x284],0x2
; jc 0x126e
; test byte [0x287],0xff
; jnz 0x1261
; mov byte [0x1ae],0x0
; test byte [0x288],0xff
; jnz 0x126d
; mov byte [0x1b1],0x0
; ret
; mov al,[0x284]
; add al,0x10
; mov [0x1bc],al
; mov al,[0x286]
; or al,al
; jnz 0x127f
; mov al,0xf8
; add al,0x1c
; mov [0x1c3],al
; ret
; mov byte [0x23e],0x0
; mov al,[0x23e]
; call 0x129c
; inc byte [0x23e]
; cmp byte [0x23e],0x19
; jnz 0x128a
; ret
; push ds
; push es
; push bx
; xor ch,ch
; mov cl,al
; mov bx,0x1ab
; xlatb
; mov bx,0x56dc
; xor ah,ah
; shl ax,1
; shl ax,1
; shl ax,1
; shl ax,1
; add bx,ax
; mov ax,0x280
; mul cx
; add ax,0x100
; mov di,ax
; mov byte [0x297],0x10
; mov ax,0xa00
; mov ds,ax
; mov al,[bx]
; inc bx
; cmp al,0xd
; ja 0x12d6
; mov [0x29d],al
; mov al,0x20
; cmp al,0xe0
; jc 0x12dc
; sub al,0xe0
; call 0x13a2
; dec byte [0x297]
; jnz 0x12c5
; pop bx
; pop es
; pop ds
; ret
; call 0x274b
; and al,0x14
; jnz 0x12f8
; add byte [si+0x8],0x2
; and byte [si+0x8],0x6
; call 0x274b
; and al,0x74
; jnz 0x1303
; xor byte [si+0x6],0x1
; ret
; test byte [0x284],0xff
; jz 0x1315
; cmp byte [0x284],0x1
; jnz 0x1303
; jmp short 0x1345
; nop
; mov si,0x4b
; call 0x12e9
; mov si,0x6e
; call 0x12e9
; test byte [0x23b],0xff
; jnz 0x136c
; mov byte [0x23b],0x1
; mov bp,0x5510
; mov ax,[ds:bp+0x0]
; cmp ax,0x0
; jz 0x136c
; mov bx,[ds:bp+0x2]
; call 0x1370
; add bp,byte +0x4
; jmp short 0x1330
; call 0x2cb5
; test byte [0x23b],0xff
; jnz 0x136c
; mov byte [0x23b],0x1
; mov bp,0x5562
; mov ax,[ds:bp+0x0]
; cmp ax,0x0
; jz 0x136c
; mov bx,[ds:bp+0x2]
; call 0x1370
; add bp,byte +0x4
; jmp short 0x1357
; ret
; pop es
; pop ds
; ret
; push ds
; push es
; push bx
; mov bl,al
; mov al,ah
; xor ah,ah
; shl ax,1
; shl ax,1
; shl ax,1
; mov di,ax
; xor bh,bh
; shl bx,1
; add di,[bx+0x7e0]
; pop bx
; mov ax,0xa00
; mov ds,ax
; mov al,[bx]
; inc bx
; cmp al,0xd
; jz 0x136d
; ja 0x139d
; mov [0x29d],al
; jmp short 0x138a
; call 0x13a2
; jmp short 0x138a
; push ds
; push si
; push cx
; mov dx,0xff00
; mov es,dx
; xor ah,ah
; shl ax,1
; shl ax,1
; shl ax,1
; mov si,ax
; mov cx,0x8
; push di
; mov ah,[0x29d]
; mov al,[es:si]
; inc si
; mov dx,0xf400
; mov ds,dx
; test ah,0x1
; jz 0x13ce
; mov [di],al
; jmp short 0x13d0
; mov [di],dl
; mov dx,0x1c00
; mov ds,dx
; test ah,0x2
; jz 0x13de
; mov [di],al
; jmp short 0x13e1
; mov byte [di],0x0
; mov dx,0xf000
; mov ds,dx
; test ah,0x4
; jz 0x13ef
; mov [di],al
; jmp short 0x13f1
; mov [di],dl
; inc di
; test di,0x3
; jz 0x1402
; loop 0x13bc
; pop di
; add di,byte +0x4
; pop cx
; pop si
; pop ds
; ret
; add di,0x13c
; loop 0x13bc
; pop di
; add di,byte +0x4
; pop cx
; pop si
; pop ds
; ret
; cmp byte [0x284],0x1
; ja 0x1418
; ret
; cmp byte [0x296],0xe
; jnz 0x1426
; inc byte [0x284]
; jmp 0xe14
; cmp byte [0x296],0x1
; jnz 0x1432
; jmp 0x7f5:0x0
; cmp byte [0x296],0x2
; jnz 0x143c
; jmp 0x14f9
; cmp byte [0x296],0x3
; jnz 0x1461
; xor byte [0x1bc],0x1
; mov al,0x11
; call 0x129c
; call 0x15ea
; cmp byte [0x296],0x3
; jnz 0x144d
; xor byte [0x1bc],0x1
; mov al,0x11
; call 0x129c
; ret
; ret
; test byte [0x285],0xff
; jnz 0x1462
; test byte [0x28f],0xff
; js 0x1462
; cmp byte [0x282],0x1
; jz 0x1499
; cmp byte [0x296],0x1
; jz 0x149c
; cmp byte [0x296],0x2
; jz 0x14ca
; cmp byte [0x296],0x3
; jz 0x14db
; cmp byte [0x296],0x4
; jz 0x14f9
; cmp byte [0x296],0x5
; jz 0x14f1
; ret
; mov al,[0x286]
; or al,al
; jnz 0x14a9
; mov word [0x287],0x101
; ror al,1
; jnc 0x14b1
; inc byte [0x287]
; ror al,1
; jnc 0x14b9
; inc byte [0x288]
; inc byte [0x285]
; mov bx,0x277
; mov al,[0x283]
; xlatb
; mov [0x284],al
; jmp 0xe14
; inc byte [0x286]
; and byte [0x286],0x3
; call 0x1236
; mov al,0x18
; jmp 0x129c
; mov al,[0x283]
; inc al
; cmp al,0x6
; jl 0x14e6
; xor al,al
; mov [0x283],al
; call 0x1236
; mov al,0x15
; jmp 0x129c
; xor byte [0x284],0x1
; jmp 0xe14
; xor byte [0x5b83],0x1
; call 0x1236
; mov al,0xe
; jmp 0x129c
; ret
; test byte [0x285],0xff
; jz 0x1506
; mov si,0x4b
; mov byte [0x1a9],0x2
; test byte [si+0x18],0xff
; jns 0x151f
; call 0x2a20
; cmp byte [0x1a9],0x2
; jz 0x152d
; cmp byte [0x286],0x0
; jnz 0x153a
; mov al,[si+0xb]
; and al,[si+0xe]
; jnz 0x153a
; mov word [si+0x2],0x0
; test byte [si+0x18],0xff
; js 0x1543
; jmp 0x15c4
; test byte [si+0x20],0xff
; jz 0x1551
; call 0x163d
; jz 0x1551
; call 0x11e8
; mov al,[si+0xb]
; and al,[si+0xe]
; jnz 0x15d1
; xor ah,ah
; test byte [si+0xe],0xff
; jz 0x157a
; cmp byte [0x283],0x3
; jz 0x159b
; call 0x164a
; jz 0x159b
; mov byte [0x29e],0x8
; mov ah,0x7
; mov byte [si+0x7],0x0
; jmp short 0x159b
; call 0x16de
; jz 0x159e
; mov ah,0x7
; mov al,[si+0x7]
; jns 0x1592
; or al,al
; jz 0x159b
; xor ah,ah
; mov byte [si+0x7],0x0
; jmp short 0x159b
; or al,al
; jnz 0x159b
; xor ah,ah
; inc byte [si+0x7]
; mov [si+0x3],ah
; xor ah,ah
; call 0x1688
; jz 0x15c4
; mov ah,0x7
; mov al,[si+0x6]
; jns 0x15b8
; or al,al
; jz 0x15c1
; xor ah,ah
; mov byte [si+0x6],0x0
; jmp short 0x15c1
; or al,al
; jnz 0x15c1
; xor ah,ah
; inc byte [si+0x6]
; mov [si+0x2],ah
; add si,byte +0x23
; dec byte [0x1a9]
; jz 0x15d0
; jmp 0x151f
; ret
; test byte [si+0x2],0xff
; jnz 0x15c4
; call 0x1688
; jz 0x15c4
; jns 0x15e4
; mov byte [si+0x6],0x0
; jmp short 0x15c4
; mov byte [si+0x6],0x1
; jmp short 0x15c4
; mov ah,0x1
; call 0x2e68
; jz 0x162b
; xor ah,ah
; call 0x2e68
; mov [0x296],al
; cmp al,0xa
; jz 0x1631
; cmp al,0x1f
; jz 0x1637
; cmp al,0x0
; jnz 0x1630
; cmp ah,0x3b
; jc 0x162b
; cmp ah,0x3f
; ja 0x1617
; sub ah,0x3a
; mov [0x296],ah
; ret
; cmp ah,0x47
; jc 0x162b
; cmp ah,0x51
; ja 0x162b
; mov bx,0x1c8
; mov al,ah
; xlatb
; mov [0x296],al
; ret
; mov byte [0x296],0x0
; ret
; mov byte [0x296],0x31
; ret
; mov byte [0x296],0x35
; ret
; cmp byte [0x1a9],0x1
; jz 0x1657
; test byte [0x5503],0xff
; ret
; cmp byte [0x1a9],0x2
; jnz 0x166e
; test byte [0x5502],0xff
; ret
; cmp byte [0x286],0x0
; jnz 0x1664
; test byte [0x5507],0xff
; ret
; cmp byte [0x296],0x8
; jnz 0x1685
; or al,0x1
; ret
; cmp byte [0x286],0x0
; jnz 0x167b
; test byte [0x5506],0xff
; ret
; cmp byte [0x296],0xd
; jnz 0x1685
; or al,0x1
; ret
; xor al,al
; ret
; cmp byte [0x1a9],0x2
; jnz 0x16a0
; cmp byte [0x5500],0x20
; jc 0x16d6
; cmp byte [0x5500],0x8c
; ja 0x16d9
; xor al,al
; ret
; cmp byte [0x286],0x0
; jnz 0x16b8
; cmp byte [0x5504],0x20
; jc 0x16d6
; cmp byte [0x5504],0x8c
; ja 0x16d9
; xor al,al
; ret
; mov al,[0x296]
; cmp al,0x37
; jz 0x16d6
; cmp al,0x34
; jz 0x16d6
; cmp al,0x31
; jz 0x16d6
; cmp al,0x39
; jz 0x16d9
; cmp al,0x36
; jz 0x16d9
; cmp al,0x33
; jz 0x16d9
; xor al,al
; ret
; or al,0x80
; ret
; xor al,al
; inc al
; ret
; cmp byte [0x1a9],0x2
; jnz 0x16f6
; cmp byte [0x5501],0x28
; jc 0x172f
; cmp byte [0x5501],0x8c
; ja 0x172a
; xor al,al
; ret
; cmp byte [0x286],0x0
; jnz 0x170e
; cmp byte [0x5505],0x28
; jc 0x172f
; cmp byte [0x5505],0x8c
; ja 0x172a
; xor al,al
; ret
; mov al,[0x296]
; cmp al,0x37
; jc 0x171c
; cmp al,0x39
; jna 0x172f
; xor al,al
; ret
; cmp al,0x35
; jz 0x172a
; cmp al,0x31
; jz 0x172a
; cmp al,0x33
; jz 0x172a
; jmp short 0x1719
; xor al,al
; inc al
; ret
; or al,0x80
; ret
; mov al,[0x293]
; and al,[0x29e]
; jnz 0x173c
; ret
; mov al,[0x292]
; or al,al
; js 0x174f
; dec al
; mov [0x292],al
; cmp al,0x8
; jnz 0x173b
; jmp 0x21d7
; mov al,[0x295]
; test byte [0x294],0xff
; jz 0x1762
; inc ax
; cmp al,0x1d
; ja 0x176a
; mov [0x295],al
; ret
; dec al
; js 0x176a
; mov [0x295],al
; ret
; xor byte [0x294],0x1
; ret
; mov di,[0x28b]
; mov si,[0x28d]
; mov al,[0x295]
; xor ah,ah
; shl ax,1
; shl ax,1
; shl ax,1
; mov [0x28b],ax
; mov ax,0x5f20
; test byte [0x281],0x2
; jz 0x1793
; add ax,0xd8
; mov [0x28d],ax
; cmp di,0xffff
; jz 0x17a2
; mov cx,0xc
; call 0x267e
; mov di,[0x28b]
; mov si,[0x28d]
; mov cx,0xc
; call 0x267e
; ret
; inc byte [0x280]
; mov al,[0x280]
; cmp al,[0x27f]
; jz 0x17bf
; ret
; call 0xec3
; call 0x230a
; mov byte [0x29d],0x7
; mov bx,0x594
; mov ax,0x95a
; call 0x1370
; call 0xe9f
; mov cx,0x1a01
; dec cx
; jz 0x17fd
; or cl,cl
; jnz 0x17f4
; mov al,ch
; or al,0x4
; mov [0x29d],al
; mov bx,0x594
; mov ax,0x95a
; push cx
; call 0x1370
; pop cx
; jmp short 0x17d9
; push cx
; mov cx,0x32
; loop 0x17f8
; pop cx
; jmp short 0x17d9
; call 0xec3
; mov al,[0x284]
; inc al
; cmp al,[0x106e]
; jna 0x1817
; mov byte [0x284],0x2
; mov byte [0x283],0x0
; jmp short 0x182f
; mov [0x284],al
; mov ah,al
; push bx
; mov bx,0x277
; mov al,[0x283]
; inc al
; xlatb
; pop bx
; cmp ah,al
; jc 0x182f
; inc byte [0x283]
; jmp 0xe14
; mov ch,[ds:bp+0x0]
; mov ah,ch
; and ah,0xfc
; dec ch
; and ch,0x3
; or ch,ah
; mov al,[si]
; mov ah,[si+0x1]
; sub ah,al
; inc ah
; mov [0x23c],ah
; mov ah,[si+0x2]
; test byte [0x23a],0xff
; jz 0x185e
; push ax
; call 0x186b
; pop ax
; mov ch,[ds:bp+0x0]
; jmp short 0x186b
; nop
; mov word [0x23c],0x7
; push bx
; push si
; push di
; mov cl,ah
; xor ah,ah
; shl ax,1
; mov bx,0x7e0
; add bx,ax
; mov al,cl
; xor ah,ah
; shl al,1
; shl al,1
; shl al,1
; mov [0x27d],ax
; mov al,ch
; sub al,0x21
; mov ah,0x24
; mul ah
; mov si,0x970
; add si,ax
; mov cx,[0x23c]
; mov dl,0x6
; mov di,[bx]
; add di,[0x27d]
; mov ax,0xf400
; mov es,ax
; lodsw
; xor [es:di],al
; xor [es:di+0x4],ah
; mov ax,0x1c00
; mov es,ax
; lodsw
; xor [es:di],al
; xor [es:di+0x4],ah
; mov ax,0xf000
; mov es,ax
; lodsw
; xor [es:di],al
; xor [es:di+0x4],ah
; inc bx
; inc bx
; dec dl
; jnz 0x18d1
; sub si,byte +0x24
; mov dl,0x6
; loop 0x1899
; pop di
; pop si
; pop bx
; ret
; add ah,[si+0x1b]
; mov dx,ax
; mov di,[si+0x10]
; mov bx,[si+0x12]
; mov ah,dh
; mov al,[bx]
; or al,al
; jz 0x1908
; cmp ah,[di+0x2]
; jc 0x1908
; sub ah,[di+0x2]
; cmp ah,0x5
; jc 0x18fd
; add di,byte +0x3
; inc bx
; jmp short 0x18e2
; cmp [di],dl
; ja 0x18f7
; cmp [di+0x1],dl
; jc 0x18f7
; jmp short 0x1941
; mov di,[si+0x10]
; mov bx,[si+0x12]
; mov ah,dh
; mov al,[bx]
; or al,al
; jz 0x1929
; cmp ah,[di+0x2]
; jc 0x1932
; sub ah,[di+0x2]
; cmp ah,0x5
; jc 0x1938
; mov [si+0x10],di
; mov [si+0x12],bx
; mov dl,0xff
; mov byte [si+0xb],0x1
; mov dh,0x0
; ret
; sub di,byte +0x3
; dec bx
; jmp short 0x190e
; cmp [di],dl
; ja 0x1932
; cmp [di+0x1],dl
; jc 0x1932
; mov dl,[di+0x2]
; sub dl,[si+0x1b]
; mov byte [si+0xb],0x0
; mov byte [si+0xf],0x0
; mov al,[bx]
; cmp al,0x39
; jnz 0x1959
; inc al
; mov [bx],al
; cmp al,0x3b
; jnz 0x1961
; mov al,0x38
; mov [bx],al
; cmp al,0x4c
; jc 0x197f
; cmp si,byte +0x6e
; ja 0x197f
; push si
; push di
; push bx
; push ax
; push dx
; mov bx,0x28a
; jz 0x1975
; dec bx
; dec byte [bx]
; call 0x1f33
; pop dx
; pop ax
; pop bx
; pop di
; pop si
; mov dh,al
; mov [si+0x10],di
; mov [si+0x12],bx
; ret
; mov di,[si+0x14]
; mov bx,[si+0x16]
; add ah,0x8
; mov dx,ax
; mov al,dl
; mov ah,[bx]
; or ah,ah
; jz 0x19b0
; cmp ah,0x23
; jz 0x19aa
; cmp al,[di+0x2]
; jc 0x19b0
; jnz 0x19aa
; call 0x19fb
; add di,byte +0x3
; inc bx
; jmp short 0x1993
; mov di,[si+0x14]
; mov bx,[si+0x16]
; mov al,dl
; mov ah,[bx]
; or ah,ah
; jz 0x19ce
; cmp ah,0x23
; jz 0x19f4
; cmp al,[di+0x2]
; jna 0x19ef
; mov [si+0x14],di
; mov [si+0x16],bx
; test byte [si+0xe],0xff
; jnz 0x19ee
; inc byte [si+0xe]
; cmp byte [si+0xd],0x3
; ja 0x19e6
; xor byte [si+0xd],0x1
; push bx
; call 0x259c
; pop bx
; mov byte [si+0x8],0x0
; mov byte [si+0xc],0x1
; ret
; jnz 0x19f4
; call 0x19fb
; sub di,byte +0x3
; dec bx
; jmp short 0x19b6
; ret
; cmp byte [bx],0x3b
; ja 0x1a0b
; cmp [di],dh
; ja 0x19fa
; cmp [di+0x1],dh
; jc 0x19fa
; jmp short 0x1a58
; mov al,[di]
; sub al,0x6
; cmp al,dh
; ja 0x19fa
; mov al,[di+0x1]
; add al,0x6
; cmp al,dh
; jc 0x19fa
; cmp byte [si+0xd],0x3
; ja 0x1a8b
; call 0x17b1
; mov ch,[bx]
; mov al,[di]
; mov ah,[di+0x2]
; call 0x1865
; mov byte [bx],0x23
; push si
; push di
; push bx
; xor al,al
; mov dx,0x5c98
; cmp si,byte +0x6e
; jc 0x1a44
; mov al,0x8
; add dx,byte +0x6c
; mov cl,0x5
; call 0xf1a
; xchg di,si
; call 0x20a8
; xchg di,si
; pop bx
; pop di
; pop si
; call 0x2d7c
; jmp short 0x1a8b
; mov byte [si+0xf],0x0
; test byte [si+0xb],0xff
; jz 0x1a6e
; mov byte [si+0x2],0x0
; mov byte [si+0x3],0x0
; mov byte [si+0xb],0x0
; test byte [si+0xe],0xff
; jz 0x1a8b
; cmp byte [si+0xd],0x3
; ja 0x1a8b
; xor byte [si+0xd],0x1
; push bx
; call 0x259c
; pop bx
; mov byte [si+0x8],0x0
; mov byte [si+0xe],0x0
; mov [si+0x14],di
; mov [si+0x16],bx
; pop ax
; ret
; mov si,0x91
; mov byte [0x1a9],0x8
; test byte [0x284],0xff
; jz 0x1ab8
; cmp byte [si+0xd],0x4
; jz 0x1ac1
; cmp byte [si+0xd],0x6
; jz 0x1af8
; add si,byte +0x23
; dec byte [0x1a9]
; jnz 0x1a9b
; ret
; cmp byte [0x1a9],0x4
; jc 0x1aa2
; jmp short 0x1aae
; call 0x274b
; test al,0x7
; jz 0x1ad2
; test al,0x8
; jz 0x1aae
; mov byte [si+0x2],0x7
; jmp short 0x1aae
; test byte [si+0xb],0xff
; jz 0x1ade
; test byte [si+0xe],0xff
; jnz 0x1aae
; xor byte [si+0x6],0x1
; call 0x274b
; and al,0x1
; mov [si+0xf],al
; mov byte [si+0x2],0x7
; mov byte [si+0x3],0x7
; mov byte [si+0x7],0x0
; jmp short 0x1aae
; mov al,[0x281]
; and al,0xf
; jnz 0x1aae
; mov al,[si+0x2]
; inc ax
; cmp al,0x7
; ja 0x1b0a
; mov [si+0x2],al
; mov al,[si+0x3]
; inc ax
; cmp al,0x7
; ja 0x1b15
; mov [si+0x3],al
; call 0x274b
; test al,0x5
; jnz 0x1aae
; test al,0x2
; jz 0x1b26
; xor byte [si+0x6],0x1
; jmp short 0x1aae
; xor byte [si+0x6],0x1
; jmp short 0x1aae
; rol byte [0x29e],1
; mov ax,[0x281]
; inc ax
; jnz 0x1b37
; dec ax
; mov [0x281],ax
; cmp ah,0x3
; jnz 0x1b44
; mov byte [0x293],0xff
; and al,0x3f
; jnz 0x1b5a
; mov byte [0x292],0xe
; call 0x274b
; and ah,0x3
; jnz 0x1b5a
; xor byte [0x294],0x1
; test word [0x290],0xffff
; jz 0x1bbb
; mov ax,[0x290]
; cmp ax,[0x281]
; ja 0x1bbb
; call 0xec3
; call 0x230a
; mov byte [0x29d],0x7
; mov bx,0x572
; mov ax,0xc5a
; call 0x1370
; call 0xe9f
; mov cx,0x3501
; dec cx
; jz 0x1ba6
; or cl,cl
; jnz 0x1b9d
; mov [0x29d],ch
; mov bx,0x572
; mov ax,0xc5a
; push cx
; call 0x1370
; pop cx
; jmp short 0x1b85
; push cx
; mov cx,0x32
; loop 0x1ba1
; pop cx
; jmp short 0x1b85
; call 0xec3
; mov byte [0x284],0x1
; mov byte [0x28f],0xff
; mov byte [0x285],0x0
; jmp 0xe14
; mov ax,[0x281]
; add [0x29b],ax
; ret
; mov si,0x4b
; mov byte [0x1a9],0xa
; test byte [si+0x18],0xff
; js 0x1bd4
; jmp 0x1ea6
; mov al,[si+0xd]
; cmp al,0x3
; ja 0x1be7
; test byte [0x285],0xff
; jz 0x1be7
; call 0x10b7
; jmp short 0x1bf4
; cmp al,0x7
; jnz 0x1bf4
; test byte [si+0x20],0xff
; jns 0x1bf4
; call 0xf70
; mov al,[si+0xd]
; cmp al,0x5
; jc 0x1c49
; cmp al,0x7
; jnz 0x1c31
; mov byte [si+0xc],0x0
; cmp byte [si+0x20],0x0
; jng 0x1c49
; mov bx,0x4b
; cmp byte [si+0x20],0x1
; jz 0x1c15
; mov bx,0x6e
; mov al,[bx]
; mov ah,[bx+0x6]
; mov [si+0x6],ah
; test ah,0xff
; jz 0x1c24
; add al,0x2
; mov [si],al
; mov al,[bx+0x1]
; add al,0x7
; mov [si+0x1],al
; jmp 0x1ea6
; cmp al,0x6
; jnz 0x1c42
; test byte [si+0x7],0xff
; jz 0x1c42
; test byte [0x281],0x4
; jnz 0x1c49
; inc byte [si+0x8]
; and byte [si+0x8],0x3
; mov al,[si+0x2]
; mov bx,0x25f
; xlatb
; and al,[0x29e]
; jnz 0x1c59
; jmp 0x1cda
; xor byte [si+0xc],0x1
; jz 0x1caf
; mov al,[si]
; dec al
; test byte [si+0x6],0xff
; jz 0x1c6b
; add al,0x2
; cmp al,0xff
; jz 0x1c86
; mov ah,[si+0xd]
; cmp ah,0x5
; jc 0x1c82
; cmp ah,0x7
; jnz 0x1c82
; cmp al,0x20
; jc 0x1cad
; jmp short 0x1c86
; cmp al,0x1e
; jc 0x1cad
; mov ah,[si+0xd]
; cmp ah,0x4
; jz 0x1c99
; cmp ah,0x7
; jnz 0x1ca7
; test byte [si+0x20],0xff
; jns 0x1ca7
; call 0x274b
; and al,0x4
; jnz 0x1ca7
; mov byte [si+0x18],0x1
; jmp 0x1ea6
; xor byte [si+0x6],0x1
; jmp short 0x1caf
; mov [si],al
; mov ah,[si+0xd]
; cmp ah,0x4
; ja 0x1cda
; jnz 0x1cc2
; mov al,[si+0x8]
; inc al
; and al,0x3
; jmp short 0x1cd7
; mov al,[si+0x8]
; inc al
; and al,0x7
; test byte [si+0xd],0xff
; jz 0x1cd7
; cmp byte [si+0xd],0x2
; jz 0x1cd7
; and al,0x1
; mov [si+0x8],al
; mov al,[si+0x3]
; mov bx,0x267
; xlatb
; and al,[0x29e]
; jnz 0x1cea
; jmp 0x1d7c
; cmp byte [si+0xd],0x5
; jnz 0x1cf7
; inc byte [si+0x8]
; and byte [si+0x8],0x3
; test byte [si+0x7],0xff
; jz 0x1d3b
; cmp byte [si+0xd],0x6
; jnz 0x1d14
; add byte [si+0x1],0x2
; cmp byte [si+0x1],0xa6
; jc 0x1d11
; mov byte [si+0x7],0x0
; jmp 0x1ea6
; mov ah,[si+0x1]
; add ah,0x3
; test byte [si+0xe],0xff
; jnz 0x1d2b
; xor byte [si+0x8],0x1
; and byte [si+0x8],0x1
; add ah,0x3
; mov al,0xae
; sub al,[si+0x1b]
; cmp al,ah
; ja 0x1d36
; mov ah,al
; mov [si+0x1],ah
; jmp short 0x1d7c
; mov al,[si+0x1]
; cmp byte [si+0xd],0x6
; jnz 0x1d5f
; sub al,0x2
; jnc 0x1d59
; mov byte [si+0x7],0x1
; call 0x274b
; and al,0x8
; jnz 0x1d57
; mov byte [si+0x18],0x1
; xor al,al
; mov [si+0x1],al
; jmp 0x1ea6
; sub al,0x3
; jnc 0x1d65
; xor al,al
; test byte [si+0xe],0xff
; jnz 0x1d79
; xor byte [si+0x8],0x1
; and byte [si+0x8],0x1
; sub al,0x3
; jnc 0x1d79
; xor al,al
; mov [si+0x1],al
; test byte [0x284],0xff
; jnz 0x1d8d
; cmp byte [0x1a9],0x5
; jc 0x1d8d
; jmp 0x1ea6
; cmp byte [si+0xd],0x6
; jc 0x1d9e
; jz 0x1d9b
; test byte [si+0x20],0xff
; jns 0x1d9e
; jmp 0x1ea6
; cmp byte [si+0xd],0x5
; jz 0x1daa
; mov ax,[si]
; inc ax
; call 0x1988
; mov al,[si]
; cmp byte [si+0xd],0x5
; jz 0x1dba
; cmp byte [si+0xd],0x7
; jz 0x1dba
; inc al
; mov ah,[si+0x1]
; call 0x18d7
; cmp dl,0xff
; jnz 0x1e27
; test byte [si+0xe],0xff
; jnz 0x1dce
; jmp 0x1ea3
; mov al,0x44
; test byte [si+0xf],0xff
; jz 0x1dd8
; mov al,0x10
; and al,[0x29e]
; jz 0x1de7
; sub byte [si+0x2],0x1
; jnc 0x1de7
; inc byte [si+0x2]
; cmp byte [0x283],0x1
; jz 0x1df4
; test byte [si+0xf],0xff
; jz 0x1dfe
; test byte [0x29e],0x55
; jnz 0x1dfe
; jmp 0x1ea3
; test byte [si+0x7],0xff
; jz 0x1e13
; mov al,[si+0x3]
; inc ax
; cmp al,0x8
; jc 0x1e0d
; dec ax
; mov [si+0x3],al
; jmp 0x1ea3
; mov al,[si+0x3]
; sub al,0x1
; jnc 0x1e1c
; inc al
; mov [si+0x3],al
; jnz 0x1e25
; mov byte [si+0x7],0x1
; jmp short 0x1ea3
; mov [si+0x1],dl
; mov byte [si+0x3],0x0
; cmp byte [si+0xd],0x3
; ja 0x1e3e
; test byte [si+0x2],0xff
; jz 0x1e3e
; mov byte [si+0x2],0x7
; cmp byte [si+0xd],0x5
; jz 0x1e70
; cmp byte [si+0xd],0x7
; jnz 0x1ea3
; dec byte [si+0x19]
; mov al,[si+0x19]
; jnz 0x1e57
; call 0x2126
; jmp short 0x1ea6
; cmp al,0x8
; ja 0x1ea3
; mov bx,0x231
; xlatb
; mov [si+0x3],al
; mov byte [si+0x7],0x0
; mov byte [si+0xb],0x1
; mov byte [si+0xe],0x1
; jmp short 0x1ea6
; test byte [si+0x19],0xff
; jnz 0x1e83
; mov byte [si+0x18],0x1
; mov di,si
; call 0x210b
; mov si,di
; jmp short 0x1ea6
; mov al,[si+0x19]
; dec byte [si+0x19]
; mov [si+0x2],al
; mov [si+0x3],al
; mov byte [si+0xb],0x1
; mov byte [si+0xe],0x1
; mov byte [si+0x7],0x0
; call 0x274b
; and al,0x1
; mov [si+0x6],al
; call 0x1eb3
; add si,byte +0x23
; dec byte [0x1a9]
; jz 0x1eb2
; jmp 0x1bcb
; ret
; mov al,dh
; cmp al,0x40
; jc 0x1f1e
; cmp al,0x48
; jc 0x1f02
; cmp al,0x4b
; ja 0x1ee4
; dec byte [si+0x7]
; jz 0x1eb2
; mov al,0x7
; mov [si+0x3],al
; mov [si+0xf],al
; test byte [si+0x2],0xff
; jz 0x1ed7
; mov [si+0x2],al
; mov byte [si+0x7],0x0
; mov byte [si+0xb],0x1
; mov byte [si+0xe],0x1
; ret
; mov byte [si+0x2],0x7
; mov byte [si+0x3],0x7
; mov byte [si+0xb],0x1
; mov byte [si+0xe],0x1
; mov byte [si+0x7],0x0
; cmp byte [si+0xd],0x3
; ja 0x1f1e
; call 0x2d8d
; ret
; test al,0x3
; jnz 0x1f1e
; cmp al,0x43
; ja 0x1f12
; dec byte [si]
; mov ax,[si]
; inc ax
; jmp 0x1988
; cmp al,0x47
; ja 0x1f1e
; inc byte [si]
; mov ax,[si]
; inc ax
; jmp 0x1988
; ret
; test word [0x287],0xffff
; jnz 0x1f32
; mov dx,[0x281]
; add dx,byte +0x28
; mov [0x290],dx
; ret
; cmp byte [0x284],0x2
; jc 0x1f32
; push di
; push si
; test byte [0x63],0xff
; jns 0x1f70
; mov al,[0x289]
; test al,0xff
; jnz 0x1f63
; mov byte [0x63],0x1
; mov byte [0x287],0x0
; mov byte [0x1af],0x36
; mov al,0x4
; call 0x129c
; call 0x1f1f
; jmp short 0x1f70
; mov di,0x5932
; mov bl,0x4
; mov byte [0x1af],0x25
; call 0x1fa7
; test byte [0x86],0xff
; jns 0x1fa4
; mov al,[0x28a]
; test al,0xff
; jnz 0x1f97
; mov byte [0x86],0x1
; mov byte [0x288],0x0
; mov byte [0x1b2],0x36
; mov al,0x7
; call 0x129c
; call 0x1f1f
; jmp short 0x1fa4
; mov di,0x5942
; mov bl,0x7
; mov byte [0x1b2],0x26
; call 0x1fa7
; pop si
; pop di
; ret
; mov dx,0xa
; mov cl,al
; xor ch,ch
; or cl,cl
; jz 0x1fb9
; mov byte [di],0xe2
; inc di
; dec dx
; loop 0x1fb2
; or dx,dx
; jz 0x1fc5
; mov cx,dx
; mov byte [di],0x20
; inc di
; loop 0x1fbf
; mov al,bl
; jmp 0x129c
; mov ax,0xa00
; mov es,ax
; mov di,0x21a
; mov si,0x1228
; mov cx,0x8
; xor ax,ax
; push si
; rep stosw
; mov di,0x5915
; mov cx,0x6
; mov dx,[0x275]
; mov al,0x20
; mov [di],al
; mov [di+0x10],al
; dec dx
; inc di
; loop 0x1fe9
; push dx
; mov di,0x5932
; mov cx,0xa
; mov al,0x20
; mov [di],al
; mov [di+0x10],al
; inc di
; loop 0x1ffb
; mov di,0x58f6
; mov word [di],0x2020
; xor ax,ax
; mov [0x285],al
; mov [0x287],al
; mov [0x288],al
; mov [0x28f],al
; mov byte [0x289],0xa
; mov byte [0x28a],0xa
; mov byte [0x284],0x0
; ret
; xor ah,ah
; out 0x26,al
; in al,0x20
; mov cl,al
; in al,0x20
; mov ch,al
; or cx,0x1528
; mov [0x299],cx
; mov [0x29b],dx
; ret
; mov al,0x1
; out 0x30,al
; xor al,al
; out 0x32,al
; mov word [0x281],0x0
; mov byte [0x292],0xff
; mov byte [0x293],0xaa
; call 0x2062
; call 0x2071
; jmp 0x230a
; mov si,0x4b
; mov cx,0xa
; call 0x2101
; add si,byte +0x23
; loop 0x2068
; ret
; mov si,0x0
; mov cx,0xf
; mov byte [si],0x0
; add si,byte +0x5
; loop 0x2077
; ret
; mov cx,0x8
; mov si,0x6e
; add si,byte +0x23
; test byte [si+0x18],0xff
; jnz 0x2090
; ret
; loop 0x2086
; pop ax
; ret
; mov cx,0xf
; mov si,0xfffb
; add si,byte +0x5
; test byte [si],0xff
; jnz 0x20a4
; clc
; ret
; loop 0x209a
; stc
; ret
; push ax
; call 0x2094
; jc 0x20cf
; mov [si+0x1],dx
; mov ax,[di]
; push di
; mov bl,ah
; xor ah,ah
; shl al,1
; shl al,1
; shl al,1
; mov di,ax
; xor bh,bh
; shl bx,1
; add di,[bx+0x7e0]
; mov [si+0x3],di
; pop di
; mov byte [si],0x37
; pop ax
; ret
; mov si,0x0
; mov byte [0x1a9],0xf
; mov al,[si]
; or al,al
; jz 0x20f7
; dec byte [si]
; cmp al,0x37
; jz 0x20e9
; cmp al,0x7
; ja 0x20f7
; push si
; mov cx,0x6
; mov di,[si+0x3]
; mov si,[si+0x1]
; call 0x267e
; pop si
; add si,byte +0x5
; dec byte [0x1a9]
; jnz 0x20d9
; ret
; mov bx,0x22
; mov byte [bx+si],0x0
; dec bx
; jns 0x2104
; ret
; nop
; call 0x2d82
; call 0x274b
; and al,0x1
; jz 0x2123
; test byte [si],0xff
; jz 0x2123
; cmp byte [si],0x1f
; jz 0x2123
; jmp short 0x21a1
; nop
; jmp short 0x2175
; nop
; mov ax,[si]
; mov cx,[si+0x21]
; mov bx,[si+0x4]
; push bx
; call 0x2101
; pop bx
; mov [si+0x21],cx
; mov [si+0x4],bx
; dec al
; jns 0x213f
; inc al
; mov [si],ax
; call 0x274b
; and al,0x3
; or al,0x1
; mov [si+0x2],al
; call 0x274b
; and al,0x3
; or al,0x1
; mov [si+0x3],al
; call 0x274b
; and al,0x1
; mov [si+0x6],al
; call 0x274b
; and al,0x1
; mov [si+0x7],al
; inc byte [si+0xb]
; inc byte [si+0xe]
; mov byte [si+0xd],0x6
; dec byte [si+0x18]
; jmp 0x22d5
; call 0x2080
; call 0x2101
; mov al,[di]
; dec al
; jns 0x2183
; inc al
; mov [si],al
; mov al,[di+0x1]
; sub al,0x5
; mov [si+0x1],al
; mov byte [si+0x2],0x7
; inc byte [si+0xb]
; mov byte [si+0xd],0x4
; dec byte [si+0x18]
; inc byte [si+0xc]
; jmp 0x22d5
; call 0x2080
; call 0x2101
; mov ax,[di]
; inc ah
; mov [si],ax
; mov byte [si+0xd],0x7
; call 0x22d5
; inc byte [si+0xb]
; dec byte [si+0x18]
; mov al,0x8
; sub al,[0x282]
; jns 0x21c4
; xor al,al
; shl al,1
; shl al,1
; shl al,1
; jnz 0x21d3
; call 0x274b
; and al,0x3
; or al,0x1
; mov [si+0x19],al
; ret
; call 0x2080
; call 0x2101
; mov al,[0x295]
; mov ah,0x3
; inc ax
; mov [si],ax
; mov byte [si+0xd],0x5
; call 0x22d5
; inc byte [si+0x7]
; inc byte [si+0xc]
; inc byte [si+0xe]
; dec byte [si+0x18]
; mov al,[0x282]
; shr al,1
; sub al,0x7
; neg al
; cmp al,0x1
; jnl 0x2207
; mov al,0x1
; mov [si+0x19],al
; ret
; call 0x2295
; call 0x22a6
; test byte [0x284],0xff
; jnz 0x221b
; call 0x225b
; nop
; call 0x1304
; cmp byte [0x284],0x1
; jg 0x2227
; ret
; mov al,[0x284]
; dec ax
; cbw
; mov cl,0xa
; div cl
; mov di,0x58f6
; or ax,0x3030
; mov [di],ax
; ret
; cmp byte [0x28f],0x3
; jz 0x2241
; ret
; mov byte [0x28f],0x0
; call 0x2ab7
; mov cx,0x0
; loop 0x224c
; loop 0x224e
; loop 0x2250
; loop 0x2252
; loop 0x2254
; jmp 0x7f5:0x0
; call 0x229c
; call 0x22ad
; mov si,0x91
; mov word [si],0x6c00
; call 0x2191
; inc byte [si+0x6]
; add si,byte +0x23
; mov word [si],0x7d00
; call 0x2165
; add si,byte +0x23
; mov word [si],0x8a01
; call 0x21e5
; add si,byte +0x23
; mov word [si],0x9601
; mov byte [si+0xd],0x7
; call 0x22d5
; dec byte [si+0x18]
; ret
; ret
; test byte [0x287],0xff
; jz 0x2294
; mov si,0x4b
; mov ax,[0x29f]
; xor dl,dl
; jmp short 0x22b7
; test byte [0x288],0xff
; jz 0x2294
; mov si,0x6e
; mov ax,[0x2a1]
; mov dl,0x2
; jmp short 0x22b7
; call 0x2101
; mov [si],ax
; mov [si+0xd],dl
; inc byte [si+0x7]
; mov byte [si+0x8],0x2
; inc byte [si+0xc]
; inc byte [si+0xb]
; inc byte [si+0xe]
; dec byte [si+0x18]
; jmp short 0x22d5
; nop
; push bx
; push di
; mov ax,[si]
; mov bl,ah
; xor ah,ah
; shl al,1
; shl al,1
; shl al,1
; mov di,ax
; xor bh,bh
; shl bx,1
; add di,[bx+0x7e0]
; mov [si+0x9],di
; pop di
; mov word [si+0x10],0x2a6
; mov word [si+0x12],0x38e
; mov word [si+0x14],0x3dc
; mov word [si+0x16],0x50a
; call 0x259c
; pop bx
; ret
; cld
; mov ax,0x1c00
; mov es,ax
; mov cx,0x4000
; mov di,0x0
; xor ax,ax
; rep stosw
; mov ax,0xf000
; mov es,ax
; mov cx,0x8000
; mov di,0x0
; xor ax,ax
; rep stosw
; ret
; mov si,0x26f
; mov bx,0xa
; mov al,bl
; out 0x30,al
; lodsb
; out 0x32,al
; inc bx
; cmp bl,0x10
; jnz 0x2330
; ret
; mov ax,0xa00
; mov es,ax
; xor bh,bh
; mov bl,[0x284]
; shl bl,1
; mov si,[bx+0x1010]
; mov di,0x2a6
; mov bx,0x38e
; lodsb
; cmp al,0x20
; jl 0x236d
; jz 0x2374
; mov ah,al
; cmp ah,0x31
; jl 0x2355
; cmp ah,0x33
; jg 0x2355
; add ah,0x8
; jmp short 0x2355
; stosb
; movsw
; mov [bx],ah
; inc bx
; jmp short 0x2355
; mov byte [bx],0x0
; mov di,0x3dc
; mov bx,0x50a
; mov word [0x27f],0x0
; lodsb
; cmp al,0x20
; jl 0x238e
; jz 0x239e
; mov ah,al
; jmp short 0x2383
; movsw
; stosb
; mov [bx],ah
; inc bx
; cmp ah,0x3c
; jnz 0x2383
; inc byte [0x27f]
; jmp short 0x2383
; mov byte [bx],0x0
; mov ax,[si]
; mov [0x29f],ax
; mov ax,[si+0x2]
; mov [0x2a1],ax
; mov word [0x56e],0x2a6
; mov word [0x570],0x38e
; call 0x2564
; mov ax,ss
; shl ax,1
; cmp ax,0x200
; jz 0x23cc
; mov al,0xff
; out 0x3a,al
; and al,0x54
; out 0x3a,al
; mov word [0x56e],0x3dc
; mov word [0x570],0x50a
; call 0x2564
; call 0x23e8
; ret
; add si,byte +0x3
; inc bp
; jmp short 0x23ee
; jmp 0x24b6
; mov si,0x2a6
; mov bp,0x38e
; mov al,[ds:bp+0x0]
; or al,al
; jz 0x23e5
; test byte [0x23a],0xff
; jz 0x2401
; cmp al,0x38
; jl 0x23df
; cmp al,0x40
; jl 0x2414
; mov ah,al
; inc al
; and al,0x3
; and ah,0xfc
; or al,ah
; mov [ds:bp+0x0],al
; lodsw
; sub ah,al
; inc ah
; xor ch,ch
; mov cl,ah
; mov [0x23c],cx
; xor ah,ah
; shl al,1
; shl al,1
; shl al,1
; mov [0x27d],ax
; mov al,[si]
; shl ax,1
; mov bx,0x7e0
; add bx,ax
; inc si
; push si
; mov al,[ds:bp+0x0]
; sub al,0x21
; mov ah,0x24
; mul ah
; mov si,0x970
; add si,ax
; mov dl,0x6
; mov cx,[0x23c]
; mov di,[bx]
; add di,[0x27d]
; mov ax,0xf400
; mov es,ax
; lodsw
; push di
; mov [es:di],al
; mov [es:di+0x4],ah
; add di,byte +0x8
; loop 0x2459
; pop di
; push di
; mov cx,[0x23c]
; mov ax,0x1c00
; mov es,ax
; lodsw
; mov [es:di],al
; mov [es:di+0x4],ah
; add di,byte +0x8
; loop 0x2471
; pop di
; mov cx,[0x23c]
; mov ax,0xf000
; mov es,ax
; lodsw
; mov [es:di],al
; mov [es:di+0x4],ah
; add di,byte +0x8
; loop 0x2488
; inc bx
; inc bx
; dec dl
; jnz 0x2448
; pop si
; cmp byte [ds:bp+0x0],0x3a
; jnz 0x24a6
; dec byte [ds:bp+0x0]
; inc bp
; jmp 0x23ee
; add si,byte +0x3
; inc bp
; jmp short 0x24bc
; mov byte [0x23a],0x1
; ret
; mov si,0x3dc
; mov bp,0x50a
; mov al,[ds:bp+0x0]
; or al,al
; jz 0x24b0
; test byte [0x23a],0xff
; jz 0x24cf
; cmp al,0x3c
; jl 0x24aa
; cmp al,0x3c
; jl 0x24e2
; mov ah,al
; inc al
; and al,0x3
; and ah,0xfc
; or al,ah
; mov [ds:bp+0x0],al
; cmp al,0x3c
; jc 0x24eb
; call 0x1832
; jmp short 0x24aa
; lodsw
; sub ah,al
; inc ah
; xor ch,ch
; mov cl,ah
; mov [0x23c],cx
; xor ah,ah
; shl ax,1
; mov bx,0x7e0
; add bx,ax
; mov al,[si]
; inc si
; xor ah,ah
; shl al,1
; shl al,1
; shl al,1
; mov [0x27d],ax
; push si
; mov al,[ds:bp+0x0]
; sub al,0x21
; mov ah,0x24
; mul ah
; mov si,0x970
; add si,ax
; mov cx,[0x23c]
; mov dl,0x6
; mov di,[bx]
; add di,[0x27d]
; mov ax,0xf400
; mov es,ax
; lodsw
; mov [es:di],al
; mov [es:di+0x4],ah
; mov ax,0x1c00
; mov es,ax
; lodsw
; mov [es:di],al
; mov [es:di+0x4],ah
; mov ax,0xf000
; mov es,ax
; lodsw
; mov [es:di],al
; mov [es:di+0x4],ah
; inc bx
; inc bx
; dec dl
; jnz 0x255d
; sub si,byte +0x24
; mov dl,0x6
; loop 0x2525
; pop si
; inc bp
; jmp 0x24bc
; mov cx,0x1
; mov si,[0x56e]
; mov bx,[0x570]
; mov al,[bx+0x1]
; or al,al
; jz 0x2599
; mov al,[si+0x2]
; cmp al,[si+0x5]
; jna 0x2593
; xchg [si+0x5],al
; mov [si+0x2],al
; mov ax,[si]
; xchg [si+0x3],ax
; mov [si],ax
; mov ax,[bx]
; xchg ah,al
; mov [bx],ax
; xor cl,cl
; inc bx
; add si,byte +0x3
; jmp short 0x256f
; jcxz 0x2564
; ret
; mov bx,0x22a
; mov al,[si+0xd]
; mov ah,al
; xlatb
; mov [si+0x1b],al
; mov bx,0x3320
; mov al,ah
; shl al,1
; cbw
; add bx,ax
; mov bx,[bx]
; mov [si+0x1e],bx
; ret
; mov si,0x4b
; xor ch,ch
; mov byte [0x1a9],0xa
; test byte [si+0x18],0xff
; jns 0x25fd
; mov ax,[si]
; mov bl,ah
; xor ah,ah
; shl al,1
; shl al,1
; shl al,1
; mov di,ax
; xor bh,bh
; shl bx,1
; add di,[bx+0x7e0]
; mov [si+0x9],di
; xor ah,ah
; mov bx,[si+0x1e]
; mov dl,[bx]
; inc bx
; mov al,[si+0x8]
; shl al,1
; test byte [si+0x6],0xff
; jz 0x25f6
; add al,dl
; add bx,ax
; mov bx,[bx]
; mov [si+0x1c],bx
; add si,byte +0x23
; dec byte [0x1a9]
; jnz 0x25c2
; ret
; mov si,0x4b
; xor ch,ch
; mov byte [0x1a9],0xa
; test byte [si+0x18],0xff
; js 0x261f
; jz 0x266c
; mov byte [si+0x18],0x0
; jmp short 0x2640
; mov ax,[si+0x9]
; cmp ax,[si+0x4]
; jnz 0x262f
; mov ax,[si+0x1c]
; cmp ax,[si+0x21]
; jz 0x266c
; push si
; mov cl,[si+0x1b]
; and cl,0xfe
; mov di,[si+0x9]
; mov si,[si+0x1c]
; call 0x2676
; pop si
; push si
; mov cl,[si+0x1b]
; cmp cl,0x9
; jnz 0x2650
; sub cl,0x3
; mov byte [si+0x1b],0x8
; mov di,[si+0x4]
; mov si,[si+0x21]
; test si,0xffff
; jz 0x265f
; call 0x2676
; pop si
; mov ax,[si+0x1c]
; mov [si+0x21],ax
; mov ax,[si+0x9]
; mov [si+0x4],ax
; add si,byte +0x23
; dec byte [0x1a9]
; jnz 0x2611
; ret
; cmp cl,0x6
; jnz 0x267e
; jmp 0x2713
; mov ax,0xf400
; mov es,ax
; lodsw
; xor [es:di],al
; xor [es:di+0x4],ah
; mov ax,0x1c00
; mov es,ax
; lodsw
; xor [es:di],al
; xor [es:di+0x4],ah
; mov ax,0xf000
; mov es,ax
; lodsw
; xor [es:di],al
; xor [es:di+0x4],ah
; add di,byte +0x8
; mov ax,0xf400
; mov es,ax
; lodsw
; xor [es:di],al
; xor [es:di+0x4],ah
; mov ax,0x1c00
; mov es,ax
; lodsw
; xor [es:di],al
; xor [es:di+0x4],ah
; mov ax,0xf000
; mov es,ax
; lodsw
; xor [es:di],al
; xor [es:di+0x4],ah
; add di,byte +0x8
; mov ax,0xf400
; mov es,ax
; lodsw
; xor [es:di],al
; xor [es:di+0x4],ah
; mov ax,0x1c00
; mov es,ax
; lodsw
; xor [es:di],al
; xor [es:di+0x4],ah
; mov ax,0xf000
; mov es,ax
; lodsw
; xor [es:di],al
; xor [es:di+0x4],ah
; sub di,byte +0xf
; test di,0x3
; jz 0x2709
; dec cx
; jz 0x2708
; jmp 0x267e
; ret
; add di,0x13c
; dec cx
; jz 0x2708
; jmp 0x267e
; mov ax,0xf400
; mov es,ax
; lodsw
; xor [es:di],al
; xor [es:di+0x4],ah
; mov ax,0x1c00
; mov es,ax
; lodsw
; xor [es:di],al
; xor [es:di+0x4],ah
; mov ax,0xf000
; mov es,ax
; lodsw
; xor [es:di],al
; xor [es:di+0x4],ah
; inc di
; test di,0x3
; jz 0x2744
; loop 0x2713
; ret
; add di,0x13c
; loop 0x2713
; ret
; mov [0x298],ah
; push bx
; push cx
; push dx
; mov bx,[0x299]
; mov cx,[0x29b]
; mov al,0x7d
; mul cx
; mov [0x299],dx
; mov [0x29b],ax
; mov al,0x7d
; mul bx
; add [0x299],ax
; mov ax,[0x29b]
; shr ax,1
; shr ax,1
; shr ax,1
; pop dx
; pop cx
; pop bx
; mov ah,[0x298]
; ret
; add [bx+si],al
; push ax
; push bx
; push cx
; push dx
; push bp
; push si
; push di
; push es
; call 0x2a19
; call 0x2953
; call 0x299f
; jnc 0x2796
; jmp 0x2824
; mov di,0x2
; pushf
; push dx
; push di
; push es
; cli
; cld
; mov al,dh
; out 0xc,al
; mov dx,0x8
; mov si,0x19d2
; mov bp,bx
; mov di,bx
; mov ax,ds
; mov es,ax
; mov bh,0x2
; mov bl,0x96
; mov ah,0x0
; mov al,0x80
; out 0x8,al
; aam
; aam
; aam
; aam
; in al,dx
; sar al,1
; jnc 0x27e4
; jnz 0x27c3
; in al,dx
; and al,bl
; jz 0x27ca
; in al,0xe
; stosb
; in al,dx
; dec ax
; jz 0x27d2
; cmp al,bh
; jnz 0x27e4
; in al,0xe
; stosb
; in al,dx
; cmp al,bh
; jz 0x27da
; jmp si
; mov bx,di
; pop es
; pop di
; pop dx
; popf
; in al,0x8
; and al,0xff
; jnz 0x280c
; loop 0x27ff
; pop es
; pop di
; pop si
; pop bp
; pop dx
; pop cx
; pop bx
; pop ax
; call 0x2a12
; clc
; ret
; inc dh
; cmp dh,0x9
; jc 0x2796
; inc dl
; mov dh,0x1
; jmp short 0x278e
; mov bx,bp
; dec di
; jz 0x2829
; test al,0x3c
; jz 0x2821
; test di,0x1
; jnz 0x2821
; call 0x29fb
; jmp 0x278e
; jmp 0x2799
; test al,0x80
; jz 0x2829
; clc
; pop es
; pop di
; pop si
; pop bp
; pop dx
; pop cx
; pop bx
; lahf
; add sp,byte +0x2
; sahf
; call 0x2a12
; jc 0x2854
; test al,0x80
; jnz 0x284c
; test al,0x10
; jnz 0x2858
; test al,0xc
; jnz 0x2850
; jmp short 0x2860
; mov al,0x0
; jmp short 0x2862
; mov al,0x2
; jmp short 0x2862
; mov al,0x4
; jmp short 0x2862
; mov al,0x6
; jmp short 0x2862
; mov al,0x8
; jmp short 0x2862
; mov al,0xa
; jmp short 0x2862
; mov al,0xc
; stc
; ret
; push ax
; push bx
; push cx
; push dx
; push bp
; push di
; push es
; call 0x2a19
; call 0x2953
; call 0x299f
; jnc 0x2879
; jmp 0x2915
; mov di,0xa
; push cx
; push dx
; push si
; push di
; cli
; cld
; mov al,dh
; out 0xc,al
; mov dx,0x8
; mov di,0x1abb
; mov bp,bx
; mov si,bx
; mov ax,ds
; mov es,ax
; mov al,0xa0
; out 0x8,al
; aam
; aam
; aam
; aam
; mov ah,0xc
; mov ch,0x0
; mov bh,0x2
; mov bl,0xf6
; lodsb
; xchg ax,cx
; in al,dx
; sar al,1
; jnc 0x28cf
; jnz 0x28aa
; in al,dx
; and al,bl
; jz 0x28b1
; xchg ax,cx
; out 0xe,al
; jmp short 0x28c6
; in al,dx
; dec ax
; jz 0x28bb
; cmp al,bh
; jnz 0x28cf
; xchg ax,cx
; out 0xe,al
; lodsb
; xchg ax,cx
; in al,dx
; and al,bh
; jnz 0x28c3
; jmp di
; mov bx,bp
; add bx,0x200
; pop di
; pop si
; pop dx
; pop cx
; in al,0x8
; and al,0xff
; jnz 0x28fd
; loop 0x28ed
; pop es
; pop di
; pop bp
; pop dx
; pop cx
; pop bx
; pop ax
; call 0x2a12
; clc
; ret
; inc dh
; cmp dh,0x9
; jnc 0x28f6
; jmp short 0x2879
; inc dl
; mov dh,0x1
; jmp 0x2871
; mov bx,bp
; dec di
; jz 0x291a
; test al,0x3c
; jz 0x2912
; test di,0x1
; jnz 0x2912
; call 0x29fb
; jmp 0x2871
; jmp 0x287c
; test al,0x80
; jz 0x291a
; clc
; pop es
; pop di
; pop bp
; pop dx
; pop cx
; pop bx
; lahf
; add sp,byte +0x2
; sahf
; call 0x2a12
; jnc 0x292d
; jmp 0x2854
; test al,0x80
; jz 0x2934
; jmp 0x284c
; test al,0x40
; jz 0x293b
; jmp 0x2848
; test al,0x20
; jz 0x2942
; jmp 0x285c
; test al,0x10
; jz 0x2949
; jmp 0x2858
; test al,0xc
; jz 0x2950
; jmp 0x2850
; jmp 0x2860
; push bx
; push ax
; in al,0x1c
; and al,0x3
; mov byte [0x5d0],0xfc
; or [0x5d0],al
; pop ax
; mov bh,0x0
; mov bl,[0x5d0]
; mov [0x5d0],al
; and al,0x3
; and bl,0x3
; cmp al,bl
; jz 0x2990
; push ax
; in al,0xa
; mov [bx+0x5d1],al
; pop ax
; mov bl,al
; and al,0x3
; out 0x1c,al
; mov al,[bx+0x5d1]
; out 0xa,al
; cmp al,0x28
; jc 0x2990
; call 0x29fb
; mov ax,dx
; mov dl,0x8
; div dl
; inc ah
; mov dx,ax
; and dh,0xf
; pop bx
; ret
; push bx
; push cx
; push dx
; add dl,dl
; mov bx,0xa
; cmp dl,[0x5d5]
; jz 0x29b2
; mov cx,0x14d
; loop 0x29b0
; mov al,dl
; shr al,1
; out 0xe,al
; mov al,0x18
; out 0x8,al
; in al,0x1c
; mov ah,dl
; shl ah,1
; shl ah,1
; and ah,0x4
; and al,0xfb
; or al,ah
; out 0x1c,al
; in al,0x8
; test al,0x1
; jnz 0x29cd
; mov cx,0x8214
; in al,0x8
; test al,0x80
; jz 0x29e3
; loop 0x29d6
; dec bx
; jnz 0x29a7
; jmp short 0x29f2
; cmp dl,[0x5d5]
; jz 0x29ee
; mov cx,0x14d
; loop 0x29ec
; mov [0x5d5],dl
; pop dx
; pop cx
; pop bx
; and al,0x90
; jz 0x29fa
; stc
; ret
; mov al,0x8
; out 0x8,al
; in al,0x8
; test al,0x1
; jnz 0x29ff
; push cx
; mov cx,0x1b51
; loop 0x2a09
; pop cx
; mov byte [0x5d5],0x0
; ret
; push ax
; mov al,0x27
; out 0x2a,al
; pop ax
; ret
; push ax
; mov al,0x5
; out 0x2a,al
; pop ax
; ret
; mov word [0x5502],0x0
; test byte [0x5509],0xff
; jnz 0x2a4d
; mov cl,0x1
; call 0x2a81
; mov [0x5500],ah
; mov cl,0x2
; call 0x2a81
; mov [0x5501],ah
; ror al,1
; ror al,1
; rcr byte [0x5502],1
; ror al,1
; rcr byte [0x5503],1
; test byte [0x550a],0xff
; jnz 0x2a76
; mov cl,0x3
; call 0x2a81
; mov [0x5504],ah
; mov cl,0x4
; call 0x2a81
; mov [0x5505],ah
; ror al,1
; rcr byte [0x5506],1
; ror al,1
; ror al,1
; ror al,1
; rcr byte [0x5507],1
; ret
; jc 0x2a9b
; mov di,0x1cff
; call 0x2ab2
; jmp di
; mov al,[0x5508]
; out 0x1a,al
; mov ah,0x8
; shl ah,cl
; mov cx,0x1000
; in al,0x1a
; and al,0x7f
; out 0x1a,al
; or al,0x80
; out 0x1a,al
; and al,0x7f
; out 0x1a,al
; in al,0x18
; and al,ah
; loopne 0x2a9b
; in al,0x1a
; mov [0x5508],al
; in al,0x18
; and al,0xf
; mov ah,cl
; neg ah
; or ch,cl
; jnz 0x2ab6
; dec di
; dec di
; dec di
; stc
; ret
; mov bx,0x5d6
; mov cx,0x1
; xor ax,ax
; mov dx,0x3
; call 0x2a77
; mov cx,0x9
; jc 0x2ab6
; call 0x274b
; xor dx,dx
; and ax,0x3
; xchg ax,dx
; mov si,0x1a6d
; sub si,cx
; jmp si
; in al,0x1a
; mov [0x5508],al
; mov cl,0x1
; mov word [0x5509],0x0
; call 0x2a81
; jnc 0x2af0
; inc byte [0x5509]
; mov cl,0x3
; call 0x2a81
; jnc 0x2afb
; inc byte [0x550a]
; ret
; jmp 0x2780
; add bl,al
; cmp byte [0x284],0x1
; jnz 0x2b00
; test byte [0x28f],0xff
; jns 0x2b00
; test byte [0x5b79],0xff
; jz 0x2b19
; jmp 0x2c04
; mov si,0x21a
; test byte [0x5b7a],0xff
; jz 0x2b26
; mov si,0x222
; mov dx,0x0
; mov cx,0x8
; mov di,0x5b4f
; mov ax,[si]
; cmp ax,[di]
; jna 0x2b3b
; inc dx
; sub di,byte +0x25
; loop 0x2b31
; or dx,dx
; jnz 0x2b68
; mov byte [0x5b79],0x0
; mov byte [0x5b7f],0x0
; inc byte [0x5b7a]
; cmp byte [0x5b7a],0x2
; jc 0x2b67
; mov byte [0x28f],0x3
; mov byte [0x5b7a],0x0
; mov word [0x5b77],0x0
; jmp 0x2c82
; ret
; mov [0x5b7b],dx
; mov bx,0x5b2a
; mov di,0x5b4f
; dec dx
; jz 0x2b88
; mov cx,0x1e
; mov al,[bx]
; mov [di],al
; inc bx
; inc di
; loop 0x2b78
; add bx,byte -0x43
; add di,byte -0x43
; jmp short 0x2b72
; mov bx,0x5b74
; mov cx,[0x5b7b]
; sub bx,byte +0x25
; loop 0x2b8f
; mov ax,[si]
; mov [bx],ax
; inc bx
; inc bx
; mov word [si],0x0
; inc si
; inc si
; mov cx,0x16
; mov byte [bx],0x5f
; inc bx
; loop 0x2ba3
; mov cx,0x6
; mov al,[si]
; add al,0x30
; mov [bx],al
; mov byte [si],0x0
; inc si
; inc bx
; loop 0x2bac
; sub bx,byte +0x1c
; mov [0x5b75],bx
; mov word [0x5b77],0x0
; inc byte [0x5b79]
; ret
; add dh,dh
; push es
; adc byte [di-0x55],0x75
; idiv word [bp+di+0x5d6]
; mov di,0x1df1
; mov ax,0x1
; mov cx,ax
; mov dx,cx
; push di
; dec ax
; mov si,0xe0f
; add si,0xb71
; push si
; add di,si
; inc byte [0x5580]
; ret
; jc 0x2bca
; mov ax,ds
; mov es,ax
; mov cx,0x128
; mov di,0x5a4c
; mov si,0x5d6
; rep movsb
; jmp short 0x2bca
; test byte [0x5b7f],0xff
; jnz 0x2c28
; test byte [0x5b7a],0xff
; jnz 0x2c1e
; mov byte [0x1b3],0x34
; mov al,0x8
; call 0x129c
; jmp short 0x2c28
; mov byte [0x1b3],0x28
; mov al,0x8
; call 0x129c
; mov al,[0x296]
; or al,al
; jz 0x2ca6
; mov di,[0x5b75]
; mov cx,[0x5b77]
; add di,cx
; cmp al,0xd
; jz 0x2c52
; cmp al,0x8
; jz 0x2ca7
; cmp al,0x20
; jc 0x2ca6
; mov [di],al
; inc cx
; cmp cx,byte +0x15
; ja 0x2ca6
; mov [0x5b77],cx
; ret
; cmp byte [di],0x5f
; jnz 0x2c5d
; mov byte [di],0x20
; inc di
; jmp short 0x2c52
; mov byte [0x5b79],0x0
; mov word [0x5b77],0x0
; inc byte [0x5b7a]
; cmp byte [0x5b7a],0x2
; jc 0x2ca6
; mov byte [0x5b7a],0x0
; mov byte [0x5b7f],0x0
; mov byte [0x28f],0x3
; mov ax,ds
; mov es,ax
; mov cx,0x128
; mov si,0x5a4c
; mov di,0x5d6
; rep movsb
; mov bx,0x5d6
; mov ax,0x1
; mov cx,ax
; mov dx,cx
; mov si,0x36c8
; sub si,0x1c64
; push si
; dec ax
; add di,si
; ret
; mov byte [di],0x5f
; jcxz 0x2cb4
; mov byte [di-0x1],0x5f
; dec word [0x5b77]
; ret
; cmp byte [0x284],0x1
; jnz 0x2cb4
; mov di,0x12e0
; mov word [0x5b7d],0x8
; mov si,0x5a4e
; mov byte [0x29d],0x3
; call 0x2d1b
; mov cx,0x16
; lodsb
; call 0x13a2
; loop 0x2cd3
; add di,byte +0x18
; mov byte [0x29d],0x6
; call 0x2d1b
; mov cx,0x6
; lodsb
; cmp al,0x30
; jnz 0x2cf4
; add di,byte +0x4
; loop 0x2ce7
; jmp short 0x2cf9
; lodsb
; call 0x13a2
; loop 0x2cf3
; add di,byte +0x18
; mov byte [0x29d],0x5
; call 0x2d1b
; mov cx,0x7
; lodsb
; call 0x13a2
; loop 0x2d07
; add si,byte +0x2
; add di,0x304
; dec word [0x5b7d]
; jnz 0x2cc8
; ret
; test byte [0x5b79],0xff
; jz 0x2d31
; mov bx,[0x5b7d]
; cmp bx,[0x5b7b]
; jnz 0x2d31
; mov byte [0x29d],0x7
; ret
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; mov byte [0x5b80],0x4
; mov word [0x5b84],0x140
; ret
; mov byte [0x5b80],0x8
; mov word [0x5b84],0x3
; ret
; mov byte [0x5b80],0x6
; mov word [0x5b84],0x1
; ret
; mov byte [0x5b80],0x7
; mov word [0x5b84],0x2
; ret
; mov byte [0x5b82],0x3
; ret
; mov byte [0x5b82],0x4
; ret
; mov byte [0x5b82],0x1
; ret
; call 0x274b
; and al,0x3
; add al,0x2
; mov [0x5b81],al
; ret
; mov byte [0x5b81],0x3
; mov word [0x5b84],0x141
; ret
; test byte [0x5b83],0xff
; jnz 0x2d98
; mov bl,[0x5b80]
; or bl,bl
; jz 0x2db9
; mov cx,0x3
; xor bh,bh
; mov si,0x5b9f
; mov bh,[bx+si]
; call 0x2de7
; dec byte [0x5b80]
; mov bl,[0x5b81]
; or bl,bl
; jz 0x2dd2
; mov cx,0x2
; xor bh,bh
; mov si,0x5baa
; mov bh,[bx+si]
; call 0x2de7
; dec byte [0x5b81]
; mov bl,[0x5b82]
; or bl,bl
; jz 0x2de6
; mov cx,0x1
; xor bh,bh
; call 0x2de7
; dec byte [0x5b82]
; ret
; cli
; in al,0x3a
; and al,0x1
; jz 0x2de8
; mov al,bh
; out 0x38,al
; loop 0x2de8
; sti
; ret
; mov al,0xc
; out 0x30,al
; mov al,[0x5b85]
; out 0x32,al
; mov al,0xd
; out 0x30,al
; mov al,[0x5b84]
; out 0x32,al
; mov word [0x5b84],0x0
; ret
; in al,0x3a
; test al,0x2
; ret
; push ax
; push bx
; push es
; push ds
; mov ax,0xa00
; mov ds,ax
; call 0x2e0f
; jz 0x2e40
; test al,0x8
; les bx,[0x5b98]
; jz 0x2e2e
; les bx,[0x5b9c]
; xor ax,ax
; in al,0x38
; shl ax,1
; add bx,ax
; mov al,0x35
; out 0x3a,al
; mov ax,[es:bx]
; call 0x2e45
; pop ds
; pop es
; pop bx
; pop ax
; iret
; xor bh,bh
; mov bl,[0x5b86]
; mov [bx+0x5b88],ax
; add bl,0x2
; and bl,0xf
; mov bh,[0x5b87]
; cmp bl,bh
; jnz 0x2e63
; sub bl,0x2
; and bl,0xf
; mov [0x5b86],bx
; ret
; push bx
; dec ah
; js 0x2e71
; jz 0x2e8e
; pop bx
; ret
; mov al,[0x5b87]
; cmp al,[0x5b86]
; jz 0x2e71
; xor bh,bh
; mov bl,al
; mov ax,[bx+0x5b88]
; add bl,0x2
; and bl,0xf
; mov [0x5b87],bl
; pop bx
; ret
; int 0xfb
; cli
; xor bh,bh
; mov al,[0x5b87]
; cmp al,[0x5b86]
; mov bl,al
; mov ax,[bx+0x5b88]
; sti
; pop bx
; ret
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [si],al
; add ax,0x100
; push es
; or al,0x2
; pop es
; or ax,[bp+si]
; or [bp+si],ah
; add cl,[bx+di]
; adc al,[bp+si]
; or dl,[bx+si]
; add ax,[bx+si]
; adc ax,0x16
; sbb al,0x1d
; add al,0x5
; add [bp+di],ah
; add [bx+si],al
; and al,0x0
; add [bx+di],al
; push es
; or ax,0x702
; adc al,[bp+si]
; or [0x3],cl
; and [0x2100],dl
; add [si],al
; add ax,0x0
; add [bx+si],al
; add [bx],ah
; add [bx+di],ch
; sub ch,[bp+di]
; sub al,0x2d
; cs das
; xor [bx+di],dh
; xor dh,[bp+di]
; add [bx+si],al
; xor ax,0x21
; aaa
; cmp [bx+di],bh
; cmp [si],si
; xor ax,0x3636
; xor [di],si
; xor ax,[bx+si]
; add [bx+si],dh
; xor [bx+si],dh
; xor [bx+si],dh
; xor [bx+si],al
; add [bx+si],dh
; xor [bx+si],dh
; xor [bx+si],dh
; xor [bx+si],dl
; adc [bx+si],dl
; adc [si],cl
; push es
; or [0x0],ax
; add [bp+si],al
; add ax,0x304
; add al,[bx+si]
; add [bx+si],al
; add [bx+si],al
; fld dword [bp+si]
; fld dword [bp+si]
; fld dword [bp+si]
; fld dword [bp+si]
; inc word [bp+si]
; inc bp
; add di,[bx-0x7bfd]
; add di,bx
; add bx,di
; add bx,di
; add bx,di
; add [bx+di-0x11ff],cx
; add [bp+0x2],sp
; out dx,al
; add [bx+si],ax
; adc [si+0x49],al
; stosb
; insw
; out dx,al
; inc word [bx+si]
; or [bp+si],ah
; stosb
; db 0xff
; db 0xff
; db 0xff
; jmp [bx+si]
; add [bx+si],al
; add [bx+di+0x0],al
; rcr byte [di],cl
; add al,[0x180c]
; sbb ax,0x29
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],ax
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+di],ax
; add [bx],cx
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [si],al
; add [bx+si],ax
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; and [bx+di+0x4f],bl
; push bp
; push dx
; and [bx+si+0x4f],dl
; push di
; inc bp
; push dx
; and [bx+di+0x53],cl
; and [bx+0x4f],al
; dec si
; inc bp
; and [cs:bx+si],ah
; inc di
; inc cx
; dec bp
; inc bp
; and [bx+0x56],cl
; inc bp
; push dx
; and [bx+si],sp
; or ax,0x4f47
; dec di
; inc sp
; and [bx+0x4f],dl
; push dx
; dec bx
; and [bx+si],sp
; and [bx+di+0x4f],bl
; push bp
; and [bx+si+0x41],cl
; push si
; inc bp
; and [bp+di+0x4f],al
; dec sp
; dec sp
; inc bp
; inc bx
; push sp
; inc bp
; inc sp
; and [bx+di+0x4c],al
; dec sp
; and [si+0x48],dl
; inc bp
; and [bp+di+0x41],al
; push bx
; dec ax
; and [di],cx
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; db 0xff
; db 0xff
; db 0xff
; db 0xff
; inc word [bx+si]
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+di],al
; add [bp+si],al
; add [bp+di],al
; add [bx+si+0x1],al
; inc cx
; add [bp+si+0x1],ax
; inc bx
; add [bx+si-0x7efe],ax
; add al,[bp+si-0x7cfe]
; add al,al
; add ax,cx
; add ax,dx
; add ax,bx
; add ax,[bx+si]
; add ax,0x501
; add al,[di]
; add ax,[di]
; inc ax
; push es
; inc cx
; push es
; inc dx
; push es
; inc bx
; push es
; add byte [bx],0x81
; pop es
; db 0x82
; pop es
; add word [bx],byte -0x40
; or cl,al
; or dl,al
; or bl,al
; or [bx+si],al
; or al,[bx+di]
; or al,[bp+si]
; or al,[bp+di]
; or al,[bx+si+0xb]
; inc cx
; or ax,[bp+si+0xb]
; inc bx
; or ax,[bx+si-0x7ef4]
; or al,0x82
; or al,0x83
; or al,0xc0
; or ax,0xdc1
; ret 0xc30d
; or ax,0xf00
; add [bx],cx
; add cl,[bx]
; add cx,[bx]
; inc ax
; adc [bx+di+0x10],al
; inc dx
; adc [bp+di+0x10],al
; adc byte [bx+di],0x81
; adc [bp+si-0x7cef],ax
; adc ax,ax
; adc al,cl
; adc al,dl
; adc al,bl
; adc al,[bx+si]
; adc al,0x1
; adc al,0x2
; adc al,0x3
; adc al,0x40
; adc ax,0x1541
; inc dx
; adc ax,0x1543
; adc byte [0x1681],0x82
; push ss
; adc word [0x17c0],byte -0x3f
; pop ss
; ret 0xc317
; pop ss
; add [bx+di],bl
; add [bx+di],bx
; add bl,[bx+di]
; add bx,[bx+di]
; inc ax
; sbb al,[bx+di+0x1a]
; inc dx
; sbb al,[bp+di+0x1a]
; sbb byte [bp+di],0x81
; sbb ax,[bp+si-0x7ce5]
; sbb ax,ax
; sbb al,0xc1
; sbb al,0xc2
; sbb al,0xc3
; sbb al,0x0
; push ds
; add [0x1e02],bx
; add bx,[0x1f40]
; inc cx
; pop ds
; inc dx
; pop ds
; inc bx
; pop ds
; and byte [bx+si],0x81
; and [bp+si-0x7ce0],al
; and al,al
; and cx,ax
; and dx,ax
; and bx,ax
; and [bx+si],ax
; and ax,[bx+di]
; and ax,[bp+si]
; and ax,[bp+di]
; and ax,[bx+si+0x24]
; inc cx
; and al,0x42
; and al,0x43
; and al,0x80
; and ax,0x2581
; db 0x82
; and ax,0x2583
; shl byte [0x26c1],byte 0xc2
; es ret
; add [es:bx+si],ch
; add [bx+si],bp
; add ch,[bx+si]
; add bp,[bx+si]
; inc ax
; sub [bx+di+0x29],ax
; inc dx
; sub [bp+di+0x29],ax
; sub byte [bp+si],0x81
; sub al,[bp+si-0x7cd6]
; sub al,al
; sub ax,cx
; sub ax,dx
; sub ax,bx
; sub ax,[bx+si]
; sub ax,0x2d01
; add ch,[di]
; add bp,[di]
; inc ax
; cs inc cx
; cs inc dx
; cs inc bx
; sub byte [cs:bx],0x81
; das
; db 0x82
; das
; sub word [bx],byte -0x40
; xor cl,al
; xor dl,al
; xor bl,al
; xor [bx+si],al
; xor al,[bx+di]
; xor al,[bp+si]
; xor al,[bp+di]
; xor al,[bx+si+0x33]
; inc cx
; xor ax,[bp+si+0x33]
; inc bx
; xor ax,[bx+si-0x7ecc]
; xor al,0x82
; xor al,0x83
; xor al,0xc0
; xor ax,0x35c1
; ret 0xc335
; xor ax,0x3700
; add [bx],si
; add dh,[bx]
; add si,[bx]
; inc ax
; cmp [bx+di+0x38],al
; inc dx
; cmp [bp+di+0x38],al
; cmp byte [bx+di],0x81
; cmp [bp+si-0x7cc7],ax
; cmp ax,ax
; cmp al,cl
; cmp al,dl
; cmp al,bl
; cmp al,[bx+si]
; cmp al,0x1
; cmp al,0x2
; cmp al,0x3
; cmp al,0x40
; cmp ax,0x3d41
; inc dx
; cmp ax,0x3d43
; db 0xff
; db 0xff
; db 0xff
; inc word [bx+si]
; add [bx],al
; lock add [bx+si],al
; add [bx+si],al
; psubb mm0,[bx+si]
; add [bx+si],al
; add [bx],cl
; clc
; add [bx+si],al
; add [bx+si],al
; pop es
; lock add [bx+si],al
; add [bx+si],al
; db 0xff
; db 0xff
; db 0xff
; inc word [bx+si]
; add [bx+si],al
; add [bx+si],al
; add al,ah
; pop es
; inc ax
; add al,[bx+si]
; add al,ah
; pop es
; add [bx+si],al
; add [bx+si],al
; loopne 0x385d
; inc sp
; and al,[bx+si]
; add bh,bh
; inc word [bx+si]
; add [bx+si],al
; add al,ah
; pop es
; inc ax
; add al,[bx+si]
; add al,ah
; pop es
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; push dx
; xchg ax,sp
; push dx
; xchg ax,sp
; add [bx+si],al
; mov [bp+di-0x7c],fs
; and al,[bx+si]
; add [bp+di-0x64],dh
; push dx
; xchg ax,sp
; add [bx+si],al
; cmp si,cx
; sub [bp+si+0x0],cx
; add dh,al
; xor [bp+si+0x11],ax
; add [bx+si],al
; sub [bp+si+0x29],cx
; dec dx
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; db 0xff
; inc word [bx+si]
; add [bx+si],al
; add [bx],al
; loopne 0x38e4
; loopne 0x38df
; add bh,ah
; out 0xe7,ax
; out 0x60,ax
; push es
; arpl si,ax
; arpl si,ax
; pusha
; push es
; xor [si],cl
; xor [si],cl
; xor [si],cl
; pop ds
; clc
; pop ds
; clc
; pop es
; loopne 0x38f9
; add [si],ah
; xchg ax,dx
; db 0xff
; inc word [bp+di]
; rol byte [bp+di],byte 0xc0
; add al,[bx+si-0x1]
; db 0xff
; db 0xff
; call [di-0x56]
; loopne 0x3913
; loopne 0x3915
; mov al,[0xe005]
; pop es
; loopne 0x391b
; mov al,[0x5]
; add [si],ah
; xchg ax,dx
; db 0xff
; db 0xff
; jl 0x395c
; add [bx+si],al
; add [bx+si],al
; db 0xc7
; jcxz 0x3925
; add [bx+si],al
; add [si+0x3e],bh
; add [bx+si],al
; add [bx+si],al
; db 0xc7
; jcxz 0x3931
; add [bx+si],al
; add [si+0x3e],bh
; add [bx+si],al
; add [bx+si],al
; db 0xc7
; jcxz 0x393d
; add [bx+si],al
; add [si+0x3e],bh
; jl 0x3982
; add [bx+si],al
; db 0xc7
; jcxz 0x3910
; jcxz 0x394b
; add [si+0x3e],bh
; jl 0x398e
; add [bx+si],al
; db 0xc7
; jcxz 0x391c
; jcxz 0x3957
; add [si+0x3e],bh
; jl 0x399a
; add [bx+si],al
; db 0xc7
; jcxz 0x3928
; jcxz 0x3963
; add bh,bh
; inc word [bx+si]
; add bh,bh
; inc cx
; add cx,byte -0x7d
; add [bx+si],al
; arpl si,ax
; arpl si,ax
; add [bx+si],al
; aas
; cld
; aas
; cld
; add [bx+si-0x399d],ax
; arpl si,ax
; add ax,ax
; push es
; pusha
; push es
; pusha
; pop es
; loopne 0x3988
; db 0xff
; db 0xff
; db 0xff
; db 0xff
; inc word [bx+si]
; add bh,bh
; db 0xff
; db 0xff
; inc word [bx+si]
; add bh,bh
; inc word [bx+si]
; add bh,bh
; db 0xff
; db 0xff
; inc word [bx+si]
; add [bx+si],al
; add [bx+si],al
; add bh,bh
; db 0xff
; db 0xff
; inc word [bx+si]
; add [bx+si],al
; add [bx+si],al
; add bh,bh
; db 0xff
; db 0xff
; dec word [di]
; mov al,0xe0
; pop es
; db 0xff
; push word [0xc06c]
; add di,di
; push word [0xc06c]
; add di,di
; dec word [di]
; mov al,0xe0
; pop es
; db 0xff
; inc word [bx+si]
; add bh,bh
; db 0xff
; db 0xff
; inc word [bx+si]
; add bh,bh
; inc word [bx+si]
; add [bx+di],ch
; xchg ax,sp
; salc
; imul ax,[bx+si],byte +0x0
; and ax,sp
; fdivr qword [bp+di]
; add [bx+si],al
; adc al,0x28
; imul dx,si,byte +0x0
; add [bx+si],cl
; adc [0x6c],dh
; add [bx+si],al
; add [si],bl
; cmp [bx+si],al
; add [bp+si+0xaa],ch
; add bh,bh
; inc word [bx+di]
; add byte [bx+si],0x0
; db 0xfe
; jg 0x3a00
; inc word [bx+si]
; add [bx+si],al
; add [di-0x56],dl
; add [bx+si],al
; db 0xfe
; jg 0x3a0c
; inc word [bx+si]
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add bh,bh
; inc word [bx+di]
; add byte [bx+si],0x0
; add ax,ax
; add [bx+si+0x0],ax
; add ax,ax
; add [bx+si],al
; add [bx+si-0x7fff],ax
; add al,[bx+si+0x3]
; rol byte [bx+di],byte 0x80
; add [bx+si],al
; push es
; pusha
; push es
; pusha
; add al,[bx+si+0x3e]
; jl 0x3a77
; cmp ax,0x7e0
; loopne 0x3a47
; add [bx+si],al
; loopne 0x3a4b
; mov al,[0x5]
; add al,ah
; pop es
; loopne 0x3a53
; add [bx+si],al
; db 0xff
; db 0xff
; mov bx,0xdd
; add al,ah
; pop es
; loopne 0x3a5f
; add [bx+si],al
; loopne 0x3a63
; mov al,[0x5]
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add bh,bh
; call far [bx+0x9f]
; add [bx+si],al
; add bh,al
; mov word [bx+si],0x0
; add cl,dh
; int1
; add [bx+si],al
; add [bx+si],al
; cld
; cld
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; db 0xff
; inc word [bx+si]
; add [bx+si],al
; add bh,bh
; inc word [bx+si]
; add [bx],bl
; clc
; pop ds
; clc
; add [bx+si],al
; cmp [si],bl
; cmp [si],bl
; add [bx+si],al
; cmp [si],bl
; cmp [si],bl
; add [bx+si],al
; pop ds
; clc
; pop ds
; clc
; add [bx+si],al
; add [bx+si],al
; db 0xff
; inc word [bx]
; loopne 0x3b1e
; loopne 0x3b19
; add [bx],bl
; clc
; push ds
; cmp [bx+si],al
; add [bx],bh
; cld
; aas
; pushf
; add [bx+si],al
; aas
; cld
; aas
; int3
; add [bx+si],al
; pop ds
; clc
; pop ds
; fadd dword [bx+si]
; add [bx],al
; loopne 0x3b3c
; mov al,[0x0]
; pop es
; loopne 0x3b3f
; loopne 0x3b3d
; add [bx],bl
; cbw
; sbb bx,[bx+si]
; add [bx+si+0x3f],ah
; or al,0x36
; or al,0x0
; lock aas
; or al,0x36
; or al,0x0
; lock pop ds
; cbw
; sbb bx,[bx+si]
; add [bx+si+0x7],ah
; loopne 0x3b5d
; loopne 0x3b5b
; add [bx+si],al
; add [bx+si],al
; add [bx],bl
; js 0x3b69
; add [bx+si],al
; add [bx],bh
; cld
; or al,0x0
; add [bx+si],al
; aas
; cld
; add al,0x0
; add [bx+si],al
; pop ds
; clc
; add ax,[bx+si]
; add [bx+si],al
; db 0x0f
; lock add [bx+si],al
; add [bx+si],al
; add ax,ax
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; inc ax
; add al,[bx+si-0xff]
; call far [si]
; cmp [si],bl
; cmp [bx+si],al
; add [0x660],al
; pusha
; add [bx+si],al
; add ax,ax
; add ax,ax
; add ax,ax
; push ds
; js 0x3bdd
; js 0x3bc1
; add al,bh
; pop ds
; clc
; pop ds
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si+0x0],ax
; add [bx+si],al
; aas
; cld
; add [bx+si],al
; add [bx+si],al
; xor [bx+si+0x0],ax
; add [bx+si],al
; aas
; cld
; add [bx+si],al
; add [bx+si],al
; add [si+0x0],cx
; add [bx+si],al
; aas
; cld
; add [bx+si],al
; add [bx+si],al
; add [bx+si+0x0],ax
; add [bx+si],al
; aas
; cld
; add [bx+si],al
; add [bx+si],al
; xor [bx+si+0x0],ax
; add [bx+si],al
; aas
; cld
; add [bx+si],al
; add [bx+si],al
; add [si+0x0],cx
; add [bx+si],al
; aas
; cld
; add [bx+si],al
; add [bx+si],al
; add [bx+si+0x0],ax
; cmp al,0x3c
; aas
; cld
; add [bx+si],al
; xor [bx+si],al
; xor [bx+si+0x0],ax
; cmp al,0x3c
; aas
; cld
; add [bx+si],al
; add [si],cl
; add [si+0x0],cx
; cmp al,0x3c
; aas
; cld
; add [bx+si],al
; add [bx+si],al
; add [bx+si+0x0],ax
; add [bx+si],al
; aas
; cld
; cmp al,0x3c
; add [bx+si],al
; xor [bx+si+0x30],ax
; add [bx+si],al
; aas
; cld
; cmp al,0x3c
; add [bx+si],al
; add [si+0xc00],cx
; add [bx+si],al
; aas
; cld
; cmp al,0x3c
; ja 0x3cf5
; ja 0x3cf7
; ja 0x3cf9
; db 0x0f
; lock add [bx+si],al
; db 0x0f
; lock sbb [bx+si-0x7fff],bx
; sbb ax,0x19b8
; cbw
; add [bx+si-0x63c7],ax
; sbb [bx+si-0x7fff],bx
; sbb ax,0xfb8
; lock add [bx+si],al
; db 0x0f
; lock out dx,al
; out dx,al
; out dx,al
; out dx,al
; out dx,al
; out dx,al
; db 0x0f
; lock add [bx+si],al
; db 0x0f
; lock push ds
; sbb [0x1e00],al
; cmp [bx+di],bl
; cbw
; add [bx+si-0x63c7],ax
; sbb [bx+si+0x0],bh
; pusha
; sbb al,0x78
; db 0x0f
; lock add [bx+si],al
; db 0x0f
; lock fstp st5
; fstp st5
; fstp st5
; db 0x0f
; lock add [bx+si],al
; db 0x0f
; lock sbb [bx+si],bl
; add [bx+si],al
; sbb al,0x38
; pop ds
; clc
; pop es
; loopne 0x3d1a
; cld
; sbb [bx+si],bl
; add [bx+si],al
; sbb al,0x38
; db 0x0f
; lock add [bx+si],al
; db 0x0f
; lock mov bx,0xbbbb
; mov bx,0xbbbb
; db 0x0f
; lock add [bx+si],al
; db 0x0f
; lock sbb [bx+si+0x0],bh
; pusha
; sbb al,0x78
; sbb [bx+si-0x7fff],bx
; cmp [si+0x181e],bx
; push es
; add [0xf38],bl
; lock add [bx+si],al
; db 0x0f
; lock mov bx,0xbbbb
; mov bx,0xbbbb
; db 0x0f
; lock add [bx+si],al
; db 0x0f
; lock sbb [bx+si+0x0],bh
; pusha
; sbb al,0x78
; sbb [bx+si-0x7fff],bx
; cmp [si+0x181e],bx
; push es
; add [0xf38],bl
; lock add [bx+si],al
; db 0x0f
; lock fstp st5
; fstp st5
; fstp st5
; db 0x0f
; lock add [bx+si],al
; db 0x0f
; lock sbb [bx+si],bl
; add [bx+si],al
; sbb al,0x38
; pop ds
; clc
; pop es
; loopne 0x3d86
; cld
; sbb [bx+si],bl
; add [bx+si],al
; sbb al,0x38
; db 0x0f
; lock add [bx+si],al
; db 0x0f
; lock out dx,al
; out dx,al
; out dx,al
; out dx,al
; out dx,al
; out dx,al
; db 0x0f
; lock add [bx+si],al
; db 0x0f
; lock push ds
; sbb [0x1e00],al
; cmp [bx+di],bl
; cbw
; add [bx+si-0x63c7],ax
; sbb [bx+si+0x0],bh
; pusha
; sbb al,0x78
; db 0x0f
; lock add [bx+si],al
; db 0x0f
; lock ja 0x3df1
; ja 0x3df3
; ja 0x3df5
; db 0x0f
; lock add [bx+si],al
; db 0x0f
; lock sbb [bx+si-0x7fff],bx
; sbb ax,0x19b8
; cbw
; add [bx+si-0x63c7],ax
; sbb [bx+si-0x7fff],bx
; sbb ax,0xfb8
; lock add [bx+si],al
; db 0x0f
; lock add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; db 0xff
; db 0xff
; db 0xff
; db 0xff
; db 0xff
; inc word [bx+si]
; add [bx+si],al
; add [bx+si],al
; add bh,bh
; inc word [bx+si]
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add bh,bh
; db 0xff
; clc
; pop ds
; clc
; pop ds
; add [bx+si],al
; pop ds
; clc
; pop ds
; clc
; add [bx+si],al
; clc
; pop ds
; clc
; pop ds
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; db 0xff
; inc word [bx+si]
; add [bx+si],al
; add bh,bh
; db 0xff
; clc
; pop ds
; clc
; pop ds
; add [bx+si],al
; pop es
; loopne 0x3dfa
; loopne 0x3df5
; add [bx],al
; loopne 0x3e00
; loopne 0x3dfb
; add al,bh
; pop ds
; clc
; pop ds
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; db 0xff
; inc word [bx+si]
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add bh,bh
; db 0xff
; clc
; pop ds
; clc
; pop ds
; add [bx+si],al
; pop ds
; clc
; pop ds
; clc
; add [bx+si],al
; clc
; pop ds
; clc
; pop ds
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; db 0xff
; dec word [bx+si-0x7778]
; mov [bx+si+0x1188],cl
; adc [bx+di],dx
; adc [bx+di],dx
; adc [bp+si],sp
; and ah,[bp+si]
; and ah,[bp+si]
; and al,[si+0x44]
; inc sp
; inc sp
; inc sp
; inc sp
; and ah,[bp+si]
; and ah,[bp+si]
; and ah,[bp+si]
; adc [bx+di],dx
; adc [bx+di],dx
; adc [bx+di],dx
; adc [bx+di],dx
; adc [bx+di],dx
; adc [bx+di],dx
; and ah,[bp+si]
; and ah,[bp+si]
; and ah,[bp+si]
; inc sp
; inc sp
; inc sp
; inc sp
; inc sp
; inc sp
; mov [bx+si-0x7778],cl
; mov [bx+si+0x4444],cl
; inc sp
; inc sp
; inc sp
; inc sp
; and ah,[bp+si]
; and ah,[bp+si]
; and ah,[bp+si]
; and ah,[bp+si]
; and ah,[bp+si]
; and ah,[bp+si]
; inc sp
; inc sp
; inc sp
; inc sp
; inc sp
; inc sp
; mov [bx+si-0x7778],cl
; mov [bx+si+0x1111],cl
; adc [bx+di],dx
; adc [bx+di],dx
; mov [bx+si-0x7778],cl
; mov [bx+si+0x4444],cl
; inc sp
; inc sp
; inc sp
; inc sp
; inc sp
; inc sp
; inc sp
; inc sp
; inc sp
; inc sp
; mov [bx+si-0x7778],cl
; mov [bx+si+0x1111],cl
; adc [bx+di],dx
; adc [bx+di],dx
; and ah,[bp+si]
; and ah,[bp+si]
; and ah,[bp+si]
; adc [bx+di],dx
; adc [bx+di],dx
; adc [bx+di],dx
; mov [bx+si-0x7778],cl
; mov [bx+si+0x0],cl
; add [bx+si],al
; inc cx
; adc [bp+di+0x12],sp
; fist word [bp+si]
; outsw
; adc cl,cl
; adc [si+0x2b],cl
; or ah,[si]
; sbb bl,[fs:bx+di-0x6cd2]
; sbb bp,di
; and bx,cx
; pop ds
; push di
; and al,0x1d
; xor [si],ah
; sub [bx+di],di
; sub ax,0x3147
; o32 sub bh,[bx+0x6824]
; and ax,sp
; daa
; mov dx,0x7c22
; das
; cmp [si],ch
; push ax
; xor dh,[bp+di]
; sub al,cl
; sub ax,0x29b4
; leave
; and ax,0x1971
; pop cx
; sbb al,0x9
; sbb ax,0x1b29
; mul byte [0x288a]
; out dx,ax
; and [bx+di-0x3ae3],cx
; push ds
; out 0x20,ax
; sbb [0x2538],ah
; mov bp,0x7518
; pop ss
; popa
; adc al,0x1
; adc ax,0x15d7
; mov sp,0x2e16
; add [es:di],al
; sbb [bx+di],cl
; push ss
; sbb [bp+si],bl
; pop ds
; sbb [di],al
; or ch,[bp+si]
; adc ax,0x2a1a
; add [bx],al
; dec ax
; or dx,[si]
; dec ax
; sbb [bx],bl
; dec ax
; add [bx+di],cl
; insb
; or ax,0x6c12
; push ss
; pop ds
; insb
; add [bx],al
; nop
; or dx,[si]
; nop
; sbb [bx],bl
; nop
; add [bx],bl
; scasb
; and [bx+di],ch
; add [bx+si],si
; test al,0x1e
; xor [bx+si+0xc0f],ch
; pop cx
; adc [si],cl
; pop cx
; cmp al,0x1
; or al,0x12
; push ds
; or al,0x12
; or al,0x3c
; inc dx
; adc di,[si]
; inc dx
; or [bx+si+0x66],ah
; pop ss
; pusha
; o32 or al,0x84
; mov dl,[bp+di]
; test [bp+si+0x420],cl
; sahf
; sbb [bp+0x27],bx
; add ax,0x91e
; push cs
; push ds
; adc [0x1a1e],dx
; pop ds
; push ds
; or dx,[si]
; cmp al,0x3
; or [bp+0x17],cl
; sbb al,0x4e
; or dx,[si]
; pop dx
; or dx,[si]
; js 0x3f96
; add ax,0x1a7e
; pop ds
; jng 0x3fa3
; or dl,[bp+0x110e]
; xchg ax,si
; adc ax,0x9618
; add [bx],bl
; scasb
; and [bp+si],ah
; add [0x14e],ax
; insb
; test al,0x7
; cmp al,0x7e
; or al,0xc
; das
; movmskps ecx,xmm12
; mov [bp+di],dx
; or al,0x2f
; sbb [si],bh
; jng 0x3fe0
; push es
; dec si
; push ds
; insb
; test al,0x3c
; add al,0x12
; sbb [si],al
; jna 0x404a
; add ax,0x4842
; or [bp+0xd94],cx
; insb
; jc 0x3fe6
; xor [0x3011],dh
; adc cl,[ss:bp+0x54]
; push ss
; mov ss,[si+0x421a]
; dec ax
; sbb dx,[bp+si]
; sbb [bp+di],bl
; jna 0x4068
; and [bp+di],al
; sahf
; sbb bl,[bp+0x1137]
; adc ax,0x170c
; sbb [si],cx
; sbb bx,[bp+di]
; or al,0x1e
; push ds
; or al,0x11
; adc [bp+si],dx
; adc dx,[bp+di]
; adc dl,[di]
; adc ax,0x1712
; pop ss
; adc bl,[bx+di]
; sbb [bp+si],dx
; sbb bx,[si]
; adc bl,[0x121e]
; adc [bx+di],dx
; sbb [bp+di],dl
; adc bx,[bx+si]
; adc ax,0x1815
; pop ss
; sbb [bx+si],bx
; sbb bx,[0x1118]
; adc [0x1515],bx
; push ds
; pop ss
; pop ss
; push ds
; sbb [bx+di],bx
; push ds
; sbb bx,[bp+di]
; push ds
; sbb ax,0x1e1e
; adc [bx+di],dx
; and al,0x15
; adc ax,0x1724
; pop ss
; and al,0x19
; sbb [si],sp
; sbb bx,[bp+di]
; and al,0x1e
; push ds
; and al,0x26
; push ss
; sbb [si],bh
; xor al,0x1a
; push ds
; ds daa
; sbb [bp+si],bx
; inc si
; xor ax,0x1714
; dec ax
; cmp [si],bl
; sbb al,0x4b
; xor [0x481f],bx
; dec ax
; sbb bl,[si]
; jo 0x40a3
; sbb [bp+si],bl
; jns 0x40ab
; sbb al,0x1e
; jns 0x40b7
; sbb [di],bx
; db 0x82
; and [bx+si],ax
; pop ds
; mov [0x3c20],al
; add [si],cx
; adc al,[bp+si]
; or al,0x12
; add ah,[si]
; sub al,[bp+di]
; or al,0x12
; add sp,[si]
; sub al,[di]
; or al,0x12
; add [bp+si],dx
; sbb [bx+di],al
; sbb [0x1e01],bl
; and al,0x1
; and al,0x2a
; add ax,0x1812
; add ax,0x1e18
; add ax,0x241e
; add ax,0x2a24
; push es
; or al,0x12
; push es
; sbb [0xc07],bl
; adc cl,[bx+di]
; or al,0x12
; or [si],sp
; sub cl,[bp+si]
; or al,0x12
; or bl,[bx+si]
; push ds
; pop es
; adc bl,[bx+si]
; pop es
; sbb [0x1e07],bl
; and al,0x7
; and al,0x2a
; or [bp+si],dx
; sbb [bx+di],cl
; sbb [0x240a],bl
; sub cl,[bp+di]
; or al,0x12
; or bx,[bx+si]
; push ds
; or ax,0x120c
; push cs
; sbb [0xc0f],bl
; adc cl,[bp+di]
; push ds
; and al,0xb
; and al,0x2a
; or ax,0x1812
; or ax,0x1e18
; or ax,0x241e
; or ax,0x2a24
; movlps xmm3,qword [bx+si]
; prefetcht2 byte [0x1e0f]
; and al,0xf
; and al,0x2a
; sbb [bx+0x1995],cl
; mov dx,[bx+di-0x71e6]
; xchg ax,sp
; and cl,[0x6554]
; das
; adc [bp+0x5f],cl
; sub [bp+si],dx
; push cx
; arpl [bx+si],bp
; adc al,0x54
; and [gs:bx+si],al
; cmp ax,0x5700
; and ax,0x1f00
; scasb
; add [ss:bx+si],al
; and al,[bx+di]
; add [si],sp
; add al,[bp+si]
; and al,[bp+di]
; add sp,[bx+si]
; add al,0x4
; push ds
; add ax,0x1b05
; push es
; push es
; sbb al,[bx]
; pop es
; sbb cl,[bx+si]
; or [si],bl
; or [bx+di],cx
; push ds
; or cl,[bp+si]
; sbb al,0xb
; or bx,[bx+si]
; or al,0xc
; adc cx,[di]
; or ax,0xe0f
; push cs
; or ax,0x100f
; or al,0x11
; adc [di],cx
; adc dl,[bp+si]
; movlps qword [bp+di],xmm2
; adc dx,[si]
; adc al,0x18
; adc ax,0x1c15
; push ss
; push ss
; push ds
; pop ss
; pop ss
; sbb al,0x18
; sbb [bp+si],bl
; sbb [bx+di],bx
; sbb bl,[bp+si]
; sbb bl,[bp+di]
; sbb bx,[bp+di]
; push ds
; sbb al,0x1c
; and [di],bl
; sbb ax,0x1e22
; push ds
; and al,0x1f
; pop ds
; and dh,[di]
; add [si],ax
; pushf
; sbb bx,[0x209c]
; das
; pop es
; add [bx+di],bl
; sbb [bx+si],al
; sbb [bx+di],ax
; sub bl,[si+0x2a1e]
; pushf
; and [bp+si],al
; mov [bp+di],ds
; mov [0xd0a],segr6
; and dl,[bp+si]
; adc ax,0x22
; push es
; sbb [ss:bx],bx
; movups xmm7,oword [ss:si]
; push cs
; push cs
; adc [ds:bx+di],dx
; ds or ax,0x400d
; adc dl,[bp+si]
; inc ax
; add [bx+si],al
; pop ax
; pop ds
; pop ds
; pop ax
; add [bx+di],ax
; pop bx
; push ds
; push ds
; pop bx
; add al,[bp+si]
; pop si
; sbb ax,0x5e1d
; add ax,[bp+di]
; pusha
; sbb al,0x1c
; pusha
; add al,0x4
; bound bx,[bp+di]
; sbb sp,[bp+si+0x5]
; add ax,0x1a64
; sbb ah,[si+0x6]
; push es
; sbb [gs:bx+di],bx
; gs pop es
; pop es
; o32 sbb [bx+si],bl
; o32 or [bx+si],cl
; pop ss
; pop ss
; or [ecx],cx
; push word 0x1616
; push word 0xc0a
; imul dx,[bp+di],word 0x6915
; or al,0xc
; adc word [bp+di],byte +0x13
; or word [bp+di],byte +0xb
; xchg [si],dl
; adc al,0x86
; or cl,[bp+si]
; mov [di],dl
; adc ax,0x988
; or [bp+si+0x1616],cx
; mov cl,[bx+si]
; or [si+0x1717],cl
; mov [bx],es
; pop es
; mov ds,[bx+si]
; sbb [bp+0x606],cl
; db 0x8f
; sbb [bx+di],bx
; pop word [di]
; add ax,0x1a90
; sbb dl,[bx+si+0x404]
; xchg ax,cx
; sbb bx,[bp+di]
; xchg ax,cx
; add [bp+di],al
; xchg ax,dx
; sbb al,0x1f
; xchg ax,dx
; or ax,0xae12
; aaa
; add [bp+si],al
; scasb
; push es
; or al,0xae
; adc bx,[bx+di]
; scasb
; sbb ax,0xae1f
; dec ax
; pop es
; or [0x1817],dh
; ss dec dx
; add ax,[di]
; scasb
; sbb bl,[si]
; scasb
; and [si],ah
; or ax,[bx+si]
; add [si],dx
; add [bx+di],al
; or al,0x0
; add dl,[bp+di]
; add [bp+si],al
; or ax,0x400
; adc al,[bx+si]
; add al,0xe
; add [bp+si],cl
; adc [bx+si],ax
; or cl,[bx]
; add [di],bl
; adc [bx+si],al
; sbb ax,0x750d
; jg 0x427d
; jnz 0x42ec
; push cs
; jnc 0x41f1
; adc [bp+di-0x7f],si
; sub [bx+si],cl
; add [bx+di],al
; pop ss
; add [bx+di],al
; or [bx+si],ax
; add dl,[0x200]
; or al,[bx+si]
; add dx,[di]
; add [bp+di],al
; or ax,[bp+si]
; add ax,0x214
; add ax,0x30c
; or [bp+di],dl
; add cx,[bx+si]
; or ax,0xd05
; adc al,[di]
; or ax,0xb0e
; daa
; adc [bp+di],cx
; daa
; hint_nop55 word [bp+di]
; adc [0xd3b],bl
; pop sp
; jz 0x42b5
; or byte [bp+di+0x5c12],0x74
; adc al,[bx+si+0xe8b]
; pop cx
; jc 0x42c2
; db 0x82
; lea dx,[bx+di]
; pop cx
; jc 0x42cb
; db 0x82
; lea bp,[bx+di]
; add [si],bh
; inc si
; pop ds
; cmp al,0x46
; add [si],di
; pop dx
; push ds
; cmp al,0x5a
; add bh,[si]
; inc si
; sbb ax,0x463c
; add di,[si]
; inc cx
; sbb al,0x3c
; inc cx
; add al,0x3c
; inc ax
; sbb di,[si]
; inc ax
; add ax,0x3f3c
; sbb bh,[si]
; aas
; push es
; cmp al,0x3e
; sbb [si],di
; ds cmp al,0x3
; push cx
; push di
; sbb al,0x51
; push di
; add al,0x2c
; xor bl,[bp+di]
; sub al,0x32
; add al,0xa1
; cmpsw
; sbb sp,[bx+di+0x8a7]
; jng 0x4281
; pop ss
; jng 0x4284
; or bx,[bp+0x64]
; adc al,0x5e
; fs or al,0x12
; sbb [bp+di],dl
; adc bl,[bx+si]
; and [di],cl
; sahf
; adc [bp+0xb31],bl
; or al,0x12
; adc [si],dx
; adc bl,[bx+di]
; sbb [bp+si],dx
; push ds
; pop ds
; adc al,[0x1807]
; push ds
; pop ds
; push ds
; add [bp+si],al
; and al,0x14
; adc ax,0x1e2a
; pop ds
; sub al,[0x3007]
; movups xmm6,oword [0x200]
; cmp al,0x6
; pop es
; dec ax
; movups xmm1,oword [bx+si+0x15]
; push ss
; dec ax
; add [bp+si],al
; push sp
; sbb bl,[bp+di]
; push sp
; add [bp+si],al
; pusha
; adc [bx+di],dl
; arpl [di],dx
; push ss
; pusha
; add al,0x5
; insb
; or al,0xc
; insb
; or [si],cx
; js 0x4368
; adc ax,0x1678
; pop ss
; test [0x9011],cl
; sbb [bx+di],bl
; nop
; or [bp+si],cx
; xchg ax,si
; push ds
; pop ds
; xchg ax,si
; add al,[di]
; mov [0x1f1e],al
; mov [0xe0d],al
; test al,0x4c
; or cl,[di]
; and al,0xe
; push cs
; and cl,[bx]
; db 0x0f
; and [bx+si],dl
; adc bx,[0x1f19]
; ss pop es
; or al,0x5a
; sbb bl,[bx]
; jc 0x4389
; pop es
; test [bp+si],cl
; adc ax,0x2bae
; add [bx+di],cl
; scasb
; push ss
; pop ds
; scasb
; and [si],bh
; or ax,[0x150c]
; push es
; or al,0x1
; sbb [0x2a10],bl
; xor [di],dl
; push sp
; pop dx
; or ch,[si+0x72]
; pop ss
; mov [0x20a8],al
; add [bp-0x61fb],bl
; cs sbb al,0x1c
; sub bl,[bp+di]
; sbb ax,0x1a24
; push ds
; and [bx+di],bx
; pop ds
; push ds
; add ax,[bp+di]
; pusha
; add al,[si]
; pop dx
; add [di],ax
; push di
; add [0x1c54],al
; sbb al,0x96
; sbb bx,[di]
; nop
; sbb bl,[0x198d]
; pop ds
; mov dl,[bx]
; pop ds
; scasb
; dec sp
; push es
; push es
; and al,0x5
; pop es
; daa
; add al,0x9
; sub al,[0x2d0a]
; pop es
; or [bx+si],dh
; adc [bp+si],dx
; inc bp
; adc [bp+di],dl
; dec ax
; unpcklps xmm1,oword [bp+0xd]
; push cs
; push cx
; adc ax,0x5115
; or dx,[0x1454]
; adc al,0x57
; or ax,0x5a13
; add [bx+si],al
; mov al,[bx+si]
; add [bx+si+0x100],dl
; xchg ax,si
; add [bp+si],al
; pushf
; add [si],al
; mov [0xb00],al
; test al,0x5
; pop es
; movsw
; or al,0xf
; stosw
; add [0x25ae],dl
; add [bp+si],al
; adc al,[bx]
; or [bp+si],dx
; adc [bx+di],dl
; adc dl,[0x1217]
; or ax,0x1e0e
; or ax,0x2a0e
; adc dx,[si]
; sub dl,[di]
; push ss
; sbb [ss:bp+si],bx
; inc dx
; push ds
; pop ds
; dec si
; sbb [bp+si],bx
; pop dx
; sbb ax,0x661f
; or [bp+si],cl
; jc 0x4454
; adc [bp+si+0x19],si
; sbb dh,[bp+si+0x4]
; add ax,0x147e
; adc ax,0x47e
; add ax,0xe8a
; push cs
; mov cl,[bx+si]
; or [bp+0xf0e],dx
; xchg ax,si
; adc dl,[si]
; mov [0x3c20],al
; sbb dl,[bx]
; sbb ax,0x121c
; sbb [0x1d17],bl
; add [di+0x53],cx
; add cx,[bx+si+0x4e]
; add ax,0x534d
; sbb al,[bp+di+0x1c89]
; jng 0x43fd
; push ds
; or word [bx+di+0x1e14],byte +0x24
; or ah,[bp+0x6c]
; and [bx+di],bl
; sahf
; sbb ax,0x2a9e
; add [di],al
; scasb
; push cs
; push cs
; scasb
; sbb bl,[bx]
; scasb
; adc [bx+di],dx
; scasb
; dec ax
; movups xmm5,oword [bp+0x64c]
; or ax,0x12ae
; sbb [bp+0x200],bp
; sub al,[bx+si]
; add [di],ch
; or [si],cl
; sub cl,[bx+di]
; or bp,[di]
; movups oword [bp+si],xmm5
; adc [bx+si],dl
; sub ax,0x1814
; sub dl,[di]
; pop ss
; sub ax,0x1f1d
; sub bl,[bx]
; pop ds
; sub ax,0x130d
; inc dx
; movups oword [di+0x0],xmm0
; or [si+0x0],ch
; add ax,0x72
; add [bx+si+0x2],di
; add si,[di+0x6]
; pop es
; outsw
; pop ss
; pop ds
; insb
; sbb bl,[bx]
; jc 0x44f7
; pop ds
; js 0x44f4
; sbb [bx+0x1c],bp
; sbb ax,0x2575
; add al,[bx]
; sbb [si],cl
; push cs
; sbb [bp+di],dl
; adc bx,[bx+si]
; sbb [si],bl
; sbb [bx+di],dh
; or ax,0x360d
; adc dx,[bp+di]
; ss add ax,0x3c06
; adc ax,0x3c15
; or cl,[bp+si]
; inc dx
; or [bp+si],cx
; dec ax
; pop ss
; sbb cl,[bx+si+0x1e]
; pop ds
; dec ax
; add ax,0x5405
; adc dx,[bp+di]
; push sp
; add al,0x5
; pusha
; or cl,[bp+di]
; pusha
; adc dx,[di]
; pusha
; sbb bx,[si]
; pusha
; or cl,[bp+di]
; jc 0x4531
; adc ax,0xf72
; adc [bp+0x5],bh
; pop es
; mov cl,[bx]
; adc [bx+si+0x1917],dl
; nop
; add [bx+di],al
; xchg ax,si
; push ds
; pop ds
; xchg ax,si
; add ax,[bp+di]
; mov [0x1412],al
; mov [0x1b1b],al
; mov [0x2520],al
; add al,0x1e
; xor [bx+si],dl
; inc sp
; pop dx
; cmp al,0x3
; or al,0x12
; or [si],cl
; adc cl,[di]
; or al,0x12
; adc cl,[si]
; adc dl,[bx]
; or al,0x12
; sbb al,0xc
; adc cl,[di]
; das
; xor ax,0x2f13
; xor ax,0x3c1e
; inc dx
; or ah,[bp+0x6c]
; push cs
; mov al,[0x11a6]
; mov al,[0x20a6]
; add [bp-0x61e3],bl
; dec sp
; add [bx],bl
; scasb
; add [di],al
; mov al,[bx+si]
; add cl,[di+0x1512]
; mov dl,[bx+di]
; adc al,0x8d
; sbb bl,[bx]
; mov bl,[di]
; pop ds
; lea ax,[bp+di]
; push es
; pop dx
; add al,0x5
; pop bp
; or dx,[bx+si]
; pop dx
; push cs
; minps xmm2,oword [si]
; push ss
; pop dx
; sbb bl,[bx]
; pop dx
; sbb bx,[di]
; pop bp
; or [bp+si],cx
; xor [bp+si],cl
; or bp,[di]
; or cx,[bx]
; sub dl,[si]
; sbb bp,[bp+si]
; adc ax,0x2d18
; and ax,0x807
; mov [0xf0d],al
; mov [0x1814],al
; mov [0x200],al
; js 0x45b9
; or [bx+si+0xd],bh
; adc [bx+si+0x15],bh
; push ss
; js 0x45d8
; sbb ax,0xb78
; push cs
; dec ax
; adc dx,[si]
; dec ax
; sbb [bp+si],bx
; dec ax
; push ds
; pop ds
; dec ax
; push es
; pop es
; cmp al,0x0
; add dh,[bx+si]
; add ax,0x1806
; or cx,[di]
; sbb [bx+di],dl
; adc [bx+si],bx
; adc al,0x16
; sbb [di],bl
; pop ds
; sbb [bx+di],dh
; add [bp+si],al
; mov [0x1f1d],al
; mov [0x2520],al
; add [bp+si],dx
; and ax,[bx+di]
; dec si
; imul cx,[bx+si],byte +0x4e
; imul cx,[bp+si],byte -0x76
; xchg ax,bp
; movd dword [di+0x3011],mm2
; xor ax,0x8a17
; xchg ax,bp
; push ds
; push ds
; cmp di,[si]
; add ax,0x120c
; adc cl,[si]
; adc bl,[0x120c]
; cpu_write
; inc dx
; pop ss
; cmp al,0x42
; or bp,[si+0x72]
; push ds
; insb
; jc 0x461e
; xor [0x960e],dh
; pushf
; adc al,0x6c
; jc 0x4641
; add [bp+si-0x6de3],dl
; dec sp
; add [bx+si],al
; inc dx
; add [bx+di],ax
; inc si
; add al,[bp+si]
; dec cx
; add ax,[bp+di]
; dec sp
; add al,0x4
; dec di
; add ax,0x5205
; push es
; push es
; push sp
; pop es
; pop es
; push si
; or [bx+si],cl
; push di
; or [bx+di],cx
; pop ax
; pop ds
; pop ds
; inc dx
; push ds
; push ds
; inc si
; sbb ax,0x491d
; sbb al,0x1c
; dec sp
; sbb bx,[bp+di]
; dec di
; sbb bl,[bp+si]
; push dx
; sbb [bx+di],bx
; push sp
; sbb [bx+si],bl
; push si
; pop ss
; pop ss
; push di
; push ss
; push ss
; pop ax
; add [bx],bl
; scasb
; or al,0xd
; dec ax
; push cs
; push cs
; inc bp
; movups xmm0,oword [bp+si+0x11]
; adc [di+0x12],ax
; adc cx,[bx+si+0xc]
; or ax,0xe7e
; push cs
; jpo 0x468a
; adc [bx+si+0x11],bh
; adc [bp+di+0x12],di
; adc di,[bp+0x31]
; add [bx+di],ax
; test ax,0x202
; test ax,0x707
; test ax,0x808
; test ax,0x909
; test ax,0xf0f
; test ax,0x1010
; test ax,0x1616
; test ax,0x1717
; test ax,0x1818
; test ax,0x1d1d
; test ax,0xc0c
; inc sp
; push ds
; push ds
; test ax,0x303
; dec ax
; add al,0x4
; dec ax
; add ax,0x4805
; push es
; push es
; dec ax
; sbb [bx+di],bx
; dec ax
; sbb bl,[bp+si]
; dec ax
; sbb bx,[bp+di]
; dec ax
; sbb al,0x1c
; dec ax
; or ax,0x440d
; adc dl,[bp+si]
; inc sp
; adc dx,[bp+di]
; inc sp
; add al,[si]
; cmp al,0x7
; or [0xe0c],si
; xor [bp+di],dl
; adc ax,0x1a2a
; sbb al,0x1e
; sbb ax,0x2a1f
; sbb bx,[di]
; cmp al,0xb
; or ax,0x125a
; adc al,0x5a
; add al,0x5
; jng 0x4705
; sbb di,[bp+0x48]
; add al,0x5
; pushf
; sbb bl,[bp+di]
; pushf
; and ax,[si]
; add ax,0x1a9c
; sbb bx,[si+0x2520]
; add [bx+si+0x7d],cl
; add [si+0x7a],cx
; add cl,[bx+0x59]
; add dx,[bp+si+0x74]
; add al,0x55
; jno 0x4712
; pop ax
; outsb
; push es
; pop dx
; imul ax,[bx],byte +0x5c
; push word 0x5d08
; or [gs:bp+0x62],bx
; pop ds
; dec ax
; jnl 0x473d
; dec sp
; jpe 0x473f
; dec di
; pop cx
; sbb al,0x52
; jz 0x4743
; push bp
; jno 0x4745
; pop ax
; outsb
; sbb [bp+si+0x6b],bx
; sbb [si+0x68],bl
; pop ss
; pop bp
; gs push ss
; pop si
; bound ax,[bx+di]
; or al,0x29
; add ah,[bx+di+0x77]
; sbb ax,0x7761
; and cl,[bp+si]
; dec si
; ja 0x475c
; dec si
; ja 0x4786
; push es
; or al,0x12
; push ds
; push es
; or al,0x18
; xor [0x360c],dh
; cmp al,0x13
; ss cmp al,0x5
; inc dx
; dec ax
; add bl,[bp+si+0x60]
; sbb ax,0x605a
; or dx,[bp+0x149c]
; xchg ax,si
; pushf
; and [bx+di],al
; cbw
; sbb ax,0x3198
; add [bp+di],al
; push ds
; or [bx+di],cl
; push ds
; or al,0xf
; push ds
; adc al,0x18
; push ds
; pop es
; or [bx+si+0xd],cl
; push cs
; dec ax
; adc [si],dx
; dec ax
; push ss
; pop ss
; dec ax
; sbb al,0x1f
; dec ax
; add [bp+di],al
; jc 0x4795
; or al,0x72
; adc [bp+si],dx
; jc 0x47a7
; sbb [bp+si+0x2],dh
; add ax,0xa9c
; push cs
; pushf
; adc [bp+si],dx
; pushf
; adc ax,0x9c18
; sbb bx,[si]
; pushf
; sub bx,[di]
; pop ds
; push ds
; add [di],al
; dec ax
; sbb ax,0x721f
; add [bx],al
; scasb
; dec sp
; or [bx],bl
; scasb
; add al,[bp+di]
; sub al,[bx]
; or [bp+si],ch
; or al,0xd
; sub dl,[bx+di]
; adc ch,[bp+si]
; push ss
; pop ss
; sub bl,[bx+di]
; sbb ch,[bp+si]
; add ax,[di]
; push sp
; or [bp+di],cx
; push sp
; movups oword [si+0x15],xmm2
; pop ss
; push sp
; sbb bx,[di]
; push sp
; add al,0x7
; jng 0x47e5
; push cs
; jng 0x47ef
; adc ax,0x197e
; sbb al,0x7e
; and [bp+si],ah
; push ds
; and al,0x3b
; push ds
; js 0x4779
; add [bp+0x65],cx
; and ax,0x9d09
; mov ax,[0x23c]
; adc bl,[bx+si]
; or dl,[bp+si]
; sbb [bp+si],dl
; adc bl,[bx+si]
; sbb [bp+si],dl
; sbb [si],dl
; adc bl,[bx+si]
; add ax,0x423c
; or al,0x3c
; inc dx
; adc al,0x3c
; inc dx
; sbb di,[si]
; inc dx
; or [bp+0x6c],sp
; adc ax,0x6c66
; push ds
; o32 insb
; push cs
; nop
; xchg ax,si
; pop ss
; nop
; xchg ax,si
; and [bx+si],al
; sahf
; add ax,0x369e
; add [bp+di],al
; xor [si],al
; add al,0x2d
; add ax,0x2a05
; push es
; push es
; daa
; pop es
; pop es
; and al,0x8
; or [bx+di],ah
; or [bx+di],cx
; push ds
; or cl,[bp+si]
; sbb cx,[bp+di]
; or al,0x18
; db 0x0f
; hint_nop50 word [bx+si]
; adc [bp+di],bl
; adc [bp+si],dx
; sbb [bx],dl
; sbb [bx+si],bl
; sbb al,0x1f
; and al,0xf
; db 0x0f
; adc [ss:bx+si],dl
; xor dx,[bx+di]
; adc dh,[bx+si]
; pop ss
; sbb [bx+si],dh
; add [bp+si],al
; dec ax
; add ax,0x4806
; movups xmm1,oword [bx+si+0x19]
; sbb cl,[bx+si+0x1d]
; pop ds
; dec ax
; add [bx+di],al
; jc 0x4889
; pop ds
; jc 0x4873
; push es
; o32 pop es
; pop es
; arpl [bx+si],cx
; or [bx+si+0xa],sp
; or ah,[bp+di+0xb]
; or sp,[bp+0x14]
; adc al,0x66
; adc ax,0x6315
; push ss
; pop ss
; pusha
; sbb [bx+si],bl
; arpl [bx+di],bx
; sbb ah,[bp+0xe]
; adc [bp+si+0x200],cx
; scasb
; sbb ax,0xae1f
; dec sp
; adc dx,[0x1318]
; push ss
; xor [bx],cl
; adc [bp+si+0x9],dh
; or al,0xae
; adc dx,[0x40ae]
; or [si],cx
; dec ax
; or al,0xc
; imul cx,[di],word 0x6c0d
; push cs
; push cs
; outsw
; or ax,0xae0f
; pop ss
; sbb al,0xae
; inc sp
; adc dx,[0x1148]
; adc [bx+0x12],bp
; adc ch,[si+0x13]
; adc bp,[bx+di+0x3]
; or [bp+0x1210],ch
; scasb
; and [bx],ch
; add cx,[si]
; and ax,[bp+si]
; dec si
; pop word [0x8f78]
; or bh,[bx+si-0x71]
; adc ax,0x8f78
; sbb [bx+si-0x71],di
; sbb ax,0x8f4e
; or al,0x90
; mov ax,[0x9013]
; mov ax,[0x1e0c]
; ss cmp al,0x1
; push es
; or al,0x1
; push ds
; and al,0x5
; or al,0x12
; sbb al,0x18
; push ds
; add [si],di
; inc dx
; push ds
; cmp al,0x42
; punpcklbw mm4,[bp+0x10]
; pusha
; o32 add al,0x84
; mov bl,[bp+di]
; test [bp+si-0x63f5],cl
; mov [0x9c14],al
; mov [0x20],al
; sahf
; sbb ax,0x409e
; pop es
; or bx,[bx+si]
; add cx,[bp+di]
; jc 0x4930
; sbb al,0x90
; adc al,0x1c
; scasb
; push es
; pop es
; sbb ax,[di]
; push es
; push ds
; add al,0x5
; and [bp+di],ax
; add al,0x24
; inc sp
; adc al,0x18
; sbb [bp+si],bl
; sbb al,0x40
; adc al,0x1c
; jc 0x493b
; or dx,[bx+si+0xb03]
; scasb
; sbb [bx+di],bl
; sbb bx,[bx+di]
; sbb bl,[0x1b1a]
; and [bp+di],bx
; sbb al,0x24
; and [si],cx
; or ax,0x1218
; adc bx,[bx+si]
; push cs
; adc [bx+di],ch
; or dl,[bx+di]
; cmp [bx+di],cx
; or bh,[si]
; adc [bp+si],dx
; cmp al,0x8
; or [bx],di
; adc dl,[bp+di]
; aas
; pop es
; or [bp+si+0x13],al
; adc al,0x42
; push es
; pop es
; inc bp
; adc al,0x15
; inc bp
; add ax,0x4806
; adc ax,0x4816
; push ss
; pop ss
; dec bx
; pop ss
; sbb [bp+0x18],cl
; sbb [bx+di+0x19],dx
; sbb dl,[si+0x1b]
; sbb al,0x5a
; sbb al,0x1f
; arpl [bx],cx
; adc [di+0x100f],bl
; jpo 0x499c
; adc [bp+si+0xf],ch
; adc [si+0x100f],cl
; pop cx
; add [bp+si],al
; scasb
; or al,0x13
; scasb
; sbb ax,0xae1f
; add [bp+si],al
; jc 0x49bf
; pop ds
; jc 0x49bf
; sbb dx,[bx+0x0]
; add sp,[bx]
; sbb al,0x1f
; daa
; dec ax
; add [bp+si],al
; pusha
; and [si],bh
; add [0xa0c],ax
; dec si
; push sp
; add si,[0x33c]
; imul bp,[bx+0x1e],word 0x352f
; push ds
; push es
; or al,0x1c
; imul bp,[bx+0x3],word 0x8d87
; sbb al,0x87
; lea ax,[bx+di]
; movsw
; stosw
; push ds
; movsw
; stosw
; and [bx],al
; sahf
; sbb [bp+0xe48],bl
; adc [bx],di
; and [bx+di],cx
; or bx,[bx+si]
; adc al,0x16
; sbb [bp+si],al
; push es
; adc bl,[bp+si]
; sbb ax,0xe12
; adc [0xb09],bx
; ss adc al,0x16
; movups xmm3,oword [ss:bp+si+0xa]
; or sp,[bp+0x14]
; adc ax,0x666
; or dx,[bp+0x1914]
; xchg ax,si
; add [bx],bl
; scasb
; and [bp+si],ah
; add [bx],ax
; wait push ds
; pop es
; wait or [bp+si-0x7d],al
; pop ss
; inc dx
; cmp word [si],byte +0x8
; adc bl,[bx+si]
; pop ss
; adc bl,[bx+si]
; db 0x0f
; ss cmp al,0x10
; ss cmp al,0xf
; imul dx,[gs:bx+si],byte +0x65
; imul cx,[bx],byte -0x76
; nop
; adc [bp+si+0x490],cl
; sub dh,[bx+si]
; sbb bp,[bp+si]
; xor [di],al
; pop dx
; pusha
; sbb bl,[bp+si+0x60]
; sbb cx,[bp+si+0x490]
; mov dl,[bx+si+0x320]
; sahf
; sbb bl,[bp+0x321]
; add ax,0x342
; add ax,0x55a
; push es
; js 0x4a5a
; or al,0x8e
; push cs
; push cs
; xchg ax,sp
; adc [bx+si],dl
; call 0x1494:0x1212
; adc al,0x8e
; inc ax
; add ax,[bp+di]
; adc al,[di]
; add ax,0xb12
; or bx,[bx+si]
; or ax,0x180d
; adc dx,[bp+di]
; sbb [0x1816],dl
; sbb bl,[bp+si]
; adc bl,[si]
; sbb al,0x12
; sbb ax,0x2a1f
; sbb bx,[bp+di]
; cmp al,0x1a
; sbb dl,[di+0x1d]
; sbb ax,0x1a50
; sbb al,[si+0x1f1a]
; xchg ax,si
; add al,[di]
; xchg ax,sp
; inc sp
; add al,0x4
; adc al,[0x1206]
; sbb bx,[bp+di]
; adc bl,[di]
; sbb ax,0xa12
; or bl,[bx+si]
; or al,0xc
; sbb [si],dl
; adc ax,0x1c18
; sbb al,0x3c
; sbb al,0x1c
; sbb [fs:bx+di],bx
; jo 0x4ac7
; sbb ax,0x7a
; add bp,[bp+0x1c06]
; scasb
; dec ax
; add al,0x5
; scasb
; sbb ax,0xae1f
; and [bp+si],ah
; add [bp+si],bx
; sub ax,0x300d
; inc dx
; wrmsr
; inc dx
; adc [bx+si],si
; inc dx
; adc si,[bx+si]
; inc dx
; or si,[0x1572]
; ss jc 0x4ad2
; inc dx
; jpo 0x4ae1
; pusha
; js 0x4ae6
; pusha
; js 0x4aeb
; pusha
; js 0x4af0
; pusha
; js 0x4b1c
; adc [0x80c],al
; and al,0x2a
; sbb [0x1c24],bx
; inc bx
; dec cx
; push cs
; dec ax
; dec si
; adc cl,[bp+si+0x50]
; adc [si+0x5a],dl
; push ds
; pop bx
; popa
; or [di+0x7b],si
; adc [bx+si+0x7e],bh
; adc [bx],bl
; and ax,0x4b07
; push cx
; and [bp+si],al
; sahf
; sbb bx,[bp+0x1e2b]
; pop ds
; sbb [0x541f],bl
; or al,0xc
; pop dx
; or al,0xc
; pusha
; or al,0xc
; movupd xmm5,oword [si+0x13]
; adc bx,[bp+si+0x13]
; adc sp,[bx+si+0x13]
; adc sp,[bp+0x16]
; push ss
; jl 0x4b3b
; adc cl,[si+0x1a1a]
; mov [di],cs
; push cs
; pushf
; push ss
; push ss
; pushf
; push ds
; push ds
; pushf
; add [bp+si],al
; scasb
; adc [si],dl
; scasb
; sbb [si],bl
; scasb
; dec sp
; or cx,[bx]
; scasb
; adc ax,0xae17
; sbb ax,0xae1f
; inc ax
; push cs
; prefetcht1 byte [bp+si]
; adc bx,[bx+si]
; sbb [di],bx
; sbb [0x540f],cl
; adc dl,[bp+di]
; push sp
; sbb [di],bx
; push sp
; add al,0xa
; scasb
; inc sp
; or al,0xd
; sbb [bx+si],dl
; adc [bx+si],bx
; add ax,[0xc27]
; or ax,0x1054
; adc [si+0x48],dx
; add ax,[bp+di]
; scasb
; add ax,[bp+di]
; xchg ax,bx
; add ax,[bp+di]
; js 0x4b7e
; add bx,[di+0x3]
; add ax,[bp+si+0x31]
; sbb [bx+di],bx
; insb
; and [bp+si],ah
; or ax,0x3512
; adc dl,[bp+si]
; xor ax,0x720f
; adc word [bx+si],byte +0x72
; cmp word [si],byte +0x3
; or al,0x12
; or [si],cl
; adc al,[bp+di]
; dec dx
; push ax
; or [bx+si+0x4e],cl
; push ss
; or word [bx+di+0xc16],byte +0x12
; push ss
; dec ax
; dec si
; sbb dl,[bp+di+0x1299]
; xchg ax,bx
; cwd
; or ax,0x615b
; adc bl,[bp+di+0x61]
; and [di],bl
; inc sp
; sbb ax,0x2a08
; add [bp+si],ax
; push ds
; push es
; or bx,[0x1914]
; push ds
; sbb ax,0x1e1e
; push es
; or ch,[bp+si]
; adc ax,0x2a19
; push es
; or [si],di
; push ss
; sbb [si],di
; pop ss
; sbb [si+0x6],dx
; or [si+0x6],dl
; pop es
; jc 0x4bf4
; sbb [bp+si+0x6],si
; push es
; xchg ax,si
; sbb [bx+di],bx
; xchg ax,si
; or al,0x13
; scasb
; add [bp+si],al
; scasb
; sbb ax,0xae1f
; inc ax
; or ax,0x140d
; push cs
; push cs
; adc cl,[bx]
; movups oword [bp+di],xmm0
; or bp,[bp+0x1044]
; adc [bx+di],dl
; adc [bx+di],dx
; adc dl,[bp+si]
; adc dl,[si]
; adc al,0x1c
; scasb
; and [bx+si],dh
; add [bx+di],si
; call 0x3c9a:0x311e
; add [0x1e0c],ax
; push es
; or al,0xc
; push es
; or al,0x13
; push es
; or al,0xd
; mov [bp-0x79f2],cl
; mov [bx],cs
; mov [bp-0x79f0],cl
; mov [bx+di],ss
; mov [bp-0x79ee],cl
; mov [bp+di],ss
; mov [bp-0x79f4],cl
; mov [bx+si],fs
; push cs
; sahf
; adc [bp+0xa21],bx
; or sp,[bx+si+0xd]
; push cs
; pusha
; adc [bp+si],dx
; pusha
; adc al,0x15
; pusha
; or cx,[di]
; jc 0x4c4c
; add ax,0x1272
; adc al,0x72
; sbb [si],bx
; jc 0x4c61
; adc [bp+si+0x604],cx
; cwd
; sbb [bp+di],bx
; xchg ax,si
; add [bx+si],cl
; scasb
; pop ss
; pop ds
; scasb
; or [bx+di],cx
; lodsw
; or cl,[bp+si]
; lodsb
; or cx,[bp+di]
; stosw
; or al,0xc
; stosb
; or ax,0xa90d
; push cs
; push cs
; test al,0xf
; db 0x0f
; cmpsw
; adc [bx+si],dl
; cmpsw
; adc [bx+di],dx
; test al,0x12
; adc ch,[bx+di+0x1313]
; stosb
; adc al,0x14
; stosw
; adc ax,0xac15
; push ss
; push ss
; lodsw
; dec ax
; add [bx+di],al
; mov bl,[0x8a1f]
; inc sp
; add ax,[bp+di]
; inc bp
; add al,0x4
; inc dx
; add ax,0x3f05
; push es
; push es
; cmp al,0x7
; pop es
; cmp [bx+si],cx
; or [0x909],dh
; xor ax,[bp+si]
; add cl,[bx+si+0x40]
; add ax,[bp+di]
; dec bx
; add al,0x4
; dec si
; add ax,0x5105
; push es
; push es
; push sp
; pop es
; pop es
; push di
; and [si],ah
; add [bp+si],sp
; and ax,[bp+si]
; and [di],ah
; add sp,[bx+si]
; daa
; add al,0x1e
; sub [di],ax
; and [bp+di],ch
; push es
; push ds
; sub [bx],ax
; sbb al,0x27
; or [0x925],bl
; push ds
; and cx,[bp+si]
; push ds
; and [bp+di],cx
; push ds
; pop ds
; or al,0x30
; xor [di],cx
; xor cx,[cs:0x352c]
; cvtpi2ps xmm6,qword [bp+di]
; adc [si],ch
; xor [bx+di],dx
; xor [cs:bp+si],dx
; xor [bx+di],dh
; adc si,[bx+si]
; xor [si],dl
; and al,0x25
; adc ax,0x2723
; adc ax,0x3c3c
; push ss
; and al,0x29
; push ss
; cmp di,[0x2217]
; sub dx,[bx]
; cmp al,0x3f
; sbb [bx+si],ah
; sub [bx+si],bx
; cmp al,[bx+di+0x19]
; push ds
; daa
; sbb [bx+si],di
; inc bx
; sbb bl,[si]
; sub [bp+si],bx
; ss inc bx
; sbb bx,[bp+si]
; sub [bp+di],bx
; cmp [bx+di+0x1c],al
; sbb al,0x27
; sbb al,0x38
; inc cx
; sbb ax,0x271c
; sbb ax,0x3f3a
; push ds
; push ds
; and bx,[0x3f3a]
; pop ds
; and [bx+di],ah
; pop ds
; cmp al,0x3d
; and cl,[bp+si]
; o32 js 0x4d4e
; o32 js 0x4d54
; o32 js 0x4d5b
; o32 js 0x4d56
; mov dl,[di-0x75ee]
; xchg ax,bp
; cmp al,0x2
; sub dh,[bx+si]
; add ax,0x1812
; or [bx+si+0x4e],cl
; adc [0x173c],si
; adc bl,[bx+si]
; or al,0x60
; adc esp,[bx+si+0x66]
; db 0x0f
; nop
; xchg ax,si
; adc [bx+si+0x1a96],dl
; dec ax
; dec si
; push ds
; sub dh,[bx+si]
; and [bp+si],al
; sahf
; sbb ax,0x309e
; add [bp+di],al
; adc bl,[si]
; pop ds
; adc al,[bx+si]
; add bp,[bp+si]
; pop ds
; pop ds
; xor [0x361e],bl
; sbb ax,0x3c1d
; sbb al,0x1c
; inc dx
; sbb bx,[bp+di]
; dec ax
; sbb bl,[bp+si]
; dec si
; add [bp+di],al
; dec ax
; pop ds
; pop ds
; push sp
; push ds
; push ds
; pop dx
; sbb ax,0x601d
; sbb al,0x1c
; sbb ebx,[bp+di]
; insb
; sbb bl,[bp+si]
; jc 0x4da7
; add sp,[bp+0x0]
; add ax,[si+0x1f1c]
; nop
; add [bx+di],al
; scasb
; adc dl,[bp+di]
; xchg ax,bx
; push ss
; pop ss
; mov cl,[bx]
; pop ds
; scasb
; dec sp
; or [0x44ae],cl
; add ax,[bp+di]
; lodsw
; add al,0x4
; lodsb
; add ax,0xab05
; push es
; push es
; stosb
; pop es
; pop es
; test ax,0x808
; test al,0x9
; or [bx+0xa0a],sp
; cmpsb
; or cx,[bp+di]
; movsw
; or al,0xc
; movsb
; or ax,0xa30d
; push cs
; push cs
; mov [0x202],al
; scasb
; dec ax
; adc ax,0x7917
; adc dl,[si]
; o32 pop ss
; sbb [si],sp
; and [si],ah
; pop es
; push ss
; sbb [bx],ax
; inc dx
; inc bx
; or [bx+si],bl
; sbb cx,[bx+si]
; inc ax
; inc bp
; or [bp+si],bx
; sbb ax,0x1706
; sbb [bx+di],cl
; cmp al,0x4b
; or bl,[si]
; pop ds
; or bh,[bp+si]
; dec di
; or bx,[0xb21]
; cmp [bx+di+0xb],al
; inc sp
; push bx
; or al,0x20
; and ax,0x340c
; cmp ax,0x220d
; sub [di],cx
; xor [bp+di],bh
; or ax,0x6548
; push cs
; and al,0x29
; push cs
; cs aaa
; push cs
; dec dx
; arpl [bx],cx
; xor cx,[es:bx]
; dec sp
; popa
; adc [bx+si],ch
; xor [bx+si],dx
; dec si
; pop di
; adc [bp+si],bp
; das
; adc [bx+si+0x5b],dx
; adc ch,[si]
; sub ax,0x5212
; pop cx
; adc dx,[si+0x55]
; or al,0x46
; pop bp
; and al,[0x775a]
; add cx,[bp+si+0x59b]
; or ah,[bp+di]
; cmp al,0x1
; sbb [0x3601],bl
; cmp al,0x1
; jc 0x4ed9
; sbb [0x1e3c],dh
; push ds
; and al,0xe
; mov dl,[bx+si+0x421e]
; dec ax
; adc [bx+si],bx
; push ds
; add [si+0x5a],dx
; push ds
; js 0x4ef4
; and [bx+si],al
; sahf
; adc al,0x9e
; daa
; add [bp+di],al
; sbb [si],bl
; pop ds
; sbb [bx+si],al
; add cx,[bx+si+0x1c]
; pop ds
; dec ax
; add [bx+si],al
; jng 0x4e8d
; add [bx+0x2],di
; add al,[bx+si+0x303]
; sbb word [si],0x811c
; or cx,[si]
; dec si
; adc dx,[si]
; dec si
; sbb ax,0x801d
; push ds
; push ds
; jg 0x4ec3
; pop ds
; jng 0x4eae
; or [bp+0x1817],ch
; scasb
; xor cx,[bx]
; adc [si],ah
; pop es
; pop es
; sub cl,[bx+si]
; or [bp+di],ch
; or [bx+di],cx
; sub al,0xa
; or ch,[di]
; add [si],al
; scasb
; or cx,[bp+di]
; cs or al,0xc
; das
; adc dx,[bp+di]
; das
; adc al,0x14
; cs adc ax,0x2d15
; sbb bx,[bx]
; scasb
; push ss
; push ss
; sub al,0x17
; pop ss
; sub bx,[bx+si]
; sbb [bp+si],ch
; movups xmm5,oword [si+0x7]
; pop es
; o32 or [bx+si],cl
; or [gs:bx+di],cx
; or cl,[fs:bp+si]
; arpl [bp+di],cx
; or sp,[bp+si+0xc]
; or al,0x61
; adc dx,[bp+di]
; popa
; adc al,0x14
; bound dx,[di]
; adc ax,0x1663
; push ss
; fs pop ss
; pop ss
; sbb [gs:bx+si],bl
; o32 add al,0x4
; db 0x82
; add ax,0x8305
; push es
; push es
; test [bx],al
; pop es
; test [bx+si],cx
; or [bp+0x909],al
; xchg [bp+si],cx
; or cl,[bx+si+0xb0b]
; mov [si],dx
; adc al,0x89
; adc ax,0x8815
; push ss
; push ss
; xchg [bx],dx
; pop ss
; xchg [bx+si],bl
; sbb [di+0x1919],al
; test [bp+si],bl
; sbb al,[bp+di+0x1b1b]
; db 0x82
; add ax,0x1e05
; sbb bl,[bp+si]
; push ds
; inc sp
; adc [bp+di],dl
; scasb
; inc ax
; or al,0xf
; scasb
; dec sp
; add al,0x6
; scasb
; or [bp+di],cx
; scasb
; adc al,0x16
; scasb
; sbb [bp+di],bx
; scasb
; dec ax
; push cs
; adc [bx+si+0x20],cx
; xor [bp+di],cl
; or al,0x23
; adc al,0xc
; and cx,[bx+si]
; inc dx
; dec si
; pop ss
; inc dx
; dec si
; db 0x0f
; jc 0x4efc
; adc [bp+si-0x65],dh
; cmp al,0x1
; xchg ax,si
; pushf
; or [bp+0xb9c],dl
; jc 0x4fe6
; wrmsr
; ss wrmsr
; ss sbb al,0x60
; or [0x100c],eax
; xor [0x961e],dh
; pushf
; pop ss
; xchg ax,si
; pushf
; add [0x1e0c],ax
; push es
; or al,0x14
; jc 0x5004
; push ss
; push es
; or al,0x3
; pusha
; o32 and [bp+si],al
; xor bl,[di]
; xor ah,[bx+di]
; or cx,[di]
; push cx
; adc dl,[si]
; push cx
; sbb bl,[bp+di]
; dec di
; add [bp+di],ax
; sbb al,0x1e
; or al,0xd
; jnc 0x4fbd
; adc si,[bp+di+0x6]
; pop es
; sbb word [bx+si],0x8119
; or cx,[0x1189]
; adc al,0x89
; add ax,[si]
; xchg ax,bp
; sbb bx,[si]
; xchg ax,bp
; add [bp+di],cl
; scasb
; or ax,0xae12
; adc al,0x1f
; scasb
; inc sp
; adc [bp+di],dl
; ss dec ax
; pop ss
; sbb [bp+di+0x7],bl
; or [bx+di+0x8],ch
; or [bx+di+0x1717],al
; or word [si],0xae0c
; adc dx,[bp+di]
; scasb
; and [bp+si],ah
; add [di-0x7d],bp
; push ds
; insw
; cmp word [si],byte +0x1e
; or [bx],cx
; add [bx],cx
; adc ax,0xd06
; adc dx,[si]
; or dx,[bx+di]
; sbb [bx],bp
; xor ax,0x3401
; cmp cl,[si]
; pop dx
; pusha
; adc bx,[bp+si+0x60]
; or bh,[si-0x7e]
; adc ax,0x827c
; adc ax,[bx+di+0x47]
; and al,0x0
; and bp,[bx+di]
; add [bp+0x4a],al
; add [si],sp
; sub ax,[bx+di]
; inc di
; dec sp
; add ah,[bp+di]
; das
; add sp,[bp+di]
; xor ax,0x4502
; dec bx
; add ax,[bx+si+0x49]
; add al,0x22
; cmp ax,0x3f04
; inc si
; add ax,0x4421
; push es
; and [bx+di+0x7],al
; push ds
; aas
; or [bp+di],bl
; cmp ax,0x1709
; cmp al,0x4
; add [bp+si],al
; add ax,0x301
; push es
; add al,[si]
; pop es
; add ax,[di]
; or [bp+di],al
; pop es
; or [bp+si],ax
; or [bp+si],cx
; add [bp+di],di
; or si,[si]
; cmp cx,[si]
; aaa
; cmp al,0xd
; cmp [si],di
; push cs
; cmp bh,[si]
; db 0x0f
; cmp di,[bp+di]
; or ax,[bx+si]
; and [si],cx
; push es
; sbb ax,0xb0d
; sbb cx,[0x1a0f]
; movlps xmm3,qword [bp+di]
; adc [di],dl
; sbb ax,0x1711
; push ds
; adc bl,[bx+si]
; pop ds
; adc bx,[bp+si]
; and [si],dl
; sbb sp,[bx+si]
; adc ax,0x211d
; push ss
; sbb sp,[bp+si]
; pop ss
; sbb [bp+di],ah
; sbb [bp+di],dl
; and ax,0xc19
; sub [bp+si],bl
; add [bp+si],ch
; sbb cx,[bx]
; sub ax,0x151c
; xor [di],bl
; sbb [bp+si],si
; push ds
; sbb al,0x33
; pop ds
; push ds
; xor [bx+si],sp
; or al,0x9e
; adc [bp+0x21],bx
; add dl,[bp+si]
; sbb ax,0x121f
; add [bp+si],al
; bound bx,[di]
; pop ds
; bound ax,[bp+di]
; add sp,[bx+si+0x6]
; or [bx+di+0x1916],bx
; cwd
; push cs
; adc [bp+di+0xd0a],cx
; test [bp+si],dl
; adc ax,0x1c84
; sbb al,0x60
; inc ax
; adc bl,[bx]
; scasb
; inc sp
; add [di],cl
; scasb
; dec ax
; push es
; pop es
; cs push es
; pop es
; push bp
; sbb [bx+di],bl
; push bp
; sbb [bx+di],bl
; cs push cs
; push cs
; scasb
; adc [bx+di],dx
; scasb
; dec sp
; movups xmm5,oword [bp+0x2420]
; or ah,[bx+di]
; daa
; or bx,[si]
; sub al,0xc
; sbb [bx+si],dh
; or ax,0x3315
; push cs
; adc si,[di]
; movlps xmm6,qword [0x1310]
; xor ax,0x1511
; xor dx,[bp+si]
; sbb [bx+si],dh
; adc bx,[si]
; sub al,0x14
; and [bx],sp
; or dx,[bx+0x5d]
; or al,0x52
; bound cx,[di]
; dec si
; push word 0x4b0e
; imul cx,[bx],byte +0x49
; outsb
; adc [bx+si+0x6f],cl
; adc [bx+di+0x6e],cx
; adc cl,[bp+di+0x6b]
; adc cx,[bp+0x68]
; adc al,0x52
; bound dx,[di]
; push di
; pop bp
; and al,[bx+di]
; push ds
; cmp [0x381e],bl
; add ax,0x7559
; sbb bl,[bx+di+0x75]
; push ds
; jnz 0x50c8
; add [di-0x6c],si
; cmp al,0x1
; pop es
; or ax,0x707
; or ax,0x70f
; or ax,0x718
; or ax,0x71e
; or ax,0x3a0b
; inc ax
; adc al,0x3a
; inc ax
; push cs
; cmp al,0x42
; adc [si],di
; inc dx
; add [bp+si+0x70],bp
; push ds
; push byte +0x70
; or bp,[bx+di+0x6f]
; adc bp,[bx+di+0x6f]
; add [bx+si+0x1ea6],sp
; mov al,[0x20a6]
; add bx,[bp-0x61e4]
; xor al,0x1b
; sbb al,0x14
; or al,0x11
; sbb [bx+si],al
; add ch,[bx]
; or al,0x11
; inc dx
; sbb bl,[si]
; dec bx
; adc al,0x17
; pop di
; sbb al,0x1d
; arpl [si],ax
; add ax,0x76
; add al,[bx+si+0x340]
; add al,0x20
; adc [bp+si],dx
; es sbb al,0x1c
; sub al,0x1b
; sbb bp,[bx]
; sbb bl,[bp+si]
; xor bl,[bx+di]
; sbb [di],si
; sbb [bx+si],bl
; cmp [bx],dl
; pop ss
; cmp dx,[0x3e16]
; adc ax,0x4115
; adc dl,[si]
; inc dx
; db 0x0f
; punpckldq mm1,[0x650e]
; or ax,0x680d
; or al,0xc
; imul cx,[bp+di],byte +0xb
; outsb
; inc sp
; adc ax,0x141a
; add ax,0x2006
; or [di],cx
; es push es
; push es
; jna 0x51cc
; pop es
; jns 0x51d0
; or [si+0x9],bh
; or [bx+0xa],di
; or al,[bp+si+0xb0b]
; test [si],cx
; or al,0x88
; or ax,0x8b0d
; dec ax
; or [bx+di],cl
; adc al,[si]
; add ax,0x94
; pop ds
; scasb
; and [si],bh
; add cx,[di]
; adc bx,[0x3f39]
; or [bx+0x55],cx
; adc [bp+si+0x70],bp
; pop es
; sub [0x8a1c],ch
; nop
; push ds
; unpckhps xmm1,oword [bx]
; push ds
; and al,0x2f
; add al,0x32
; gs dmint
; popa
; adc bh,[si-0x68]
; adc ax,0x896d
; sbb [bp+di+0x7c],dl
; sbb ax,0x4e14
; push ds
; pop si
; xchg [bx+si],sp
; or al,0x8
; invd
; or cx,[es:si]
; and dl,[bp+di]
; adc al,0x22
; or [0x33],dx
; add al,0x42
; sbb bx,[bx]
; inc dx
; add ax,0x4505
; sbb bl,[bp+si]
; inc bp
; push es
; push es
; dec ax
; sbb [bx+di],bx
; dec ax
; pop es
; or cx,[bp+di+0x14]
; sbb [bp+di+0x3],cl
; add al,0x66
; or [si],cl
; adc edx,[bx]
; sbb ebx,[si]
; o32 add [bx],al
; jng 0x5256
; adc di,[bp+0x18]
; pop ds
; jng 0x5250
; add dl,[bp+0x1a05]
; xchg ax,si
; sbb ax,0x961f
; add [bp+di],cl
; lodsw
; push cs
; adc [di+0x1f14],bp
; lodsw
; add [bx+si],al
; or al,0x1f
; pop ds
; or al,0x48
; add ax,[si]
; xchg ax,si
; sbb bx,[si]
; xchg ax,si
; dec sp
; or al,0xd
; lodsw
; adc dl,[bp+di]
; lodsw
; and [bx+si],ch
; add [bx+di],cx
; ss push ds
; or [0x3a0e],si
; imul dx,[bx+di],byte +0x3a
; imul bp,[bx+di],byte +0xf
; mov fs,[bx+di-0x71f0]
; mov ax,[0x63c]
; or al,0x12
; add bx,[bx+si]
; push ds
; sbb [si],cx
; adc bl,[si]
; sbb [0xc0d],bl
; adc dl,[bp+si]
; or al,0x12
; add [si+0x5a],dx
; push ds
; push sp
; pop dx
; push cs
; outsw
; jnz 0x52b8
; outsw
; jnz 0x52ab
; mov dl,[bx+si-0x75e2]
; nop
; add [bp+si+0x1ea8],sp
; mov [0x20a8],al
; pop es
; popf
; push ss
; popf
; daa
; add [0x912],al
; sbb al,0x21
; pop es
; or si,[di+0xc]
; push cs
; js 0x52d7
; adc [bp+di+0x12],di
; push ss
; jng 0x52e5
; sbb ax,[bx+di+0x1f0e]
; xchg ax,bp
; sub ax,[bx+si]
; pop ds
; scasb
; inc ax
; push cs
; sbb al,0x44
; and [bx+si],ch
; add bl,[bx+si]
; test al,0x7
; ds jz 0x52f4
; push si
; jpe 0x5304
; add [bp+0x3c],ah
; add [bx],ax
; or ax,0x2c01
; xor cl,[bx+di]
; xor [bx],si
; or ax,[bx+di+0x1187]
; sub [bx],bp
; adc bl,[bp+si+0x60]
; adc al,0x88
; mov ds,[0x322c]
; and [bx+si],al
; sahf
; add bl,[bp+0x834]
; or al,0x1e
; adc dx,[bx]
; push ds
; or al,0x13
; inc dx
; add [bx+di],al
; xchg [0x861f],bl
; or ax,0x8812
; or ax,0xae12
; inc ax
; sbb [di],bl
; inc dx
; adc bl,[di]
; pop bp
; add cl,[bx+di]
; xchg [bp+di],dl
; pop ds
; scasb
; inc sp
; add al,[bx]
; inc dx
; add cl,[di]
; pop bp
; push ss
; sbb ax,0x86
; or al,0xae
; and [bx+si],dh
; add [0xc7d],si
; and al,0x2f
; or ax,0xa88e
; adc cl,[bp+0x13a8]
; and al,0x2f
; push ds
; ss jnl 0x5388
; add ch,[bx+0x75]
; or [bx+di],dl
; pop ss
; or [di],dh
; cmp cx,[di]
; dec si
; push sp
; push cs
; call 0xa09a:0x11a0
; adc cl,[bp+0x54]
; pop ss
; adc [bx],dx
; pop ss
; xor ax,0x1d3b
; outsw
; jnz 0x538b
; add [bp-0x61e3],bl
; or dx,[es:si]
; and [si],ax
; or [si],ch
; pop ss
; sbb bp,[si]
; add [bx+di],cl
; dec dx
; push ss
; pop ds
; dec dx
; add [bp+di],al
; scasb
; sbb al,0x1f
; scasb
; inc ax
; or [0x1e66],cl
; pop ds
; o32 sbb al,0x1e
; outsw
; sbb bl,[si]
; js 0x53aa
; sbb ax,[si+0x1814]
; xchg ax,bx
; adc [bx+si],bx
; scasb
; inc sp
; add [bx+di],al
; adc [bx],edx
; add [bp+di],eax
; outsw
; add ax,[di]
; js 0x53ad
; or [si+0xb07],al
; xchg ax,bx
; pop es
; push cs
; scasb
; dec ax
; movups xmm5,oword [bp+0x44b]
; push es
; scasb
; sbb [bp+di],bx
; scasb
; and [bx+di],ch
; db 0x0f
; daa
; sahf
; adc [bx],ah
; sahf
; cmp al,0x1
; xor [0x8801],dh
; mov es,[si]
; pop bp
; arpl [bp+di],cx
; add byte [bp+0x140d],0x1a
; adc dl,[si]
; sbb dl,[si]
; add byte [bp+0x5d1b],0x63
; push ds
; xor [0x881e],dh
; mov fs,[bx+si]
; add [bp-0x61e4],bx
; xor [bp+si],ax
; add ax,0x212
; add ax,0x242
; add ax,0x272
; add ax,0x8a2
; or bx,[0xb08]
; or [ss:bp+di],cl
; dec si
; or [bp+di],cl
; o32 or [bp+di],cl
; jng 0x540d
; or dx,[bp+0x110e]
; adc cl,[0x2a11]
; push cs
; adc [bp+si+0xe],bx
; adc [bp+si+0x1714],cx
; push ds
; adc al,0x17
; ss adc al,0x17
; dec si
; adc al,0x17
; o32 adc al,0x17
; jng 0x5437
; pop ss
; xchg ax,si
; sbb bl,[di]
; adc bl,[bp+si]
; sbb ax,0x1a42
; sbb ax,0x1a72
; sbb ax,0x4ca2
; add [bx+di],al
; adc al,[bx+si]
; add [bp+si+0x0],ax
; add [bp+si+0x0],si
; add [bp+si+0x1f1e],sp
; adc bl,[0x421f]
; push ds
; pop ds
; jc 0x5466
; pop ds
; mov [0x24],al
; pop ds
; scasb
; and [si],bh
; add [bx+di],cx
; db 0x0f
; add [bp+di],bp
; xor [bx+di],ax
; arpl [bx+di+0x1],bp
; lea dx,[bp+di+0x91e]
; hint_nop53 word [bp+di]
; xor [0x6963],bx
; push ds
; lea dx,[bp+di+0x420d]
; dec ax
; or ax,0x7872
; adc al,[bp+si+0x48]
; adc dh,[bp+si+0x78]
; and [si],cl
; sahf
; adc [bp+0x226],bx
; push es
; and al,0x10
; adc sp,[si]
; push ss
; sbb [si],sp
; sbb al,0x1f
; and al,0x8
; or cl,[bx+si+0x8]
; or ax,0x860
; adc [bx+si+0x8],bh
; adc dx,[bx+si+0x1f00]
; scasb
; xor [bx+di],bx
; pop ds
; nop
; and [bx+di],ch
; add al,0x2a
; scasw
; adc ch,[bp+si]
; jnl 0x54ba
; sub bh,[di+0x1e]
; sub bh,[di+0x3c]
; adc bl,[bx+si]
; push ds
; push ds
; sbb [0x3002],bl
; ss push es
; xor [0x9c1e],dh
; mov [0x841c],al
; mov cl,[bx+di]
; insb
; jc 0x54c7
; mov [0x16a8],al
; insb
; jc 0x54e4
; add [si],dx
; add al,0x14
; daa
; push es
; or [bp+si],dx
; push ss
; sbb [bp+si],dx
; add [bx+di],al
; test [0x841f],bl
; add al,0x4
; nop
; sbb bx,[bp+di]
; nop
; or [bp+di],cx
; xchg ax,si
; adc al,0x16
; xchg ax,si
; add [bp+di],al
; scasb
; sbb al,0x1f
; scasb
; add ax,0xae09
; push ss
; sbb ch,[bp+0x848]
; or [si+0x1717],al
; test [si],al
; add al,0xae
; or cl,[bp+si]
; scasb
; adc ax,0xae15
; sbb bx,[bp+di]
; scasb
; inc sp
; or cx,[si]
; scasb
; inc ax
; adc dx,[si]
; scasb
; dec sp
; or ax,0xae12
; and [bp+si],ah
; add bx,[0x1c77]
; push ds
; ja 0x553d
; or ax,0x472a
; adc ch,[bp+si]
; inc di
; push cs
; and al,0x2f
; push cs
; inc dx
; dec bp
; adc [si],sp
; das
; adc [bp+si+0x4d],ax
; cmp al,0x1
; or al,0x12
; or ax,0xc06
; adc al,[0x1e0c]
; or al,0x12
; wrmsr
; adc [ss:bx+si],dh
; or bl,[ss:bp+si+0x60]
; adc ax,0x605a
; push es
; o32 insb
; pcmpgtd mm5,[si+0x10]
; o32 insb
; sbb [bp+0x6c],sp
; push cs
; xchg ax,sp
; call 0x249a:0x9411
; pop es
; cmp cx,[ss:bx+si]
; xor [bx+di+0x9],al
; sub al,[bx+0xa]
; and al,0x4d
; or bx,[0xc53]
; push ds
; sub [si],cx
; dec ax
; push bx
; or ax,0x291e
; or ax,0x5348
; push cs
; push ds
; and cx,[0x534e]
; hint_nop52 word [bp+di]
; cmovng dx,[bp+di+0x10]
; push ds
; and dx,[bx+si]
; dec si
; push bx
; adc [0x1123],bx
; dec si
; push bx
; adc bl,[0x1229]
; dec ax
; push bx
; adc bx,[0x1329]
; dec ax
; push bx
; adc al,0x1e
; push bx
; adc ax,0x4d24
; push ss
; sub al,[bx+0x17]
; xor [bx+di+0x18],al
; cmp sp,[ss:bx+si]
; add [bx+si-0x67e2],bx
; sub cx,[si]
; adc bp,[bp+si]
; add [bp+si],al
; xor [di],bl
; pop ds
; xor [di],al
; or [bp+0xe],ah
; adc [bp+0x17],sp
; sbb ah,[bp+0xf]
; adc [bp+si+0xf],dh
; adc [bp+0xc],bh
; push cs
; xchg ax,si
; adc [bp+di],dx
; xchg ax,si
; add [bx],bl
; scasb
; inc sp
; add cx,[bx+si]
; xor [bx+si],cl
; or [0xa09],si
; cmp al,0x10
; adc [bp+0x14],cx
; adc ax,0x4042
; or cl,[bp+di]
; inc dx
; push cs
; cmovng dx,[bx]
; sbb al,0x30
; push ss
; pop ss
; ss adc ax,0x3c16
; adc dx,[si]
; inc bp
; adc dl,[bp+di]
; dec ax
; inc ax
; or cx,[si]
; inc bp
; or al,0xd
; dec ax
; dec ax
; movups xmm2,oword [bp+0x2f20]
; add dh,[0x1da1]
; mov ax,[ss:0x124]
; unpckhps xmm0,oword [bp+si]
; or al,0x17
; add cx,[bx+di]
; adc [si],ax
; push es
; syscall
; push es
; or ax,[0x1106]
; pop es
; push es
; sub [bx+si],cx
; push es
; and cx,[bx+di]
; push es
; sbb ax,0x90a
; pop ss
; or cx,[si]
; adc [si],dx
; or al,0x11
; adc ax,0x1709
; push ss
; push es
; sbb ax,0x617
; and bx,[bx+si]
; push es
; sub [bx+di],bx
; push es
; adc [bp+si],bx
; push es
; or bx,[bp+di]
; push es
; hint_nop33 word [bx+di]
; adc [di],bx
; or al,0x17
; push ds
; unpckhps xmm7,oword [si]
; push cs
; or [bx],cx
; adc [bx+di],cl
; sgdt [0x1e0c]
; push es
; or al,0xe
; ss cmp al,0x11
; ss cmp al,0x9
; dec ax
; dec si
; push ss
; dec ax
; dec si
; or [bx+si+0x7e],di
; or al,0x78
; jng 0x5677
; js 0x56e4
; push ss
; js 0x56e7
; or [bp+si+0x1790],cl
; mov dl,[bx+si+0x420]
; sahf
; sbb [bp+0x434],bx
; pop es
; sbb [si],cl
; adc bx,[bx+di]
; sbb [bp+di],bl
; sbb [si],al
; or [0x120d],dh
; aaa
; pop ss
; sbb si,[0x804]
; push sp
; or ax,0x5512
; pop ss
; sbb dx,[si+0x4]
; or [bp+si+0xd],dh
; adc dh,[bp+di+0x17]
; sbb si,[bp+si+0x4]
; or [bx+si+0x120d],dl
; xchg ax,cx
; pop ss
; sbb dx,[bx+si+0x1f00]
; scasb
; and [bp+si],ah
; add [0x129],bx
; cmp al,0x47
; add [bp+si+0x65],bx
; add [bx+si-0x7d],di
; add [bp+0x1ea1],dx
; push ds
; sub [0x473c],bx
; push ds
; pop dx
; gs push ds
; js 0x5645
; push ds
; xchg ax,si
; mov ax,[0xc3c]
; push es
; or al,0xe
; push es
; or al,0x11
; push es
; or al,0x13
; push es
; or al,0x10
; and al,0x2a
; cmovc cx,[bx+si+0x10]
; pusha
; jz dword 0x9e03776b
; sbb bl,[bp+0x234]
; add al,0x12
; sbb bx,[di]
; adc al,[bx]
; or [0xe0c],bx
; sub dl,[bx+di]
; adc si,[0x1816]
; inc dx
; add [bx],bl
; scasb
; and [bx+di],ch
; add bx,[bx+si]
; test ax,0x181c
; test ax,0x2408
; wait or ax,0x8f30
; adc bh,[si]
; adc word [bx],byte +0x48
; ja 0x574a
; add ax,[0x1c0c]
; push es
; or al,0x8
; adc bl,[bx+si]
; or ax,0x241e
; adc ch,[bp+si]
; xor [bx],dl
; ss cmp al,0x10
; inc dx
; dec ax
; or cx,[bp+0x54]
; push es
; pop dx
; pusha
; add [bp+0x6c],sp
; pop ss
; test [bp+si-0x6fee],cl
; xchg ax,si
; or ax,0xa29c
; and [bx+si],bl
; sahf
; adc ax,0x2a9e
; or [bx+di],cl
; sbb [0x1810],cl
; adc ax,0x1817
; sbb al,0x1f
; sbb [bp+si],bl
; sbb dh,[bx+si]
; sbb [bx+di],bx
; xor bl,[bx+si]
; sbb [si],dh
; pop ss
; pop ss
; adc [ss:bp+di],dl
; inc dx
; or cx,[si]
; dec si
; pop ss
; sbb [bp+0x10],cl
; adc bx,[bp+si+0xb]
; or al,0x66
; pop ss
; sbb [bp+0x10],ah
; adc si,[bp+si+0xb]
; or al,0x7e
; pop ss
; sbb [bp+0x10],bh
; adc cx,[bp+si+0xc0b]
; xchg ax,si
; pop ss
; sbb [bp+0x1310],dl
; mov [0xa00],al
; scasb
; sbb [bx],bx
; scasb
; or al,0xc
; stosb
; or ax,0xa80d
; push cs
; push cs
; cmpsb
; pfmax mm4,[si+0x1414]
; adc ax,0xa615
; push ss
; push ss
; test al,0x17
; pop ss
; stosb
; dec ax
; or cx,[bp+di]
; scasb
; sbb [bx+si],bl
; scasb
; and [bp+si],ah
; add dl,[bp+si]
; pop di
; push ds
; push ds
; das
; cmp al,0x1
; push es
; or al,0x1
; push ds
; and al,0x1
; ss cmp al,0x1
; dec si
; push sp
; add [bp+0x6c],sp
; or [0xf0c],al
; push es
; or al,0x16
; push es
; or al,0x1d
; push es
; or al,0xb
; push sp
; pop dx
; sbb [si+0x5a],dl
; or bp,[si+0x72]
; sbb [si+0x72],ch
; and [bx],al
; sahf
; sbb al,0x9e
; xor ax,0x400
; push ds
; or [bp+di],cx
; push ds
; push cs
; adc [0x1614],bx
; push ds
; sbb bx,[bx]
; push ds
; add [si],al
; or [ss:si],cx
; movups xmm6,oword [ss:0x1613]
; sbb bx,[ss:bx]
; add [ss:si],al
; dec si
; or [di],cx
; dec si
; adc dl,[0x1b4e]
; pop ds
; dec si
; add [si],al
; or [di],ecx
; o32 adc dl,[0x1b66]
; pop ds
; o32 add [si],al
; jng 0x5818
; or al,0x7e
; movups xmm7,oword [bp+0x13]
; push ss
; jng 0x5833
; pop ds
; jng 0x581b
; add al,0x96
; or [bp+di],cx
; xchg ax,si
; push cs
; adc [bp+0x1614],dx
; xchg ax,si
; sbb bx,[bx]
; xchg ax,si
; add [bx],bl
; scasb
; and [bx+si],dh
; add [bx+si],ax
; mov ax,[0x1e]
; mov ax,[0xa3c]
; unpckhps xmm1,oword [bp+si]
; daa
; sub ax,0x3f0a
; inc bp
; or dl,[bx+0x5d]
; or ch,[bx+0x75]
; or al,[bx+0x78d]
; pushf
; mov [0xf15],al
; adc ax,0x2715
; sub ax,0x3f15
; inc bp
; adc ax,0x5d57
; adc ax,0x756f
; adc ax,0x8d87
; sbb [si+0x20a2],bl
; add dl,[bp+0x1b]
; push si
; xor al,0x0
; add bx,[bx+si]
; or [si],cx
; sbb [bp+di],dl
; push ss
; sbb [si],bl
; pop ds
; sbb [bx+di],cl
; or al,0x30
; adc dx,[0xe30]
; adc [bp+si+0xa],ax
; or al,0x48
; adc dx,[di]
; dec ax
; add [bx],al
; dec si
; sbb [bx],bl
; dec si
; xor ax,0x1708
; jng 0x5893
; pop ss
; xchg ax,si
; add [si],al
; mov bl,[bp+di]
; pop ds
; mov al,[bx+si]
; add bp,[bp+0x1708]
; scasb
; sbb al,0x1f
; scasb
; dec ax
; add al,0x4
; scasb
; sbb bx,[bp+di]
; scasb
; dec cx
; add ax,0xae05
; sbb bl,[bp+si]
; scasb
; dec dx
; push es
; push es
; scasb
; sbb [bx+di],bx
; scasb
; dec bx
; pop es
; pop es
; scasb
; sbb [bx+si],bl
; scasb
; and [bp+si],ah
; push cs
; add [di],dh
; adc [bx+si],ax
; xor ax,0x904
; inc cx
; sbb cx,[bx+di]
; inc cx
; add [bx],di
; gs push ds
; aas
; sub [gs:bx+di],al
; imul ebx,[0x6b66],byte +0x30
; add [si-0x74],bp
; push ds
; insb
; mov [bp+si],cs
; jnz 0x587a
; adc ax,0x9d75
; cmp al,0x1
; unpckhps xmm3,oword [0x150f]
; add cl,[si]
; adc bl,[di]
; or al,0x12
; or cl,[si]
; adc dl,[di]
; or al,0x12
; or sp,[bx+di]
; daa
; adc al,0x21
; daa
; add ax,0x6c66
; sbb ah,[bp+0x6c]
; or al,0x69
; outsw
; adc bp,[bx+di+0x6f]
; push cs
; xchg [si-0x79ef],cl
; mov [bx+di],es
; xchg ax,si
; pushf
; push ds
; xchg ax,si
; pushf
; and [si],cl
; sahf
; adc [bp+0x82a],bx
; or bl,[si]
; adc ax,0x1c17
; or cx,[bp+di]
; sbb cl,[si]
; or al,0x18
; or ax,0x160d
; push cs
; push cs
; adc al,0xf
; adc [bp+si],dl
; adc [bx+di],dx
; adc al,0x12
; adc dl,[0x1313]
; sbb [si],dl
; adc al,0x1a
; push cs
; adc [bx+si+0xd],di
; or ax,0xc7a
; or al,0x7c
; or cx,[bp+di]
; jng 0x594f
; or al,[bx+si+0x909]
; db 0x82
; or [bx+si],cl
; test [bp+si],dl
; adc bh,[bp+si+0x13]
; adc di,[si+0x14]
; adc al,0x7e
; adc ax,0x8015
; push ss
; push ss
; db 0x82
; pop ss
; pop ss
; test [bx+si],al
; add dl,[bx+si+0x1f1d]
; nop
; add ax,[bp+di]
; xchg ax,dx
; add al,0x4
; xchg ax,sp
; add ax,0x9605
; push es
; push es
; cbw
; pop es
; pop es
; call 0x169c:0x908
; pop ss
; pushf
; sbb [bx+si],bl
; call 0x1a98:0x1919
; sbb dl,[bp+0x1b1b]
; xchg ax,sp
; sbb al,0x1c
; xchg ax,dx
; add [es:si],al
; and al,0x1b
; pop ds
; and al,0xe
; adc [bp+si],bp
; or [bp+si],cx
; inc dx
; adc [bp+di],dx
; inc dx
; add al,[di]
; push sp
; sbb bl,[di]
; push sp
; push cs
; adc [bp+si+0x0],bx
; pop ds
; scasb
; or al,0xe
; inc dx
; adc ax,0x4216
; and [bx+si],ch
; add ax,0x411b
; sbb bl,[bp+di]
; inc cx
; or di,[bx+di]
; imul dx,[si],byte +0x39
; imul cx,[di],byte -0x7c
; mov ax,[0x8412]
; mov ax,[0xe29]
; sub ax,0x1141
; sub ax,0x141
; dec bx
; gs push es
; dec bx
; sbb [gs:bp+di+0x65],cx
; push ds
; dec bx
; gs cmp al,0xf
; push es
; or al,0x10
; push es
; or al,0x3
; xor [0x301c],dh
; cmovs cx,[ss:bp+0x10]
; dec ax
; dec si
; add [si+0x72],bp
; push ds
; insb
; jc 0x59ed
; js 0x5a6c
; push ds
; js 0x5a6f
; add [si+0x1ea2],bx
; pushf
; mov [0x920],al
; or al,0x16
; or al,0x2c
; sbb [0x1a],bx
; add bx,[si]
; adc al,0x18
; sbb ax,0x1310
; and [di],cl
; db 0x0f
; and ax,[0x3809]
; add al,[si]
; aas
; sbb bx,[bx]
; dec cx
; add al,[si]
; bound bx,[bx+si]
; sbb dh,[bx+si+0x1e]
; pop ds
; jo 0x5a25
; pop es
; add word [bp+si],0x8704
; add [si],dl
; scasb
; sbb [bx],bl
; scasb
; dec ax
; add al,0x4
; sbb al,0x6
; push es
; sbb al,0x8
; or [bx+0xa],dl
; or dl,[bx+0x15]
; adc ax,0x1770
; pop ss
; jo 0x5a4e
; adc [bx+di+0x1212],cl
; mov [di],dx
; adc ax,0x17ae
; pop ss
; scasb
; dec bx
; add ax,0x1c05
; or [bx+di],cx
; push di
; push ss
; push ss
; jo 0x5a65
; adc [bx+di+0x1616],cx
; scasb
; xor [bp+si],dx
; adc bh,[si]
; adc dx,[bp+di]
; cmp al,0x14
; adc al,0x3c
; adc ax,0x3c15
; push ss
; push ss
; cmp al,0x17
; pop ss
; cmp al,0xb
; or al,0x57
; or ax,0x570e
; movups xmm2,oword [bx+0x11]
; adc dl,[bx+0x33]
; or [bx+di],cl
; test [bp+si],cl
; or ax,[bx+0xd0c]
; test [0x870f],cl
; and [bx+si],ch
; add [bp+si],sp
; test al,0x5
; sub al,0xa8
; or ah,[bp+di]
; cmp cx,[bp+di]
; pop ds
; cmp [si],cl
; sbb ax,0x1631
; push cs
; sub [di],bx
; or bh,[bx]
; sbb bh,[0x2956]
; sbb [bp+0x6f],bp
; sbb ch,[si+0x6f]
; sbb sp,[bp+si-0x65]
; sbb al,0x5b
; cbw
; sbb ax,0x9458
; push ds
; push di
; popa
; push ds
; push byte +0x6f
; pop ds
; push si
; pop sp
; pop ds
; insw
; outsw
; sbb [bp+0x78],si
; sbb dh,[bp+0x7a]
; push ds
; jna 0x5b40
; pop ds
; jna 0x5b40
; cmp al,0x2
; xor di,[bx+di]
; add dx,[bx+0x5d]
; add al,0x7a
; or byte [bx+di],0x49
; dec di
; rsts tword [bp+di+0x1710]
; sbb ax,0x3016
; sbb ah,[ss:bp+si+0x1ea8]
; cmp ax,0x2043
; add [bp-0x61fc],bl
; add [es:si],al
; push sp
; add ax,0x3c0b
; or cl,[bx]
; push ds
; push cs
; adc dh,[0x1612]
; dec si
; inc ax
; add ax,[bp+di]
; jnz 0x5b01
; add al,0x72
; add ax,0x6f05
; push es
; push es
; insb
; pop es
; pop es
; imul cx,[bx+si],word 0x6608
; or [bx+di],cx
; arpl [bp+si],cx
; or ah,[bx+si+0x44]
; or cx,[bp+di]
; pusha
; or al,0xc
; arpl [di],cx
; or ax,0xe66
; push cs
; imul cx,[bx],word 0x6c0f
; adc [bx+si],dl
; outsw
; adc [bx+di],dx
; jc 0x5b3a
; adc dh,[di+0x31]
; adc ax,0x3016
; sbb [bp+si],bx
; cmp al,0x1d
; push ds
; dec ax
; sub ax,0x705
; jng 0x5b3e
; pop es
; xchg ax,si
; or cl,[si]
; js 0x5b4b
; push cs
; mov [0x100e],al
; xchg ax,si
; adc [si],dl
; mov bl,[bx+di]
; sbb cx,[bp+si+0x48]
; add ch,[bp+0x1212]
; scasb
; sbb bx,[bp+di]
; scasb
; dec sp
; adc ax,0xa818
; adc bx,[bp+si]
; scasb
; daa
; add dx,[bx+di]
; scasb
; sbb al,0x1f
; scasb
; adc dx,[bp+di]
; test al,0x14
; adc al,0xa5
; adc ax,0xa215
; sbb [bx+si],bl
; mov [0x1919],al
; movsw
; sbb bl,[bp+si]
; test al,0x2c
; sbb ax,0x6c1f
; and [si],ah
; adc cl,[bx]
; sbb [bp+di],dx
; or al,0x1b
; adc al,0xa
; sbb ax,0x815
; and [0x2306],dx
; pop ss
; push es
; and [bx+si],bl
; push es
; sbb ax,0x619
; sbb ax,0x81a
; sbb bx,[bp+di]
; or dl,[bx]
; sbb al,0xc
; adc al,0x1d
; or al,0x11
; push ds
; push cs
; wrmsr
; add ax,0x5f42
; or ah,[si]
; cmp cx,[bp+di]
; inc dx
; push bx
; push cs
; cmp al,0x59
; db 0x0f
; and al,0x35
; adc bh,[si]
; dec bp
; push ss
; push sp
; imul sp,[bp+si],byte +0x5
; jnz 0x5c38
; pop es
; test [di+0x7811],dl
; mov [bx+di],bp
; push ds
; jc 0x5b66
; cmp al,0x3
; xor [0x8a05],dh
; nop
; or [si+0x5a],dx
; or dx,[bp+si]
; sbb [si],cl
; insb
; jc 0x5be6
; inc dx
; dec ax
; adc [0x180c],ax
; jng 0x5b62
; sbb bx,[bp+si+0x60]
; sbb ax,0x1e18
; and [bp+si],cl
; sahf
; push cs
; sahf
; or cx,[cs:di]
; sbb [bp+di],cl
; or ax,0x123c
; adc al,0x18
; adc dl,[si]
; cmp al,0x2
; push es
; push ds
; sbb [di],bx
; push ds
; or [si],cl
; sub dl,[bp+si]
; pop ss
; sub al,[bx+si]
; pop ds
; scasb
; add al,0x7
; dec ax
; sbb [bp+di],bl
; dec ax
; sub ax,0xe08
; pop dx
; adc [bx],dx
; pop dx
; add ax,[0xa78]
; push cs
; js 0x5c2a
; adc ax,0x1978
; sbb al,0x78
; add [bp+si],al
; xchg ax,si
; push es
; or [bp+0xe0c],dl
; xchg ax,si
; adc [bp+di],dx
; xchg ax,si
; pop ss
; sbb [bp+0x1f1d],dx
; xchg ax,si
; and [0x1e0d],dh
; cmp cx,[0x5912]
; db 0x0f
; or al,0x71
; adc [si],cl
; das
; adc [bp+si],dx
; and si,[bx]
; db 0x0f
; jc 0x5be6
; adc [bx+si],dh
; mov ax,[0x2411]
; pop cx
; adc bl,[0x3c3b]
; add [bp+0x6c],sp
; add dx,[bp+si]
; sbb [di],al
; cmp al,0x42
; or sp,[bp+0x6c]
; or ax,[si+0xc8a]
; push es
; or al,0x13
; push es
; or al,0x14
; o32 insb
; adc al,0x84
; mov bl,[bp+si]
; cmp al,0x42
; sbb al,0x12
; sbb [0x6c66],bl
; and [bx+si],al
; sahf
; sbb ax,0x2e9e
; or [bx+di],cl
; sbb dl,[0x1a17]
; push es
; or [si],bl
; pop ss
; sbb [si],bx
; add ax,[0x191e]
; sbb al,0x1e
; add [bp+di],al
; and [si],bl
; pop ds
; and [di],dh
; or [bp+di],cx
; ss adc al,0x16
; ss pop es
; or [bx+di],di
; push ss
; sbb [bx+di],bh
; or ax,0x4712
; inc sp
; push es
; pop es
; fs pop es
; or [bx+0x9],sp
; or al,0x6a
; adc al,0x1c
; scasb
; inc ax
; sbb [bx+di],bl
; fs push ss
; sbb [bx+0x13],ah
; push ss
; push byte +0x3
; or bp,[bp+0xc2c]
; adc ax,[bp+0x120d]
; mov [0x8a11],cl
; movups xmm1,oword [si+0x130c]
; scasb
; or [es:bx+di],cl
; mov dx,[0x8b17]
; push es
; or [bp+0x1917],cl
; mov cs,[bx+si]
; or dl,[bx+di+0x1715]
; xchg ax,cx
; or cl,[si]
; xchg ax,sp
; adc dx,[di]
; xchg ax,sp
; dec ax
; add [bp+si],al
; scasb
; sbb ax,0xae1f
; add [bp+si],al
; cbw
; sbb ax,0x981f
; add [bp+si],al
; sbb byte [di],0x1f
; add byte [bx+si],0x2
; push word 0x1f1d
; push word 0x200
; push ax
; sbb ax,0x501f
; add [bp+si],al
; cmp [di],bl
; pop ds
; cmp [bx+si],ah
; das
; push es
; sub ax,0x1951
; sub ax,0x2851
; or dl,[bx+si]
; and dx,[di]
; adc [bp+di],ah
; db 0x0f
; cmp dx,[bp+0x10]
; cmp dx,[bp+0x29]
; or al,0x2a
; dec bx
; adc bp,[bp+si]
; dec bx
; cmp al,0x2
; pop dx
; pusha
; sbb ax,0x605a
; add al,0x11
; pop ss
; sbb dx,[bx+di]
; pop ss
; pop es
; jg 0x5cba
; sbb [bx-0x7b],bh
; or bl,[bp+si+0x60]
; adc ax,0x605a
; db 0x0f
; es sub al,0x10
; es sub al,0x20
; or al,0x9e
; adc bl,[bp+0x135]
; add [bp+0x2],cx
; add dl,[bx+di+0x3]
; add dx,[si+0x5]
; add ax,0x654
; push es
; push cx
; pop es
; pop es
; dec si
; or [bx+si],cl
; or [bx+di],ecx
; imul cx,[bp+si],word 0x6c0a
; or al,0xc
; insb
; or ax,0x690d
; push cs
; push cs
; o32 add al,[bp+di]
; insb
; add ax,0x6c06
; or [bp+si],cx
; test [si],cl
; or ax,0x3384
; add [bx+si],al
; nop
; add [bx+di],ax
; nop
; add al,[bp+si]
; nop
; add ax,[bp+di]
; nop
; add al,0x4
; nop
; add ax,0x9005
; push es
; push es
; nop
; pop es
; pop es
; nop
; or [bx+si],cl
; xchg ax,bx
; or [bx+di],cx
; xchg ax,si
; or cl,[bp+si]
; cwd
; or cx,[bp+di]
; pushf
; or al,0xc
; pushf
; pop es
; pop es
; push ds
; or [bx+si],cl
; push ds
; or [bx+di],cx
; push ds
; or cl,[bp+si]
; push ds
; or cx,[bp+di]
; push ds
; or al,0xc
; push ds
; or ax,0x1e0d
; push cs
; push cs
; push ds
; db 0x0f
; db 0x0f
; and [bx+si],dx
; adc [si],ah
; adc [bx+di],dx
; daa
; adc dl,[bp+si]
; sub dl,[bp+di]
; adc bp,[bp+si]
; daa
; pop ss
; sbb ax,0x1718
; sbb ax,0x143c
; sbb ax,0x3478
; adc [bp+di],dx
; cmp al,0x11
; adc cx,[bp+0x11]
; adc sp,[bx+si+0x18]
; sbb cx,[bp+si+0x1b18]
; mov [0x1714],al
; xchg ax,si
; sbb al,0x1f
; xchg ax,si
; xor ax,0x1f00
; scasb
; and [bx],ch
; add al,0x18
; ja 0x5dfe
; xor [bx+0x1b30],cl
; or al,0x41
; sbb al,0x30
; gs adc ax,0x896c
; cmp al,0x10
; or al,0x12
; sbb [si],cl
; adc cl,[bx+si]
; xor [0x300e],dh
; sbb [ss:bx+si],dh
; add al,[ss:bp+si+0x48]
; adc al,[bp+si+0x48]
; add ah,[bx+si+0x66]
; push ds
; pusha
; o32 adc ch,[si+0x72]
; add bh,[bp-0x7c]
; or ax,0x7e78
; add bl,[si+0x20a2]
; push ss
; sahf
; sbb ax,0x389e
; sbb bl,[bx]
; adc al,0x15
; sbb [bx+si],bl
; adc [bp+di],dx
; push ds
; add al,[bp+si]
; push ds
; or [bp+si],cl
; sub al,[si]
; push es
; xor [bx+si],al
; add [0x604],si
; cmp al,0x8
; or al,[bp+si+0x11]
; adc di,[si]
; sbb bl,[bx]
; inc dx
; or al,0xf
; dec ax
; add al,[bp+si]
; dec si
; adc [bp+di],dx
; dec si
; adc ax,0x5418
; sbb bl,[bx]
; pop dx
; add [di],al
; pusha
; pop es
; or [bp+0xc],sp
; push cs
; insb
; sbb ax,0x721d
; adc [bp+di],dl
; jc 0x5e82
; pop ss
; js 0x5e89
; sbb di,[bp+0x1e]
; pop ds
; test [bx+di],bl
; sbb cx,[bp+si+0xe0c]
; mov al,[bx+si]
; add ax,0x1590
; pop ss
; nop
; adc [bp+di],dl
; xchg ax,si
; or al,0xe
; pushf
; sbb ax,0x9c1d
; or [bx+di],cl
; mov [0xf0c],al
; and al,0x34
; add [bx],bl
; scasb
; and [bp+si],ah
; sbb [bx+si+0x30a5],dx
; push es
; inc dx
; push di
; cmp al,0x1
; sbb [0x2104],bl
; daa
; sbb bx,[0x1e24]
; or al,0x12
; add al,0x48
; dec si
; push ds
; dec cx
; dec di
; sbb cx,[bp+0x54]
; add al,0x6c
; jc 0x5eb8
; jc 0x5f31
; sbb si,[bp+si+0x78]
; add [bp+0x49c],dx
; pushf
; mov [0x961b],al
; pushf
; push ds
; mov [0x20a8],al
; add [bx+si+0x321d],al
; and al,0x0
; pop ds
; add [bx+si],al
; or [bp+0x1f16],bp
; scasb
; dec sp
; or dl,[di]
; scasb
; and [si],bh
; or al,0x57
; pop bp
; push cs
; push di
; pop bp
; adc [bx+0x5d],dl
; adc dl,[bx+0x5d]
; sub al,0x8
; adc ch,[bx]
; or [bp+si],dx
; pop ss
; or [0x923],bx
; sub ch,[bx]
; or bl,[bx+si]
; sbb ax,0x240a
; sub [si],cx
; adc dl,[bx]
; or al,0x2a
; das
; or ax,0x2f12
; push cs
; adc dl,[bx]
; push cs
; sub ch,[bx]
; adc [bp+si],dl
; das
; adc [bp+si],bp
; das
; adc ch,[bp+si]
; das
; adc al,0x12
; das
; adc ax,0x2f2a
; push ss
; sub ch,[bx]
; add dh,[0x353]
; cmp ax,[ss:bp+di]
; dec si
; push bx
; add al,0x3c
; dec bp
; push es
; ss push bx
; pop es
; dec si
; push bx
; or [0xa53],dh
; ss push bx
; or di,[si]
; inc cx
; or al,0x42
; inc di
; or ax,0x5336
; db 0x0f
; ss push bx
; adc [bp+0x53],cl
; adc [bp+0x53],cx
; adc si,[0x1453]
; cmp dx,[ss:si]
; inc dx
; inc di
; adc al,0x4e
; push bx
; adc ax,0x3b36
; adc ax,0x534e
; pop ss
; ss dec bp
; sbb [bp+0x53],cl
; sbb [0x1b4d],si
; ss inc di
; sbb al,0x42
; push bx
; sbb ax,0x4736
; or [bx+si+0x7d],ah
; or [bx+si+0x65],sp
; or [bx+si+0x7d],di
; or ah,[bp+0x77]
; or al,0x60
; jnl 0x5f88
; pusha
; gs or ax,0x7d78
; push cs
; pusha
; jnl 0x5f94
; pusha
; jnl 0x5f98
; js 0x6006
; adc ah,[bx+si+0x7d]
; adc al,0x60
; jnl 0x5fa5
; pusha
; gs adc ax,0x7d78
; push ss
; pusha
; gs push ss
; insb
; jno 0x5fb2
; js 0x601b
; pop ss
; insb
; jnl 0x5fa6
; test [bx+di-0x7bfb],ah
; mov [di],ax
; nop
; xchg ax,bp
; push es
; test [bx+di-0x7bf8],cl
; mov ax,[0x8409]
; mov [bx+di],cx
; nop
; xchg ax,bp
; or cl,[bp+si+0xa8f]
; xchg ax,si
; mov ax,[0x8a0c]
; mov ax,[0x840d]
; mov [di],cx
; nop
; xchg ax,bp
; push cs
; mov ah,[bx+di-0x7bf0]
; xchg ax,bp
; adc [bx+si+0x12a1],dx
; test [di-0x7bec],dl
; mov ax,[0x8415]
; mov [di],dx
; nop
; xchg ax,bp
; adc ax,0xa19c
; push ss
; test [bx+di-0x63ea],cl
; mov ax,[0x8418]
; mov ax,[0x8419]
; mov [bx+di],bx
; nop
; xchg ax,bp
; sbb cl,[bp+si+0x1a8f]
; xchg ax,si
; mov ax,[0x120]
; sahf
; sbb ax,0x2c9e
; add [bp+si],al
; sub al,[bp+di]
; add bp,[si]
; add al,0x4
; add [cs:bp+si],al
; dec ax
; add ax,[bp+di]
; dec dx
; add al,0x4
; dec sp
; add [bp+si],al
; add eax,[bp+di]
; push word 0x404
; push byte +0xe
; push cs
; cs
; db 0x0f
; cvttps2pi mm2,[bx+si]
; adc bp,[bp+si]
; adc al,0x14
; daa
; adc ax,0x2415
; push ss
; push ss
; and [bx+si],bx
; sbb [bp+di],bl
; sbb [bx+di],bx
; sbb [bp+si],bl
; sbb dl,[di]
; push cs
; push cs
; dec sp
; db 0x0f
; cmovpe dx,[bx+si]
; adc [bx+si+0xe],cx
; push cs
; push byte +0xf
; punpckhbw mm2,[bx+si]
; adc sp,[bp+0x21]
; adc ax,0x5415
; push ss
; push ss
; push cx
; pop ss
; pop ss
; dec si
; sbb [bx+si],bl
; push cx
; sbb [bx+di],bx
; push sp
; adc ax,0x7219
; daa
; add [bx],bl
; scasb
; push ss
; sbb [bp+0x3620],dl
; add dl,[bp+0x39b]
; nop
; wait add al,0x8a
; wait add ax,0x9b84
; push es
; test [bp+di+0x2a07],bl
; xchg ax,bp
; or [0x98f],bl
; adc cl,[bx+di+0x7e0c]
; wait or ax,0x9584
; push cs
; mov cl,[bx+0x637]
; jng 0x6004
; pop es
; test [bx+di+0x1e0a],cl
; db 0x8f
; or bp,[bp+si]
; xchg ax,bp
; or ax,0x9b96
; push cs
; nop
; wait
; db 0x0f
; nop
; wait adc [bp+0x299b],dl
; or [bp+0x53],cl
; or [bp+si+0x5f],bl
; or [bp+0x6b],ah
; or [bp+si+0x77],dh
; pop ss
; adc cl,[di+0x2e]
; pop es
; cmp cx,[ss:bx+si]
; cmp cx,[ss:bx+di]
; cmp cx,[ss:bp+si]
; cmp ax,[ss:bx]
; inc dx
; inc di
; or [bp+si+0x47],al
; or [bp+si+0x47],ax
; or al,[bp+si+0x47]
; and dl,[bp+di]
; insb
; mov ax,[0xc1b]
; mov ax,[0x1530]
; pop dx
; jno 0x60e4
; pop dx
; jno 0x60ec
; and al,0x2f
; push ds
; push sp
; pop di
; push ds
; test [bx+0x13c],cl
; ss cmp al,0x1
; push sp
; pop dx
; push es
; or al,0x12
; or [bp+0x109c],dx
; ss cmp al,0x10
; push sp
; pop dx
; adc ax,0x120c
; pop ss
; pusha
; o32 pop ss
; mov dl,[bx+si+0x3019]
; ss push ds
; dec ax
; dec si
; push ds
; js 0x6179
; and [di],cl
; sahf
; adc [bp+0x227],bl
; add al,0x12
; adc [bp+di],bx
; adc al,[bx+si]
; or ah,[si]
; pop ss
; sbb ax,0x72a
; or [si],di
; push ss
; sbb [bx+si+0x2],ah
; or [bx+si+0x15],bh
; sbb ax,0x47e
; db 0x0f
; xchg ax,si
; sbb bx,[bx]
; xchg ax,si
; add [bx],bl
; scasb
; and [bp+di],dx
; sbb [bp+si+0x1e],ax
; pop ds
; inc dx
; add [bp+di],al
; pusha
; push es
; or al,0x60
; and [bp+si],ah
; add [bx+si+0x3ab],dx
; sbb al,0x53
; push es
; insb
; stosw
; or [bp+si],dl
; das
; or al,0x72
; adc word [bp+di],byte +0x1e
; das
; pop ss
; jna 0x60f1
; sbb [bp+si],cx
; xor ax,0x541b
; mov [0x1d0c],bx
; xor [di],cl
; or al,0x41
; adc ah,[bp-0x55]
; aaa
; or [bp+si+0x5f],bx
; or bl,[bp+si+0x5f]
; or dx,[si+0x5f]
; or al,0x48
; pop di
; or ax,0x6542
; push cs
; cmp al,0x6b
; cvtps2pd xmm5,[bp+di+0x10]
; pusha
; jno 0x6181
; pusha
; jnl 0x6185
; pop dx
; adc dx,[gs:si+0x5f]
; ss push cs
; xor [bp+di],bh
; push cs
; dec ax
; push bx
; db 0x0f
; ss pop cx
; adc [si],bh
; pop di
; adc [si],di
; pop di
; adc al,[bp+si+0x59]
; adc cx,[bx+si+0x53]
; adc al,0x48
; push bx
; adc ax,0x4d48
; push ss
; dec ax
; dec bp
; cmp al,0x3
; push es
; or al,0x16
; push es
; or al,0x1c
; push ds
; and al,0x7
; xor [0x3615],dh
; cmp al,0x1
; cmp al,0x42
; sbb [bp+0x54],cl
; add [si+0x72],bp
; or bp,[si+0x72]
; adc ax,0x726c
; or [bp+si+0x1e90],cx
; mov dl,[bx+si+0xf20]
; sahf
; adc bx,[bp+0x0]
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],dh
; xor dx,[bx+di+0x33]
; push si
; xor si,[bx+0x33]
; jl 0x620d
; xchg ax,si
; xor bx,[bx-0x72cd]
; xor dx,[bx+si]
; sub [bx+di+0x48],al
; inc dx
; push word 0x4843
; inc dx
; sub [bx+di-0x78],al
; inc sp
; test al,0x45
; mov [si-0x38],al
; inc si
; call 0x6a3d
; dec cx
; call 0x2a41
; inc si
; sub [bp+si+0x48],cl
; dec bx
; sub [bp+si+0x0],cl
; push word 0x884c
; dec bp
; adc [bx+si-0x37cd],ch
; xor al,0xe8
; xor ax,0x34c8
; test al,0x33
; or [bx],dh
; sub [bx+si],bh
; or [bx],dh
; dec ax
; cmp [bx+si+0x3a],bp
; mov [bp+di],bh
; push word 0x483a
; cmp [bx+si-0x37c4],bp
; cmp ax,0x3ca8
; add al,ch
; or [ds:bx+si+0x8],al
; or al,0x51
; in al,0x51
; or al,0x51
; in al,0x51
; pop sp
; dec di
; xor al,0x50
; pop sp
; dec di
; xor al,0x50
; add [bx+si-0x57b2],ch
; dec si
; test al,0x4e
; test al,0x4e
; add ah,cl
; dec si
; lock dec si
; adc al,0x4f
; cmp [bx+0x0],cl
; mov sp,0x4c52
; push bx
; fcom qword [bp+di+0x6c]
; push sp
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add di,ax
; add di,ax
; add di,ax
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],ax
; add bh,al
; add bh,al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; psubb mm1,[bx]
; clc
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add ax,si
; add ax,si
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add di,ax
; add di,ax
; add ax,ax
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; pop es
; test [bx],al
; cld
; pop es
; clc
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; pop es
; add [bx],al
; cld
; pop es
; cld
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; pop es
; add [bx],al
; cld
; pop es
; in al,dx
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add ax,[bx+si-0x3fd]
; add di,sp
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si-0x7ff],cx
; add ax,di
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [si-0x3ff],cx
; add [bx+si+0x0],dh
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+di],al
; test [bx+di],al
; cld
; add sp,di
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add ax,di
; add ax,di
; add ax,di
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add ax,di
; add ax,di
; add ax,di
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add ax,si
; add ax,si
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; pop es
; clc
; pop es
; clc
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+di],al
; add [bx+di],al
; add [bx+di],al
; cld
; add ah,bh
; add ah,bh
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],ax
; add [bx+si],ax
; add [si+0x0],bh
; jl 0x6396
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx],al
; add [bx],al
; add [bx+si],al
; cld
; add ah,bh
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add al,bh
; add al,bh
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+di],ax
; loope 0x63c6
; loope 0x63c3
; add ah,bh
; add al,ah
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+di],al
; out 0x1,ax
; out 0xe,ax
; add bh,bh
; add cl,bh
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; jg 0x63e9
; jg 0x63fa
; add dh,bh
; cmp byte [bx-0x80],0x0
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; pop ds
; add [bx],bl
; pop ds
; add dh,bh
; sar bh,byte 0xc0
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bp+di],al
; add [bp+di],al
; jl 0x6410
; std
; loopne 0x6410
; loopne 0x6415
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add ah,bh
; add ah,bh
; jo 0x6421
; jo 0x6427
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add ah,bh
; add ah,bh
; lock add al,dh
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bp+di],al
; add [bp+di],al
; add [bp+di],al
; cld
; add ah,bh
; add ah,bh
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; str [bx]
; add [bx],cl
; inc word [bx+si-0x7f05]
; inc word [bx+si+0x0]
; add [bx+si],al
; add [bx+si],al
; add [bx],bl
; add [bx],bl
; add [bx],bl
; pavgb mm0,[bx]
; loopne 0x647c
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; pop ds
; add [bx],bl
; add [bx+si],al
; add ax,ax
; add ax,ax
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+0x0],bh
; jg 0x648b
; add [bp+di],al
; add byte [bp+di],0x80
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; pop es
; lock pop es
; lock pop es
; lock add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add ax,0x5f0
; lock add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bp+di],al
; add [bp+di],al
; add [bx+si],al
; fcomip st0
; fcomip st0
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bp+di],al
; add [bp+di],al
; add [bx+si],al
; ret
; lock ret
; lock add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+di],al
; add [bx+di],al
; pop es
; clc
; db 0xc7
; cld
; mov word [si+0x0],0x0
; add [bx+si],al
; add [bx+si],al
; add [bx+di],al
; add [bx+di],al
; add [0xfdff],bl
; jmp bx
; add [bx+si],al
; add byte [bx+si],0x80
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; push ds
; db 0xff
; std
; sti
; inc word [bx+si]
; add al,al
; add al,al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; jng 0x655e
; std
; aas
; inc word [bx+si]
; add al,dh
; add al,dh
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bp+di],al
; clc
; add di,ax
; add di,ax
; add [bx+si],al
; js 0x6538
; js 0x653a
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add ax,di
; add ax,di
; add ax,sp
; add [bx+si],al
; sbb al,0x0
; sbb al,0x0
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add sp,di
; add sp,di
; add [si],bl
; add [bx+si],al
; sbb al,0x0
; sbb al,0x0
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; pop ds
; db 0xfe
; pop ds
; db 0xfe
; pop ds
; inc byte [bx+si]
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx],bh
; db 0xff
; aas
; sti
; aas
; inc ax
; add al,al
; add al,al
; add [bx+si],al
; add [bx+si],ax
; add [bx+si],ax
; add dh,bh
; paddd mm0,[bx]
; jng 0x659d
; lock add al,dh
; add [bx+si],al
; add [bx+si],al
; add [bx+si],ax
; add [bx+si],ax
; add ah,bh
; add sp,di
; add [si],cx
; add al,ah
; add al,ah
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add al,bh
; add al,bh
; add [bx+si],al
; add al,al
; add al,al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],ax
; add [bx+si],ax
; add sp,di
; add ah,bh
; add ah,bh
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],ax
; add [bx+si+0x7c00],ax
; add [si+0x0],bh
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx],al
; add [bx],al
; add [bx+si],al
; cld
; add ah,bh
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add al,bh
; add al,bh
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+di],ax
; loope 0x6606
; loope 0x6603
; add ah,bh
; add al,ah
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+di],ax
; out 0x1,ax
; out 0xc0,ax
; add bh,bh
; add bh,bh
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],ax
; jg 0x6629
; jg 0x65ab
; add bh,bh
; cmp ch,0x80
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bp+di],al
; add [di],bl
; add [bx],bl
; loopne 0x663e
; inc ax
; inc ax
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bp+di],al
; add [bx+di],al
; add [bp+di],al
; cld
; add bh,bh
; loopne 0x6652
; loopne 0x6655
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add ah,bh
; add ah,bh
; jo 0x6661
; jo 0x6667
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add ah,bh
; add ah,bh
; lock add al,dh
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bp+di],al
; add [bp+di],al
; add [bp+di],al
; cld
; add ah,bh
; add ah,bh
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; str [0xf00]
; inc word [bx+si-0x7f01]
; inc word [bx+si+0x0]
; add [bx+si],al
; add [bx+si],al
; add [bx],bl
; add [bx],bl
; add [bx],bl
; lahf
; loopne 0x66ca
; loopne 0x664c
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; pop ds
; add [bx],bl
; add [bx+si],al
; add ax,ax
; add ax,ax
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+0x0],bh
; jg 0x66cb
; add [bp+di],al
; add byte [bp+di],0x80
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; pop es
; lock pop es
; lock pop es
; lock add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add ax,0x5f0
; lock add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bp+di],al
; add [bp+di],al
; add [bx+si],al
; fcomip st0
; fcomip st0
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bp+di],al
; add [bp+di],al
; add [bx+si],al
; ret
; lock ret
; lock add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+di],al
; add [bx+di],al
; pop es
; fadd to st7
; cld
; db 0xc7
; loopne 0x672d
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],ax
; add [bx],cx
; add bh,bh
; db 0xff
; db 0xff
; inc word [bx+si]
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx],bl
; add bh,ch
; db 0xff
; push di
; add [bx+si],al
; rol byte [bx+si],byte 0xc0
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx],cl
; db 0xc0
; aaa
; db 0xff
; aas
; inc word [bx+si]
; add al,dh
; add al,dh
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bp+di],al
; clc
; add di,ax
; add di,ax
; add [bx+si],al
; js 0x6778
; js 0x677a
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add ax,di
; add ax,di
; add ax,sp
; add [bx+si],al
; sbb al,0x0
; sbb al,0x0
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add sp,di
; add sp,di
; add [si],bl
; add [bx+si],al
; sbb al,0x0
; sbb al,0x0
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; paddb mm1,[0xffc]
; cld
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; pop ds
; call far [di]
; call far [bx]
; inc ax
; add al,al
; add al,al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add dh,bh
; jg 0x67c9
; jg 0x680b
; jg 0x67bf
; add al,dh
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add ah,bh
; add sp,di
; add [si],cx
; add al,ah
; add al,ah
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si+0x0],bh
; js 0x67f0
; add [bx+si],al
; rol byte [bx+si],byte 0xc0
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx],bl
; rcr byte [bx],byte 0xc0
; pop ds
; rol byte [bx+si],byte 0x0
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si+0x401f],al
; pop ds
; inc ax
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; pop ds
; lock pop ds
; lock add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; jo near 0xe849
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; pop ds
; rcr byte [bx],byte 0xc0
; add ax,ax
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; and ax,sp
; aas
; loopne 0x687c
; loopne 0x685f
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; loopne 0x68ac
; loopne 0x68ae
; loopne 0x6871
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; loopne 0x68be
; loopne 0x68b8
; loopne 0x6883
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+di],al
; sar byte [bx],byte 0xc0
; aas
; rol byte [bx+si],byte 0x0
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; adc [bx+si-0x7fe1],ax
; pop ds
; add byte [bx+si],0x0
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; xor [bx+si-0x7fc1],ax
; push cs
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+di],ah
; cmp byte [bx],0x80
; aas
; add byte [bx+si],0x0
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; pop ds
; sbb byte [bx],0x80
; pop ds
; add byte [bx+si],0x0
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; pop ds
; sbb byte [bx],0x80
; pop ds
; add byte [bx+si],0x0
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; jo near 0xe90d
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; pop ds
; loopne 0x692e
; loopne 0x6911
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; aas
; add [bx],bh
; add [bx],bh
; add byte [bx+si],0x80
; add [bx+si+0x0],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [ds:0x0],bh
; add byte [bx+si],0x80
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; aas
; add [bx],bh
; add [bx+si],al
; loopne 0x694c
; loopne 0x694e
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx],bl
; add [bx],bl
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx],bh
; add [bx],bh
; add [bx],al
; add byte [bx+si],0x87
; add byte [bx+0x80],0x0
; add [bx+si],al
; add [bx+si],al
; add [bx+si+0x0],dh
; inc word [bx+si]
; lahf
; add [bx+si],al
; out 0x80,ax
; out 0x80,ax
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add al,dh
; add [bx+0x1],di
; inc byte [bx+si]
; add dh,bh
; add dh,bh
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; clc
; add di,[bx+0x3]
; inc word [bx+si]
; add al,bh
; add al,bh
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; ds pop es
; mov di,0xbf07
; add [bx+si],al
; rol byte [bx+si],byte 0xc0
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; aas
; push cs
; aas
; push cs
; aas
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx],bh
; db 0x0f
; aas
; sldt [bx+si]
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; aas
; add [bx],bh
; add [bx],bh
; rol byte [bx+si],byte 0xc0
; add al,al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+di],al
; inc word [bx+di]
; fild word [bx+di]
; push ax
; add al,dh
; add al,dh
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx],al
; lock pop es
; loopne 0x6a0d
; lock clc
; add al,bh
; add al,bh
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bp+di],al
; rol byte [bp+di],byte 0xc0
; add [bx+si],al
; clc
; add al,bh
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+di],al
; rol byte [bx+di],byte 0xc0
; add [bx+si],al
; inc byte [bx+si]
; inc byte [bx+si]
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; pavgb mm1,[bx]
; loopne 0x6a52
; loopne 0x6a45
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx],cl
; mov al,[0xa00f]
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; psubq mm1,[bx]
; sti
; add [bx+si],al
; rol byte [bx+si],byte 0xc0
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx],cl
; ret
; movnti [bx+si],eax
; add al,al
; add al,al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx],bl
; loopne 0x6ac8
; jcxz 0x6aac
; jcxz 0x6a8d
; add [bx+si-0x8000],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],ax
; add [bx+si+0x0],di
; mov di,0xc7ff
; inc word [bx+si]
; add [bx+si-0x8000],al
; add [bx+si],al
; add [bx+si],al
; add ax,[bx+si]
; add di,[bx+si+0x0]
; mov di,0xffff
; fild word [bx+si]
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; str [bx]
; jng 0x6abe
; mov di,0xfffc
; cld
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [0x1e00],bl
; pop ds
; rcr byte [bx],byte 0xc0
; pop ds
; rol byte [bx+si],byte 0x0
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],bh
; add [bx+si],bh
; pop ds
; sbb byte [bx],0x80
; pop es
; add byte [bx+si],0x0
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],bh
; add [bx+si],bh
; aas
; cmp byte [bx],0x80
; cmp [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; jg 0x6afe
; jg 0x6b00
; jg 0x6b02
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bp+di],al
; add [bp+di],al
; add [bp+di],al
; db 0xff
; cld
; db 0xdf
; cld
; db 0xff
; cld
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx],cl
; add [bx],cl
; add [bx+si],al
; lock jg 0x6b0b
; jg 0x6b1d
; jng 0x6aaf
; add [bx+si+0x0],al
; add [bx+si],al
; pop es
; add [bx],al
; add [bx+si],al
; cmp byte [bx],0x80
; aas
; add [bx+si],dh
; add byte [bx+si],0x80
; add [bx+si],al
; add [bx+si],al
; add ax,[bx+si]
; add ax,[bx+si]
; add [bx+si],al
; pop ds
; add [bx],bl
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx],bh
; add [bx],bh
; add [bx],bh
; add byte [bx+si],0x80
; add [bx+si+0x0],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],ax
; add [ds:0x0],bh
; add byte [bx+si],0x80
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; aas
; add [bx],bh
; add [bx+si],al
; loopne 0x6b8c
; loopne 0x6b8e
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx],bl
; add [bx],bl
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx],bh
; add [bx],bh
; add [bx],al
; add byte [bx+si],0x87
; add byte [bx+0x80],0x0
; add [bx+si],al
; add [bx+si],al
; add [bp+di],al
; add bh,bh
; add bh,bh
; add byte [bx+si],0xe7
; and bh,0x80
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+di],al
; add di,di
; add [bx+0x80],di
; inc byte [bx+si]
; inc byte [bx+si]
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx],al
; add di,di
; add di,di
; rol byte [bx+si],byte 0xb8
; add al,bh
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; aas
; pop es
; inc word [bx]
; inc ax
; add [bx+si-0x4000],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; aas
; push cs
; aas
; push cs
; aas
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx],bh
; db 0x0f
; aas
; sldt [bx+si]
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; aas
; add [bx],bh
; add [bx],bh
; rol byte [bx+si],byte 0xc0
; add al,al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+di],al
; inc word [bx+di]
; inc word [bx+di]
; push ax
; add [bx+si+0x0],dh
; lock add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx],al
; stc
; pop es
; clc
; add cl,bh
; clc
; add al,bh
; add al,bh
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bp+di],al
; rol byte [bp+di],byte 0xc0
; add [bx+si],al
; clc
; add al,bh
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+di],al
; rol byte [bx+di],byte 0xc0
; add [bx+si],al
; inc byte [bx+si]
; inc byte [bx+si]
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; pavgb mm1,[bx]
; loopne 0x6c92
; loopne 0x6c85
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx],cl
; mov al,[0xa00f]
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; psubq mm1,[bx]
; sti
; add [bx+si],al
; rol byte [bx+si],byte 0xc0
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx],cl
; ret
; movnti [bx+si],eax
; add al,al
; add al,al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bp+di],bh
; loopne 0x6d08
; jcxz 0x6cd2
; jcxz 0x6ccd
; add [bx+si-0x8000],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; lock
; db 0xff
; db 0xff
; db 0xff
; inc word [bx+si]
; add [bx+si-0x8000],al
; add [bx+si],al
; add [bx+si],al
; add ax,[bx+si]
; add ax,[bx+si]
; clc
; push di
; out dx,ax
; inc word [bx+si]
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; str [bx]
; add si,ax
; db 0xff
; in al,dx
; db 0xff
; cld
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [0x1e00],bl
; pop ds
; rcr byte [bx],byte 0xc0
; pop ds
; rol byte [bx+si],byte 0x0
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],bh
; add [bx+si],bh
; pop ds
; sbb byte [bx],0x80
; pop es
; add byte [bx+si],0x0
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],bh
; add [bx+si],bh
; aas
; cmp byte [bx],0x80
; cmp [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; aas
; lock aas
; jo 0x6d88
; lock add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bp+di],al
; add [bp+di],al
; add [bp+di],al
; db 0xff
; clc
; db 0xff
; mov ax,0xf8ff
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx],cl
; add [bx],cl
; add [bx+si],al
; db 0xfe
; jg 0x6d69
; jg 0x6d6b
; jl 0x6d6f
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; pop es
; add [bx],al
; add [bx+si],al
; cmp byte [bx],0x80
; aas
; add [bx+si],dh
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bp+di],al
; add [bp+di],al
; add [bx+si],al
; add [0x1e00],bl
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; paddb mm1,[bx]
; cld
; paddb mm0,[bx+si]
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add ax,[bx+si]
; add ax,[si]
; or bh,al
; clc
; xbegin 0x6db8
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bp+di],al
; add [bp+di],al
; add [bx+si],al
; xbegin 0x668f
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bp+di],al
; add [bp+di],al
; add [bx+si],al
; xor ax,byte -0x7d
; lock add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bp+di],al
; add [bp+di],al
; pop es
; clc
; xbegin 0x6eac
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bp+di],al
; add [bp+di],al
; pop es
; clc
; db 0xff
; db 0xff
; cld
; sldt [bx+si]
; add byte [bx+si],0x80
; add [bx+si],al
; add [bx+si],al
; add [bx+si],ax
; add [bx],cx
; cld
; db 0xff
; db 0xff
; db 0xff
; inc word [bx+si]
; add al,al
; add al,al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx],al
; clc
; db 0xff
; db 0xff
; db 0xff
; inc word [bx+si]
; add al,ah
; add al,ah
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx],al
; clc
; pop es
; clc
; pop es
; clc
; add [bx+si],al
; loopne 0x6e38
; loopne 0x6e3a
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; pop es
; lock pop es
; int1
; add [bx+di],al
; add [bx+si],al
; rol byte [bx+si],byte 0xc0
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx],bl
; clc
; pop ds
; stc
; pop ds
; stc
; add [bx+si],al
; rol byte [bx+si],byte 0xc0
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx-0x4],bh
; jg 0x6e64
; jg 0x6e66
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; cld
; ds cld
; ds cld
; add [ds:bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; clc
; ds clc
; add [ds:0x0],bh
; add [bx+si],al
; add [bx+si],al
; add [bx+di],al
; add [bx+di],al
; add [bx+si],al
; cld
; ds cld
; add [ds:bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+0x0],bh
; jg 0x6eb1
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx],bh
; lock aas
; lock aas
; lock add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; adc [bx+si],ah
; pop ds
; jcxz 0x6ef4
; jcxz 0x6ed7
; add al,al
; add al,al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx],bl
; jcxz 0x6f06
; jcxz 0x6ee9
; add al,al
; add al,al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx],cl
; ror word [bx],byte 0xc1
; add [bx+si],al
; rol byte [bx+si],byte 0xc0
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx],bl
; loopne 0x6f28
; jcxz 0x6f0b
; add ax,[bx+si]
; add al,al
; add al,al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],ax
; add [bx],bx
; loopne 0x6f1a
; push ax
; aas
; add [bx+si],al
; rol byte [bx+si],byte 0xc0
; add [bx+si],al
; add [bx+si],al
; add ax,[bx+si]
; add di,[bx]
; lock
; db 0xff
; db 0xff
; db 0xff
; inc word [bx+si]
; add [bx+si-0x8000],al
; add [bx+si],al
; add [bx+si],al
; pop es
; add [bx],al
; pop ds
; loopne 0x6f3e
; db 0xff
; db 0xff
; inc word [bx+si]
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; pop es
; add [bx],al
; pop ds
; loopne 0x6f70
; loopne 0x6f72
; loopne 0x6f55
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add ax,[bx+si]
; add cx,[bx]
; loopne 0x6ef2
; loopne 0x6ee5
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add ax,[bx+si]
; add bx,[bx]
; clc
; lahf
; clc
; lahf
; clc
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; aas
; db 0xfe
; aas
; db 0xfe
; aas
; inc byte [bx+si]
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [si+0x3f],bh
; jl 0x6fd9
; jl 0x6fdb
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; jl 0x6fc9
; jl 0x6fcb
; jl 0x6fae
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; jl 0x6ffb
; jl 0x6ffd
; add [bx+si],al
; add byte [bx+si],0x80
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add dh,bh
; add dh,bh
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bp+di],al
; lock add si,ax
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si-0xffb],dh
; pop es
; rol byte [bx+si],byte 0x0
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; adc ax,0x1f78
; clc
; pop ds
; rol byte [bx+si],byte 0x0
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add bh,[si-0x3fd]
; add sp,ax
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; pop es
; inc byte [bx+si]
; push cs
; pop es
; lock add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; addps xmm0,oword [bx+si]
; lock psubb mm0,[bx+si]
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [0xfa8],cl
; clc
; add ax,di
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; movmskps ecx,xmm12
; clc
; add ax,di
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; pop es
; test al,0x0
; clc
; pop es
; clc
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add bx,[bp+0x0]
; loopne 0x7088
; inc byte [bx+si]
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; mov [0xf803],ax
; add bx,sp
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si+0x3],ax
; clc
; add ax,ax
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add si,ax
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add si,ax
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add dl,[bx+si]
; add [bx+si],al
; xor si,ax
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],dl
; add [bx+si],al
; pop ds
; lock add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; cld
; add ah,bh
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],ax
; add [si],bp
; add [si+0x0],bh
; lock add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add ax,0x700
; add [bx],al
; pop si
; add dh,bh
; add al,dh
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx-0x80],ch
; cmp al,0x0
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+di+0x1],ax
; loopne 0x7146
; loope 0x7144
; rol byte [bx+di],byte 0xc0
; cld
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; mov [0xe701],al
; add di,sp
; scasb
; add cl,dh
; add bh,bh
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; push bp
; add [bx+0x0],bh
; jg 0x71ca
; add bh,bh
; xor al,0x80
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bp+si],al
; add [bx],bl
; add [bx],bl
; lahf
; inc ax
; inc ax
; loopne 0x7142
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx],al
; add [bx],al
; jl 0x7130
; and ax,0xe0fd
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; call [bx+si+0x0]
; jo 0x71a4
; jo 0x71a7
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+di],al
; mov al,[0x70fc]
; add ax,si
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bp+di],al
; add [bx+si],al
; add [bx+si+0xfc],al
; add [bx+si+0x0],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx],cl
; add [bx+si],al
; add al,0x0
; sti
; add byte [bx+si],0x0
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx],bl
; add [bx+si],al
; or [bx+si+0x7],al
; add [bx+si],al
; loopne 0x71ef
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; adc [bx+si],ax
; add [bx+di],al
; lahf
; add al,[bx+si]
; add [bx+si],al
; adc ax,ax
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+di],al
; add [bx+si],al
; add bh,bh
; add [bx+si],al
; add [bx+si],al
; jo near 0x7214
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; xadd [bx],cl
; rol byte [bx+si],byte 0x0
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add ah,al
; pop ss
; loopne 0x7254
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; or al,[bx+si]
; str [bx]
; push bp
; jo 0x72c4
; lock jg 0x71c8
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [di],al
; add [bx],cl
; add [bx],cl
; or bh,[bp-0x1f1]
; xadd [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add al,[bx+si]
; pop es
; add [bx],al
; pop ds
; rol byte [bx+si],byte 0x0
; pop ds
; rol byte [bx+si],byte 0x0
; add [bx+si],al
; add [bx+si],al
; add [di],al
; add [bx],al
; add [bx],al
; push bp
; jpe 0x727a
; xchg bh,bh
; inc byte [bx+si]
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add al,[bx+si]
; add ax,[bx+si]
; add bp,[bp+si-0x3]
; db 0xff
; inc word [bx+0x0]
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; push bp
; cli
; db 0xff
; db 0xff
; inc byte [bx]
; add byte [bx+si],0xc0
; add al,al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx],cl
; loope 0x72b1
; add [bx],cx
; loope 0x72f5
; add al,ah
; add al,ah
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx],al
; cld
; add [bx+si],al
; pop es
; cld
; and [bx+si],al
; jo 0x72ca
; jo 0x72cc
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [0xf007],al
; add [0x50],al
; jo 0x72dc
; jo 0x72de
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; jg 0x72e0
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [si],cl
; add [bx+si],dl
; db 0xff
; out dx,ax
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+di],al
; add [0x2000],cl
; clc
; sbb al,0x0
; add ax,[bx+si+0x0]
; add [bx+si],al
; rol byte [bx+si],byte 0x0
; add [bx+si],al
; add [bx+si],al
; pop es
; inc ax
; add al,0x30
; add al,al
; daa
; add [bx+si],al
; add [bx+si],al
; add byte [bx+si],0x0
; add [bx+si],al
; add [bx+si],al
; add sp,[bx+si]
; adc [bx+si],al
; add al,ah
; pop ds
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; cld
; add ah,bh
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],ax
; add [si],bp
; add [si+0x0],bh
; lock add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add ax,0x700
; add [bx],al
; pop si
; add dh,bh
; add al,dh
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx-0x80],ch
; cmp al,0x0
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+di+0x1],al
; loopne 0x7386
; loope 0x7384
; rol byte [bx+di],byte 0xc0
; cld
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; mov ax,[0xe601]
; add di,sp
; retf 0x3f00
; add bh,bh
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; adc ax,0x7f00
; add [bp-0x6b],bh
; add bh,bh
; cmp byte [bx-0x80],0x0
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; or ax,[bx+si]
; aas
; add [si],bh
; jmp 0x1fc0:0xff80
; rol byte [bx+si],byte 0x0
; add [bx+si],al
; add [bx+si],al
; add [bp+di],dl
; add [si],bl
; add [bx],bl
; cld
; inc ax
; add sp,ax
; jmp ax
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; jmp [bx+si]
; add [bx+si-0x1],dh
; jo 0x73e7
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+di],al
; inc ax
; cld
; lock add ax,si
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+di],al
; add [bp+si],al
; add [bx+si],al
; add [bx+si],al
; cld
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; sldt [bx+si]
; add byte [bx+si],0x7f
; rol byte [bx+si],byte 0x0
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx],bl
; add [bx+si],al
; add byte [bx+si+0x1f],0x0
; add al,ah
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+di],dl
; add [bx+si],al
; add bh,bl
; add al,[bx+si]
; add [bx+si],al
; or ax,ax
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+di],al
; add [bx+si],al
; add [bx+0x0],bh
; add [bx+si],al
; add [bx],cl
; add byte [bx+si],0x0
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; xadd [bx],cl
; rol byte [bx+si],byte 0x0
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add ah,al
; pop ss
; loopne 0x7494
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; or al,[bx+si]
; str [bx]
; push bp
; jo 0x7504
; lock jg 0x7408
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [di],al
; add [bx],cl
; add [bx],cl
; or bh,[bp-0x1f1]
; xadd [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add al,[bx+si]
; pop es
; add [bx],al
; pop ds
; rol byte [bx+si],byte 0x0
; pop ds
; rol byte [bx+si],byte 0x0
; add [bx+si],al
; add [bx+si],al
; add [di],al
; add [bx],al
; add [bx],al
; jnl 0x750a
; ret
; cld
; db 0xff
; cld
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bp+si],al
; add [bp+di],al
; add [bp+di],al
; mov si,0xffaa
; inc bx
; inc word [bx+si]
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [di+0x54],bh
; db 0xff
; inc bx
; inc word [bx+si-0x4000]
; add al,al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx],bl
; stc
; add [bx+di],al
; pop ds
; stc
; inc ax
; add al,ah
; add al,ah
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx],al
; inc word [bx+si]
; add [bx],al
; jmp [bx+si]
; add [bx+si+0x0],dh
; jo 0x750c
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add al,[bx+si]
; add sp,di
; add al,[bx+si]
; rol byte [bx+si],1
; jo 0x751c
; lock add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [si],al
; add [bp+di-0x8],bh
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [si],cl
; add al,0x0
; sti
; inc word [bx+si]
; add [bx+si],al
; add [bx+si+0x0],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],ax
; push cs
; push es
; add cl,bh
; inc byte [bx+si]
; add [bx+si],sp
; add [bx+si],al
; add al,ah
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; pop es
; inc ax
; add dh,[bx+si]
; add al,al
; adc ax,[bx+si]
; add [bx+si],al
; add al,al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add sp,[bx+si]
; or [bx+si],al
; add al,ah
; sldt [bx+si]
; add [bx+si],al
; add byte [bx+si],0x0
; add [bx+si],al
; add [bx+si],al
; add [bx],cl
; ror byte [bx],byte 0xc0
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; or ax,0xf00
; mov al,[0xe003]
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; push ds
; test al,0x1f
; clc
; add di,ax
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; cmp ax,0x3f40
; rol byte [bx],byte 0xc0
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; jg 0x75a8
; jo 0x75ca
; pavgb mm0,[bx+si]
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bp+si],bl
; lock ltr [bx]
; lock add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; adc ax,0x1f70
; lock pop ds
; add byte [bx+si],0x0
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; or dh,al
; pop ds
; lock pop ds
; add byte [bx+si],0x0
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; adc ax,0x1fe0
; add [bx],bl
; loopne 0x7615
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bp+si-0x40],bh
; pop es
; add [bx-0x40],bh
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; lds ax,[bx+si]
; pop ds
; rol bh,byte 0x80
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add al,[bx+si-0x3fe1]
; add ax,[bx+si+0x0]
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; xadd [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx],cl
; rol byte [bx+si],byte 0x0
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; or [bx+si+0x0],al
; add [bx],cl
; int3
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; or [bx+si],al
; add [bx+si],al
; psubb mm0,[bx+si]
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; aas
; add [bx],bh
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [si],dh
; add [0xf00],bh
; add [bx+si],al
; add byte [bx+si],0x80
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; jpe 0x76c5
; jg 0x76c7
; push fs
; add al,ah
; add al,ah
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+di],al
; cmc
; add di,di
; add [bx],bl
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add di,[bx-0x7ffd]
; add [bx],bh
; db 0x82
; add byte [bx],0x80
; xchg [bx+si+0x0],ax
; add [bx+si],al
; add [bx+si],al
; add [di+0x0],dh
; pop word [bx+si]
; inc word [di+0x0]
; out 0x80,ax
; out 0x80,ax
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add dl,bh
; add di,di
; add [bx],cx
; stosb
; add dh,bh
; add dh,bh
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bp+si],al
; stc
; add di,di
; add ax,[bx]
; inc ax
; add al,bh
; add al,bh
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [di],al
; ds pop es
; add word [bx],0xbf
; add al,ah
; add al,ah
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bp+si],cl
; dec word [0xe00]
; inc word [bx+si]
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [di],al
; or byte [0xf3f],0x80
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],ax
; add [bx],bh
; add [bx+si],ax
; add [bx+si],al
; rol byte [bx+si],byte 0x0
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; and [bx+di],al
; fild word [bx+si]
; add [bx+si],al
; add al,dh
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bp+si],al
; adc [bx+si],al
; loopne 0x7794
; add [bx+si],al
; add al,bh
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; inc ax
; add [bx+si],al
; add cx,ax
; mov [bx+si],al
; add [bx+si],al
; stc
; add byte [bx+si],0x0
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add ax,si
; add byte [bx+si],0x0
; add bh,bh
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bp+di],al
; lock add si,ax
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; pop es
; inc ax
; pop es
; call 0x6fd6
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; push cs
; stosb
; paddd mm0,[bx+di]
; db 0xfe
; push ax
; add al,dh
; add al,dh
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [di+0x50],bh
; jg 0x77e8
; add si,ax
; mov al,[0xf000]
; add al,dh
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bp+di],al
; clc
; add [bx+si],al
; add di,ax
; inc ax
; add al,ah
; add al,ah
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bp-0x56],bl
; popa
; db 0xff
; jg 0x781d
; mov al,[0xe000]
; add al,ah
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx-0xab],bh
; jmp cx
; inc word [bx+si+0x0]
; rol byte [bx+si],byte 0xc0
; add [bx+si],al
; add [bx+si],ax
; add ax,[bx+si]
; add bx,[bx-0x56]
; db 0xff
; jmp ax
; jg 0x7843
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add al,[bx+si]
; pop es
; add [bx],al
; xchg ax,si
; add byte [bx+si],0x87
; lock add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [si],al
; add [0xe00],cl
; aas
; loopne 0x7863
; add [bx],bh
; loopne 0x7867
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; or al,[bx+si]
; push cs
; add [0x60],cl
; pavgb mm4,[bx+si+0x0]
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; pop ds
; inc byte [bx+si]
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],cl
; add bh,dh
; inc word [bx+si]
; add [bx+si],al
; add [bx+si],al
; add [bx+si],dh
; add [bx+si],al
; add al,[bx+si]
; add [bx+si],al
; add ax,[si]
; add [bx+si],bh
; pop ds
; rol byte [bx+si],byte 0x0
; add [bx+si+0x7000],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],sp
; add al,[bx+si]
; or al,0xe4
; add ax,[bx+si]
; add [bx+si],al
; add al,ah
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],cl
; add al,0x0
; add al,bh
; pop es
; add [bx+si],al
; add [bx+si],al
; rol byte [bx+si],byte 0x0
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; aas
; add [bx],bh
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [si],dh
; add [0xf00],bh
; add [bx+si],al
; add byte [bx+si],0x80
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; jpe 0x7905
; jg 0x7907
; push fs
; add al,ah
; add al,ah
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+di],al
; cmc
; add di,di
; add [bx],bl
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add di,[bx-0x7ffd]
; add [bx],bh
; db 0x82
; add [bx],al
; add byte [bx+0x80],0x0
; add [bx+si],al
; add [bx+si],al
; add [bp+di+0x0],dl
; cld
; add bh,bh
; test [bx+si],ax
; and bh,0x80
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+di-0xff],ch
; add si,di
; test al,0x0
; inc byte [bx+si]
; jng 0x7956
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+0x3],dx
; inc word [bp+di]
; clc
; rol byte [bx+si],1
; cld
; add [si],bh
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bp+si],al
; aas
; pop es
; rol byte [bx],byte 0xff
; enter 0x3800,0x0
; clc
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [si],al
; dec word [0xe00]
; inc word [bx+si]
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bp+si],al
; or byte [bx],0x3f
; jo near 0x799a
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx],bh
; add [bx+si],al
; add byte [bx+si],0x40
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bp+di],ax
; inc byte [bx+si]
; add [bx+si],al
; add al,dh
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bp+si],al
; add [bx+si],ax
; clc
; pop es
; add [bx+si],al
; add al,bh
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; inc ax
; add [bx+si],al
; add dx,ax
; mov [bx+si],al
; add [bx+si],al
; sti
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+di],al
; lock add byte [bx+si],0x0
; add dh,bh
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bp+di],al
; lock add si,ax
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; pop es
; inc ax
; pop es
; call 0x7216
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; push cs
; stosb
; paddd mm0,[bx+di]
; db 0xfe
; push ax
; add al,dh
; add al,dh
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [di+0x50],bh
; jg 0x7a28
; add si,ax
; mov al,[0xf000]
; add al,dh
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bp+di],al
; clc
; add [bx+si],al
; add di,ax
; inc ax
; add al,ah
; add al,ah
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bp+si],cl
; mov si,0xc33f
; aas
; jmp [bx+si-0x2000]
; add al,ah
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [di+0x7d],dl
; db 0xff
; db 0xff
; inc bx
; inc ax
; add al,al
; add al,al
; add [bx+si],al
; add [bx+si],ax
; add ax,[bx+si]
; add bp,[bp+si]
; mov si,0xffff
; inc bx
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bp+si],al
; add [bx],al
; add [bx],al
; lahf
; clc
; add byte [bx+si],0x9f
; clc
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [si],al
; add [0xe00],cl
; jmp ax
; add [bx+si],al
; jmp ax
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bp+di],cl
; add [0xf00],cl
; add [bx+si+0x3f],al
; add byte [bx+si],0x40
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],ah
; pop ds
; fiadd word [bx+si]
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],ax
; add [bx+si],al
; and bh,bh
; fild word [bx+si]
; add [bx+si],al
; add [bx+si],al
; add [bx+si],dh
; add [bx+si],al
; add al,0x0
; add [bx+si],al
; pop es
; add [bx+si+0x7f],ah
; lahf
; add byte [bx+si],0x0
; add [bx+si+0x7000],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add ax,[bx+si+0x2]
; add [si],cl
; enter 0x3,0x0
; add [bx+si],al
; loopne 0x7b06
; add [bx+si],al
; add [bx+si],al
; add [bx+di],al
; adc [si],al
; add [bx+si],al
; lock pop es
; add [bx+si],al
; add [bx+si],al
; rol byte [bx+si],byte 0x0
; add [bx+si],al
; add [bx+si],al
; add [bp+di],al
; lock add si,ax
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+di],al
; add [bp+di],al
; add [bp+di],al
; pop es
; clc
; xbegin 0x7bf6
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bp+di],al
; add [bp+di],al
; xchg ax,di
; xbegin 0x7c08
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+di],al
; add [bp+di],al
; add [bp+di],al
; paddb mm1,[bx-0x7a04]
; sub [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add ax,[bx+si]
; add bx,[bx-0x2002]
; inc al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],ax
; add ax,[bx+si]
; add dx,[bx-0x6]
; clc
; pop es
; db 0xff
; inc word [bx+si]
; add [bx+si-0x8000],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],ax
; add [bx-0x3],bp
; push ax
; add ax,[bx+si+0x0]
; rol byte [bx+si],byte 0xc0
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx-0x4],bl
; db 0xff
; push ax
; add ax,[bx+si-0x2000]
; add al,ah
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx],al
; clc
; add [bx+si],al
; pop es
; clc
; inc ax
; add al,ah
; add al,ah
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx],al
; lock add [bx+di],al
; pop es
; int1
; add byte [bx+si],0xc0
; add al,al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [si],cl
; add [bp+di],dx
; stc
; or al,0x1
; add [bx+si],al
; rol byte [bx+si],byte 0xc0
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],bl
; add [bx-0x4],ah
; sbb [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; cld
; add [ds:bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [0xf8],bh
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+di],al
; add [bx+si],al
; add [bx+si],al
; cld
; add [ds:bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+0x0],bh
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx],cl
; ror byte [bx],byte 0xc0
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; pop ds
; loopne 0x7c72
; jcxz 0x7c55
; add ax,[bx+si-0x4000]
; add al,al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx],bl
; loope 0x7c84
; jcxz 0x7c67
; add ax,[bx+si]
; add al,al
; add al,al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx],bh
; lock aas
; int1
; adc al,0xa1
; add byte [bx+si],0xc0
; add al,al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx-0x7],bh
; jg 0x7c85
; add [bp+di],al
; add [bx+si],al
; rol byte [bx+si],byte 0xc0
; add [bx+si],al
; add [bx+si],al
; add [bx+si],ax
; add [bx-0x16],bx
; loopne 0x7cbb
; db 0xff
; inc word [bx+si-0x4000]
; add al,al
; add [bx+si],al
; add al,[bx+si]
; add ax,[bx+si]
; add di,[bx-0xb]
; inc ax
; sldt [bx+si]
; add byte [bx+si],0x80
; add [bx+si],al
; add [bx+si],ax
; pop es
; add [bx],al
; aas
; cli
; db 0xff
; inc ax
; sldt [bx+si]
; add [bx+si],al
; add [bx+si],al
; add [bp+si],al
; add [bx],al
; add [bx],al
; pop ds
; loopne 0x7cd1
; add [bx],bl
; loopne 0x7cd5
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],ax
; add ax,[bx+si]
; add cx,[bx]
; loopne 0x7c63
; add [bx+0xe0],cl
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add ax,[bx+si]
; add ax,[bx+si-0x60d0]
; enter 0x3080,0x0
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; sbb [bx],bh
; out 0x0,al
; sbb [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [si+0x3f],bh
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; jl 0x7d2c
; add [bx],bl
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; jl 0x7d7f
; add [bx+si],al
; add [bx+si],al
; add byte [bx+si],0x0
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add dh,bh
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+di],al
; add byte [bx+di],0x80
; add ax,ax
; add ax,ax
; add ax,ax
; pop es
; loopne 0x7d6e
; loopne 0x7d70
; loopne 0x7d72
; loopne 0x7d74
; loopne 0x7d76
; loopne 0x7d78
; loopne 0x7d7a
; loopne 0x7d7c
; loopne 0x7d78
; add byte [bp+di],0xc0
; add ax,ax
; add al,[bx+si]
; add al,0x60
; add ax,0x680
; cmp [bx+si],bl
; lock sbb [bx+si],cx
; or al,0x3c
; xor al,ah
; xor bx,[si]
; or al,0x3c
; xor al,ah
; xor bx,[si]
; push es
; cmp [bx+si],bl
; lock sbb [bx+si],cx
; add al,[bx+si]
; add al,0x60
; add ax,0x580
; add byte [bp+si],0x0
; push es
; pusha
; sbb [bx+si],cx
; push es
; cmp [0x33c0],bl
; sbb al,0xc
; cmp al,0x3c
; db 0xc0
; xor bx,[si]
; or al,0x3c
; cmp al,0xc0
; sbb [bx+si],cx
; push es
; cmp [0x5c0],bl
; add byte [bp+si],0x0
; push es
; pusha
; push es
; pusha
; add ax,0x380
; sbb byte [0x19c0],0x8
; pop es
; xor [si],bh
; db 0xc0
; xor bx,[si]
; db 0x0f
; and [si],bh
; db 0xc0
; xor bx,[si]
; db 0x0f
; and [0x19c0],bl
; or [bx],al
; xor [0x560],al
; add byte [bp+di],0x80
; add ax,sp
; add ax,[bx+si+0x6004]
; add ax,cx
; pop es
; xor [bx+si],bl
; lock add bx,sp
; db 0x0f
; and [bx+si],dh
; loopne 0x7dfe
; fmul qword [bx]
; and [bx+si],dh
; loopne 0x7e02
; enter 0x3007,0x18
; lock add ax,sp
; add ax,[bx+si+0x6004]
; add [bx],al
; add [bx+si],al
; add [bx],al
; add byte [bx+si],0x0
; add [bx+si+0x0],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; or al,0x0
; add [bx+si],al
; or al,0xc0
; add [bx+si],al
; add al,al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; sbb [bx+si],al
; add [bx+si],al
; sbb [bx+si+0x3],ah
; pusha
; add [bx+si],al
; add ax,[bx+si]
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; sbb [bx+si],al
; add [bx+si],al
; sbb [bx+si],al
; add al,[bx+si]
; add [bx+si],al
; add dh,al
; add [bx+si],al
; add al,dh
; add [bx+si],al
; sldt [bx+si]
; add [bx],cl
; add [bp+di],al
; add [bx+si],al
; add [bp+di],al
; clc
; add [bx+si],al
; add al,bh
; add [bx+si],al
; add [bx+si],ax
; add [bx+si],al
; add sp,di
; pop es
; add [bx+si],al
; cld
; pop es
; call 0x7e75
; add al,ch
; add [bx+si],al
; add ax,[bx+si]
; add [bx+si],al
; add di,di
; inc byte [bx+si]
; add bh,bh
; db 0xfe
; clc
; add [bx+si],cl
; add al,bh
; add [bx+si],al
; add ax,[bx+si]
; add [bx+si],al
; add di,di
; inc word [bx+si]
; add bh,bh
; inc word [bx+si]
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add ax,[bx+si]
; add [bx+si],al
; add bx,di
; inc byte [bx+si]
; add bh,bl
; inc byte [bx+si]
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; pop es
; add [bx+si],al
; add [bx],al
; db 0x8f
; fiadd word [bx+si]
; add [bx+0xde],cl
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; sbb ax,0x0
; add [di],bl
; sbb byte [0x1000],0x80
; push cs
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [0xe00],cl
; add [bx+si],al
; rol byte [bx],byte 0xc0
; pop es
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add ax,sp
; add [bx+si],al
; add ax,sp
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add si,[bx+si]
; add [bx+si],al
; add si,[bx+si]
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; push es
; sbb [bx+si],al
; sbb [0x100],al
; add byte [bx+si],0x0
; add [bx+si+0x0],ax
; add [bx+si],al
; add [bx+si],al
; push es
; add [bx+si],al
; add [0x100],al
; jo 0x7f29
; add [bx+di],al
; jo 0x7f2d
; add [bx+si],al
; add [bx+si],al
; add [bp+di],al
; add byte [bx+si],0x0
; add ax,[bx+si-0x7f9]
; add [bx+si],al
; pop es
; clc
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add ah,bh
; add [bx+si],al
; add ah,bh
; psubsb mm0,[bx+si]
; add [bx],cl
; call 0x7f52
; add [bx+si],al
; add [bx+si],al
; add di,di
; add [bx+si],al
; add di,di
; db 0xfe
; clc
; add [bx+si],cl
; db 0xfe
; clc
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add di,di
; add [bx+si],al
; add di,di
; inc word [bx+si]
; add [bx+si],al
; inc word [bx+si]
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add dh,bh
; add [bx+si],al
; add dh,bh
; std
; add byte [bx+si],0x0
; std
; add byte [bx+si],0x0
; add [bx+si],al
; add [bx+si],al
; push cs
; out dx,ax
; or [bx+si],al
; push es
; out dx,ax
; mov bx,0xc0
; add [bp+di+0xc0],bh
; add [bx+si],al
; add [bx+si],al
; add [si],cl
; jo 0x7fad
; add [bx+si],al
; jo 0x8015
; rol byte [bx+si],byte 0x0
; jo 0x7f6a
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],bh
; add [bx+si],bh
; add [bx+si],al
; loopne 0x7f98
; loopne 0x7f9a
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+di],al
; add [bx+si],al
; add [bx+di],al
; loopne 0x7fca
; add [bx+si],al
; loopne 0x7fce
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bp+di],al
; add [bx+si],al
; add [bp+di],al
; xor [bx+si],al
; add [bx+si],al
; xor [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; rol byte [0x600],byte 0xc0
; add [bx+si],bl
; add [bx+si],al
; add [bx+si],bl
; add [bx+si],al
; sldt [bx+si]
; add [bx],cl
; inc ax
; add [bx+si],al
; add [bx+si+0x0],al
; sbb [bx+si],al
; add [bx+si],al
; sbb [bx+si],al
; add [bx],bl
; add [bx+si],al
; add [bx],bl
; rol byte [bx+si],byte 0x0
; add al,al
; add al,dh
; add [bx+si],al
; add al,dh
; add [bx+si],al
; pop ss
; add [bx+si],al
; add [bx],dl
; loopne 0x805d
; add [bx+si],al
; loopne 0x8061
; add byte [bx+si],0x0
; add [bx+si+0x0],al
; pop ds
; add [bx+si],dl
; add [bx],bl
; jg 0x802f
; add [bx+si],al
; jg 0x8033
; rol byte [bx+si],byte 0x0
; add al,al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add bh,bh
; inc word [bx+si]
; add bh,bh
; inc ax
; add [bx+si],al
; add al,al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx-0x5],bh
; add [bx+si],al
; jg 0x8053
; rol byte [bx+si],byte 0x0
; add al,al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bp+di-0xf],bh
; add [bx+si],al
; jpo 0x805b
; loopne 0x806c
; add [bx+si],al
; loopne 0x8070
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; js 0x8079
; or [bx+si],al
; jo 0x807d
; mov ax,0x0
; add [bx+si+0x0],bh
; add [bx+si],al
; add [bx+si],al
; add al,ah
; add sp,ax
; add ax,[bx+si]
; add [bx+si+0x0],dh
; jo 0x8092
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; pop es
; add byte [bx+si],0x0
; pop es
; add byte [bx+si],0x0
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; or al,0xc0
; add [bx+si],al
; or al,0xc0
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si+0x0],ax
; add [bx+si+0x6018],ax
; sbb [bx+si],al
; add [bx+si+0x0],ah
; add [bx+si],al
; add [bx+si],al
; add [0x80],cl
; add [0x80],cl
; pusha
; add [bx+si],al
; add [bx+si+0x0],ah
; add [bx+si],al
; add [bx+si],al
; add [bx],bl
; loopne 0x80df
; add [bx],bl
; loopne 0x80e4
; rol byte [bx+si],byte 0x0
; add ax,ax
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; pop ss
; lock add [bx+si],al
; pop ss
; lock aas
; add [bx+si],al
; add [bx],bh
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx],bl
; jg 0x8113
; add [bx],bl
; jg 0x8106
; add byte [bx+si],0x0
; inc word [bx+si+0x0]
; add [bx+si],al
; add [bx+si],al
; add bh,bh
; add [bx+si],al
; add bh,bh
; inc word [bx+si+0x0]
; inc word [bx+si+0x0]
; add [bx+si],al
; add [bx+si],al
; add [bx+0x0],di
; add [bx+0x40ef],di
; add [bx+si],al
; out dx,ax
; inc ax
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add bx,bp
; add [bx+si],al
; add bx,bp
; div word [bx+si+0x0]
; adc bh,dh
; pusha
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add cx,[0x0]
; add cx,[0x300e]
; add [bx+si],dh
; push cs
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx],al
; pop es
; pop es
; pop es
; add [bx+si],al
; sbb al,0x0
; sbb al,0x0
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; push ds
; add [bx+si],al
; add [0x0],bl
; add [bx+si],al
; add [bp+di],al
; rol byte [bx+si],byte 0x78
; add [bx+si],al
; add [bx+si+0x7],bh
; dec word [bx+si]
; add [bx],al
; inc word [bp+si+0x241]
; inc ax
; xchg cx,sp
; jmp ax
; add [bx+si],dl
; jmp ax
; add [bx+si],al
; add di,di
; add [bx+si],al
; loopne 0x819f
; add ax,ax
; out 0xe7,ax
; add [bx+si],al
; inc ax
; add [bx+si],al
; add [bx],bh
; add [bx],bh
; add [bx+si],al
; cld
; aas
; add word [bx+di-0x181],0xfc
; cld
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add bh,bh
; inc word [bx+si]
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bp+si],cl
; push ax
; add ax,0xa0
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+di],al
; or byte [bp+si],0x50
; or [bx+si],dl
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; sbb al,0x38
; sbb al,0x38
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bp+si],al
; add [bx+si],al
; add [bp+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; inc ax
; add [bx+si],al
; add [bx+si+0x0],al
; add [bx],bl
; add [bx+si],al
; add [bx],bl
; mov [bx+di],dl
; adc al,0x28
; mov dx,cx
; clc
; add [bx+si],al
; add al,bh
; add [bx+si],al
; jo 0x8223
; jmpe word [bx+si-0x1e]
; inc di
; or dl,[bx+si-0x19]
; out 0xe,ax
; add al,dh
; add [0x100],cl
; mov word [bx+si],0x13f
; sar al,byte 0x1f
; add cx,byte +0x7f
; db 0xfe
; jcxz 0x81c0
; cld
; add [bp+di],al
; add byte [bp+di],0x1c
; add ah,bh
; add ax,[bx+si]
; cld
; aas
; add [bx+si-0x3ffd],ax
; cmp al,al
; aas
; add [bx+si],al
; rol byte [0x100],byte 0x80
; push es
; add [bx],al
; loopne 0x8277
; sbb [bx+si],bl
; sbb [bx+si],al
; pusha
; add [bx+si+0x6000],ax
; or al,0x0
; add [bx+si],al
; or al,0x0
; add ax,ax
; sub [si],dl
; sub [si],dl
; add [bx+si],dh
; add [bx+si],al
; add [bx+si],dh
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bp+si],al
; add [bx+si],al
; add [bp+si],al
; adc al,0x28
; sub dx,sp
; adc al,0x28
; inc ax
; add [bx+si],al
; add [bx+si+0x0],al
; add [bx],bl
; add [bx+si],al
; add [bx],bl
; mov dl,[bx+di+0x15]
; test al,0x8a
; push cx
; clc
; add [bx+si],al
; add al,bh
; add [bx+si],al
; aas
; add [bx+si],al
; add [bx],bh
; loopne 0x82bf
; or [bx+si],dl
; out 0xe7,ax
; cld
; add [bx+si],al
; add ah,bh
; add [bx+si],al
; add [edi],bl
; add [bx+si-0x6],ah
; pop di
; db 0x82
; inc cx
; jg 0x82cc
; out 0x0,al
; clc
; add [0x0],al
; enter 0x3800,0x0
; sar al,byte 0x1f
; add ax,ax
; pop es
; loopne 0x82f4
; add [si],bl
; add [bp+di],al
; add [bx+di],al
; nop
; add [bx+si+0x1],dh
; add byte [si],0x20
; sub [si-0x2bd5],dx
; or [bx+si+0xe],ax
; add [bx+si-0x7fff],ax
; add [bx+si+0x1],ah
; add byte [bp+di],0xc0
; add [bx+si],al
; add [bx+si],al
; add [bx+si+0x6],ax
; add [bx+si-0x4000],ax
; add [bx+si],al
; add al,al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add ax,[bx+si]
; add [bx+si],al
; add ax,[bx+si]
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; adc [bx+si],cl
; and [si],al
; adc [bx+si],cl
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add di,di
; add [bx+si],al
; add di,di
; mov [bx+di],dl
; adc al,0x28
; mov dx,cx
; inc word [bx+si+0x0]
; inc word [bx+si-0x7ff1]
; add [bx+0xf],bh
; and dl,0x47
; or dl,[bx+si-0x19]
; out 0x1,ax
; lock inc byte [bx+si]
; add ax,si
; sbb [bx],bh
; pop es
; call far [bx+si]
; add al,bh
; pop ds
; add cx,byte +0x7f
; db 0xfe
; cld
; sbb bh,bh
; loopne 0x8363
; sbb [bx+si],dh
; add [bx+si],al
; add [bx+si],dh
; add ah,bh
; aas
; add [bx+si-0x3ffd],ax
; add [si],cl
; add [bx+si],al
; add [si],cl
; inc ax
; add [bx+si],ah
; add [bx+si+0x0],al
; db 0x0f
; lock add [bx+si],al
; add [bx+si],al
; add [bp+si],al
; add [si],al
; add [bp+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add ax,ax
; or [bx+si],dl
; or [bx+si],dl
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; adc al,0x28
; adc al,0x28
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; das
; add al,0x81
; push bp
; das
; adc al,0x8c
; push bp
; cmp ax,0xbd04
; push bp
; ds pop fs
; push bp
; inc di
; add dx,bx
; push bp
; push si
; add al,0x97
; push bp
; pop dx
; push ss
; db 0xc6
; push bp
; pusha
; add bp,[di+0x7055]
; adc ah,bl
; push bp
; jns 0x83f8
; lock push bp
; db 0x82
; adc bh,dh
; push bp
; lea dx,[si]
; or dl,[bp-0x67]
; adc al,0x11
; push si
; jo 0x83fa
; sbb al,0x56
; jng 0x83fe
; and dl,[bp-0x77]
; add al,0x29
; push si
; xchg ax,si
; add al,0x30
; push si
; test ax,0x3606
; push si
; mov cl,0x5
; pop bp
; push si
; mov cx,0x8804
; push si
; add [bx+si],al
; sbb ax,0xb90d
; push si
; xor [si],al
; db 0xc6
; push si
; xor [bp+si],dl
; into
; push si
; xor [bx+si],bl
; aad 0x56
; test ax,0x3606
; push si
; mov cl,0x5
; pop bp
; push si
; mov cx,0x8804
; push si
; add [bx+si],al
; add [bx],al
; push sp
; dec ax
; inc bp
; and [bp+di+0x41],al
; push bx
; push sp
; cmp cl,[di]
; push sp
; dec ax
; inc bp
; and [bx+si+0x52],dl
; dec di
; push ax
; push bx
; cmp cl,[di]
; add sp,[bp+si]
; push bx
; inc cx
; dec cx
; dec sp
; dec di
; push dx
; and cl,[di]
; push es
; inc di
; dec cx
; push dx
; inc sp
; inc bp
; push dx
; push bx
; and [si],al
; adc [di],cl
; add di,[0x203e]
; dec bx
; inc bp
; pop cx
; inc dx
; dec di
; inc cx
; push dx
; inc sp
; and [si],bh
; cmp al,0xd
; add ax,0x5322
; dec ax
; inc bp
; dec cx
; dec bx
; and cl,[di]
; add al,0x11
; push es
; and [bp+di+0x4c],al
; dec cx
; dec bp
; inc dx
; inc bp
; push dx
; push bx
; or ax,0x3e05
; and [ds:bp+si+0x4f],cl
; pop cx
; push bx
; push sp
; dec cx
; inc bx
; dec bx
; and [si],bh
; cmp al,0xd
; push es
; inc si
; dec sp
; dec cx
; dec si
; inc di
; inc bp
; push dx
; push bx
; and [si],al
; adc [di],cl
; push es
; inc bx
; dec di
; dec si
; push si
; inc bp
; pop cx
; dec di
; push dx
; push bx
; and [si],al
; adc [di],cl
; push es
; pop dx
; inc cx
; push ax
; push ax
; inc bp
; push dx
; push bx
; and [si],al
; adc [di],cl
; pop es
; inc bx
; inc cx
; push bx
; dec ax
; and [di],cx
; push es
; inc cx
; dec si
; inc sp
; and [di+0x4f],cl
; push dx
; inc bp
; and [di],cx
; and cl,[bp+di+0x41]
; push sp
; and cl,[di]
; and al,[bp+si+0x59]
; push dx
; inc sp
; and cl,[di]
; and al,[bp+si+0x4f]
; dec bp
; inc dx
; and cl,[di]
; and al,[di+0x47]
; inc di
; and cl,[di]
; pop es
; inc bx
; dec di
; push ax
; pop cx
; push dx
; dec cx
; inc di
; dec ax
; push sp
; and [bp+si+0x41],cl
; dec si
; push bp
; inc cx
; push dx
; pop cx
; and [bx+0x46],cl
; and [bx+di],dh
; cmp [bx+si],di
; xor al,0x20
; inc dx
; pop cx
; and [di+0x49],cl
; inc bx
; dec ax
; push sp
; push dx
; dec di
; dec si
; or ax,0x4153
; dec si
; pop cx
; dec di
; das
; dec cx
; inc dx
; dec bp
; and [bp+0x45],dl
; push dx
; push bx
; dec cx
; dec di
; dec si
; push bx
; and [bx+0x52],dl
; dec cx
; push sp
; push sp
; inc bp
; dec si
; and [bp+si+0x59],al
; and [bp+si+0x49],al
; dec sp
; dec sp
; and [si+0x55],al
; dec si
; dec sp
; inc bp
; push si
; pop cx
; or ax,0x524f
; dec cx
; inc di
; dec cx
; dec si
; inc cx
; dec sp
; and [bx+si+0x52],dl
; dec di
; inc di
; push dx
; inc cx
; dec bp
; and [bp+si+0x59],al
; and [bp+si+0x49],al
; dec sp
; dec sp
; and [si+0x55],al
; dec si
; dec sp
; inc bp
; push si
; pop cx
; and [bx+di+0x4e],al
; inc sp
; and [si+0x4f],al
; push bp
; inc di
; and [bp+0x52],al
; inc cx
; pop cx
; inc bp
; push dx
; or ax,0x4807
; dec cx
; inc di
; dec ax
; and [bp+di+0x43],dl
; dec di
; push dx
; inc bp
; push bx
; or ax,0x4c50
; inc cx
; pop cx
; inc bp
; push dx
; cmp cl,[di]
; push bx
; inc bx
; dec di
; push dx
; inc bp
; cmp cl,[di]
; push sp
; dec cx
; push sp
; dec sp
; inc bp
; cmp cl,[di]
; and [bx+si],ah
; and [bx+si],ah
; and [bx+si],ah
; and [bx+si],ah
; and [bx+si],ah
; and [bx+si],ah
; and [bx+si],ah
; and [bx+si],ah
; add ax,0xcdc9
; int 0xcd
; int 0xcd
; int 0xcd
; int 0xcd
; int 0xcd
; int 0xcd
; mov bx,0xc705
; db 0xc4
; db 0xc4
; db 0xc4
; db 0xc4
; db 0xc4
; db 0xc4
; db 0xc4
; db 0xc4
; db 0xc4
; db 0xc4
; db 0xc4
; db 0xc4
; les si,[bp-0x37fb]
; int 0xcd
; int 0xcd
; int 0xcd
; int 0xcd
; int 0xcd
; int 0xcd
; int 0xbc
; push es
; and [bx+si],ah
; push di
; inc bp
; dec sp
; inc bx
; dec di
; dec bp
; inc bp
; and [si+0x4f],dl
; and [bx+si],ah
; and [0x2020],al
; and [bp+di+0x41],al
; push bx
; dec ax
; dec bp
; inc cx
; dec si
; and [bx+si],sp
; and [bx+si],ah
; and [di],al
; mov dx,0x2006
; and [bx+si],ah
; and [bx+si+0x46],dl
; xor [bx+si],sp
; and [bx+si],ah
; and [di],al
; mov dx,0xba05
; push es
; and [bx+si],ah
; and [bx+si],ah
; push ax
; inc si
; xor ah,[bx+si]
; and [bx+si],ah
; and [di],al
; mov dx,0xba05
; push es
; and [bx+si],ah
; and [bx+si],ah
; push ax
; inc si
; xor sp,[bx+si]
; and [bx+si],ah
; and [di],al
; mov dx,0xba05
; push es
; and [bx+si],ah
; and [bx+si],ah
; push ax
; inc si
; xor al,0x20
; and [bx+si],ah
; and [di],al
; mov dx,0xba05
; push es
; and [bx+si],ah
; and [bx+si],ah
; push ax
; inc si
; xor ax,0x2020
; and [bx+si],ah
; add ax,0x5ba
; mov dx,0x5003
; dec cx
; inc bx
; dec bx
; and [bx+si+0x4c],dl
; inc cx
; pop cx
; inc bp
; push dx
; add ax,0x5ba
; mov dx,0x5303
; push sp
; inc cx
; push dx
; push sp
; and [bx+0x41],al
; dec bp
; inc bp
; and [di],al
; mov dx,0xba05
; add ax,[bx+di+0x42]
; dec di
; push dx
; push sp
; and [bx+0x41],al
; dec bp
; inc bp
; and [di],al
; mov dx,0xba05
; add dx,[bx+si+0x41]
; push bp
; push bx
; inc bp
; and [bx+0x41],al
; dec bp
; inc bp
; and [di],al
; mov dx,0xba05
; add dx,[bp+si+0x45]
; push bx
; push bp
; dec bp
; inc bp
; and [bx+0x41],al
; dec bp
; inc bp
; add ax,0x5ba
; mov dx,0x4803
; dec cx
; inc di
; dec ax
; and [bp+di+0x43],dl
; dec di
; push dx
; inc bp
; push bx
; add ax,0x5ba
; mov dx,0x4903
; dec si
; inc si
; dec di
; push dx
; dec bp
; inc cx
; push sp
; dec cx
; dec di
; dec si
; add ax,0x5ba
; mov dx,0x5303
; dec di
; push bp
; dec si
; inc sp
; cmp al,[si]
; dec di
; dec si
; and [bx+si],ah
; add ax,0x5ba
; mov dx,0x5303
; dec di
; push bp
; dec si
; inc sp
; cmp al,[si]
; dec di
; inc si
; inc si
; and [di],al
; mov dx,0x3206
; and [di+0x45],cl
; dec si
; sub al,0x20
; xor ah,[bx+si]
; dec dx
; dec di
; pop cx
; push bx
; push sp
; dec bx
; push es
; push bx
; push sp
; inc cx
; push dx
; push sp
; dec cx
; dec si
; inc di
; and [bx+di+0x52],al
; inc bp
; inc cx
; cmp ah,[bx+si]
; pop es
; and [bx+si],ah
; and [bx+si],ah
; inc bp
; inc cx
; push bx
; pop cx
; and [bx+si],ah
; and [bx+si],ah
; and [bx+si],ah
; and [bx],al
; and [bp+di+0x55],dl
; push ax
; inc bp
; push dx
; sub ax,0x554a
; dec bp
; push ax
; and [bx+si],sp
; and [bx+si],ah
; pop es
; and [bx+si],ah
; dec bp
; dec di
; inc sp
; inc bp
; push dx
; inc cx
; push sp
; inc bp
; and [bx+si],ah
; and [bx+si],ah
; and [bx],al
; and [bp+0x4f],cl
; and [bp+si+0x55],cl
; dec bp
; push ax
; dec cx
; dec si
; inc di
; and [bx+si],ah
; and [bx+si],ah
; pop es
; and [di+0x58],al
; push ax
; inc bp
; push dx
; dec cx
; inc bp
; dec si
; inc bx
; inc bp
; inc sp
; and [bx+si],ah
; and [bx],al
; inc bp
; pop ax
; push ax
; inc bp
; push dx
; push sp
; add bx,[bp+di+0x50]
; push bp
; pop dx
; pop dx
; dec sp
; inc bp
; pop bp
; add dx,[bx+si+0x4c]
; inc cx
; pop cx
; dec cx
; dec si
; inc di
; and [di+0x4f],cl
; inc sp
; inc bp
; cmp ah,[bx+si]
; and [0x4853],al
; inc bp
; dec cx
; dec bx
; sub ax,0x4f4a
; pop cx
; push bx
; push sp
; dec cx
; inc bx
; dec bx
; and [0x4153],al
; dec cx
; dec sp
; dec di
; push dx
; sub ax,0x454b
; pop cx
; inc dx
; dec di
; inc cx
; push dx
; inc sp
; push es
; push bx
; dec ax
; inc bp
; dec cx
; dec bx
; and [bp+0x53],dl
; and [bp+di+0x41],dl
; dec cx
; dec sp
; dec di
; push dx
; push es
; and [bp+di+0x55],al
; push dx
; push dx
; inc bp
; dec si
; push sp
; and [bx+di+0x52],al
; inc bp
; inc cx
; cmp ah,[bx+si]
; add sp,[bx+si]
; and [bx+si],ah
; push bx
; dec cx
; push sp
; inc bp
; cmp al,[bx]
; and sp,[bp+di]
; and [bx+si],ah
; and [bx+si],ah
; add ax,0x3ba
; push bx
; inc bp
; dec sp
; inc bp
; inc bx
; push sp
; and [bx+di+0x52],al
; inc bp
; inc cx
; add ax,0x6ba
; push bx
; dec ax
; inc bp
; dec cx
; dec bx
; and [bx+si],ah
; and al,0x20
; and [bx+si],ah
; and [bx+si],ah
; and [bx+si],ah
; add dx,[bp+di+0x41]
; dec cx
; dec sp
; dec di
; push dx
; and [si],ah
; and [bx+si],ah
; and [bx+si],ah
; and [bx+si],ah
; and [bp+si],al
; and [bx+si],ah
; and [bx+si],ah
; and [bx+si],ah
; and [bx+si],ah
; and [bx+si],ah
; and [bx+si],ah
; and [bx+si],ah
; and [bp+si],al
; and [bx+si],ah
; and [bx+si],ah
; and [bx+si],ah
; and [bx+si],ah
; and [bx+si],ah
; and [bx+si],ah
; and [bx+si],ah
; and [0x4f57],al
; push di
; and [bx+si],sp
; inc di
; dec di
; dec di
; inc sp
; and [bp+di+0x48],dl
; dec di
; push di
; and [bp+di],al
; push bx
; inc cx
; dec cx
; dec sp
; dec di
; push dx
; and [0x4557],ax
; and [bx+0x49],dl
; push bx
; dec ax
; and [si+0x4f],dl
; and [bp+si+0x45],dl
; inc bx
; dec di
; push dx
; inc sp
; and [bx+di+0x4f],bl
; push bp
; push dx
; and [bx+si],ah
; dec si
; inc cx
; dec bp
; inc bp
; and [bx+di+0x4e],cl
; push bx
; dec cx
; inc sp
; inc bp
; and [bx+0x55],cl
; push dx
; pop es
; dec ax
; inc cx
; dec sp
; dec sp
; and [bx+0x46],cl
; and [bp+0x41],al
; dec bp
; inc bp
; push es
; push bx
; dec di
; and [si+0x48],dl
; inc cx
; push sp
; and [bp+0x55],al
; push sp
; push bp
; push dx
; inc bp
; and [bx+si],ah
; and [bx+si],ah
; and [bx+si+0x4c],dl
; inc cx
; pop cx
; inc bp
; push dx
; push bx
; and [bp+di+0x41],al
; dec si
; and [bx+si],ah
; and [bx+si],ah
; and [bp+di+0x48],al
; inc cx
; dec sp
; dec sp
; inc bp
; dec si
; inc di
; inc bp
; and [bx+di+0x4f],bl
; push bp
; push dx
; and [bx+si],ah
; push bx
; inc bx
; dec di
; push dx
; inc bp
; and [cs:bx+si],ah
; push ax
; dec sp
; inc bp
; inc cx
; push bx
; inc bp
; and [bx+si],ah
; dec ax
; dec cx
; push sp
; add dx,[bp+si+0x45]
; push sp
; push bp
; push dx
; dec si
; push es
; push di
; dec ax
; inc bp
; dec si
; and [bx+di+0x4f],bl
; push bp
; and [bx+di+0x52],al
; inc bp
; and [si+0x48],dl
; push dx
; dec di
; push bp
; inc di
; dec ax
; and [si+0x59],dl
; push ax
; dec cx
; dec si
; inc di
; and [bx+di+0x4e],cl
; and [bx+di+0x4f],bl
; push bp
; push dx
; and [bx+si],ah
; dec si
; inc cx
; dec bp
; inc bp
; and [cs:bx+si],ah
; push sp
; dec ax
; inc cx
; dec si
; dec bx
; push bx
; and [bx+si],sp
; add ax,0x4853
; inc bp
; dec cx
; dec bx
; and [0x4557],ax
; and [bx+0x49],dl
; push bx
; dec ax
; and [si],al
; pop cx
; dec di
; push bp
; and [di+0x41],cl
; inc sp
; inc bp
; and [bx+di+0x54],cl
; and [si+0x4f],dl
; and [si],al
; sub cl,[bx+0x55]
; push sp
; and [bx+0x46],cl
; and [bx+si+0x4f],dl
; push di
; inc bp
; push dx
; sub ah,[bx+si]
; salc
; add al,0x54
; push word 0x2065
; push sp
; imul bp,[di+0x65],word 0x4220
; popa
; outsb
; imul si,[fs:si+0x20],word 0x666f
; and [bx+0x6c],cl
; xor [fs:bx+di],dh
; xor dh,[bp+di]
; cmp [bx+si],dh
; inc bx
; inc cx
; push bx
; dec ax
; dec bp
; inc cx
; dec si
; add word [bp+di],0x6154
; jc 0x89a1
; popa
; outsb
; and [si+0x6f],ch
; outsw
; imul si,[bp+di+0x20],byte +0x66
; outsw
; jc 0x8954
; inc bx
; inc cx
; push bx
; dec ax
; and [bx+si],dh
; xor [bx+si],bh
; cmp [bx],si
; xor [bx+di+0x43],al
; push dx
; dec di
; inc dx
; inc cx
; push sp
; les ax,[bx+di]
; inc dx
; imul bp,[bx+0x6e],word 0x6369
; and [di+0x61],cl
; outsb
; and [si+0x65],dl
; jnc 0x89cb
; jnc 0x8979
; push ax
; popa
; jc 0x89d1
; jnc 0x898f
; xor [si],dh
; xor ax,0x3032
; inc si
; inc cx
; dec sp
; dec sp
; inc di
; push bp
; pop cx
; cmp al,0x1
; inc bx
; popa
; jo 0x89e5
; popa
; imul bp,[bp+0x20],word 0x7243
; jnz 0x89de
; insb
; sub ax,0x2061
; inc sp
; gs insb
; jz 0x89e3
; outsb
; xor [bx+si],dh
; xor si,[bx+di]
; xor [ss:bp+si+0x55],cl
; dec bp
; push ax
; dec bp
; inc cx
; dec si
; out dx,ax
; add [bp+si],ah
; push di
; popa
; jz 0x89fa
; push word 0x7420
; push word 0x2065
; inc dx
; imul si,[bp+si+0x64],word 0x2279
; and [bp+si+0x6f],al
; bound sp,[bx+si]
; xor [bx+si],dh
; xor dh,[bp+di]
; cmp [bx+si],si
; inc dx
; pop cx
; push dx
; inc sp
; dec bp
; inc cx
; dec si
; add [edx+0x69],cl
; insw
; bound bp,[bx+0x20]
; jz 0x8a27
; and [gs:bp+di+0x68],al
; imul bp,[di+0x70],word 0x6e61
; jpe 0x8a2f
; and [gs:bx+si],ah
; xor [bx+si],dh
; xor [bx+si],si
; xor si,[bx+si]
; inc dx
; inc cx
; inc di
; inc dx
; dec di
; pop cx
; aas
; sbb [bx+si],ax
; inc bp
; jpe 0x8a00
; push di
; jnz 0x8a5d
; outsw
; outsw
; outsb
; and [si+0x68],dh
; and [gs:bx+0x6f],al
; outsw
; outsb
; and [bx+si],ah
; and [bx+si],dh
; xor [bx+si],dh
; xor dh,[di]
; xor [di+0x47],al
; inc di
; dec ax
; inc bp
; inc cx
; inc sp
; or al,[bx+si]
; push sp
; push word 0x2065
; push sp
; gs jc 0x8a7b
; imul sp,[bp+si+0x6c],word 0x2065
; inc di
; jnz 0x8a7f
; imul si,[bp+di+0x20],byte +0x20
; and [bx+si],ah
; xor [bx+si],dh
; xor [bx+di],dh
; xor [bx+si],dh
; dec bx
; inc cx
; push sp
; inc dx
; inc cx
; dec cx
; push sp
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add ah,bh
; add [bp+si],al
; add ah,bh
; db 0xff
; db 0xfe
; cld
; clc
; lock out 0xe4,al
; loopne 0x8a19
; rol al,byte 0x80
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; db 0xfe
; inc word [bx+si]
; add dh,bh
; inc word [bx+si]
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [0xc3],al
; add [0xc3],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [0xc3],bh
; add [0xc3],bh
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [0xc3],al
; add [0xc3],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [0xc3],al
; add [0xc3],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add dh,bh
; inc word [bx+si]
; add dh,bh
; inc word [bx+si]
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add dh,bh
; db 0xff
; db 0xfe
; inc word [bx+si]
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [0x6c3],al
; ret
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; ds ret
; ds ret
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; push es
; ret
; push es
; ret
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; push es
; ret
; push es
; ret
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; db 0xfe
; db 0xff
; db 0xfe
; inc word [bx+si]
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add dh,bh
; inc word [bx+si]
; add dh,bh
; inc word [bx+si]
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add al,al
; ret
; add [bx+si],al
; rol bl,byte 0x0
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add dh,bh
; ret
; add [bx+si],al
; inc bl
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; push es
; ret
; add [bx+si],al
; push es
; ret
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; mov bl,0x0
; add dh,al
; ret
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; jng 0x8ba9
; add [bx+si],al
; jng 0x8bad
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; db 0xfe
; db 0xff
; db 0xfe
; inc word [bx+si]
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add al,al
; ret
; rol bl,byte 0x0
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add dh,bh
; ret
; inc bl
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; push es
; ret
; push es
; ret
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; mov bl,0xc6
; ret
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; jng 0x8c15
; jng 0x8c17
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bp+di],al
; add [bx+si],al
; add [bp+di],al
; pop ds
; out dx,ax
; add [bx+si],al
; pop ds
; out dx,ax
; lock add [bx+si],al
; add al,dh
; add [bx+si],al
; pop es
; add [bx+si],al
; add [bx],al
; sbb [si+0x0],ch
; add [bx+si],bl
; insb
; xor [bx+si],al
; add [bx+si],al
; xor [bx+si],al
; add [bp+di],al
; add [bx+si],al
; add [bp+di],al
; sbb [si+0x0],ch
; add [bx+si],bl
; insb
; xor [bx+si],al
; add [bx+si],al
; xor [bx+si],al
; add [bp+di],al
; add [bx+si],al
; add [bp+di],al
; sbb [si+0x0],ch
; add [bx+si],bl
; insb
; xor [bx+si],al
; add [bx+si],al
; xor [bx+si],al
; add [bp+di],al
; add [bx+si],al
; add [bp+di],al
; pop ax
; insb
; add [bx+si],al
; pop ax
; insb
; xor [bx+si],al
; add [bx+si],al
; xor [bx+si],al
; add [bx],cl
; add [bx+si],al
; add [bx],cl
; fucomip st7
; add [bx+si],al
; fucomip st7
; lock add [bx+si],al
; add al,dh
; add [bx+si],al
; add ax,[bx+si]
; add ax,[bx+si]
; add [bx],bl
; out dx,ax
; pop ds
; out dx,ax
; add [bx+si],al
; lock add al,dh
; add [bx+si],al
; add [bx+si],al
; pop es
; add [bx],al
; add [bx+si],al
; sbb [si+0x18],ch
; insb
; add [bx+si],al
; xor [bx+si],al
; xor [bx+si],al
; add [bx+si],al
; add [bp+di],al
; add [bp+di],al
; add [bx+si],al
; sbb [si+0x18],ch
; insb
; add [bx+si],al
; xor [bx+si],al
; xor [bx+si],al
; add [bx+si],al
; add [bp+di],al
; add [bp+di],al
; add [bx+si],al
; sbb [si+0x18],ch
; insb
; add [bx+si],al
; xor [bx+si],al
; xor [bx+si],al
; add [bx+si],al
; add [bp+di],al
; add [bp+di],al
; add [bx+si],al
; pop ax
; insb
; pop ax
; insb
; add [bx+si],al
; xor [bx+si],al
; xor [bx+si],al
; add [bx+si],al
; add [bx],cl
; add [bx],cl
; add [bx+si],al
; fucomip st7
; fucomip st7
; add [bx+si],al
; lock add al,dh
; add [bx+si],al
; add [bx+si],al
; pop es
; add [bx+si],al
; add [bx],al
; iret
; out dx,ax
; add [bx+si],al
; iret
; out dx,ax
; lock add [bx+si],al
; add al,dh
; add [bx+si],al
; or al,0x0
; add [bx+si],al
; or al,0x6c
; or al,0x0
; add [si+0xc],ch
; xor [bx+si],al
; add [bx+si],al
; xor [bx+si],al
; add [bx+di],al
; add [bx+si],al
; add [bx+di],al
; iret
; in al,dx
; add [bx+si],al
; iret
; in al,dx
; xor [bx+si],al
; add [bx+si],al
; xor [bx+si],al
; add [bx],al
; add [bx+si],al
; add [bx],al
; add [si+0x0],ch
; add [bx+si],al
; insb
; xor [bx+si],al
; add [bx+si],al
; xor [bx+si],al
; add [si],cl
; add [bx+si],al
; add [si],cl
; or al,0x6c
; add [bx+si],al
; or al,0x6c
; xor [bx+si],al
; add [bx+si],al
; xor [bx+si],al
; add [bx],cl
; add [bx+si],al
; add [bx],cl
; imul di
; add [bx+si],al
; imul di
; lock add [bx+si],al
; add al,dh
; add [bx+si],al
; pop es
; add [bx],al
; add [bx+si],al
; iret
; out dx,ax
; iret
; out dx,ax
; add [bx+si],al
; lock add al,dh
; add [bx+si],al
; add [bx+si],al
; or al,0x0
; or al,0x0
; add [si+0xc],ch
; insb
; or al,0x0
; add [bx+si],dh
; add [bx+si],dh
; add [bx+si],al
; add [bx+si],al
; add [bx+si],ax
; add [bx+si],ax
; add bh,cl
; in al,dx
; iret
; in al,dx
; add [bx+si],al
; xor [bx+si],al
; xor [bx+si],al
; add [bx+si],al
; add [bx],al
; add [bx],al
; add [bx+si],al
; add [si+0x0],ch
; insb
; add [bx+si],al
; xor [bx+si],al
; xor [bx+si],al
; add [bx+si],al
; add [si],cl
; add [si],cl
; add [bx+si],al
; or al,0x6c
; or al,0x6c
; add [bx+si],al
; xor [bx+si],al
; xor [bx+si],al
; add [bx+si],al
; add [bx],cl
; add [bx],cl
; add [bx+si],al
; imul di
; imul di
; add [bx+si],al
; lock add al,dh
; add [bx+si],al
; add [bp+di],al
; clc
; add [bx+si],al
; add di,ax
; add [bx+si],al
; pop ds
; clc
; add [bx+si],al
; pop ds
; rol byte [bx+si],byte 0x0
; pop ds
; rol byte [0x10c],byte 0x10
; pop es
; sbb al,0x3
; shr byte [si],byte 0x34
; add [bx+si],al
; xor [bx+si+0x8],ah
; cmp byte [bx+si],0xe0
; or al,0x6
; add [bx+si],al
; or al,0xe6
; pop es
; loopne 0x8e75
; push ds
; add [bx+si],al
; pusha
; xor [bx+si],al
; add [bx+0x30],ah
; or al,0x6
; add [bx+si],cl
; or al,0xfe
; db 0x0f
; lock ror byte [bp+di],1
; add [bx+si],al
; pusha
; xor [bx+si],dl
; add [bx+0x30],bh
; push es
; movsb
; add [bx+si],ax
; pop es
; cld
; pop ds
; clc
; loopne 0x8e29
; add [bx+si],al
; and ax,0x60
; cmp byte [bx],0xe0
; add cx,bx
; add [bp+di],al
; add di,sp
; aas
; cld
; db 0xff
; inc word [bx+si]
; add bl,dl
; rol al,byte 0x0
; aas
; rol byte [bx+si],byte 0x0
; add [bx+di],al
; add [0xc30],bl
; rol byte [bp+di],byte 0x0
; add [bx+si],al
; add [bx+si+0x7800],al
; add [bx+si],al
; add al,0x0
; add [bx+si],al
; pabsb mm0,mm0
; add ax,[bx+si]
; add [bx+si],ah
; add [bx+si],al
; add al,dh
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; pop es
; xor [si],cl
; rol byte [bp+di],byte 0x80
; add [bx+si],ax
; add [bx+si],al
; add al,ah
; add [bx+si],al
; add [bx+si],al
; add ax,[bx+si]
; add [bx+si],sp
; add al,0xc0
; add ax,[bx+si+0x1]
; add al,al
; add [bx+si+0x0],al
; add [bx+si],al
; add [bx+si],ax
; add [bx+si],al
; add al,al
; add ax,[bx+si]
; add [bx+si],al
; add [bx+si+0x0],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si+0x2],al
; rol byte [bp+di],byte 0x40
; add al,[bx+si]
; add [bx+si],al
; add [bx+si],al
; add [bp+di],al
; clc
; add [bx+si],al
; add di,ax
; and [si],al
; aas
; cld
; and [si],al
; pop ds
; rol byte [bx+si],byte 0x0
; pop ds
; rol byte [0xc],byte 0x40
; push es
; dec sp
; add ax,ax
; sub al,0x34
; add [bx+si],al
; xor [bx+si+0x2],ah
; add [bp+si],dh
; pusha
; or al,0x6
; add [bx+si],cl
; or al,0xee
; pop es
; loopne 0x8f4d
; push ds
; add [bx+si],al
; pusha
; xor [bx+si],dl
; inc ax
; ja 0x8f4e
; or al,0x6
; add al,[bx+si]
; push cs
; db 0xf6
; db 0x0f
; lock ror byte [bp+di],1
; add [bx+si],al
; pusha
; xor [bx+si],al
; add [bx+0x30],ch
; push es
; test [bx+si],al
; and [0x1ffc],al
; clc
; loopne 0x8f01
; add [bx+si],al
; and ax,sp
; add al,0x0
; aas
; loopne 0x8f06
; retf
; add [bp+di],al
; add di,sp
; aas
; cld
; db 0xff
; inc word [bx+si]
; add bl,dl
; rol al,byte 0x0
; aas
; rol byte [bx+si],byte 0x0
; add [bx+di],al
; add [0xc30],bl
; rol byte [bp+di],byte 0x0
; add [bx+si],al
; add [bx+si+0x7800],al
; add [bx+si],al
; add al,0x0
; add [bx+si],al
; pabsb mm0,mm0
; add ax,[bx+si]
; add [bx+si],ah
; add [bx+si],al
; add al,dh
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; pop es
; xor [si],cl
; rol byte [bp+di],byte 0x80
; add [bx+si],ax
; add [bx+si],al
; add al,ah
; add [bx+si],al
; add [bx+si],al
; add ax,[bx+si]
; add [bx+si],sp
; add al,0xc0
; add ax,[bx+si+0x1]
; add al,al
; add [bx+si+0x0],al
; add [bx+si],al
; add [bx+si],ax
; add [bx+si],al
; add al,al
; add ax,[bx+si]
; add [bx+si],al
; add [bx+si+0x0],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add al,al
; add ax,[bx+si]
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; cmp [bx+si],al
; cmp [bx+si],al
; add al,ah
; loopne 0x9029
; loopne 0x904b
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],ax
; add [bx+si],al
; add ax,sp
; add [bx+si],al
; add al,ah
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add ax,[bx+si]
; add [bx+si],al
; add si,[bx+si]
; add [bx+si],al
; add [bx+si],dh
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add al,al
; push es
; add [0xc0],al
; sbb [bx+si],al
; add [bx+si],al
; sbb [bx+si],al
; add [bx],cl
; add [bx+si],al
; add [bx],cl
; inc ax
; add [bx+si],al
; add [bx+si+0x0],al
; sbb [bx+si],al
; add [bx+si],al
; sbb [bx+si],al
; add [bx],bl
; add [bx+si],al
; add [bx],bl
; rol byte [bx+si],byte 0x0
; add al,al
; add al,dh
; add [bx+si],al
; add al,dh
; add [bx+si],al
; pop ss
; add [bx+si],al
; add [bx],dl
; loopne 0x90ed
; add [bx+si],al
; loopne 0x90f1
; add byte [bx+si],0x0
; add [bx+si+0x0],al
; pop ds
; add [bx+si],dl
; add [bx],bl
; jg 0x90bf
; add [bx+si],al
; jg 0x90c3
; rol byte [bx+si],byte 0x0
; add al,al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add bh,bh
; inc word [bx+si]
; add bh,bh
; inc ax
; add [bx+si],al
; add al,al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx-0x5],bh
; add [bx+si],al
; jg 0x90e3
; rol byte [bx+si],byte 0x0
; add al,al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bp+di-0xf],bh
; add [bx+si],al
; jpo 0x90eb
; loopne 0x90fc
; add [bx+si],al
; loopne 0x9100
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; js 0x9109
; or [bx+si],al
; jo 0x910d
; mov ax,0x0
; add [bx+si+0x0],bh
; add [bx+si],al
; add [bx+si],al
; add al,ah
; add sp,ax
; add ax,[bx+si]
; add [bx+si+0x0],dh
; jo 0x9122
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; pop es
; add byte [bx+si],0x0
; pop es
; add byte [bx+si],0x0
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; or al,0xc0
; add [bx+si],al
; or al,0xc0
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si+0x0],ax
; add [bx+si+0x6018],ax
; sbb [bx+si],al
; add [bx+si+0x0],ah
; add [bx+si],al
; add [bx+si],al
; add [0x80],cl
; add [0x80],cl
; pusha
; add [bx+si],al
; add [bx+si+0x0],ah
; add [bx+si],al
; add [bx+si],al
; add [bx],bl
; loopne 0x916f
; add [bx],bl
; loopne 0x9174
; rol byte [bx+si],byte 0x0
; add ax,ax
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; pop ss
; lock add [bx+si],al
; pop ss
; lock aas
; add [bx+si],al
; add [bx],bh
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx],bl
; jg 0x91a3
; add [bx],bl
; jg 0x9196
; add byte [bx+si],0x0
; inc word [bx+si+0x0]
; add [bx+si],al
; add [bx+si],al
; add bh,bh
; add [bx+si],al
; add bh,bh
; inc word [bx+si+0x0]
; inc word [bx+si+0x0]
; add [bx+si],al
; add [bx+si],al
; add [bx+0x0],di
; add [bx+0x40ef],di
; add [bx+si],al
; out dx,ax
; inc ax
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add bx,bp
; add [bx+si],al
; add bx,bp
; div word [bx+si+0x0]
; adc bh,dh
; pusha
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add cx,[0x0]
; add cx,[0x300e]
; add [bx+si],dh
; push cs
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx],al
; pop es
; pop es
; pop es
; add [bx+si],al
; sbb al,0x0
; sbb al,0x0
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; push ds
; add [bx+si],al
; add [0x0],bl
; add [bx+si],al
; add [bp+di],al
; rol byte [bx+si],byte 0x78
; add [bx+si],al
; add [bx+si+0x7],bh
; dec word [bx+si]
; add [bx],al
; inc word [bp+si+0x241]
; inc ax
; xchg cx,sp
; jmp ax
; add [bx+si],dl
; jmp ax
; add [bx+si],al
; add di,di
; add [bx+si],al
; loopne 0x922f
; add ax,ax
; out 0xe7,ax
; add [bx+si],al
; inc ax
; add [bx+si],al
; add [bx],bh
; add [bx],bh
; add [bx+si],al
; cld
; aas
; add word [bx+di-0x181],0xfc
; cld
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add bh,bh
; inc word [bx+si]
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bp+si],cl
; push ax
; add ax,0xa0
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+di],al
; or byte [bp+si],0x50
; or [bx+si],dl
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; sbb al,0x38
; sbb al,0x38
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bp+si],al
; add [bx+si],al
; add [bp+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; inc ax
; add [bx+si],al
; add [bx+si+0x0],al
; add [bx],bl
; add [bx+si],al
; add [bx],bl
; mov [bx+di],dl
; adc al,0x28
; mov dx,cx
; clc
; add [bx+si],al
; add al,bh
; add [bx+si],al
; jo 0x92b3
; jmpe word [bx+si-0x1e]
; inc di
; or dl,[bx+si-0x19]
; out 0xe,ax
; add al,dh
; add [0x100],cl
; mov word [bx+si],0x13f
; sar al,byte 0x1f
; add cx,byte +0x7f
; db 0xfe
; jcxz 0x9250
; cld
; add [bp+di],al
; add byte [bp+di],0x1c
; add ah,bh
; add ax,[bx+si]
; cld
; aas
; add [bx+si-0x3ffd],ax
; cmp al,al
; aas
; add [bx+si],al
; rol byte [0x100],byte 0x80
; push es
; add [bx],al
; loopne 0x9307
; sbb [bx+si],bl
; sbb [bx+si],al
; pusha
; add [bx+si+0x6000],ax
; or al,0x0
; add [bx+si],al
; or al,0x0
; add ax,ax
; sub [si],dl
; sub [si],dl
; add [bx+si],dh
; add [bx+si],al
; add [bx+si],dh
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bp+si],al
; add [bx+si],al
; add [bp+si],al
; adc al,0x28
; sub dx,sp
; adc al,0x28
; inc ax
; add [bx+si],al
; add [bx+si+0x0],al
; add [bx],bl
; add [bx+si],al
; add [bx],bl
; mov dl,[bx+di+0x15]
; test al,0x8a
; push cx
; clc
; add [bx+si],al
; add al,bh
; add [bx+si],al
; aas
; add [bx+si],al
; add [bx],bh
; loopne 0x934f
; or [bx+si],dl
; out 0xe7,ax
; cld
; add [bx+si],al
; add ah,bh
; add [bx+si],al
; add [edi],bl
; add [bx+si-0x6],ah
; pop di
; db 0x82
; inc cx
; jg 0x935c
; out 0x0,al
; clc
; add [0x0],al
; enter 0x3800,0x0
; sar al,byte 0x1f
; add ax,ax
; pop es
; loopne 0x9384
; add [si],bl
; add [bp+di],al
; add [bx+di],al
; nop
; add [bx+si+0x1],dh
; add byte [si],0x20
; sub [si-0x2bd5],dx
; or [bx+si+0xe],ax
; add [bx+si-0x7fff],ax
; add [bx+si+0x1],ah
; add byte [bp+di],0xc0
; add [bx+si],al
; add [bx+si],al
; add [bx+si+0x6],ax
; add [bx+si-0x4000],ax
; add [bx+si],al
; add al,al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add ax,[bx+si]
; add [bx+si],al
; add ax,[bx+si]
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; adc [bx+si],cl
; and [si],al
; adc [bx+si],cl
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add di,di
; add [bx+si],al
; add di,di
; mov [bx+di],dl
; adc al,0x28
; mov dx,cx
; inc word [bx+si+0x0]
; inc word [bx+si-0x7ff1]
; add [bx+0xf],bh
; and dl,0x47
; or dl,[bx+si-0x19]
; out 0x1,ax
; lock inc byte [bx+si]
; add ax,si
; sbb [bx],bh
; pop es
; call far [bx+si]
; add al,bh
; pop ds
; add cx,byte +0x7f
; db 0xfe
; cld
; sbb bh,bh
; loopne 0x93f3
; sbb [bx+si],dh
; add [bx+si],al
; add [bx+si],dh
; add ah,bh
; aas
; add [bx+si-0x3ffd],ax
; add [si],cl
; add [bx+si],al
; add [si],cl
; inc ax
; add [bx+si],ah
; add [bx+si+0x0],al
; db 0x0f
; lock add [bx+si],al
; add [bx+si],al
; add [bp+si],al
; add [si],al
; add [bp+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add ax,ax
; or [bx+si],dl
; or [bx+si],dl
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; adc al,0x28
; adc al,0x28
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; das
; add al,0x81
; push bp
; das
; adc al,0x8c
; push bp
; cmp ax,0xbd04
; push bp
; ds pop fs
; push bp
; inc di
; add dx,bx
; push bp
; push si
; add al,0x97
; push bp
; pop dx
; push ss
; db 0xc6
; push bp
; pusha
; add bp,[di+0x7055]
; adc ah,bl
; push bp
; jns 0x9488
; lock push bp
; db 0x82
; adc bh,dh
; push bp
; lea dx,[si]
; or dl,[bp-0x67]
; adc al,0x11
; push si
; jo 0x948a
; sbb al,0x56
; jng 0x948e
; and dl,[bp-0x77]
; add al,0x29
; push si
; xchg ax,si
; add al,0x30
; push si
; test ax,0x3606
; push si
; mov cl,0x5
; pop bp
; push si
; mov cx,0x8804
; push si
; add [bx+si],al
; sbb ax,0xb90d
; push si
; xor [si],al
; db 0xc6
; push si
; xor [bp+si],dl
; into
; push si
; xor [bx+si],bl
; aad 0x56
; test ax,0x3606
; push si
; mov cl,0x5
; pop bp
; push si
; mov cx,0x8804
; push si
; add [bx+si],al
; add [bx],al
; push sp
; dec ax
; inc bp
; and [bp+di+0x41],al
; push bx
; push sp
; cmp cl,[di]
; push sp
; dec ax
; inc bp
; and [bx+si+0x52],dl
; dec di
; push ax
; push bx
; cmp cl,[di]
; add sp,[bp+si]
; push bx
; inc cx
; dec cx
; dec sp
; dec di
; push dx
; and cl,[di]
; push es
; inc di
; dec cx
; push dx
; inc sp
; inc bp
; push dx
; push bx
; and [si],al
; adc [di],cl
; add di,[0x203e]
; dec bx
; inc bp
; pop cx
; inc dx
; dec di
; inc cx
; push dx
; inc sp
; and [si],bh
; cmp al,0xd
; add ax,0x5322
; dec ax
; inc bp
; dec cx
; dec bx
; and cl,[di]
; add al,0x11
; push es
; and [bp+di+0x4c],al
; dec cx
; dec bp
; inc dx
; inc bp
; push dx
; push bx
; or ax,0x3e05
; and [ds:bp+si+0x4f],cl
; pop cx
; push bx
; push sp
; dec cx
; inc bx
; dec bx
; and [si],bh
; cmp al,0xd
; push es
; inc si
; dec sp
; dec cx
; dec si
; inc di
; inc bp
; push dx
; push bx
; and [si],al
; adc [di],cl
; push es
; inc bx
; dec di
; dec si
; push si
; inc bp
; pop cx
; dec di
; push dx
; push bx
; and [si],al
; adc [di],cl
; push es
; pop dx
; inc cx
; push ax
; push ax
; inc bp
; push dx
; push bx
; and [si],al
; adc [di],cl
; pop es
; inc bx
; inc cx
; push bx
; dec ax
; and [di],cx
; push es
; inc cx
; dec si
; inc sp
; and [di+0x4f],cl
; push dx
; inc bp
; and [di],cx
; and cl,[bp+di+0x41]
; push sp
; and cl,[di]
; and al,[bp+si+0x59]
; push dx
; inc sp
; and cl,[di]
; and al,[bp+si+0x4f]
; dec bp
; inc dx
; and cl,[di]
; and al,[di+0x47]
; inc di
; and cl,[di]
; pop es
; inc bx
; dec di
; push ax
; pop cx
; push dx
; dec cx
; inc di
; dec ax
; push sp
; and [bp+si+0x41],cl
; dec si
; push bp
; inc cx
; push dx
; pop cx
; and [bx+0x46],cl
; and [bx+di],dh
; cmp [bx+si],di
; xor al,0x20
; inc dx
; pop cx
; and [di+0x49],cl
; inc bx
; dec ax
; push sp
; push dx
; dec di
; dec si
; or ax,0x4153
; dec si
; pop cx
; dec di
; das
; dec cx
; inc dx
; dec bp
; and [bp+0x45],dl
; push dx
; push bx
; dec cx
; dec di
; dec si
; push bx
; and [bx+0x52],dl
; dec cx
; push sp
; push sp
; inc bp
; dec si
; and [bp+si+0x59],al
; and [bp+si+0x49],al
; dec sp
; dec sp
; and [si+0x55],al
; dec si
; dec sp
; inc bp
; push si
; pop cx
; or ax,0x524f
; dec cx
; inc di
; dec cx
; dec si
; inc cx
; dec sp
; and [bx+si+0x52],dl
; dec di
; inc di
; push dx
; inc cx
; dec bp
; and [bp+si+0x59],al
; and [bp+si+0x49],al
; dec sp
; dec sp
; and [si+0x55],al
; dec si
; dec sp
; inc bp
; push si
; pop cx
; and [bx+di+0x4e],al
; inc sp
; and [si+0x4f],al
; push bp
; inc di
; and [bp+0x52],al
; inc cx
; pop cx
; inc bp
; push dx
; or ax,0x4807
; dec cx
; inc di
; dec ax
; and [bp+di+0x43],dl
; dec di
; push dx
; inc bp
; push bx
; or ax,0x4c50
; inc cx
; pop cx
; inc bp
; push dx
; cmp cl,[di]
; push bx
; inc bx
; dec di
; push dx
; inc bp
; cmp cl,[di]
; push sp
; dec cx
; push sp
; dec sp
; inc bp
; cmp cl,[di]
; and [bx+si],ah
; and [bx+si],ah
; and [bx+si],ah
; and [bx+si],ah
; and [bx+si],ah
; and [bx+si],ah
; and [bx+si],ah
; and [bx+si],ah
; add ax,0xcdc9
; int 0xcd
; int 0xcd
; int 0xcd
; int 0xcd
; int 0xcd
; int 0xcd
; mov bx,0xc705
; db 0xc4
; db 0xc4
; db 0xc4
; db 0xc4
; db 0xc4
; db 0xc4
; db 0xc4
; db 0xc4
; db 0xc4
; db 0xc4
; db 0xc4
; db 0xc4
; les si,[bp-0x37fb]
; int 0xcd
; int 0xcd
; int 0xcd
; int 0xcd
; int 0xcd
; int 0xcd
; int 0xbc
; push es
; and [bx+si],ah
; push di
; inc bp
; dec sp
; inc bx
; dec di
; dec bp
; inc bp
; and [si+0x4f],dl
; and [bx+si],ah
; and [0x2020],al
; and [bp+di+0x41],al
; push bx
; dec ax
; dec bp
; inc cx
; dec si
; and [bx+si],sp
; and [bx+si],ah
; and [di],al
; mov dx,0x2006
; and [bx+si],ah
; and [bx+si+0x46],dl
; xor [bx+si],sp
; and [bx+si],ah
; and [di],al
; mov dx,0xba05
; push es
; and [bx+si],ah
; and [bx+si],ah
; push ax
; inc si
; xor ah,[bx+si]
; and [bx+si],ah
; and [di],al
; mov dx,0xba05
; push es
; and [bx+si],ah
; and [bx+si],ah
; push ax
; inc si
; xor sp,[bx+si]
; and [bx+si],ah
; and [di],al
; mov dx,0xba05
; push es
; and [bx+si],ah
; and [bx+si],ah
; push ax
; inc si
; xor al,0x20
; and [bx+si],ah
; and [di],al
; mov dx,0xba05
; push es
; and [bx+si],ah
; and [bx+si],ah
; push ax
; inc si
; xor ax,0x2020
; and [bx+si],ah
; add ax,0x5ba
; mov dx,0x5003
; dec cx
; inc bx
; dec bx
; and [bx+si+0x4c],dl
; inc cx
; pop cx
; inc bp
; push dx
; add ax,0x5ba
; mov dx,0x5303
; push sp
; inc cx
; push dx
; push sp
; and [bx+0x41],al
; dec bp
; inc bp
; and [di],al
; mov dx,0xba05
; add ax,[bx+di+0x42]
; dec di
; push dx
; push sp
; and [bx+0x41],al
; dec bp
; inc bp
; and [di],al
; mov dx,0xba05
; add dx,[bx+si+0x41]
; push bp
; push bx
; inc bp
; and [bx+0x41],al
; dec bp
; inc bp
; and [di],al
; mov dx,0xba05
; add dx,[bp+si+0x45]
; push bx
; push bp
; dec bp
; inc bp
; and [bx+0x41],al
; dec bp
; inc bp
; add ax,0x5ba
; mov dx,0x4803
; dec cx
; inc di
; dec ax
; and [bp+di+0x43],dl
; dec di
; push dx
; inc bp
; push bx
; add ax,0x5ba
; mov dx,0x4903
; dec si
; inc si
; dec di
; push dx
; dec bp
; inc cx
; push sp
; dec cx
; dec di
; dec si
; add ax,0x5ba
; mov dx,0x5303
; dec di
; push bp
; dec si
; inc sp
; cmp al,[si]
; dec di
; dec si
; and [bx+si],ah
; add ax,0x5ba
; mov dx,0x5303
; dec di
; push bp
; dec si
; inc sp
; cmp al,[si]
; dec di
; inc si
; inc si
; and [di],al
; mov dx,0x3206
; and [di+0x45],cl
; dec si
; sub al,0x20
; xor ah,[bx+si]
; dec dx
; dec di
; pop cx
; push bx
; push sp
; dec bx
; push es
; push bx
; push sp
; inc cx
; push dx
; push sp
; dec cx
; dec si
; inc di
; and [bx+di+0x52],al
; inc bp
; inc cx
; cmp ah,[bx+si]
; pop es
; and [bx+si],ah
; and [bx+si],ah
; inc bp
; inc cx
; push bx
; pop cx
; and [bx+si],ah
; and [bx+si],ah
; and [bx+si],ah
; and [bx],al
; and [bp+di+0x55],dl
; push ax
; inc bp
; push dx
; sub ax,0x554a
; dec bp
; push ax
; and [bx+si],sp
; and [bx+si],ah
; pop es
; and [bx+si],ah
; dec bp
; dec di
; inc sp
; inc bp
; push dx
; inc cx
; push sp
; inc bp
; and [bx+si],ah
; and [bx+si],ah
; and [bx],al
; and [bp+0x4f],cl
; and [bp+si+0x55],cl
; dec bp
; push ax
; dec cx
; dec si
; inc di
; and [bx+si],ah
; and [bx+si],ah
; pop es
; and [di+0x58],al
; push ax
; inc bp
; push dx
; dec cx
; inc bp
; dec si
; inc bx
; inc bp
; inc sp
; and [bx+si],ah
; and [bx],al
; inc bp
; pop ax
; push ax
; inc bp
; push dx
; push sp
; add bx,[bp+di+0x50]
; push bp
; pop dx
; pop dx
; dec sp
; inc bp
; pop bp
; add dx,[bx+si+0x4c]
; inc cx
; pop cx
; dec cx
; dec si
; inc di
; and [di+0x4f],cl
; inc sp
; inc bp
; cmp ah,[bx+si]
; and [0x4853],al
; inc bp
; dec cx
; dec bx
; sub ax,0x4f4a
; pop cx
; push bx
; push sp
; dec cx
; inc bx
; dec bx
; and [0x4153],al
; dec cx
; dec sp
; dec di
; push dx
; sub ax,0x454b
; pop cx
; inc dx
; dec di
; inc cx
; push dx
; inc sp
; push es
; push bx
; dec ax
; inc bp
; dec cx
; dec bx
; and [bp+0x53],dl
; and [bp+di+0x41],dl
; dec cx
; dec sp
; dec di
; push dx
; push es
; and [bp+di+0x55],al
; push dx
; push dx
; inc bp
; dec si
; push sp
; and [bx+di+0x52],al
; inc bp
; inc cx
; cmp ah,[bx+si]
; add sp,[bx+si]
; and [bx+si],ah
; push bx
; dec cx
; push sp
; inc bp
; cmp al,[bx]
; and sp,[bp+di]
; and [bx+si],ah
; and [bx+si],ah
; add ax,0x3ba
; push bx
; inc bp
; dec sp
; inc bp
; inc bx
; push sp
; and [bx+di+0x52],al
; inc bp
; inc cx
; add ax,0x6ba
; push bx
; dec ax
; inc bp
; dec cx
; dec bx
; and [bx+si],ah
; and al,0x20
; and [bx+si],ah
; and [bx+si],ah
; and [bx+si],ah
; add dx,[bp+di+0x41]
; dec cx
; dec sp
; dec di
; push dx
; and [si],ah
; and [bx+si],ah
; and [bx+si],ah
; and [bx+si],ah
; and [bp+si],al
; and [bx+si],ah
; and [bx+si],ah
; and [bx+si],ah
; and [bx+si],ah
; and [bx+si],ah
; and [bx+si],ah
; and [bx+si],ah
; and [bp+si],al
; and [bx+si],ah
; and [bx+si],ah
; and [bx+si],ah
; and [bx+si],ah
; and [bx+si],ah
; and [bx+si],ah
; and [bx+si],ah
; and [0x4f57],al
; push di
; and [bx+si],sp
; inc di
; dec di
; dec di
; inc sp
; and [bp+di+0x48],dl
; dec di
; push di
; and [bp+di],al
; push bx
; inc cx
; dec cx
; dec sp
; dec di
; push dx
; and [0x4557],ax
; and [bx+0x49],dl
; push bx
; dec ax
; and [si+0x4f],dl
; and [bp+si+0x45],dl
; inc bx
; dec di
; push dx
; inc sp
; and [bx+di+0x4f],bl
; push bp
; push dx
; and [bx+si],ah
; dec si
; inc cx
; dec bp
; inc bp
; and [bx+di+0x4e],cl
; push bx
; dec cx
; inc sp
; inc bp
; and [bx+0x55],cl
; push dx
; pop es
; dec ax
; inc cx
; dec sp
; dec sp
; and [bx+0x46],cl
; and [bp+0x41],al
; dec bp
; inc bp
; push es
; push bx
; dec di
; and [si+0x48],dl
; inc cx
; push sp
; and [bp+0x55],al
; push sp
; push bp
; push dx
; inc bp
; and [bx+si],ah
; and [bx+si],ah
; and [bx+si+0x4c],dl
; inc cx
; pop cx
; inc bp
; push dx
; push bx
; and [bp+di+0x41],al
; dec si
; and [bx+si],ah
; and [bx+si],ah
; and [bp+di+0x48],al
; inc cx
; dec sp
; dec sp
; inc bp
; dec si
; inc di
; inc bp
; and [bx+di+0x4f],bl
; push bp
; push dx
; and [bx+si],ah
; push bx
; inc bx
; dec di
; push dx
; inc bp
; and [cs:bx+si],ah
; push ax
; dec sp
; inc bp
; inc cx
; push bx
; inc bp
; and [bx+si],ah
; dec ax
; dec cx
; push sp
; add dx,[bp+si+0x45]
; push sp
; push bp
; push dx
; dec si
; push es
; push di
; dec ax
; inc bp
; dec si
; and [bx+di+0x4f],bl
; push bp
; and [bx+di+0x52],al
; inc bp
; and [si+0x48],dl
; push dx
; dec di
; push bp
; inc di
; dec ax
; and [si+0x59],dl
; push ax
; dec cx
; dec si
; inc di
; and [bx+di+0x4e],cl
; and [bx+di+0x4f],bl
; push bp
; push dx
; and [bx+si],ah
; dec si
; inc cx
; dec bp
; inc bp
; and [cs:bx+si],ah
; push sp
; dec ax
; inc cx
; dec si
; dec bx
; push bx
; and [bx+si],sp
; add ax,0x4853
; inc bp
; dec cx
; dec bx
; and [0x4557],ax
; and [bx+0x49],dl
; push bx
; dec ax
; and [si],al
; pop cx
; dec di
; push bp
; and [di+0x41],cl
; inc sp
; inc bp
; and [bx+di+0x54],cl
; and [si+0x4f],dl
; and [si],al
; sub cl,[bx+0x55]
; push sp
; and [bx+0x46],cl
; and [bx+si+0x4f],dl
; push di
; inc bp
; push dx
; sub ah,[bx+si]
; salc
; add al,0x54
; push word 0x2065
; push sp
; imul bp,[di+0x65],word 0x4220
; popa
; outsb
; imul si,[fs:si+0x20],word 0x666f
; and [bx+0x6c],cl
; xor [fs:bx+di],dh
; xor dh,[bp+di]
; cmp [bx+si],dh
; inc bx
; inc cx
; push bx
; dec ax
; dec bp
; inc cx
; dec si
; add word [bp+di],0x6154
; jc 0x9a31
; popa
; outsb
; and [si+0x6f],ch
; outsw
; imul si,[bp+di+0x20],byte +0x66
; outsw
; jc 0x99e4
; inc bx
; inc cx
; push bx
; dec ax
; and [bx+si],dh
; xor [bx+si],bh
; cmp [bx],si
; xor [bx+di+0x43],al
; push dx
; dec di
; inc dx
; inc cx
; push sp
; les ax,[bx+di]
; inc dx
; imul bp,[bx+0x6e],word 0x6369
; and [di+0x61],cl
; outsb
; and [si+0x65],dl
; jnc 0x9a5b
; jnc 0x9a09
; push ax
; popa
; jc 0x9a61
; jnc 0x9a1f
; xor [si],dh
; xor ax,0x3032
; inc si
; inc cx
; dec sp
; dec sp
; inc di
; push bp
; pop cx
; cmp al,0x1
; inc bx
; popa
; jo 0x9a75
; popa
; imul bp,[bp+0x20],word 0x7243
; jnz 0x9a6e
; insb
; sub ax,0x2061
; inc sp
; gs insb
; jz 0x9a73
; outsb
; xor [bx+si],dh
; xor si,[bx+di]
; xor [ss:bp+si+0x55],cl
; dec bp
; push ax
; dec bp
; inc cx
; dec si
; out dx,ax
; add [bp+si],ah
; push di
; popa
; jz 0x9a8a
; push word 0x7420
; push word 0x2065
; inc dx
; imul si,[bp+si+0x64],word 0x2279
; and [bp+si+0x6f],al
; bound sp,[bx+si]
; xor [bx+si],dh
; xor dh,[bp+di]
; cmp [bx+si],si
; inc dx
; pop cx
; push dx
; inc sp
; dec bp
; inc cx
; dec si
; add [edx+0x69],cl
; insw
; bound bp,[bx+0x20]
; jz 0x9ab7
; and [gs:bp+di+0x68],al
; imul bp,[di+0x70],word 0x6e61
; jpe 0x9abf
; and [gs:bx+si],ah
; xor [bx+si],dh
; xor [bx+si],si
; xor si,[bx+si]
; inc dx
; inc cx
; inc di
; inc dx
; dec di
; pop cx
; aas
; sbb [bx+si],ax
; inc bp
; jpe 0x9a90
; push di
; jnz 0x9aed
; outsw
; outsw
; outsb
; and [si+0x68],dh
; and [gs:bx+0x6f],al
; outsw
; outsb
; and [bx+si],ah
; and [bx+si],dh
; xor [bx+si],dh
; xor dh,[di]
; xor [di+0x47],al
; inc di
; dec ax
; inc bp
; inc cx
; inc sp
; or al,[bx+si]
; push sp
; push word 0x2065
; push sp
; gs jc 0x9b0b
; imul sp,[bp+si+0x6c],word 0x2065
; inc di
; jnz 0x9b0f
; imul si,[bp+di+0x20],byte +0x20
; and [bx+si],ah
; xor [bx+si],dh
; xor [bx+di],dh
; xor [bx+si],dh
; dec bx
; inc cx
; push sp
; inc dx
; inc cx
; dec cx
; push sp
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add ah,bh
; add [bp+si],al
; add ah,bh
; db 0xff
; db 0xfe
; cld
; clc
; lock out 0xe4,al
; loopne 0x9aa9
; rol al,byte 0x80
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; db 0xfe
; inc word [bx+si]
; add dh,bh
; inc word [bx+si]
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [0xc3],al
; add [0xc3],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [0xc3],bh
; add [0xc3],bh
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [0xc3],al
; add [0xc3],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [0xc3],al
; add [0xc3],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add dh,bh
; inc word [bx+si]
; add dh,bh
; inc word [bx+si]
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add dh,bh
; db 0xff
; db 0xfe
; inc word [bx+si]
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [0x6c3],al
; ret
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; ds ret
; ds ret
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; push es
; ret
; push es
; ret
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; push es
; ret
; push es
; ret
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; db 0xfe
; db 0xff
; db 0xfe
; inc word [bx+si]
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add dh,bh
; inc word [bx+si]
; add dh,bh
; inc word [bx+si]
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add al,al
; ret
; add [bx+si],al
; rol bl,byte 0x0
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add dh,bh
; ret
; add [bx+si],al
; inc bl
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; push es
; ret
; add [bx+si],al
; push es
; ret
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; mov bl,0x0
; add dh,al
; ret
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; jng 0x9c39
; add [bx+si],al
; jng 0x9c3d
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; db 0xfe
; db 0xff
; db 0xfe
; inc word [bx+si]
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add al,al
; ret
; rol bl,byte 0x0
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add dh,bh
; ret
; inc bl
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; push es
; ret
; push es
; ret
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; mov bl,0xc6
; ret
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; jng 0x9ca5
; jng 0x9ca7
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bx+si],al
; add [bp+di],al
; add [bx+si],al
; add [bp+di],al
; pop ds
; out dx,ax
; add [bx+si],al
; pop ds
; out dx,ax
; lock add [bx+si],al
; add al,dh
; add [bx+si],al
; pop es
; add [bx+si],al
; add [bx],al
; sbb [si+0x0],ch
; add [bx+si],bl
; insb
; xor [bx+si],al
; add [bx+si],al
; xor [bx+si],al
; add [bp+di],al
; add [bx+si],al
; add [bp+di],al
; sbb [si+0x0],ch
; add [bx+si],bl
; insb
; xor [bx+si],al
; add [bx+si],al
; xor [bx+si],al
; add [bp+di],al
; add [bx+si],al
; add [bp+di],al
; sbb [si+0x0],ch
; add [bx+si],bl
; insb
; xor [bx+si],al
; add [bx+si],al
; xor [bx+si],al
; add [bp+di],al
; add [bx+si],al
; add [bp+di],al
; pop ax
; insb
; add [bx+si],al
; pop ax
; insb
; xor [bx+si],al
; add [bx+si],al
; xor [bx+si],al
; add [bx],cl
; add [bx+si],al
; add [bx],cl
; fucomip st7
; add [bx+si],al
; fucomip st7
; lock add [bx+si],al
; add al,dh
; add [bx+si],al
; add ax,[bx+si]
; add ax,[bx+si]
; add [bx],bl
; out dx,ax
; pop ds
; out dx,ax
; add [bx+si],al
; lock add al,dh
; add [bx+si],al
; add [bx+si],al
; pop es
; add [bx],al
; add [bx+si],al
; sbb [si+0x18],ch
; insb
; add [bx+si],al
; xor [bx+si],al
; xor [bx+si],al
; add [bx+si],al
; add [bp+di],al
; add [bp+di],al
; add [bx+si],al
; sbb [si+0x18],ch
; insb
; add [bx+si],al
; xor [bx+si],al
; xor [bx+si],al
; add [bx+si],al
; add [bp+di],al
; add [bp+di],al
; add [bx+si],al
; sbb [si+0x18],ch
; insb
; add [bx+si],al
; xor [bx+si],al
; xor [bx+si],al
; add [bx+si],al
; add [bp+di],al
; add [bp+di],al
; add [bx+si],al
; pop ax
; insb
; pop ax
; insb
; add [bx+si],al
; xor [bx+si],al
; xor [bx+si],al
; add [bx+si],al
; add [bx],cl
; add [bx],cl
; add [bx+si],al
; fucomip st7
; fucomip st7
; add [bx+si],al
; lock add al,dh
; add [bx+si],al
; add [bx+si],al
; pop es
; add [bx+si],al
; add [bx],al
; iret
; out dx,ax
; add [bx+si],al
; iret
; out dx,ax
; lock add [bx+si],al
; add al,dh
; add [bx+si],al
; or al,0x0
; add [bx+si],al
; or al,0x6c
; or al,0x0
; add [si+0xc],ch
; xor [bx+si],al
; add [bx+si],al
; xor [bx+si],al
; add [bx+di],al
; add [bx+si],al
; add [bx+di],al
; iret
; in al,dx
; add [bx+si],al
; iret
; in al,dx
; xor [bx+si],al
; add [bx+si],al
; xor [bx+si],al
; add [bx],al
; add [bx+si],al
; add [bx],al
; add [si+0x0],ch
; add [bx+si],al
; insb
; xor [bx+si],al
; add [bx+si],al
; xor [bx+si],al
; add [si],cl
; add [bx+si],al
; add [si],cl
; or al,0x6c
; add [bx+si],al
; or al,0x6c
; xor [bx+si],al
; add [bx+si],al
; xor [bx+si],al
; add [bx],cl
; add [bx+si],al
; add [bx],cl
; imul di
; add [bx+si],al
; imul di
; lock add [bx+si],al
; add al,dh
; add [bx+si],al
; pop es
; add [bx],al
; add [bx+si],al
; iret
; out dx,ax
; iret
; out dx,ax
; add [bx+si],al
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
; in ax,0xe5
