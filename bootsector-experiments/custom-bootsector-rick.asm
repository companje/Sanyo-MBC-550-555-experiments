; Rick Companje, The Netherlands, March 29th, 2022

    cpu 8086
    org 0x00

    jmp code

    db 'Sanyo1.2'
    db 0x00,0x02,0x02,0x01,0x00,0x02,0x70,0x00
    db 0xd0,0x02,0xfd,0x02,0x00,0x09,0x00,0x02
    db 0x00,0x00,0x00,0x00,0x00,0x1c,0x00,0xff
    db '       Sanyo MBC-550/555        ',0x00

code:  
    mov al,0x04
    out 0x10,al
    mov ax,0x0c00
    mov es,ax
    
    mov al,0
    cld
top:
    mov cx,0x1000
    xor di,di
    ; in al,0x24
    inc al
input:
    stosb
    stosb
    stosb
    stosb
    ; add di,3
    ; loop input

    ; push ax
    ; mov ax,0xf000
    ; mov es,ax
    ; pop ax

    jmp top


    ; cli
    ; cld
    ; mov ax,cs
    ; mov ds,ax
    ; mov ss,ax
    ; mov sp,0x400
    
    ; db 0x33,0xff                         ; xor di,di
    ; db 0x33,0xf6                         ; xor si,si

    ; mov ax,0x20
    ; db 0x8E,0xC0 ; mov es,ax
    ; mov cx,0x100
    ; repz movsw

    ; push es
    ; mov ax,_0x106
    ; push ax
    ; retf

; _0x106:
;     mov ax,cs
;     mov ds,ax
;     mov ax,0
;     db 0x8E,0xC0 ; mov es,ax
;     db 0xBF,0x00,0x00 ; mov di,0
;     mov dx,0x400

;     test byte [cs:0x15],0x2
;     jnz _0x121
;     inc dh
;     inc dh
; _0x121:
;     mov cx,0x1
;     jmp _0x54
; _0x127:
;     mov ax,cs
;     mov ds,ax
;     db 0x33,0xC0  ; xor ax,ax
;     db 0x8E,0xC0  ; mov es,ax
;     db 0x8B,0xF8  ; mov di,ax
;     db 0x8B,0xD8  ; mov bx,ax
;     mov dl,0xf
; _0x135:
;     mov si,0xd1
;     jmp short _0x143
; _0x13a:
;     db 0x0A,0xDB; or bl,bl
;     jnz _0x15b
;     mov bl,0x1
; _0x140:
;     db 0xBE,0xDC,0x00  ;mov si,0xdc
; _0x143:
;     db 0x8B,0xEF  ;mov bp,di
;     mov cx,0xb
;     repe cmpsb
;     db 0x8B,0xFD ; mov di,bp
;     jz _0x13a
;     add di,byte +0x20
;     dec dl
;     jz _0x192
;     db 0x0A,0xDB  ;or bl,bl
;     jz _0x135
;     jmp short _0x140
; _0x15b:
;     mov byte [cs:0x1e],0x1
;     mov ax,0x40
;     db 0x8E,0xC0 ; mov es,ax
;     db 0xBF,0x00,0x00 ; mov di,0
;     mov ax,0x7
;     test byte [cs:0x15],0x1
;     jz _0x177
;     mov ax,0xa
; _0x177:
;     mov dl,0x8
;     test byte [cs:0x15],0x2
;     jnz _0x186
;     mov dl,0x9
;     db 0x05,0x02,0x00 ; add ax,0x2
; _0x186:
;     div dl
;     inc ah
;     db 0x8B,0xD0 ;mov dx,ax
;     mov cx,0x54
;     jmp _0x54
; _0x192:
;     db 0x2E,0x8E,0x06,0x1F,0x00 ;  mov es,[cs:0x1f]
;     db 0x33,0xC0  ; xor ax,ax
;     db 0x33,0xff                         ; xor di,di
;     mov cx,0x4000
;     rep stosw
;     mov al,0x5
;     out 0x10,al
;     mov ds,[cs:0x21]
;     mov dx,0x1b50
;     db 0x33,0xDB ; xor bx,bx
; _0x1ae:
;     db 0x2E,0x8A,0x87,0x23,0x00; mov al,[cs:bx+0x23]
;     inc bx
;     db 0x0A,0xC0 ;or al,al
; _0x1b6:
;     jz _0x1b6    ;  ??? endless loop? incorrect offset...?
;     mov cl,0x8
;     mul cl
;     db 0x8B,0xF0 ;mov si,ax
;     db 0x8B,0xFA; mov di,dx
;     mov es,[cs:0x1f]
;     mov ch,0x2
; _0x1c7:
;     mov cl,0x2
; _0x1c9:
;     lodsw   
;     mov [es:di],ax            
;     inc di    
;     inc di    
;     dec cl    
;     jnz _0x1c9        
;     add di,0x11c          
;     dec ch    
;     jnz _0x1c7        
;     add dx,byte +0x4              
;     jmp short _0x1ae              
;     loopne 0x16b     ; incorrect address...?                                     
;     inc si    
;     db 0xf0,0x8b,0x46,0xf4       ; lock mov ax,[bp-0xc]                  
;     mov cl,0x7        
;     shr ax,cl       
;     mov [bp-0xe],ax             
;     push word [bp-0x14]                 
;     mov bl,[0x160e]             
;     mov bh,0x0        
;     shl bx,1      
;     push word [bx+0xa2e]                  
;     ; call 0x0000:0x000a                                ; call IO.SYS  ?      
;     db 0x9a,0x0a,0x00   ; missing two bytes here for call . Are those bytes in IO.SYS?

incbin "Sanyo-MS-DOS-2.11-minimal.img",($-$$)  ; include default disk image skipping first 512 bytes

