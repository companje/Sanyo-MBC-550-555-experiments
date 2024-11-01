;cryptographic functions - key entry/generation, block chaining

Generate_Subkeys:
    ;DL = drive number
    ;Returns:  BX=Subkey address
    ;Destroys: AX, CX
    mov bx,BV.DSubkeys
    test dl,1
    jnz .drive1
    add bx,240
.drive1
    push dx
    push bx ;subkeys
    mov ax,BV.EncKey
    push ax ;key
    call rijndael_keygen
    pop ax
    pop bx
    pop dx
    ret

Enter_Key:
    ;input:  ds:di = key to be entered
    ;        es=ds
    ;output: carry set if canceled (null entry)
    ;trashed:  ax, bx, cx, si
.beginEntry
    ;first, clear buffer
    push di ;save buffer location
    mov cx,16 ;16 words
    xor ax,ax
    cld
    rep stosw
    pop di
    mov cl,4
.loopover
    xor bx,bx ;bx = pointer within the input buffer (32 bytes)
    xor ax,ax
    int 0x16 ;get keypress
    cmp al,13
    je .cancelExit
    jmp short .noread
.charlp
    xor ax,ax
    int 0x16 ;get keypress
.noread
    ;check for backspace
    cmp al,8 ;backspace
    je .beginEntry
    cmp al,13 ;enter key
    je .normalExit ;carry will be clear if taken
    xor al,[di+bx]
    rol al,cl
    mov [di+bx],al
    inc bx
    cmp bl,32
    jne .charlp
    jmp short .loopover
.cancelExit
    stc
.normalExit
    ret

Do_IV:
    ;CH = low eight bits of cylinder number
    ;CL = sector number 1-63 (bits 0-5)
    ;     high two bits of cylinder (bits 6-7, hard disk only)
    ;DH = head number
    ;SI = subkeys
    ;Direction: cleared
    ;Destroyed:  AX

    push bx
    push di
    push si ;subkey location for encrypt call

;   generate IV
    mov di,BV.EncIV
    push di ;IV location for encrypt call
    mov ax,cx
    stosw
    mov al,dh
    stosb
    xor ax,ax
    times 6 stosw
    stosb

;   encrypt IV
    ;arguments are already pushed
    call rijndael_encrypt

;   xor IV into first block
    pop si ;IV location
    lea bx,[si+16]
    call mixkey_nosetup  ;; Destroys AX, SI, and DI.
    pop si ;subkeys
    pop di
    pop bx
    ret

Encrypt_Sector:
    ;CH = low eight bits of cylinder number
    ;CL = sector number 1-63 (bits 0-5)
    ;     high two bits of cylinder (bits 6-7, hard disk only)
    ;DH = head number
    ;DL = drive number (bit 7 set for hard disk)
    push es
    push cs
    pop es
    push si
    cmp dl,1
    sbb si,si
    and si,240
    add si,BV.DSubkeys

    push bx
    push cx
    push dx
    call Do_IV ;Apply IV

    push si
    mov si,BV.SectorBuffer
.nextscr
    lea bx,[si+16]
    call mixkey_nosetup
    cmp si,BV.SectorBuffer+512-16
    jne .nextscr

    mov si,BV.SectorBuffer
.nextblock
    push si
    call rijndael_decrypt ;encrypt block (using decryption...)
    pop si


    ;xor block into next block
    ;si has current [source] position in sector
    lea bx,[si+16] ;xor to 16 bytes later
    call mixkey_nosetup ;adds 16 to SI (mix ciphertext)
    cmp si,BV.SectorBuffer+512-16
    jne .nextblock
    push si
    call rijndael_decrypt ;final block
    pop si
    pop si
    pop dx
    pop cx
    pop bx
    pop si
    pop es
    ret

Decrypt_Sector:
    ;CH = low eight bits of cylinder number
    ;CL = sector number 1-63 (bits 0-5)
    ;     high two bits of cylinder (bits 6-7, hard disk only)
    ;DH = head number
    ;DL = drive number
    push es
    push cs
    pop es
    push si
    cmp dl,1
    sbb si,si
    and si,240
    add si,BV.DSubkeys

    push bx
    push cx
    push dx
    push si

    mov si,BV.SectorBuffer+512-16
    push si
    call rijndael_encrypt
    pop si
.nextblock
    mov bx,si
    sub si,byte 16
    push si
    call mixkey_nosetup
    call rijndael_encrypt ;decrypt block (using encryption...)
    pop si
    cmp si,BV.SectorBuffer
    jne .nextblock
    mov si,BV.SectorBuffer+512-32
.nextscr
    lea bx,[si+16]
    call mixkey_nosetup
    sub si,byte 32
    cmp si,BV.SectorBuffer-16
    jne .nextscr
    pop si
    pop dx
    pop cx
    push cx
    push dx
    call Do_IV  ;Apply IV
    pop dx
    pop cx
    pop bx
    pop si
    pop es
    ret


;Plan:
;Encryption:
;   generate IV
;   encrypt IV
;   xor IV into first block
;   encrypt first block
;   xor first block into 2nd block
;   encrypt 2nd block...
;
;Decryption:
;   decrypt last block
;   xor 2nd to last block into last block
;   decrypt 2nd to last block
;   ...
;   decrypt first block
;   generate IV
;   encrypt IV
;   xor IV into first block