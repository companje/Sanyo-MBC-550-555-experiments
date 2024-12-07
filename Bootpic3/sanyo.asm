org 0
cpu 8086

NUM_SECTORS equ 40          ; number of sectors to read
BAR_WIDTH equ 30
COLS  equ 72
ROWS  equ 50
LINES equ 200
CENTER equ COLS*LINES/2+COLS*4/2
RED   equ 0xf000
GREEN equ 0x1c00
BLUE  equ 0xf400
DST   equ 0x38              ; absolute addres: 32592
XD    equ 4
YD    equ COLS*XD

boot:
  cli
  cld
  call clear_green          
  mov al, 5
  out 10h, al               ; select address 0x1c000 as green video page
  mov ax,GREEN      
  mov ds,ax                 ; GREEN video segment used for progress bar
  mov ax,DST                
  mov es,ax                 ; DST segment used for storing data read from disk
  mov di,0                  ;
  mov dl,0                  ; track=0
  mov dh,1                  ; sector=1
  mov cx,NUM_SECTORS        ; read 48h (72) sectors (36864 bytes)
  jmp move_head

; ───────────────────────────────────────────────────────────────────────────

next_sector:
  inc dh                    ; sector++
  cmp dh,10
  jb read_sector           ; if (dh<9) read_sector
  mov dh,1
  inc dl                    ; else track++ ; sector=1

move_head:
  mov al,dl
  out 0Eh,al               ; set track number
  mov al,18h     
  out 8,al                 ; seek track, load head
  mov al,0
  out 1Ch,al               ; set desired drive/side
  aam

head_moving:
  in al,8
  test al,1
  jnz head_moving

read_sector:
  mov al,dh
  out 0Ch,al                ; sector number
  mov bh,2                  ; 00000010b
  mov bl,96h                ; 10010110b
  mov ah,0
  mov al,80h
  out 8,al                  ; read sector
  times 4 aam               ; wait

check_status_1:
  in al,8                   ; read status
  sar al,1                  ; status/=2
  jnb check_status_3
  jnz check_status_1

wait_for_data:
  in al,8                   ; read status
  and al,bl                 ; 96h
  jz wait_for_data

store_byte_1:
  in al,0Eh
  stosb

check_status_2:
  in al,8                   ; read status
  dec ax                    ; status--
  jz check_status_2         ; if (status==0) repeat
  cmp al, bh                ; bh=2
  jnz check_status_3        ; if (status==1) 

store_byte_2:
  in al,0Eh  
  stosb

check_status_4:
  in al,8                   ; read status
  cmp al, bh                ; bh=2
  jz store_byte_2           ; if (status==2) repeat
  jmp check_status_2        ; else: was jmp SI

; ───────────────────────────────────────────────────────────────────────────

check_status_3:
  in al, 8                  ; read status
  test al, 1Ch              ; 00011100
  jz while_sectors
  jmp read_sector

; ───────────────────────────────────────────────────────────────────────────

while_sectors:
  call progress_bar
  loop next_sector

done_reading:
  push cs
  pop ss
  mov sp,0
  call clear_green
  push cs
  pop ds
  jmp setup

; ───────────────────────────────────────────────────────────────────────────

progress_bar:
  ;dit kan veel korter als NUM_SECTORS een vaste waarde heeft.
  push dx
  push bx
  xor dx,dx
  mov ax,BAR_WIDTH
  mov bx,NUM_SECTORS    
  mul cx
  div bx
  pop bx
  pop dx
  mov si,ax                 ; ax is nu 0..BAR_WIDTH
  shl si,1                  ; *=2
  shl si,1                  ; *=2  
  mov bp,CENTER+BAR_WIDTH*2
  sub bp,si
  mov byte [ds:bp],-1
  ret

clear_green:
  mov cx,COLS*ROWS*2
  mov ax,GREEN
  mov es,ax
  xor di,di
  xor ax,ax
  rep stosw         ; clear screen
  ret

; ───────────────────────────────────────────────────────────────────────────

times (512)-($-$$) db 0

