; Disassembling the Sanyo MBC-555 MS-DOS 2.11 floppy bootsector
; Rick Companje, The Netherlands, March 28th, 2022 + November 2024
; reconstructed using ndisasm 
; ndisasm -b16 empty-base.img > tmp.lst                 # this is for disassembling most of the code
; ndisasm -b16 -e 68 -o 68 empty-base.img  >  tmp2.lst  # this part is for the code at 0x44
; analysed using MAME debugger

cpu 8086
org 0x00

PORT_DISK_STATUS equ 0x08
PORT_DISK_CMD equ 0x08
PORT_DISK_SECTOR equ 0x0C
PORT_DISK_DATA equ 0x0E
PORT_DISK_CONTROL equ 0x1C     ; 1C: parallel/drive control
PORT_VIDEO_PAGE equ 0x10

SCREEN_CENTER equ 0x1b50

jmp begin

db 'Sanyo1.2'

;OB: 00 02   ; bytes per sector
;0D: 02      ; sectors per cluster
;0E: 01 00   ; reserved sectors
;10: 02      ; number of FATs
;11: 70 00   ; max number of root dir
;13: D0 02   ; total sector count
;15: FD      ; ignore
;16: 02 00   ; sectors per FAT
;18: 09 00   ; sectors per track
;1A: 02 00   ; number of heads
;1C: 00      ; -
;1D: 00      ; -
;1E: 00      ; -
;1F 00 1C    ; GREEN PLANE
;21: 00 FF   ; FONT

_0x0b:dw 512     ; bytes per sector
_0x0d:db 2       ; sectors per cluster
_0x0e:dw 256     ; reserved sectors
_0x10:db 2       ; number of FATs
_0x11:dw 112     ; max number of root directory entries (0x70)
_0x13:dw 720     ; total sector count

_0x15:db 0xfd    ; ??? 'ignore according to docs' but used for something: maybe FAT ID 0xFD to indicate 360 KB?
_0x16:dw 2       ; sectors per FAT
_0x18:dw 9       ; sectors per track
_0x1a:dw 2       ; number of heads

_0x1c:db 0       ; -
_0x1d:db 0       ; -
_0x1e:db 0       ; - used but for what? is set to 1 

; used by bootsector code: 0x15, 0x1e, 0x18

GREEN_PLANE: dw 0x1c00
FONT: dw 0xff00
BOOT_ERROR: db '     .SYS file(s) not found     ',0x00

_0x44:
    inc dh
    mov ax,[cs:_0x18]      ; sectors per track ?
    inc al
    cmp dh,al
    jc _0x76
    mov dh,1
    inc dl
_0x54:
    mov al,dl
    test byte [cs:_0x15],1  ; 0xFD & 1 ?  check FAT ID ? 0xFD / 11111101 ???
    jz _0x60
    shr al,1   ; divide al by 2 ?
_0x60:
    ; al=0x61 ??
    out PORT_DISK_DATA,al                       ; 0xE  set track number?
    mov al,0x18
    out PORT_DISK_CMD,al                        ; floppy command

    mov al,0
    jnc setDiskControl
    mov al,4
setDiskControl:
    out PORT_DISK_CONTROL,al                    ; 0 of 4
    aam
_0x70:
    in al,PORT_DISK_STATUS                      ; floppy status
    test al,1
    jnz _0x70
_0x76:
    mov al,dh
    out PORT_DISK_SECTOR,al                     ; floppy set sector
    
    mov bp,dx
    mov dx,0x8                                  ; prepare dx=8 for reading disk status with in al,dx
    mov si,0xa5
    mov bh,0x2
    mov bl,0x96
    mov ah,0x0

    mov al,0x80
    out PORT_DISK_CMD,al
    mov sp,di
    times 4 aam      ; delay
_0x96:
    in al,dx         ; dx=8  get disk status
    sar al,1
    jnc _0xb7
    jnz _0x96
_0x9d:
    in al,dx
    and al,bl
    jz _0x9d
    in al,PORT_DISK_DATA
    stosb
_0xa5:
    in al,dx          ; dx=8  get disk status
    dec ax
    jz _0xa5
    cmp al,bh
    jnz _0xb7
_0xad:
    in al,PORT_DISK_DATA
    stosb
    in al,dx           ; dx=8  get disk status
    cmp al,bh
    jz _0xad
    jmp si
_0xb7:
    in al,dx           ; dx=8  get disk status
    mov dx,bp
    test al,0x1c
    jz _0xc2
    mov di,sp
    jmp short _0x76
_0xc2:
    loop _0x44
    test byte [cs:_0x1e],1

    jz _0x127   ; as long as there's no 1 at cs:0x1e repeat loading IO.SYS ?

    jmp 0x40:0

_FILENAME_IO_SYS:    
    db 'IO      SYS'

_FILENAME_MSDOS_SYS: 
    db 'MSDOS   SYS'

begin:  ; copies the bootsector to 0020:0000 and continues there
    cli
    cld
    mov ax,cs
    mov ds,ax         
    mov ss,ax         
    mov sp,0x400
    
    xor di,di         
    xor si,si         
    mov ax,0x20
    mov es,ax         ; ES destination segment 0x20
    mov cx,0x100      ; 
    repz movsw        ; copy 0x100 words (512 bytes) from DS:SI to ES:DI

    push es           ; put 0020 (segment) on the stack
    mov ax,begin2
    push ax           ; put 0106 (offset) on the stack
    retf              ; 'jump' to 0020:0106

; it continues here but now the bootsector code has been moved to 0020:0106
begin2:               
    mov ax,cs
    mov ds,ax
    mov ax,0
    mov es,ax
    mov di,0
    mov dx,0x400      ; stack?

    test byte [cs:_0x15],2  ;  0xFD (11111101 & 2) ?
    jnz _0x121
    inc dh
    inc dh     ; now dx=0x600
_0x121:
    mov cx,1
    jmp _0x54
_0x127:
    mov ax,cs
    mov ds,ax
    xor ax,ax
    mov es,ax
    mov di,ax
    mov bx,ax
    mov dl,0x0f    ; now dx=0x60f

_find_IO_SYS:
_0x135:
    mov si, _FILENAME_IO_SYS
    jmp short _filenameCompare
_0x13a:
    or bl,bl
    jnz _0x15b
    mov bl,1
_find_MSDOS_SYS:
    mov si, _FILENAME_MSDOS_SYS
_filenameCompare:
    mov bp,di
    mov cx,0xb           ; 11 characters 'FILENAMEEXT'
    repe cmpsb           ; compares string at SI with DI. it searches for IO.SYS of MSDOS.SYS in the directory
    mov di,bp
    jz _0x13a
    add di,byte +0x20    ; skip 32 bytes (date, filesize, attributes etc) to check the next filename in the directory
    dec dl
    jz _printBootError
    or bl,bl    
    jz _find_IO_SYS
    jmp short _find_MSDOS_SYS

_0x15b:
    mov byte [cs:_0x1e],1      ; write 1 to cs:001e
    mov ax,0x40                ; segment where IO.SYS gets loaded
    mov es,ax
    mov di,0                   ; offset for IO.SYS
    mov ax,7
    test byte [cs:_0x15],1     ; 0xFD (11111101 & 1) ?
    jz _0x177
    mov ax,0xa
_0x177:
    mov dl,8
    test byte [cs:_0x15],2     ; 0xFD (11111101 & 2) ?
    jnz _0x186
    mov dl,9
    add ax,2
_0x186:                        ; dl is 8 or 9 here? based on the value at 0x15
    div dl
    inc ah
    mov dx,ax
    mov cx,0x54
    jmp _0x54


_printBootError:
    mov es,[cs:GREEN_PLANE]      ; segment green video plane
    xor ax,ax                    
    xor di,di                    ; left top on screen
    mov cx,0x4000
    rep stosw                    ; clear screen by putting 16k of zeroes at ES:DI
    mov al,5
    out PORT_VIDEO_PAGE,al       ; select green page 0x5 - address 0x1C000(?) 
    mov ds,[cs:FONT]             ; segment of font in ROM
    mov dx,SCREEN_CENTER         ; center of the screen for ES:DI
    xor bx,bx
_0x1ae:
    mov al,[cs:bx+BOOT_ERROR]    ; boot error text: '.SYS file(s) not found'
    inc bx
    or al,al                     ; if al=0 then...

_haltAfterPrintBootError:
    jz _haltAfterPrintBootError  ;  ...then halt else continue

    ;continue if more letters of the boot error are to be printed
    mov cl,8
    mul cl                       ; multiply ax by 8: get character from FONT table (8 bytes per char)
    mov si,ax
    mov di,dx                    ; position on the screen 0x1b50 is center
    mov es,[cs:GREEN_PLANE]      ; segment green video plane
    mov ch,2
_writeHalfChar:
    mov cl,2
_writeQuarterChar:
    lodsw                        ; load char from FONT table
    mov [es:di],ax            
    inc di    
    inc di                       ; write 2 lines of the char the char (2 bytes) to the screen
    dec cl    
    jnz _writeQuarterChar        ; repeat next 2 lines of the char
    add di,0x11c                 ; goto to next row of 4 lines to print bottom part of the char
    dec ch    
    jnz _writeHalfChar           ; write bottom part of the char to the screen




    add dx,byte +0x4              
    jmp short _0x1ae              
    loopne 0x16b               ; incorrect address...?                                     
    inc si    
    db 0xf0                    ; ????? debug.com shows 'LOCK'
    mov ax,[bp-0xc]                  
    mov cl,7        
    shr ax,cl       
    mov [bp-0xe],ax             
    push word [bp-0x14]                 
    mov bl,[0x160e]             
    mov bh,0        
    shl bx,1
    push word [bx+0xa2e]                  
    ; call 0x0000:0x000a       ; call IO.SYS  ?      
    db 0x9a,0x0a,0x00          ; missing two bytes here for call . Are those bytes outside the bootsector?

; %assign num $-$$
; times 368640-num db 0

incbin "Sanyo-MS-DOS-2.11-minimal.img",($-$$)  ; include default disk image skipping first 512 bytes




