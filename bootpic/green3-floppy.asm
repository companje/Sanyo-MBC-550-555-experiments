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

mov al,0x98
out PPI,al                ; PPI control: 0b10011000 (0x98) 'strobe'


MOV AX, RED         ; Zet de segment van de schermbuffer
MOV ES, AX          ; Zet ES naar 0xF400 (segment voor buffer)
XOR DI, DI          ; Zet offset in de buffer op 0

MOV AL, 0           ; Selecteer Track 0
OUT DISK_TRACK, AL  ; Schrijf track naar floppy controller

MOV AL, 1           ; Selecteer Sector 1
OUT DISK_SECTOR, AL ; Schrijf sector naar floppy controller

MOV AL, 0x80        ; Commando: Read sector
OUT DISK_CMD, AL    ; Start lezen

.wait_read:
IN AL, DISK_STATUS  ; Lees de status
TEST AL, 0x01       ; Controleer of data beschikbaar is
JZ .wait_read       ; Wacht tot de data beschikbaar is

MOV CX, 512         ; Sector grootte: 512 bytes
.read_byte:
IN AL, DISK_DATA    ; Lees een byte van de floppy
MOV [ES:DI], AL     ; Sla de byte op in de buffer
INC DI              ; Verhoog de offset
LOOP .read_byte     ; Herhaal totdat de sector gelezen is

HLT                 ; Stop de uitvoering




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


img: 
  incbin "zwembad.jpg"

%assign num $-$$
%warning num

times 368640-num db  0