org 0
cpu 8086

H equ 50      ; 50x4 lines = 200px
W equ 72    ; =COLS
WH equ W*H
; RED   equ 0xf000
; GREEN equ 0x0c00  ;; 1=0x0c00 2=0x1c00, 3=0x2c00, 4=0x3c00 ????
; BLUE  equ 0xf400

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
    db 0     ; ? Number of heads   (now first byte of sine table)
    db 9     ; ? Number of heads  
    dw 512   ; Number of hidden sectors

%include "1.asm"

times 368640-($-$$) db 0   ;fill up floppy

