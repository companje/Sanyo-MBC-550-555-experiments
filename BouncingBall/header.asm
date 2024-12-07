org 0
cpu 8086

RED   equ 0xf000
GREEN equ 0x1c00
BLUE  equ 0xf400
COLS  equ 72
DST   equ 0x38 ; 7F5h                ; absolute addres: 32592
NUM_SECTORS equ 9  ; 160 ... 360k met 2 sectors per KB    ; number of sectors for your user code
XD    equ 4
YD    equ COLS*XD