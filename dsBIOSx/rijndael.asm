    ;; Rijndael Encryption Algorithm, in 80186/286 assembler, version 1.2b
    ;; Copyright (C) 2000 Rafael R. Sevilla
    ;; (Modified 2005 by Brad Normand for optimization and use in dsBIOS)
    ;;
    ;; This library of encryption routines is free software; you can
    ;; redistribute it and/or modify it under the terms of the GNU Lesser
    ;; General Public License as published by the Free Software Foundation;
    ;; either version 2 of the License, or (at your option) any later
    ;; version.
    ;;
    ;; This Rijndael Encryption code is distributed in the hope it will
    ;; be useful, but WITHOUT ANY WARRANTY; without even the implied
    ;; warranty of MERCHANTIBILITY or FITNESS FOR A PARTICULAR PURPOSE.
    ;; See the GNU Lesser General Public License for more details.
    ;;
    ;; You should have received a copy of the GNU Lesser General Public
    ;; License along with this Rijndael Encryption code; see the file
    ;; COPYING.LIB.  If not, write to the Free Software Foundation, Inc.,
    ;; 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
    ;;
    ;; Note that the only 80186 instructions here are shr/shl instructions
    ;; with multibit counts, and these only appear in the key expansion
    ;; function.  (These instructions have been changed to 8086 compatable
    ;; equivalents -Brad)
    ;;
    ;; Heavy restructuring and optimization has been done to increase speed
    ;; on 8086 type machines - Brad
    ;;
    ;; The modification here has incorporated a few changes suggested by
    ;; Robert G. Durnal (afn21533@afn.org), and a major bugfix in the
    ;; key generation code.
    ;;
    ;; Rijndael was developed by Joan Daemen and Vincent Rijmen
    ;;
CPU 186 ;actually 8086, but dsBIOS needs this

;SECTION    .data   ;(For the dsBIOS project, CS=DS -Brad)

    ;; S-box for Rijndael
sbox:
%ifdef rijndael_empty_data  ;dsBIOS generates these at boot
    times 256 db 0
%else
    db   99, 124, 119, 123, 242, 107, 111, 197,  48,   1, 103,  43
    db  254, 215, 171, 118, 202, 130, 201, 125, 250,  89,  71, 240
    db  173, 212, 162, 175, 156, 164, 114, 192, 183, 253, 147,  38
    db   54,  63, 247, 204,  52, 165, 229, 241, 113, 216,  49,  21
    db    4, 199,  35, 195,  24, 150,   5, 154,   7,  18, 128, 226
    db  235,  39, 178, 117,   9, 131,  44,  26,  27, 110,  90, 160
    db   82,  59, 214, 179,  41, 227,  47, 132,  83, 209,   0, 237
    db   32, 252, 177,  91, 106, 203, 190,  57,  74,  76,  88, 207
    db  208, 239, 170, 251,  67,  77,  51, 133,  69, 249,   2, 127
    db   80,  60, 159, 168,  81, 163,  64, 143, 146, 157,  56, 245
    db  188, 182, 218,  33,  16, 255, 243, 210, 205,  12,  19, 236
    db   95, 151,  68,  23, 196, 167, 126,  61, 100,  93,  25, 115
    db   96, 129,  79, 220,  34,  42, 144, 136,  70, 238, 184,  20
    db  222,  94,  11, 219, 224,  50,  58,  10,  73,   6,  36,  92
    db  194, 211, 172,  98, 145, 149, 228, 121, 231, 200,  55, 109
    db  141, 213,  78, 169, 108,  86, 244, 234, 101, 122, 174,   8
    db  186, 120,  37,  46,  28, 166, 180, 198, 232, 221, 116,  31
    db   75, 189, 139, 138, 112,  62, 181, 102,  72,   3, 246,  14
    db   97,  53,  87, 185, 134, 193,  29, 158, 225, 248, 152,  17
    db  105, 217, 142, 148, 155,  30, 135, 233, 206,  85,  40, 223
    db  140, 161, 137,  13, 191, 230,  66, 104,  65, 153,  45,  15
    db  176,  84, 187,  22
%endif

    ;; Inverse S-box for Rijndael
isbox:
%ifdef rijndael_empty_data
    times 256 db 0
%else
    db   82,   9, 106, 213,  48,  54, 165,  56, 191,  64, 163, 158
    db  129, 243, 215, 251, 124, 227,  57, 130, 155,  47, 255, 135
    db   52, 142,  67,  68, 196, 222, 233, 203,  84, 123, 148,  50
    db  166, 194,  35,  61, 238,  76, 149,  11,  66, 250, 195,  78
    db    8,  46, 161, 102,  40, 217,  36, 178, 118,  91, 162,  73
    db  109, 139, 209,  37, 114, 248, 246, 100, 134, 104, 152,  22
    db  212, 164,  92, 204,  93, 101, 182, 146, 108, 112,  72,  80
    db  253, 237, 185, 218,  94,  21,  70,  87, 167, 141, 157, 132
    db  144, 216, 171,   0, 140, 188, 211,  10, 247, 228,  88,   5
    db  184, 179,  69,   6, 208,  44,  30, 143, 202,  63,  15,   2
    db  193, 175, 189,   3,   1,  19, 138, 107,  58, 145,  17,  65
    db   79, 103, 220, 234, 151, 242, 207, 206, 240, 180, 230, 115
    db  150, 172, 116,  34, 231, 173,  53, 133, 226, 249,  55, 232
    db   28, 117, 223, 110,  71, 241,  26, 113,  29,  41, 197, 137
    db  111, 183,  98,  14, 170,  24, 190,  27, 252,  86,  62,  75
    db  198, 210, 121,  32, 154, 219, 192, 254, 120, 205,  90, 244
    db   31, 221, 168,  51, 136,   7, 199,  49, 177,  18,  16,  89
    db   39, 128, 236,  95,  96,  81, 127, 169,  25, 181,  74,  13
    db   45, 229, 122, 159, 147, 201, 156, 239, 160, 224,  59,  77
    db  174,  42, 245, 176, 200, 235, 187,  60, 131,  83, 153,  97
    db   23,  43,   4, 126, 186, 119, 214,  38, 225, 105,  20,  99
    db   85,  33,  12, 125
%endif

;SECTION    .text   ;(see note above -Brad)

    ;; small procedure to mix keys.  CX must point to round key offset.
    ;; Destroys AX, SI (nosetup adds 16 to SI), and DI.  Clears direction.
mixkey:
    cld
    mov si,[bp+6]   ; base address of round keys
    add si,cx       ; make si address of current round key
    mov bx,[bp+4]   ; load cipher state address
mixkey_nosetup:
    lodsw           ; load first word BEFORE finding offset
    sub bx,si       ; bx is the offset between the round key and state
    %rep 7
      xor [si+bx],ax
      lodsw
    %endrep
    xor [si+bx],ax
    ret

xlat_rotate:
    ;bx must point to translation table (sbox or isbox)
    ;if carry=1, rotate to right.  if carry=0, rotate left.
    ;destroys ax, dx, si, and di
    mov si,[bp+4]   ; load cipher state address
    mov di,si

    ;translate row 0 right away
    %rep 2
      lodsw
      xlatb
      xchg ah,al
      xlatb
      xchg ah,al
      stosw
    %endrep

    jc  .forward
    std     ;process backward
    add     si,byte 10 ;position at end of block
    mov     di,si
.forward

    ;; Rotate (cyclically shift) row 1 by one, row 2 by two and row 3
    ;; by three.

    ;load row 1 (or 3 backwards)
    lodsw
    xchg    ax,dx
    lodsw
    ;translate and rotate right by 1
    xlatb ;byte 1
    xchg    ah,al
    xlatb ;byte 0
    xchg    dl,al
    xlatb ;byte 3
    xchg    dh,al
    xlatb ;byte 2
    ;store row 1 back (the loading order has shifted it by 2)
    stosw
    xchg    ax,dx
    stosw

    ;load row 2
    lodsw
    xlatb ;byte 1
    xchg    ah,al
    xlatb ;byte 0
    xchg    ah,al
    xchg    ax,dx
    lodsw
    xlatb ;byte 3
    xchg    ah,al
    xlatb ;byte 2
    xchg    ah,al
    ;store row 2 back (the loading order has shifted it by 2)
    stosw
    xchg    ax,dx
    stosw

    ;load row 3 (or 1 backwards) into ax:dx
    lodsw           ; first half of row
    xchg    ax,dx       ; lives in DX
    lodsw           ; second half of row lives in AX
    ;translate and rotate row 1 left by 1 (right by 3)
    xlatb ;byte 1
    xchg    dh,al
    xlatb ;byte 2
    xchg    dl,al
    xlatb ;byte 3
    xchg    ah,al
    xlatb ;byte 0
    ;store row 3 back
    stosw           ; store first half of row
    xchg    ax,dx       ; make ax the second
    stosw           ; store second half of row
    ;cld        ;mixkey clears direction flag
    ret


;   global  _rijndael_encrypt   ;(don't need globals -Brad)
rijndael_encrypt:
    push    bp
    mov bp,sp
    push    si
    push    di
    xor cx,cx
    call    mixkey
    mov cl,16       ; round key offset (16*round_number)
.round_top:
    mov bx,sbox     ; translate using sbox
    stc         ; rotate right
    call xlat_rotate    ; translate and rotate

    cmp cl,224  ;was cx ; are we at round 14 (16*14)?
    je  .finalize   ; yes, jmp
    ;; Do the MixColumn transformation.
    mov di,4        ; column loop counter
    mov si,[bp+di];di=4 ; load the address of the state
    ;push    bp
    push    cx      ; save cx
.do_mixcolumn:
    mov cl,[si]     ; zeroth byte of column
    mov dl,[si+4]   ; first byte of column
    mov ch,[si+8]   ; second byte of column
    mov dh,[si+12]  ; third byte of column
    mov bp,cx       ; save a[j] and a[j+8] to xor with
    mov ax,cx       ; let ax = tmp,tmp
    xor ax,dx
    xor ah,al
    mov al,ah       ; tmp is set up
    xor cx,dx       ; xor with a[j+4], a[j+12]

    shl cl,1        ; xtime a[j] and a[j+8]
    sbb bl,bl
    shl ch,1
    sbb bh,bh
    and bx,0x1b1b
    xor cx,bx       ; xtime done
    xor cx,ax       ; xor with tmp

    xchg dh,dl  ; byteswap a[j+4], a[j+12] to line up for xor
    xor dx,bp   ; xor with saved a[j+8], a[j]

    shl dl,1    ; xtime these two bytes
    sbb bl,bl
    shl dh,1
    sbb bh,bh
    and bx,0x1b1b
    xor dx,bx   ; xtime done

    xor dx,ax   ; xor with tmp

    xor [si],cl     ; store back to state by xoring with orig
    xor [si+4],dh
    xor [si+8],ch
    xor [si+12],dl
    inc si      ; point to next column
    dec di
    jnz .do_mixcolumn
    pop cx      ; restore cx
    ;pop bp
    mov bp,sp
    add bp,byte 4
    call    mixkey      ; mix the key
    add cx,byte 16  ; increment the loop counter
    jmp short .round_top
.finalize:
    ;; Perform a final key mixing before finishing up
    call    mixkey
    pop di
    pop si
    pop bp
    ret

;   global  _rijndael_decrypt
rijndael_decrypt:
    push    bp
    mov bp,sp
    push    si
    push    di
    mov cx,224      ; round key offset (14*16)
    ;; Perform the initial key mixing operation
    call    mixkey
    ;; The first round doesn't perform the inverse column mixing.
    jmp .start_isbox
.round_top:
    call    mixkey
    ;; The inverse column mixing is much more ticklish than the straight
    ;; mix...
    mov si,[bp+4]   ; load the address of the state
    mov ch,4        ; column loop counter
    ;push    bp
    mov bp,0x1b1b   ; values for *2 operation
.do_invmixcolumn:
    push    cx
    mov cl,[si]     ; zeroth byte of column
    mov ch,[si+4]   ; first byte of column
    mov dl,[si+8]   ; second byte of column
    mov dh,[si+12]  ; third byte of column
    ;; Multiply by 0x0e in GF(2^8) (`*' denotes multiplication in GF(2^8))
.invmix_onecolumn:
    ;output bytes (low,high):
    ;ax=x,y di=z,w
    mov ax,cx ;ax(x,y)=w,x
    xor ax,dx ;ax(x,y)=w^y,x^z

    mov di,ax ;di(z,w)=w^y,x^z
    xor ah,cl ;ah(y)=w^x^z
    xor al,dh ;al(x)=w^y^z
    xchg ax,di ;ax=z,w di=x,y
    xor ah,dl ;ah(w)=x^y^z
    xor al,ch ;al(z)=w^x^y

    ;now do *2 to each source byte
    shl cl,1
    sbb bl,bl
    shl ch,1
    sbb bh,bh
    and bx,bp;0x1b1b
    xor cx,bx   ;first 2 done
    shl dl,1
    sbb bl,bl
    shl dh,1
    sbb bh,bh
    and bx,bp;0x1b1b
    xor dx,bx   ;all *2'd

    ;for this part, w:w,x x:x,y y:y,z z:z,w
    ;ax=z,w di=x,y
    xor ax,cx ;ax(z,w)=w,x
    xor al,dh ;al(z)=w^z
    xor ah,cl ;ah(w)=w^x
    xchg ah,al
    xchg ax,di ;ax=x,y di=w,z
    xor ax,dx ;ax(x,y)=y,z
    xor al,ch ;al(x)=x^y
    xor ah,dl ;ah(y)=y^z
    xchg ah,al ;ax=y,x di=w,z

    ;now do *2 to each source byte
    shl cl,1
    sbb bl,bl
    shl ch,1
    sbb bh,bh
    and bx,bp;0x1b1b
    xor cx,bx   ;first 2 done
    shl dl,1
    sbb bl,bl
    shl dh,1
    sbb bh,bh
    and bx,bp;0x1b1b
    xor dx,bx   ;all *2'd

    ;for this part, w:w,y x:x,z y:w,y z:x,z
    ;ax=y,x di=w,z
    xor ax,cx
    xor ax,dx
    xor di,cx
    xor di,dx

    ;now do *2 to each source byte
    shl cl,1
    sbb bl,bl
    shl ch,1
    sbb bh,bh
    and bx,bp;0x1b1b
    xor cx,bx   ;first 2 done
    shl dl,1
    sbb bl,bl
    shl dh,1
    sbb bh,bh
    and bx,bp;0x1b1b
    xor dx,bx   ;all *2'd

    xor cx,dx   ;don't care about preserving source bytes anymore
    xor cl,ch
    mov ch,cl
    xor ax,cx
    xor cx,di   ;(moved to cx)

    ;ax=y,x cx=w,z

    mov [si],cl ;save bytes
    mov [si+4],ah
    mov [si+8],al
    mov [si+12],ch

;.end_col_invmix:
    inc si      ; point to next column
    pop cx
    dec ch  ;column loop counter (clears carry)
    ;jnz .do_invmixcolumn
    jz .start_isbox
    jmp .do_invmixcolumn
    ;pop bp      ; restore saved registers
.start_isbox:
    mov bp,sp
    add bp,byte 4
    mov bx,isbox    ; translate using isbox
    ;clc            ; rotate to the left (carry was cleared above)
    call xlat_rotate
    sub cx,byte 16
    jz .do_mixkey
    jmp .round_top
.do_mixkey
    call    mixkey
    pop di
    pop si
    pop bp
    ret

;   global  _rijndael_keygen
rijndael_keygen:
    cld
    push    bp
    mov     bp,sp
    push    si
    push    di
    ;; Copy the original key data into the W[] array.  This generates
    ;; the keys used in the first two rounds.
    mov si,[bp+4]
    mov di,[bp+6]
    lea bx,[si+32]
.copy_again:
    mov cx,4
.copy_key:
    lodsw           ; get two bytes of key information
    mov [di],al
    mov [di+4],ah
    lodsw           ; get another two bytes of key info
    mov [di+8],al
    mov [di+12],ah
    inc di      ; point to next column
    loop .copy_key      ; (changed this to a loop -Brad)
    add di,byte 12;16   ; point di to next block
    cmp si,bx
    jne .copy_again
    mov cl,7        ; key number minus 1 (ch was zeroed above)
    mov di,1        ; round constant
    ;mov bx,[bp+6]   ; base address of generated keys
    mov bx,cx
    mov si,bx
    and bl,0xfc     ; clear low four bits(only clears 2 bits? -Brad)
    shl bx,1        ; (granted these clear the other two... -Brad)
    shl bx,1
    and si,byte 3   ; mask low four bits (again, only 2 bits? -Brad)
    add bx,si
    add bx,[bp+6]       ; SI points to column to get
.keygen_loop:
    mov dl,[bx]
    mov dh,[bx+4]
    mov al,[bx+8]
    mov ah,[bx+12]
    inc cx
    ;; Now dl = first byte, dh = second, al = third, ah=fourth
    test    cl,00000011b    ; is round # div. by 4 or 8?
    jnz .not_div4   ; no...
    ;; Apply the S-boxes if round # is divisible by 4 or 8
    mov bx,sbox     ; load address of S-box for xlat
    xlatb           ; al = sbox[#3]
    xchg    ah,al       ; ah = sbox[#3], al=#4
    xlatb           ; ah=sbox[#3], al=sbox[#4]
    xchg    ax,dx       ; ah=#2, al=#1, dh=sbox[#3], dl=sbox[#4]
    xlatb           ; ah=#2, al=sbox[#1]
    xchg    ah,al       ; ah=sbox[#1], al=#2, dh=sbox[#3], dl=sbox[#4]
    xlatb           ; al=sbox[#2]
    ;; Now, ah=sbox[#1], al=sbox[#2], dh=sbox[#3], dl=sbox[#4].
    ;; Test whether round is divisible by 8.  If so, further transforms
    ;; are needed.
    test    cl,00000111b    ; is round # div by 8?
    jnz .not_div8   ; no...we're done
    ;; What we want is to rotate the data so that ah=sbox[#2], al=sbox[#3],
    ;; dh=sbox[#4], and dl=sbox[#1].  This is the cycle (0 1 2 3) which
    ;; can be turned into the product of transpositions (you by XCHG
    ;; instructions) (0 3)(0 2)(0 1)
    xchg    ah,dl       ; (0 3)
    xchg    ah,dh       ; (0 2)
    xchg    ah,al       ; (0,1)

    xchg bx,di  ;get round constant from di
    xor ah,bl   ;xor with round constant
    shl bl,1    ;update round constant
    sbb bh,bh
    and bh,0x1b
    xor bl,bh
    xchg bx,di  ;store next round constant back
.not_div8:
    ;; Now we have to rearrange the order of the registers again so that
    ;; from ah=#1, al=#2, dh=#3, dl=#4 => dl=#1, dh=#2, al=#3, ah=#4, so
    ;; that the following code gets the registers where they are expected.
    xchg    ah,dl
    xchg    al,dh
.not_div4:
    ;; When we enter here, dl=first byte, dh=second, al=third, ah=fourth
    ;; Perform indexing on the address of the previous key again.
    mov bx,cx
    mov si,bx
    and bl,0xfc
    shl bx,1
    shl bx,1
    and si,byte 3
    add bx,si       ; offset into keys for first byte of old key
    add bx,[bp+6]   ; add base address of subkeys
    xor dl,[bx-32]     ; xor with current
    xor dh,[bx-28]
    xor al,[bx-24]
    xor ah,[bx-20]

    mov [bx],dl
    mov [bx+4],dh
    mov [bx+8],al
    mov [bx+12],ah
    cmp cx,byte 59      ; last key?
    jne .keygen_loop
.done:  pop di
    pop si
    pop bp
    ret