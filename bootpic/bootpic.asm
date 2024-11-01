Begin:  jmp short Startup
ZBL:  db 0
Label:  db "PLZWAIT",0  ;OEM Name
BPS:  dw 512    ;Bytes per Sector
SPC:  db 2    ;Sectors per Cluster
ResSec: dw 1    ;Reserved Sectors
NumFAT: db 2    ;Number of FATs
REnt: dw 112    ;Root Entries
  dw 720    ;Total Sectors
  db 0xfd   ;Media Byte
SPFAT:  dw 2    ;Sectors per FAT
SPT:  dw 9    ;Sectors per Track
HPC:  dw 2    ;Heads per Cylinder
RSBuf:  dd 0    ;Hidden Sectors

;times 6 db 0 ;FreeDOS likes these


Startup:
  cli ;no interruptions please
  cld ;copying forward would be nice
  ;Set up the stack
  mov ax,0x1000
  mov ss,ax
  mov sp,0xffff
  mov al,0x4
  out 0x10,al ;video segment 0C00

  mov al,0x98
  out 0x1c,al ;disk 0 side 0

  ;clear the screen
  mov bx,ZBL
  call DisplayStringTL  ;we use this to set up es and di
  ;al is zero from DisplayString
  mov ch,0x40 ;we go a little over here but who cares
  rep stosb

  ;let the people know who's up in this shiaaat
  call DisplayStringTL  ;bx was already set
  mov bx,txtBoot
  call DisplayString

  push cs ;segment setup fun
  pop es
  push cs
  pop ds

  mov al,0xc
  out 8,al ;seek track 0, load head, verify, 6ms step rate

  ;next, we load the FAT to :1000
  mov di,0x1000
  push di ;mmm... tasty... we save this for later!
  mov cx,[SPFAT]
  call WaitFDCReady
  mov ax,[ResSec]
LFLoop: call ReadSector
  loop LFLoop ;zeros cx

  ;the FAT is now loaded

  ;now, we read the root directory and look for the file
  ;ax will store the current directory sector
  ;cx will store the count of searched entries

  ;find first sector, cx is already zero
  mov ax,[SPFAT]
  mul byte [NumFAT]
  add ax,word [ResSec]
  mov [RSBuf],ax

  ;load a directory sector if it's a 16th entry
.sloop  ;now, find the offset
  mov bh,cl
  and bx,0xf00
  pushf
  inc bx      ;this inc turns into 0x2000
  times 3 ror bx,1  ;bx=(cx:0-3)*8+0x2000
  popf
  jnz .noload ;zero is set if cx:0-3 was zero
  mov di,bx ;di=0x2000
  call ReadSector
.noload cmp byte [bx],0 ;is it the last entry?
  je .nfe
  mov si,10 ;si is our character count for name comparison
  ;compare 11 characters
.cmplp  mov dl,[si+bx]
  cmp dl,[si+BootName]
  je .kps ;same char?

  inc cx ; next entry...
  cmp cx,[REnt]
  jna .sloop
.nfe  mov bx,txtNotFound
  call DisplayStringTL
  jmp ErrorHalt

.kps  dec si
  jns .cmplp

  ;we found it

  ;es is now loading zone
  pop si  ;we hid some 0x1000 goodness earlier
  mov es,si
  ;xor di,di
  mov di,0x100  ;simulate .com execution

  ;set up our boot vector
  push es
  push di

  ;cluster # goes in bx
  mov bx,[bx+26]

  ;find next cluster, put it in bx
.nextc  mov ax,bx ;current goes in ax

  shl bx,1  ;
  add bx,ax ;bx=ax*3/2
  shr bx,1  ;
  ;carry is set if there is a remainder
  mov bx,[bx+si]
  jnc .even
  mov cl,4
  ror bx,cl
.even and bh,0xf
  cmp ax,0xff8
  jb .cnt
  push es
  pop ds  ;hopefully this helps upx
  retf  ;boot that shizat (vector already pushed)
.cnt  dec ax
  dec ax
  ;ReadCluster section
  ;input: ax=cluster number, trashed
  ; es:di is data destination, will be incremented 1 cluster
  ;outpt: dx,bp=trashed
  ; cx=set to zero
  mov cl,[SPC] ;get sectors per cluster
  xor ch,ch
  mul cx ;multiply ax by this (need 16>32 multiply)
  mov dx,cx  ;number of sectors to load
  xchg ax,bp  ;sectors worth of clusters to skip goes in bp
  ;we also need to add all the junk from res+fat+root
  mov ax,[REnt]
  ;we assume there is no remainder here
  mov cl,4  ;this boot sector won't fit in a 256 byte
  shr ax,cl ;  sector, so I think we can hardcode this
  ;ax now has root secs to skip
  add ax,[RSBuf]  ;add on start of root sectors
  mov cx,dx
  add ax,bp ;fat+root+res+cluster
.RS call ReadSector
  loop .RS
  jmp short .nextc

ReadSector:
  ; input: es:di must be set to desired load area
  ;   ax must be set to sector number
  ;   di and ax will be incremented for the next sector
  ; Output: bp = remaining attempts
  ;   dx = 8

  ; The plan...
  ; divide by SPT.  if 2 sides, shift LSBit right - side flag
  ; remaining is the track number
  ; use sector# mod SPT for sector #

  mov bp,8  ;max read attempts + 1 (MUST BE 8)
  mov dx,bp

.retry  push ax
  push di
  div byte [SPT]  ;divide out sectors
  ;let's get those sectors out of the way right away
  xchg ah,al
  inc al  ;first sector is 1??  Flaming.
  out 0xc,al  ;set sectors
  ;ah has track+maybe side#

  cmp byte [HPC],1  ;how many sides? (actually a word! mwahaha)
  je .sets1 ;we only have one side

  ;figure out if we're on the same track/side as before
  cmp ah,[LastTrack]
  je .trok
  mov [LastTrack],ah  ;store this one

  ;the disk has 2 sides, but we need to check which we're on
  shr ah,1  ;carry now has side, ah has track

  jnc .sets1
  mov al,0x9c ;side 2
  jmp short .sets
.sets1  mov al,0x98 ;side 1
.sets out 0x1c,al

  jne .settr  ;force a track set if the side changed
  ;now we need to find out if we're on the right track
  in al,0xa
  cmp al,ah
  je .trok  ;already there
.settr  mov al,ah
  out 0xe,al  ;track# goes to data port
  mov al,0x1c
  out dx,al ;seek, load head, verify track, 6ms step
  call WaitFDCReady
  jz .trok
  ;... seek error??
  ;let's do a restore command in case the track is desynched
  mov al,0xc
  out dx,al ;seek track 0, load head, verify, 6ms step rate
.error  pop di
.errax  call CountError
  call WaitFDCReady
  pop ax
  jmp short .retry
.trok ;we got everything lined up; let's read this shit
  mov al,0x80
  out dx,al ;read sector, no side compare, no delay
  call sdelay ;delay
.wait in al,dx
  test al,2
  jz .ndata
  in al,0xe
  stosb
  jmp short .wait
.ndata  test al,1 ;are we still busy?
  jnz .wait
  ;ok, we're not busy anymore...
  test al,0x9c
  jnz .error  ;uh oh...
  pop ax  ;this was the start di
  ;sub ax,di
  ;cmp ax,-512 ;did we get 512 bytes?
  ;je .exit
  ;add ax,di
  ;xchg ax,di
  ;jmp short .errax
.exit pop ax
sdelay: inc ax  ;increment the sector
  ret

WaitFDCReady:   ;)
  ;input:  none
  ;output:al=last status from FDC
  ; zero flag is set if no RNF/seek or CRC error
  ; we should never have a lost data error in here
  call sdelay
.wait in al,8
  test al,0x81
  jnz .wait
  test al,0x18
jRet: ret

CountError:
  ;input: bp = error counter
  ;trashed: nothing
  dec bp
  jnz jRet
  mov bx,txtRead
  call DisplayStringTL
  ;do not insert anything here - routines are chained
ErrorHalt:
  mov bx,txtError
  call DisplayString
.stop jmp short .stop

DisplayStringTL:
  xor di,di
DisplayString:
  ; cs:bx = ASCIZ string location
  ; di = video memory display location
  ; other segments will be taken care of here
  ; trashed: ax, si, es, ds
  ; bx is advanced to character after null
  mov ax,0xc00
  mov es,ax
  mov ah,0xff
  mov ds,ax
.cloop  mov al,[cs:bx]
  inc bx
  or al,al
  jz jRet ;save a byte
  mov ah,8
  mul ah
  mov si,ax
  movsw
  movsw
  add di,0x11c
  movsw
  movsw
  sub di,0x120
  jmp short .cloop

txtNotFound:
  db '"'
BootName:
  db 'DSBIOS  COM" Not Found',0
txtRead:
  db "Read Error",0
txtError:
  db ".  Halted.  ",0
txtBoot:
  db "(tm) Bootloader"
LastTrack:
  db 0
times 510-$+Begin db 0xff
  db 0x55,0xaa


%assign num $-$$
times 368640-num db  0  ; rick

