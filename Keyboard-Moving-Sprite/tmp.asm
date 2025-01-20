
  ; push ax
  ; push bx
  ; push cx
  ; push dx
  ; push si
  ; push di
  ; push bp
  ; push ds
  ; push es

  ; mov al,'x'


  ; push ax
  ; mov ax,GREEN
  ; mov es,ax
  ; mov ax,FONT
  ; mov ds,ax
  ; pop ax


  ; mov ah,8
  ; mul ah        ; ax=al*ah
  ; mov si,ax
  ; movsw
  ; movsw
  ; add di,0x11c
  ; movsw
  ; movsw
  ; mov bx,288
  ; sub di,bx


  ; ; xor di,di
  ; ; print "x"
  ; ; call write_char

  ; ; set_cursor 2,5
  ; ; print "atan(426)="
  ; ; mov ax,426
  ; ; call atan
  ; ; call write_number_word
  ; ; mov al,'x'
  ; ; call write_char

  ; hlt


  ; pop es
  ; pop ds
  ; pop bp
  ; pop di
  ; pop si
  ; pop dx
  ; pop cx
  ; pop bx
  ; pop ax

  ; iret
  ; mov al,3
  ; jmp int_msg