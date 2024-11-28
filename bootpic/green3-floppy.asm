org 0
cpu 8086

RED   equ 0xf000
GREEN equ 0x1c00
BLUE  equ 0xf400
COLS  equ 72

ROM equ 0xFE00
FONT equ 0xFF00

LINES_PER_ROW equ 4
COLS_PER_ROW equ 72

; DISK_STATUS equ 0x08
; DISK_CMD equ 0x08
; DISK_SECTOR equ 0x0C
; DISK_DATA equ 0x0E

; SEG_DST equ 0x0038
; SEG_DST equ RED

PPI equ 0x1E

jmp setup

db 'Sanyo1.2',2,0,1,0,0,2,112,0,0,0,2,0,253,2,0,9,0,2,0

; row: db 0
; col: db 0

setup:
  mov ax,RED
  mov es,ax                  ; segment for data from floppy
  xor di,di

DISK_STATUS equ 0x08
DISK_CMD equ 0x08
DISK_TRACK equ 0x0A
DISK_SECTOR equ 0x0C
DISK_DATA equ 0x0E

DISK_DRIVE equ 0x1C

cli
cld

mov al,0x98
out PPI,al                  ; PPI control: 0b10011000 (0x98) 'strobe'

mov al,4
  out DISK_DRIVE,al          ; set drive/head

  mov al,1
  out DISK_SECTOR,al          ; set sector
  times 4 aam                 ; delay


mov cx,2
readAllSectors:
  

  mov al,cl
  out DISK_DATA,al            ; set track
  times 4 aam                 ; delay

  

; wait1:
;   in al,DISK_STATUS
;   and al,0xff
;   jz wait1


  mov al,0x80                 ; read sector (to buffer of floppy controller?)
  out DISK_CMD,al
  ; times 4 aam                 ; delay

  call readSector

  loop readAllSectors

hlt

readSector:
  push cx
  mov cx,512
  loadByte:
    in al,DISK_DATA
    ; in al,DISK_STATUS
    stosb
    times 4 aam                 ; delay
    loop loadByte
  pop cx
  ret


%assign num1 $-$$
times 368640-num1 db 0

; db 1

; _1E4A:
;   mov al,0xD8
;   out DISK_CMD,al           ; floppy command: 0b11011000 (0xD8)

;   mov al,0x98
;   out PPI,al                ; PPI control: 0b10011000 (0x98) 'strobe'

; _1E52:
; mov ax,0xffff
;   stosw
;   stosw

;   in al,DISK_STATUS         ; floppy status
;   test al,0x01
;   jnz _1E52                 ; loop until bit 1 is high

; _1E58:
;   mov al,0x08
;   out DISK_CMD,al           ; floppy command 0b00001000
;   aam                       ; wait?
;   aam                       ; wait?
;   aam                       ; wait?
;   aam                       ; wait?

; _1E64:
;   in al,DISK_STATUS          ; floppy status dx=0x08
;   test al,0x01
;   jnz _1E64                  ; wait until bit 1 is high
;   test al,0x80
;   jnz _1E58                  ; wait until bit 7 is high

; _1E6E:
;   cld                        ; clear direction flag
;   mov al,0x01
;   out DISK_SECTOR,al         ; floppy set sector bit 1
  
  
  
;   mov dx,DISK_STATUS              ; used to read floppy status
;   mov si,_1EA0               ; used for local jmp later on
  
;   mov bh,0
;   mov ah,0
;   mov al,0
;   out DISK_CMD,al            ; floppy
  
;   aam
;   aam
;   aam
;   aam



; _1E91:
  

;   in al,dx
;   ; in al,DISK_STATUS              ; floppy status dx=0x08
;   sar al,1

;   jnc _1EB2            ; floppy
;   jnz _1E91            ; floppy

 
  
  

;   ; mov cx,10*2*72
;   ; rep stosw

;   ; hlt


; _1E98:
;   in al,dx              ; floppy dx=0x08
;   and al,bh             ; bit 2 (?)
;   jz _1E98  

; _1E9D:
;   in al,DISK_DATA            ; read data from floppy
;   stosb                 ; store in es:di++    

; _1EA0:
;   in al,dx              ; floppy dx=0x08
;   dec ax
;   cmp al,bh             ; bh = 2 ?
;   jnz _1EB2

; _1EA8:
;   in al,DISK_DATA            ; read data from floppy
;   stosb                 ; store in es:di++

;   in al,dx
;   cmp al,bh
;   jz _1EA8

; _1EB0:
; ; hlt
;   jmp si                ; jump to 0x1EA0

; _1EB2:
  
;   mov ax,0xff00
;   stosw
;   stosw

;   ; in al,dx              ; floppy status dx=0x08
;   ; test al,0x1C           
;   ; jnz _1E52            ; floppy status

; _1EBC:
  

;   ; jmp 0x0038:0
;   ; hlt


; img: 
  ; incbin "zwembad.jpg"

%assign num $-$$
times 368640-num db  0