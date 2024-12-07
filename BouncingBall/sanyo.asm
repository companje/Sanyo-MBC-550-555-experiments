%include "header.asm"

jmp bootloader

db 'RickyboyII',1,0,0,2,112,0,0,0,2,0,253,2,0,9,0,2,0  ; 2,0, is replaced by II

bootloader:
  cli
  cld

  mov ax, GREEN     ; green segment
  mov es, ax
  mov di, 0
  mov ax, 0
  mov cx, 2000h
  rep stosw         ; clear screen
  mov al, 5
  out 10h, al       ; set green video page
  
  ; hlt

  mov ax, cs
  mov ds, ax
  mov ax, DST       ; was 7F5h, destination segment for floppy data
  mov es, ax
  mov di, 0

  mov dl, 0         ; track=0 (was 1!)
  mov dh, 1         ; sector=1
  mov cx, NUM_SECTORS ;48h       ; read 48h (72) sectors (36864 bytes)
  jmp move_head

next_sector:
  inc dh                    ; sector++
  cmp dh, 9
  jb  read_sector           ; if (dh<9) read_sector
  mov dh, 1
  inc dl                    ; else track++ ; sector=1

move_head:
  mov al, dl
  out 0Eh, al               ; set track number
  mov al, 18h     
  out 8, al                 ; seek track, load head
  mov al, 0
  out 1Ch, al               ; set desired drive/side
  aam

.head_moving
  in al, 8
  test al, 1
  jnz .head_moving

read_sector:
  mov al, dh
  out 0Ch, al               ; sector number
  mov bp, dx                ; save dx. we use it tmp for status request
  mov dx, 8

  mov bh, 2                 ; 00000010b
  mov bl, 96h               ; 10010110b

  mov ah, 0
  mov al, 80h
  out 8, al                 ; read sector
  mov sp, di                ; save di. we should not be using push/pop from now on
  times 4 aam               ; wait

check_status_1:
  in  al, dx                ; read status
  sar al, 1                 ; status/=2
  jnb check_status_3
  jnz check_status_1

wait_for_data:
  in  al, dx                ; read status
  and al, bl                ; 96h
  jz  wait_for_data

store_byte_1:
  in  al, 0Eh
  stosb

check_status_2:
  in  al, dx                ; read status
  dec ax                    ; status--
  jz  check_status_2        ; if (status==0) repeat
  cmp al, bh                ; bh=2
  jnz check_status_3        ; if (status==1) 

store_byte_2:
  in  al, 0Eh
  stosb

check_status_4:
  in  al, dx                ; read status
  cmp al, bh                ; bh=2
  jz  store_byte_2          ; if (status==2) repeat
  jmp check_status_2        ; else: was jmp SI

; ───────────────────────────────────────────────────────────────────────────

check_status_3:
  in  al, dx                ; read status
  mov dx, bp                ; restore dx
  test  al, 1Ch             ; 00011100
  jz  while_sectors
  mov di, sp                ; restore di
  jmp read_sector

; ───────────────────────────────────────────────────────────────────────────

while_sectors:
  loop next_sector

done_reading:
  mov ax,0
  mov ss,ax
  mov sp,0

  push cs
  pop ds
  jmp setup                 ; important to jmp to allow variables above setup


times (512)-($-$$) db 0



