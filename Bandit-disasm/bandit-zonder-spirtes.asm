; Time Bandid for Sanyo MBC-555
; disassembled from LST file created with '?'. probably not IDA-pro.

; MZ header
; ....

0x8932


begin: _0x90db

; ─────────────────────────────────────────────────────────────────────

_0x0297:  /*BF5100      */     mov di,0x51
_0x029a:  /*B94600      */     mov cx,0x46
_0x029d:  /*32C0        */     xor al,al
_0x029f:  /*F3AA        */     rep stosb

_0x02a1:  /*C3          */     ret

; ─────────────────────────────────────────────────────────────────────

_0x02a2:  /*57          */     push di
_0x02a3:  /*56          */     push si
_0x02a4:  /*51          */     push cx
_0x02a5:  /*B90700      */     mov cx,0x7
_0x02a8:  /*BF5100      */     mov di,0x51
_0x02ab:  /*837D0400    */     cmp word [di+0x4],byte +0x0
_0x02af:  /*7407        */     jz _0x2b8
_0x02b1:  /*83C70A      */     add di,byte +0xa
_0x02b4:  /*E2F5        */     loop _0x2ab
_0x02b6:  /*EB14        */     jmp short _0x2cc

; ─────────────────────────────────────────────────────────────────────

_0x02b8:  /*8BC8        */     mov cx,ax
_0x02ba:  /*D1E0        */     shl ax,1
_0x02bc:  /*D1E0        */     shl ax,1
_0x02be:  /*03C1        */     add ax,cx
_0x02c0:  /*D1E0        */     shl ax,1
_0x02c2:  /*BE0100      */     mov si,0x1
_0x02c5:  /*03F0        */     add si,ax
_0x02c7:  /*B90500      */     mov cx,0x5
_0x02ca:  /*F3A5        */     rep movsw

_0x02cc:  /*59          */     pop cx
_0x02cd:  /*5E          */     pop si
_0x02ce:  /*5F          */     pop di
_0x02cf:  /*C3          */     ret

; ─────────────────────────────────────────────────────────────────────

_0x02d0:  /*803EB88D01  */     cmp byte [0x8db8],0x1
_0x02d5:  /*7401        */     jz _0x2d8
_0x02d7:  /*C3          */     ret

; ─────────────────────────────────────────────────────────────────────

_0x02d8:  /*BE5100      */     mov si,0x51
_0x02db:  /*B90700      */     mov cx,0x7
_0x02de:  /*837C0400    */     cmp word [si+0x4],byte +0x0
_0x02e2:  /*7419        */     jz _0x2fd
_0x02e4:  /*FF4C04      */     dec word [si+0x4]
_0x02e7:  /*8B5406      */     mov dx,[si+0x6]
_0x02ea:  /*8B5C08      */     mov bx,[si+0x8]
_0x02ed:  /*51          */     push cx
_0x02ee:  /*E81200      */     call _0x303
_0x02f1:  /*59          */     pop cx
_0x02f2:  /*8B04        */     mov ax,[si]
_0x02f4:  /*014406      */     add [si+0x6],ax
_0x02f7:  /*8B4402      */     mov ax,[si+0x2]
_0x02fa:  /*014408      */     add [si+0x8],ax
_0x02fd:  /*83C60A      */     add si,byte +0xa
_0x0300:  /*E2DC        */     loop _0x2de
_0x0302:  /*C3          */     ret

; ─────────────────────────────────────────────────────────────────────

_0x0303:  /*FA          */     cli
_0x0304:  /*B03D        */     mov al,0x3d
_0x0306:  /*E63A        */     out 0x3a,al        ; keyboard / beep
_0x0308:  /*8BCB        */     mov cx,bx
_0x030a:  /*E2FE        */     loop _0x30a
_0x030c:  /*B035        */     mov al,0x35
_0x030e:  /*E63A        */     out 0x3a,al        ; keyboard / beep
_0x0310:  /*8BCB        */     mov cx,bx
_0x0312:  /*E2FE        */     loop _0x312
_0x0314:  /*4A          */     dec dx
_0x0315:  /*75EC        */     jnz _0x303
_0x0317:  /*FB          */     sti
_0x0318:  /*C3          */     ret

; ─────────────────────────────────────────────────────────────────────

; DATA
_0x0319: times 0x5B8 db 0
; ........................
; ........................
; ........................
; ........................
; ........................
; ........................
; ........................
; ........................

; ─────────────────────────────────────────────────────────────────────

_0x08d1:  /*BF0200      */     mov di,0x2
_0x08d4:  /*9C          */     pushf
_0x08d5:  /*52          */     push dx
_0x08d6:  /*57          */     push di
_0x08d7:  /*06          */     push es
_0x08d8:  /*FA          */     cli
_0x08d9:  /*FC          */     cld
_0x08da:  /*8AC6        */     mov al,dh
_0x08dc:  /*E60C        */     out 0xc,al      ; disk sector
_0x08de:  /*BA0800      */     mov dx,0x8
_0x08e1:  /*BE0D07      */     mov si,0x70d
_0x08e4:  /*8BEB        */     mov bp,bx
_0x08e6:  /*8BFB        */     mov di,bx
_0x08e8:  /*8CD8        */     mov ax,ds
_0x08ea:  /*8EC0        */     mov es,ax
_0x08ec:  /*B702        */     mov bh,0x2
_0x08ee:  /*B396        */     mov bl,0x96
_0x08f0:  /*B400        */     mov ah,0x0
_0x08f2:  /*B080        */     mov al,0x80
_0x08f4:  /*E608        */     out 0x8,al     ; floppy command
_0x08f6:  /*D40A        */     aam
_0x08f8:  /*D40A        */     aam
_0x08fa:  /*D40A        */     aam
_0x08fc:  /*D40A        */     aam
_0x08fe:  /*EC          */     in al,dx       ; floppy status
_0x08ff:  /*D0F8        */     sar al,1
_0x0901:  /*731C        */     jnc _0x91f
_0x0903:  /*75F9        */     jnz _0x8fe
_0x0905:  /*EC          */     in al,dx       ; floppy status
_0x0906:  /*22C3        */     and al,bl
_0x0908:  /*74FB        */     jz _0x905
_0x090a:  /*E40E        */     in al,0xe
_0x090c:  /*AA          */     stosb
_0x090d:  /*EC          */     in al,dx       ; floppy status
_0x090e:  /*48          */     dec ax
_0x090f:  /*74FC        */     jz _0x90d
_0x0911:  /*3AC7        */     cmp al,bh
_0x0913:  /*750A        */     jnz _0x91f
_0x0915:  /*E40E        */     in al,0xe      ; floppy data
_0x0917:  /*AA          */     stosb
_0x0918:  /*EC          */     in al,dx       ; floppy status
_0x0919:  /*3AC7        */     cmp al,bh
_0x091b:  /*74F8        */     jz _0x915
_0x091d:  /*FFE6        */     jmp si

; ─────────────────────────────────────────────────────────────────────

_0x091f:  /*8BDF        */     mov bx,di
_0x0921:  /*07          */     pop es
_0x0922:  /*5F          */     pop di
_0x0923:  /*5A          */     pop dx
_0x0924:  /*9D          */     popf
_0x0925:  /*E408        */     in al,0x8      ; floppy status
_0x0927:  /*24FF        */     and al,0xff
_0x0929:  /*751C        */     jnz _0x947
_0x092b:  /*E20D        */     loop _0x93a
_0x092d:  /*07          */     pop es
_0x092e:  /*5F          */     pop di
_0x092f:  /*5E          */     pop si
_0x0930:  /*5D          */     pop bp
_0x0931:  /*5A          */     pop dx
_0x0932:  /*59          */     pop cx
_0x0933:  /*5B          */     pop bx
_0x0934:  /*58          */     pop ax
_0x0935:  /*E81F02      */     call _0xb57
_0x0938:  /*F8          */     clc
_0x0939:  /*C3          */     ret
_0x093a:  /*FEC6        */     inc dh
_0x093c:  /*80FE09      */     cmp dh,0x9
_0x093f:  /*7290        */     jc _0x8d1
_0x0941:  /*FEC2        */     inc dl
_0x0943:  /*B601        */     mov dh,0x1
_0x0945:  /*EB82        */     jmp short _0x8c9

; ─────────────────────────────────────────────────────────────────────

_0x0947:  /*8BDD        */     mov bx,bp
_0x0949:  /*4F          */     dec di
_0x094a:  /*7418        */     jz _0x964
_0x094c:  /*A83C        */     test al,0x3c
_0x094e:  /*740C        */     jz _0x95c
_0x0950:  /*F7C70100    */     test di,0x1
_0x0954:  /*7506        */     jnz _0x95c
_0x0956:  /*E8E601      */     call _0xb3f
_0x0959:  /*E96DFF      */     jmp _0x8c9

; ─────────────────────────────────────────────────────────────────────

_0x095c:  /*E975FF      */     jmp _0x8d4

; ─────────────────────────────────────────────────────────────────────

_0x095f:  /*A880        */     test al,0x80
_0x0961:  /*7401        */     jz _0x964
_0x0963:  /*F8          */     clc
_0x0964:  /*07          */     pop es
_0x0965:  /*5F          */     pop di
_0x0966:  /*5E          */     pop si
_0x0967:  /*5D          */     pop bp
_0x0968:  /*5A          */     pop dx
_0x0969:  /*59          */     pop cx
_0x096a:  /*5B          */     pop bx
_0x096b:  /*9F          */     lahf
_0x096c:  /*83C402      */     add sp,byte +0x2
_0x096f:  /*9E          */     sahf
_0x0970:  /*E8E401      */     call _0xb57
_0x0973:  /*721A        */     jc _0x98f
_0x0975:  /*A880        */     test al,0x80
_0x0977:  /*750E        */     jnz _0x987
_0x0979:  /*A810        */     test al,0x10
_0x097b:  /*7516        */     jnz _0x993
_0x097d:  /*A80C        */     test al,0xc
_0x097f:  /*750A        */     jnz _0x98b
_0x0981:  /*EB18        */     jmp short _0x99b

; ─────────────────────────────────────────────────────────────────────

_0x0983:  /*B000        */     mov al,0x0
_0x0985:  /*EB16        */     jmp short _0x99d

; ─────────────────────────────────────────────────────────────────────

_0x0987:  /*B002        */     mov al,0x2
_0x0989:  /*EB12        */     jmp short _0x99d

; ─────────────────────────────────────────────────────────────────────

_0x098b:  /*B004        */     mov al,0x4
_0x098d:  /*EB0E        */     jmp short _0x99d

; ─────────────────────────────────────────────────────────────────────

_0x098f:  /*B006        */     mov al,0x6
_0x0991:  /*EB0A        */     jmp short _0x99d

; ─────────────────────────────────────────────────────────────────────

_0x0993:  /*B008        */     mov al,0x8
_0x0995:  /*EB06        */     jmp short _0x99d

; ─────────────────────────────────────────────────────────────────────

_0x0997:  /*B00A        */     mov al,0xa
_0x0999:  /*EB02        */     jmp short _0x99d

; ─────────────────────────────────────────────────────────────────────

_0x099b:  /*B00C        */     mov al,0xc
_0x099d:  /*F9          */     stc
_0x099e:  /*C3          */     ret
_0x099f:  /*50          */     push ax
_0x09a0:  /*53          */     push bx
_0x09a1:  /*51          */     push cx
_0x09a2:  /*52          */     push dx
_0x09a3:  /*55          */     push bp
_0x09a4:  /*57          */     push di
_0x09a5:  /*06          */     push es
_0x09a6:  /*E8B501      */     call _0xb5e
_0x09a9:  /*E8E200      */     call _0xa8e
_0x09ac:  /*E83101      */     call _0xae0
_0x09af:  /*7303        */     jnc _0x9b4
_0x09b1:  /*E99C00      */     jmp _0xa50

; ─────────────────────────────────────────────────────────────────────

_0x09b4:  /*BF0A00      */     mov di,0xa
_0x09b7:  /*51          */     push cx
_0x09b8:  /*52          */     push dx
_0x09b9:  /*56          */     push si
_0x09ba:  /*57          */     push di
_0x09bb:  /*FA          */     cli
_0x09bc:  /*FC          */     cld
_0x09bd:  /*8AC6        */     mov al,dh
_0x09bf:  /*E60C        */     out 0xc,al         ; disk sector
_0x09c1:  /*BA0800      */     mov dx,0x8
_0x09c4:  /*BFF607      */     mov di,0x7f6
_0x09c7:  /*8BEB        */     mov bp,bx
_0x09c9:  /*8BF3        */     mov si,bx
_0x09cb:  /*8CD8        */     mov ax,ds
_0x09cd:  /*8EC0        */     mov es,ax
_0x09cf:  /*B0A0        */     mov al,0xa0
_0x09d1:  /*E608        */     out 0x8,al         ; floppy
_0x09d3:  /*D40A        */     aam
_0x09d5:  /*D40A        */     aam
_0x09d7:  /*D40A        */     aam
_0x09d9:  /*D40A        */     aam
_0x09db:  /*B40C        */     mov ah,0xc
_0x09dd:  /*B500        */     mov ch,0x0
_0x09df:  /*B702        */     mov bh,0x2
_0x09e1:  /*B3F6        */     mov bl,0xf6
_0x09e3:  /*AC          */     lodsb
_0x09e4:  /*91          */     xchg ax,cx
_0x09e5:  /*EC          */     in al,dx           ; floppy status
_0x09e6:  /*D0F8        */     sar al,1
_0x09e8:  /*7320        */     jnc _0xa0a
_0x09ea:  /*75F9        */     jnz _0x9e5
_0x09ec:  /*EC          */     in al,dx           ; floppy status
_0x09ed:  /*22C3        */     and al,bl
_0x09ef:  /*74FB        */     jz _0x9ec
_0x09f1:  /*91          */     xchg ax,cx
_0x09f2:  /*E60E        */     out 0xe,al         ; floppy
_0x09f4:  /*EB0B        */     jmp short _0xa01

; ─────────────────────────────────────────────────────────────────────

_0x09f6:  /*EC          */     in al,dx           ; floppy status
_0x09f7:  /*48          */     dec ax
_0x09f8:  /*74FC        */     jz _0x9f6
_0x09fa:  /*3AC7        */     cmp al,bh
_0x09fc:  /*750C        */     jnz _0xa0a
_0x09fe:  /*91          */     xchg ax,cx
_0x09ff:  /*E60E        */     out 0xe,al         ; floppy
_0x0a01:  /*AC          */     lodsb
_0x0a02:  /*91          */     xchg ax,cx
_0x0a03:  /*EC          */     in al,dx           ; floppy status
_0x0a04:  /*22C7        */     and al,bh
_0x0a06:  /*75F6        */     jnz _0x9fe
_0x0a08:  /*FFE7        */     jmp di

; ─────────────────────────────────────────────────────────────────────

_0x0a0a:  /*8BDD        */     mov bx,bp
_0x0a0c:  /*81C30002    */     add bx,0x200
_0x0a10:  /*5F          */     pop di
_0x0a11:  /*5E          */     pop si
_0x0a12:  /*5A          */     pop dx
_0x0a13:  /*59          */     pop cx
_0x0a14:  /*E408        */     in al,0x8           ; floppy status
_0x0a16:  /*24FF        */     and al,0xff
_0x0a18:  /*751E        */     jnz _0xa38
_0x0a1a:  /*E20C        */     loop _0xa28
_0x0a1c:  /*07          */     pop es
_0x0a1d:  /*5F          */     pop di
_0x0a1e:  /*5D          */     pop bp
_0x0a1f:  /*5A          */     pop dx
_0x0a20:  /*59          */     pop cx
_0x0a21:  /*5B          */     pop bx
_0x0a22:  /*58          */     pop ax
_0x0a23:  /*E83101      */     call _0xb57
_0x0a26:  /*F8          */     clc
_0x0a27:  /*C3          */     ret
_0x0a28:  /*FEC6        */     inc dh
_0x0a2a:  /*80FE09      */     cmp dh,0x9
_0x0a2d:  /*7302        */     jnc _0xa31
_0x0a2f:  /*EB83        */     jmp short _0x9b4

; ─────────────────────────────────────────────────────────────────────

_0x0a31:  /*FEC2        */     inc dl
_0x0a33:  /*B601        */     mov dh,0x1
_0x0a35:  /*E974FF      */     jmp _0x9ac

; ─────────────────────────────────────────────────────────────────────

_0x0a38:  /*8BDD        */     mov bx,bp
_0x0a3a:  /*4F          */     dec di
_0x0a3b:  /*7418        */     jz _0xa55
_0x0a3d:  /*A83C        */     test al,0x3c
_0x0a3f:  /*740C        */     jz _0xa4d
_0x0a41:  /*F7C70100    */     test di,0x1
_0x0a45:  /*7506        */     jnz _0xa4d
_0x0a47:  /*E8F500      */     call _0xb3f
_0x0a4a:  /*E95FFF      */     jmp _0x9ac

; ─────────────────────────────────────────────────────────────────────

_0x0a4d:  /*E967FF      */     jmp _0x9b7

; ─────────────────────────────────────────────────────────────────────

_0x0a50:  /*A880        */     test al,0x80
_0x0a52:  /*7401        */     jz _0xa55
_0x0a54:  /*F8          */     clc
_0x0a55:  /*07          */     pop es
_0x0a56:  /*5F          */     pop di
_0x0a57:  /*5D          */     pop bp
_0x0a58:  /*5A          */     pop dx
_0x0a59:  /*59          */     pop cx
_0x0a5a:  /*5B          */     pop bx
_0x0a5b:  /*9F          */     lahf
_0x0a5c:  /*83C402      */     add sp,byte +0x2
_0x0a5f:  /*9E          */     sahf
_0x0a60:  /*E8F400      */     call _0xb57
_0x0a63:  /*7303        */     jnc _0xa68
_0x0a65:  /*E927FF      */     jmp _0x98f

; ─────────────────────────────────────────────────────────────────────

_0x0a68:  /*A880        */     test al,0x80
_0x0a6a:  /*7403        */     jz _0xa6f
_0x0a6c:  /*E918FF      */     jmp _0x987

; ─────────────────────────────────────────────────────────────────────

_0x0a6f:  /*A840        */     test al,0x40
_0x0a71:  /*7403        */     jz _0xa76
_0x0a73:  /*E90DFF      */     jmp _0x983

; ─────────────────────────────────────────────────────────────────────

_0x0a76:  /*A820        */     test al,0x20
_0x0a78:  /*7403        */     jz _0xa7d
_0x0a7a:  /*E91AFF      */     jmp _0x997

; ─────────────────────────────────────────────────────────────────────

_0x0a7d:  /*A810        */     test al,0x10
_0x0a7f:  /*7403        */     jz _0xa84
_0x0a81:  /*E90FFF      */     jmp _0x993

; ─────────────────────────────────────────────────────────────────────

_0x0a84:  /*A80C        */     test al,0xc
_0x0a86:  /*7403        */     jz _0xa8b
_0x0a88:  /*E900FF      */     jmp _0x98b

; ─────────────────────────────────────────────────────────────────────

_0x0a8b:  /*E90DFF      */     jmp _0x99b

; ─────────────────────────────────────────────────────────────────────

_0x0a8e:  /*53          */     push bx
_0x0a8f:  /*50          */     push ax
_0x0a90:  /*E41C        */     in al,0x1c      ; parallel/floppy control
_0x0a92:  /*2403        */     and al,0x3
_0x0a94:  /*2EC606B006FC*/     mov byte [cs:0x6b0],0xfc
_0x0a9a:  /*2E0806B006  */     or [cs:0x6b0],al
_0x0a9f:  /*58          */     pop ax
_0x0aa0:  /*B700        */     mov bh,0x0
_0x0aa2:  /*2E8A1EB006  */     mov bl,[cs:0x6b0]
_0x0aa7:  /*2EA2B006    */     mov [cs:0x6b0],al
_0x0aab:  /*2403        */     and al,0x3
_0x0aad:  /*80E303      */     and bl,0x3
_0x0ab0:  /*3AC3        */     cmp al,bl
_0x0ab2:  /*741D        */     jz _0xad1
_0x0ab4:  /*50          */     push ax
_0x0ab5:  /*E40A        */     in al,0xa             ; floppy track ?
_0x0ab7:  /*2E8887B106  */     mov [cs:bx+0x6b1],al
_0x0abc:  /*58          */     pop ax
_0x0abd:  /*8AD8        */     mov bl,al
_0x0abf:  /*2403        */     and al,0x3
_0x0ac1:  /*E61C        */     out 0x1c,al           ; floppy
_0x0ac3:  /*2E8A87B106  */     mov al,[cs:bx+0x6b1]
_0x0ac8:  /*E60A        */     out 0xa,al            ; floppy
_0x0aca:  /*3C28        */     cmp al,0x28
_0x0acc:  /*7203        */     jc _0xad1
_0x0ace:  /*E86E00      */     call _0xb3f
_0x0ad1:  /*8BC2        */     mov ax,dx
_0x0ad3:  /*B208        */     mov dl,0x8
_0x0ad5:  /*F6F2        */     div dl
_0x0ad7:  /*FEC4        */     inc ah
_0x0ad9:  /*8BD0        */     mov dx,ax
_0x0adb:  /*80E60F      */     and dh,0xf
_0x0ade:  /*5B          */     pop bx
_0x0adf:  /*C3          */     ret

; ─────────────────────────────────────────────────────────────────────

_0x0ae0:  /*53          */     push bx
_0x0ae1:  /*51          */     push cx
_0x0ae2:  /*52          */     push dx
_0x0ae3:  /*02D2        */     add dl,dl
_0x0ae5:  /*BB0A00      */     mov bx,0xa
_0x0ae8:  /*2E3A16B506  */     cmp dl,[cs:0x6b5]
_0x0aed:  /*7405        */     jz _0xaf4
_0x0aef:  /*B94D01      */     mov cx,0x14d
_0x0af2:  /*E2FE        */     loop _0xaf2
_0x0af4:  /*8AC2        */     mov al,dl
_0x0af6:  /*D0E8        */     shr al,1
_0x0af8:  /*E60E        */     out 0xe,al        ; floppy
_0x0afa:  /*B018        */     mov al,0x18
_0x0afc:  /*E608        */     out 0x8,al        ; floppy
_0x0afe:  /*E41C        */     in al,0x1c        ; floppy
_0x0b00:  /*8AE2        */     mov ah,dl
_0x0b02:  /*D0E4        */     shl ah,1
_0x0b04:  /*D0E4        */     shl ah,1
_0x0b06:  /*80E404      */     and ah,0x4
_0x0b09:  /*24FB        */     and al,0xfb
_0x0b0b:  /*0AC4        */     or al,ah
_0x0b0d:  /*E61C        */     out 0x1c,al       ; floppy
_0x0b0f:  /*E408        */     in al,0x8         ; floppy
_0x0b11:  /*A801        */     test al,0x1
_0x0b13:  /*75FA        */     jnz _0xb0f
_0x0b15:  /*B91482      */     mov cx,0x8214
_0x0b18:  /*E408        */     in al,0x8         ; floppy
_0x0b1a:  /*A880        */     test al,0x80
_0x0b1c:  /*7407        */     jz _0xb25
_0x0b1e:  /*E2F8        */     loop _0xb18
_0x0b20:  /*4B          */     dec bx
_0x0b21:  /*75C5        */     jnz _0xae8
_0x0b23:  /*EB11        */     jmp short _0xb36

; ─────────────────────────────────────────────────────────────────────

_0x0b25:  /*2E3A16B506  */     cmp dl,[cs:0x6b5]
_0x0b2a:  /*7405        */     jz _0xb31
_0x0b2c:  /*B94D01      */     mov cx,0x14d
_0x0b2f:  /*E2FE        */     loop _0xb2f
_0x0b31:  /*2E8816B506  */     mov [cs:0x6b5],dl
_0x0b36:  /*5A          */     pop dx
_0x0b37:  /*59          */     pop cx
_0x0b38:  /*5B          */     pop bx
_0x0b39:  /*2490        */     and al,0x90
_0x0b3b:  /*7401        */     jz _0xb3e
_0x0b3d:  /*F9          */     stc
_0x0b3e:  /*C3          */     ret

; ─────────────────────────────────────────────────────────────────────

_0x0b3f:  /*B008        */     mov al,0x8
_0x0b41:  /*E608        */     out 0x8,al         ; floppy
_0x0b43:  /*E408        */     in al,0x8          ; floppy
_0x0b45:  /*A801        */     test al,0x1
_0x0b47:  /*75FA        */     jnz _0xb43
_0x0b49:  /*51          */     push cx
_0x0b4a:  /*B9511B      */     mov cx,0x1b51
_0x0b4d:  /*E2FE        */     loop _0xb4d
_0x0b4f:  /*59          */     pop cx
_0x0b50:  /*2EC606B50600*/     mov byte [cs:0x6b5],0x0
_0x0b56:  /*C3          */     ret

; ─────────────────────────────────────────────────────────────────────

_0x0b57:  /*50          */     push ax
_0x0b58:  /*B027        */     mov al,0x27
_0x0b5a:  /*E62A        */     out 0x2a,al       ; serial ?
_0x0b5c:  /*58          */     pop ax
_0x0b5d:  /*C3          */     ret

; ─────────────────────────────────────────────────────────────────────

_0x0b5e:  /*50          */     push ax
_0x0b5f:  /*B005        */     mov al,0x5
_0x0b61:  /*E62A        */     out 0x2a,al       ; serial ?
_0x0b63:  /*58          */     pop ax
_0x0b64:  /*C3          */     ret

; ─────────────────────────────────────────────────────────────────────

; DATA 

_0x0b65: times 0x793D db 0    ; veel blokken data. mogelijke startpunten:
                              ; _0x5a50, _0x6243, _0x7393, _0x7753, _0x7b2c, _0x7e0a, _0x8483

; _0x0c30, 64*192); //sprites
; _0x3c4e, 40*192); //sprites
; _0x6cf0, 1583);   // strings
; _0x7393, 5*192);  //sprites
; _0x7753, 984);    // strings
; _0x7e0a, 1656);   // strings
; _0x8bbb, 1167);   // strings

; _0x5a50: times 438 db 0 ; DATA
; times 2*478 db 0
; _0x6243: times XXXX db 0 ; DATA (level info?)
; _0x7393: times 0x960 db 0xFF
; _0x7753: times 0x3D9 db 0 ; DATA (messages)
; _0x7b2c: times 0x2DE db 0 ; DATA 
; _0x7e0a: times 0x697 db 0 ; DATA (strings PF1...SOLO etc)
; _0x8483: times 30 db 0  ; DATA 

; CODE

_0x84a1:  /*BE030C      */     mov si,0xc03
_0x84a4:  /*00D2        */     add dl,dl
_0x84a6:  /*030C        */     add cx,[si]
_0x84a8:  /*00D2        */     add dl,dl
_0x84aa:  /*030E00D2    */     add cx,[0xd200]
_0x84ae:  /*030C        */     add cx,[si]
_0x84b0:  /*00D2        */     add dl,dl
_0x84b2:  /*0402        */     add al,0x2
_0x84b4:  /*3B16D77B    */     cmp dx,[0x7bd7]
_0x84b8:  /*743C        */     jz _0x84f6
_0x84ba:  /*8916D77B    */     mov [0x7bd7],dx
_0x84be:  /*BF987B      */     mov di,0x7b98
_0x84c1:  /*B90300      */     mov cx,0x3
_0x84c4:  /*33C0        */     xor ax,ax
_0x84c6:  /*33DB        */     xor bx,bx
_0x84c8:  /*D0EA        */     shr dl,1
_0x84ca:  /*7301        */     jnc _0x84cd
_0x84cc:  /*48          */     dec ax
_0x84cd:  /*D0EE        */     shr dh,1
_0x84cf:  /*7301        */     jnc _0x84d2
_0x84d1:  /*4B          */     dec bx
_0x84d2:  /*8905        */     mov [di],ax
_0x84d4:  /*895D0C      */     mov [di+0xc],bx
_0x84d7:  /*25AAAA      */     and ax,0xaaaa
_0x84da:  /*81E35555    */     and bx,0x5555
_0x84de:  /*0BC3        */     or ax,bx
_0x84e0:  /*894502      */     mov [di+0x2],ax
_0x84e3:  /*894506      */     mov [di+0x6],ax
_0x84e6:  /*89450A      */     mov [di+0xa],ax
_0x84e9:  /*D1C0        */     rol ax,1
_0x84eb:  /*894504      */     mov [di+0x4],ax
_0x84ee:  /*894508      */     mov [di+0x8],ax
_0x84f1:  /*83C70E      */     add di,byte +0xe
_0x84f4:  /*E2CE        */     loop _0x84c4
_0x84f6:  /*C3          */     ret

; ─────────────────────────────────────────────────────────────────────

_0x84f7:  /*A3D081      */     mov [0x81d0],ax
_0x84fa:  /*8A14        */     mov dl,[si]
_0x84fc:  /*46          */     inc si
_0x84fd:  /*0AD2        */     or dl,dl
_0x84ff:  /*7450        */     jz _0x8551
_0x8501:  /*80FA01      */     cmp dl,0x1
_0x8504:  /*7508        */     jnz _0x850e
_0x8506:  /*A1D081      */     mov ax,[0x81d0]
_0x8509:  /*83C30C      */     add bx,byte +0xc
_0x850c:  /*EBEC        */     jmp short _0x84fa
_0x850e:  /*80FA02      */     cmp dl,0x2
_0x8511:  /*7510        */     jnz _0x8523
_0x8513:  /*50          */     push ax
_0x8514:  /*53          */     push bx
_0x8515:  /*8B14        */     mov dx,[si]
_0x8517:  /*83C602      */     add si,byte +0x2
_0x851a:  /*56          */     push si
_0x851b:  /*E896FF      */     call _0x84b4
_0x851e:  /*5E          */     pop si
_0x851f:  /*5B          */     pop bx
_0x8520:  /*58          */     pop ax
_0x8521:  /*EBD7        */     jmp short _0x84fa

; ─────────────────────────────────────────────────────────────────────

_0x8523:  /*80FA03      */     cmp dl,0x3
_0x8526:  /*750C        */     jnz _0x8534
_0x8528:  /*AD          */     lodsw
_0x8529:  /*8ADC        */     mov bl,ah
_0x852b:  /*32E4        */     xor ah,ah
_0x852d:  /*8AFC        */     mov bh,ah
_0x852f:  /*A3D081      */     mov [0x81d0],ax
_0x8532:  /*EBC6        */     jmp short _0x84fa

; ─────────────────────────────────────────────────────────────────────

_0x8534:  /*80FA04      */     cmp dl,0x4
_0x8537:  /*750A        */     jnz _0x8543
_0x8539:  /*AD          */     lodsw
_0x853a:  /*8BD8        */     mov bx,ax
_0x853c:  /*AD          */     lodsw
_0x853d:  /*93          */     xchg ax,bx
_0x853e:  /*A3D081      */     mov [0x81d0],ax
_0x8541:  /*EBB7        */     jmp short _0x84fa

; ─────────────────────────────────────────────────────────────────────

_0x8543:  /*50          */     push ax
_0x8544:  /*53          */     push bx
_0x8545:  /*56          */     push si
_0x8546:  /*E80900      */     call _0x8552
_0x8549:  /*5E          */     pop si
_0x854a:  /*5B          */     pop bx
_0x854b:  /*58          */     pop ax
_0x854c:  /*050300      */     add ax,0x3
_0x854f:  /*EBA9        */     jmp short _0x84fa
_0x8551:  /*C3          */     ret

; ─────────────────────────────────────────────────────────────────────

_0x8552:  /*BE20FE      */     mov si,0xfe20
_0x8555:  /*32F6        */     xor dh,dh
_0x8557:  /*D1E2        */     shl dx,1
_0x8559:  /*D1E2        */     shl dx,1
_0x855b:  /*D1E2        */     shl dx,1
_0x855d:  /*8BCA        */     mov cx,dx
_0x855f:  /*D1E2        */     shl dx,1
_0x8561:  /*03D1        */     add dx,cx
_0x8563:  /*03F2        */     add si,dx
_0x8565:  /*FA          */     cli
_0x8566:  /*8926F87B    */     mov [0x7bf8],sp
_0x856a:  /*32F6        */     xor dh,dh
_0x856c:  /*8BC8        */     mov cx,ax
_0x856e:  /*D1E9        */     shr cx,1
_0x8570:  /*7302        */     jnc _0x8574
_0x8572:  /*FECE        */     dec dh
_0x8574:  /*8BEA        */     mov bp,dx
_0x8576:  /*D1E1        */     shl cx,1
_0x8578:  /*D1E1        */     shl cx,1
_0x857a:  /*8BFB        */     mov di,bx
_0x857c:  /*81E70300    */     and di,0x3
_0x8580:  /*D1EB        */     shr bx,1
_0x8582:  /*D1EB        */     shr bx,1
_0x8584:  /*A1D17B      */     mov ax,[0x7bd1]
_0x8587:  /*8BE0        */     mov sp,ax
_0x8589:  /*83EC04      */     sub sp,byte +0x4
_0x858c:  /*F7E3        */     mul bx
_0x858e:  /*8BD5        */     mov dx,bp
_0x8590:  /*03F8        */     add di,ax
_0x8592:  /*03F9        */     add di,cx
_0x8594:  /*BD987B      */     mov bp,0x7b98
_0x8597:  /*C706D57B000F*/     mov word [0x7bd5],0xf00
_0x859d:  /*0AF6        */     or dh,dh
_0x859f:  /*7406        */     jz _0x85a7
_0x85a1:  /*C706D57BF000*/     mov word [0x7bd5],0xf0
_0x85a7:  /*8B1ED37B    */     mov bx,[0x7bd3]
_0x85ab:  /*8E07        */     mov es,[bx]
_0x85ad:  /*893EFC7B    */     mov [0x7bfc],di
_0x85b1:  /*891EFA7B    */     mov [0x7bfa],bx
_0x85b5:  /*8B1ED57B    */     mov bx,[0x7bd5]
_0x85b9:  /*B2FC        */     mov dl,0xfc
_0x85bb:  /*B90C00      */     mov cx,0xc
_0x85be:  /*F606F77BFF  */     test byte [0x7bf7],0xff
_0x85c3:  /*753A        */     jnz _0x85ff
_0x85c5:  /*AD          */     lodsw
_0x85c6:  /*234600      */     and ax,[bp+0x0]
_0x85c9:  /*D0EA        */     shr dl,1
_0x85cb:  /*7303        */     jnc _0x85d0
_0x85cd:  /*83C502      */     add bp,byte +0x2
_0x85d0:  /*D0CE        */     ror dh,1
_0x85d2:  /*730C        */     jnc _0x85e0
_0x85d4:  /*86C4        */     xchg ah,al
_0x85d6:  /*D1E8        */     shr ax,1
_0x85d8:  /*D1E8        */     shr ax,1
_0x85da:  /*D1E8        */     shr ax,1
_0x85dc:  /*D1E8        */     shr ax,1
_0x85de:  /*86C4        */     xchg ah,al
_0x85e0:  /*26201D      */     and [es:di],bl
_0x85e3:  /*26207D04    */     and [es:di+0x4],bh
_0x85e7:  /*260805      */     or [es:di],al
_0x85ea:  /*26086504    */     or [es:di+0x4],ah
_0x85ee:  /*47          */     inc di
_0x85ef:  /*F7C70300    */     test di,0x3
_0x85f3:  /*7404        */     jz _0x85f9
_0x85f5:  /*E2CE        */     loop _0x85c5
_0x85f7:  /*EB37        */     jmp short _0x8630

; ─────────────────────────────────────────────────────────────────────

_0x85f9:  /*03FC        */     add di,sp
_0x85fb:  /*E2C8        */     loop _0x85c5
_0x85fd:  /*EB31        */     jmp short _0x8630

; ─────────────────────────────────────────────────────────────────────

_0x85ff:  /*AD          */     lodsw
_0x8600:  /*234600      */     and ax,[bp+0x0]
_0x8603:  /*D0EA        */     shr dl,1
_0x8605:  /*7303        */     jnc _0x860a
_0x8607:  /*83C502      */     add bp,byte +0x2
_0x860a:  /*D0CE        */     ror dh,1
_0x860c:  /*730C        */     jnc _0x861a
_0x860e:  /*86C4        */     xchg ah,al
_0x8610:  /*D1E8        */     shr ax,1
_0x8612:  /*D1E8        */     shr ax,1
_0x8614:  /*D1E8        */     shr ax,1
_0x8616:  /*D1E8        */     shr ax,1
_0x8618:  /*86C4        */     xchg ah,al
_0x861a:  /*263005      */     xor [es:di],al
_0x861d:  /*26306504    */     xor [es:di+0x4],ah
_0x8621:  /*47          */     inc di
_0x8622:  /*F7C70300    */     test di,0x3
_0x8626:  /*7404        */     jz _0x862c
_0x8628:  /*E2D5        */     loop _0x85ff
_0x862a:  /*EB04        */     jmp short _0x8630

; ─────────────────────────────────────────────────────────────────────

_0x862c:  /*03FC        */     add di,sp
_0x862e:  /*E2CF        */     loop _0x85ff
_0x8630:  /*8B3EFC7B    */     mov di,[0x7bfc]
_0x8634:  /*8B1EFA7B    */     mov bx,[0x7bfa]
_0x8638:  /*83EE18      */     sub si,byte +0x18
_0x863b:  /*83C502      */     add bp,byte +0x2
_0x863e:  /*83C302      */     add bx,byte +0x2
_0x8641:  /*A1D37B      */     mov ax,[0x7bd3]
_0x8644:  /*050600      */     add ax,0x6
_0x8647:  /*3BC3        */     cmp ax,bx
_0x8649:  /*7403        */     jz _0x864e
_0x864b:  /*E95DFF      */     jmp _0x85ab
_0x864e:  /*8B26F87B    */     mov sp,[0x7bf8]
_0x8652:  /*FB          */     sti
_0x8653:  /*8CC8        */     mov ax,cs
_0x8655:  /*8EC0        */     mov es,ax
_0x8657:  /*C3          */     ret

; ─────────────────────────────────────────────────────────────────────

_0x8658:  /*56          */     push si
_0x8659:  /*57          */     push di
_0x865a:  /*BB9F27      */     mov bx,0x279f
_0x865d:  /*81C32354    */     add bx,0x5423
_0x8661:  /*E81F27      */     call _0xad83
_0x8664:  /*8B0EF57B    */     mov cx,[0x7bf5]
_0x8668:  /*8B16F37B    */     mov dx,[0x7bf3]
_0x866c:  /*8BF1        */     mov si,cx
_0x866e:  /*8BFA        */     mov di,dx
_0x8670:  /*8AC5        */     mov al,ch
_0x8672:  /*8AE9        */     mov ch,cl
_0x8674:  /*8ACE        */     mov cl,dh
_0x8676:  /*8AF2        */     mov dh,dl
_0x8678:  /*8AD0        */     mov dl,al
_0x867a:  /*D1E9        */     shr cx,1
_0x867c:  /*D1DA        */     rcr dx,1
_0x867e:  /*2BD7        */     sub dx,di
_0x8680:  /*1BCE        */     sbb cx,si
_0x8682:  /*2BD7        */     sub dx,di
_0x8684:  /*1BCE        */     sbb cx,si
_0x8686:  /*2BD7        */     sub dx,di
_0x8688:  /*1BCE        */     sbb cx,si
_0x868a:  /*8916F37B    */     mov [0x7bf3],dx
_0x868e:  /*890EF57B    */     mov [0x7bf5],cx
_0x8692:  /*5F          */     pop di
_0x8693:  /*5E          */     pop si
_0x8694:  /*C3          */     ret

; ─────────────────────────────────────────────────────────────────────

_0x8695:  /*B00C        */     mov al,0xc
_0x8697:  /*E630        */     out 0x30,al       ; CRT address
_0x8699:  /*32C0        */     xor al,al
_0x869b:  /*E632        */     out 0x32,al       ; CRT data
_0x869d:  /*B00D        */     mov al,0xd
_0x869f:  /*E630        */     out 0x30,al       ; CRT address
_0x86a1:  /*32C0        */     xor al,al
_0x86a3:  /*E632        */     out 0x32,al       ; CRT data
_0x86a5:  /*B005        */     mov al,0x5
_0x86a7:  /*E610        */     out 0x10,al       ; video page

_0x86a9:  /*33FF        */     xor di,di
_0x86ab:  /*8BC7        */     mov ax,di
_0x86ad:  /*8E063289    */     mov es,[0x8932]
_0x86b1:  /*B90420      */     mov cx,0x2004
_0x86b4:  /*F3AB        */     rep stosw

_0x86b6:  /*33FF        */     xor di,di
_0x86b8:  /*BA00F0      */     mov dx,0xf000    ; RED channel
_0x86bb:  /*8EC2        */     mov es,dx
_0x86bd:  /*B90040      */     mov cx,0x4000
_0x86c0:  /*F3AB        */     rep stosw

_0x86c2:  /*8CC8        */     mov ax,cs
_0x86c4:  /*8EC0        */     mov es,ax
_0x86c6:  /*C3          */     ret

; ─────────────────────────────────────────────────────────────────────

_0x86c7:  /*D1E3        */     shl bx,1
_0x86c9:  /*FFA7907B    */     jmp [bx+0x7b90]

; ─────────────────────────────────────────────────────────────────────

_0x86cd:  /*C706057C0000*/     mov word [0x7c05],0x0
_0x86d3:  /*B401        */     mov ah,0x1
_0x86d5:  /*E8FE01      */     call _0x88d6
_0x86d8:  /*7408        */     jz _0x86e2
_0x86da:  /*32E4        */     xor ah,ah
_0x86dc:  /*E8F701      */     call _0x88d6
_0x86df:  /*A3057C      */     mov [0x7c05],ax
_0x86e2:  /*C3          */     ret

; ─────────────────────────────────────────────────────────────────────

_0x86e3:  /*A1057C      */     mov ax,[0x7c05]
_0x86e6:  /*C606FE7B50  */     mov byte [0x7bfe],0x50
_0x86eb:  /*3D004B      */     cmp ax,0x4b00
_0x86ee:  /*7415        */     jz _0x8705
_0x86f0:  /*3D0047      */     cmp ax,0x4700
_0x86f3:  /*7410        */     jz _0x8705
_0x86f5:  /*3C0A        */     cmp al,0xa
_0x86f7:  /*740C        */     jz _0x8705
_0x86f9:  /*3C34        */     cmp al,0x34
_0x86fb:  /*7408        */     jz _0x8705
_0x86fd:  /*3C37        */     cmp al,0x37
_0x86ff:  /*7404        */     jz _0x8705
_0x8701:  /*3C31        */     cmp al,0x31
_0x8703:  /*7505        */     jnz _0x870a
_0x8705:  /*C606FE7B19  */     mov byte [0x7bfe],0x19
_0x870a:  /*3D004D      */     cmp ax,0x4d00
_0x870d:  /*7416        */     jz _0x8725
_0x870f:  /*3D0049      */     cmp ax,0x4900
_0x8712:  /*7411        */     jz _0x8725
_0x8714:  /*3D0051      */     cmp ax,0x5100
_0x8717:  /*740C        */     jz _0x8725
_0x8719:  /*3C36        */     cmp al,0x36
_0x871b:  /*7408        */     jz _0x8725
_0x871d:  /*3C39        */     cmp al,0x39
_0x871f:  /*7404        */     jz _0x8725
_0x8721:  /*3C33        */     cmp al,0x33
_0x8723:  /*7505        */     jnz _0x872a
_0x8725:  /*C606FE7B87  */     mov byte [0x7bfe],0x87
_0x872a:  /*C606FF7B50  */     mov byte [0x7bff],0x50
_0x872f:  /*3D0048      */     cmp ax,0x4800
_0x8732:  /*7416        */     jz _0x874a
_0x8734:  /*3D0047      */     cmp ax,0x4700
_0x8737:  /*7411        */     jz _0x874a
_0x8739:  /*3D0049      */     cmp ax,0x4900
_0x873c:  /*740C        */     jz _0x874a
_0x873e:  /*3C37        */     cmp al,0x37
_0x8740:  /*7408        */     jz _0x874a
_0x8742:  /*3C38        */     cmp al,0x38
_0x8744:  /*7404        */     jz _0x874a
_0x8746:  /*3C39        */     cmp al,0x39
_0x8748:  /*7505        */     jnz _0x874f
_0x874a:  /*C606FF7B19  */     mov byte [0x7bff],0x19
_0x874f:  /*3D0050      */     cmp ax,0x5000
_0x8752:  /*7415        */     jz _0x8769
_0x8754:  /*3D0051      */     cmp ax,0x5100
_0x8757:  /*7410        */     jz _0x8769
_0x8759:  /*3C0A        */     cmp al,0xa
_0x875b:  /*740C        */     jz _0x8769
_0x875d:  /*3C35        */     cmp al,0x35
_0x875f:  /*7408        */     jz _0x8769
_0x8761:  /*3C31        */     cmp al,0x31
_0x8763:  /*7404        */     jz _0x8769
_0x8765:  /*3C33        */     cmp al,0x33
_0x8767:  /*7505        */     jnz _0x876e
_0x8769:  /*C606FF7B8C  */     mov byte [0x7bff],0x8c
_0x876e:  /*C706007C0000*/     mov word [0x7c00],0x0
_0x8774:  /*3C20        */     cmp al,0x20
_0x8776:  /*7504        */     jnz _0x877c
_0x8778:  /*FE06007C    */     inc byte [0x7c00]
_0x877c:  /*3C41        */     cmp al,0x41
_0x877e:  /*7208        */     jc _0x8788
_0x8780:  /*3C7A        */     cmp al,0x7a
_0x8782:  /*7704        */     ja _0x8788
_0x8784:  /*FE06017C    */     inc byte [0x7c01]
_0x8788:  /*C3          */     ret

; ─────────────────────────────────────────────────────────────────────

_0x8789:  /*F606037CFF  */     test byte [0x7c03],0xff
_0x878e:  /*7526        */     jnz _0x87b6
_0x8790:  /*B101        */     mov cl,0x1
_0x8792:  /*E88A00      */     call _0x881f
_0x8795:  /*8826FE7B    */     mov [0x7bfe],ah
_0x8799:  /*B102        */     mov cl,0x2
_0x879b:  /*E88100      */     call _0x881f
_0x879e:  /*8826FF7B    */     mov [0x7bff],ah
_0x87a2:  /*C706007C0000*/     mov word [0x7c00],0x0
_0x87a8:  /*D0C8        */     ror al,1
_0x87aa:  /*D0C8        */     ror al,1
_0x87ac:  /*D01E007C    */     rcr byte [0x7c00],1
_0x87b0:  /*D0C8        */     ror al,1
_0x87b2:  /*D01E017C    */     rcr byte [0x7c01],1
_0x87b6:  /*C3          */     ret

; ─────────────────────────────────────────────────────────────────────

_0x87b7:  /*F606047CFF  */     test byte [0x7c04],0xff
_0x87bc:  /*7528        */     jnz _0x87e6
_0x87be:  /*B103        */     mov cl,0x3
_0x87c0:  /*E85C00      */     call _0x881f
_0x87c3:  /*8826FE7B    */     mov [0x7bfe],ah
_0x87c7:  /*B104        */     mov cl,0x4
_0x87c9:  /*E85300      */     call _0x881f
_0x87cc:  /*8826FF7B    */     mov [0x7bff],ah
_0x87d0:  /*C706007C0000*/     mov word [0x7c00],0x0
_0x87d6:  /*D0C8        */     ror al,1
_0x87d8:  /*D01E007C    */     rcr byte [0x7c00],1
_0x87dc:  /*D0C8        */     ror al,1
_0x87de:  /*D0C8        */     ror al,1
_0x87e0:  /*D0C8        */     ror al,1
_0x87e2:  /*D01E017C    */     rcr byte [0x7c01],1
_0x87e6:  /*C3          */     ret

; ─────────────────────────────────────────────────────────────────────

_0x87e7:  /*5B          */     pop bx
_0x87e8:  /*81FBF085    */     cmp bx,0x85f0
_0x87ec:  /*741B        */     jz _0x8809
_0x87ee:  /*FFE3        */     jmp bx

; ─────────────────────────────────────────────────────────────────────

_0x87f0:  /*8B4E0B      */     mov cx,[bp+0xb]
_0x87f3:  /*FE4E0D      */     dec byte [bp+0xd]
_0x87f6:  /*E0FB        */     loopne 0x87f3
_0x87f8:  /*E3ED        */     jcxz 0x87e7
_0x87fa:  /*51          */     push cx
_0x87fb:  /*8B5605      */     mov dx,[bp+0x5]
_0x87fe:  /*8B4E09      */     mov cx,[bp+0x9]
_0x8801:  /*2B4E07      */     sub cx,[bp+0x7]
_0x8804:  /*D1E9        */     shr cx,1
_0x8806:  /*8B7607      */     mov si,[bp+0x7]
_0x8809:  /*AD          */     lodsw
_0x880a:  /*03D0        */     add dx,ax
_0x880c:  /*D1C2        */     rol dx,1
_0x880e:  /*E2F9        */     loop _0x8809
_0x8810:  /*58          */     pop ax
_0x8811:  /*335603      */     xor dx,[bp+0x3]
_0x8814:  /*74D1        */     jz _0x87e7
_0x8816:  /*C7060986AB00*/     mov word [0x8609],0xab
_0x881c:  /*EBE8        */     jmp short _0x8806

; ─────────────────────────────────────────────────────────────────────

_0x881e:  /*C3          */     ret

; ─────────────────────────────────────────────────────────────────────

_0x881f:  /*FA          */     cli
_0x8820:  /*A0027C      */     mov al,[0x7c02]
_0x8823:  /*E61A        */     out 0x1a,al      ; parallel port / joystick?
_0x8825:  /*B408        */     mov ah,0x8
_0x8827:  /*D2E4        */     shl ah,cl
_0x8829:  /*B90008      */     mov cx,0x800
_0x882c:  /*E41A        */     in al,0x1a       ; parallel port / joystick?
_0x882e:  /*247F        */     and al,0x7f
_0x8830:  /*E61A        */     out 0x1a,al
_0x8832:  /*0C80        */     or al,0x80
_0x8834:  /*E61A        */     out 0x1a,al      ; parallel port / joystick?
_0x8836:  /*247F        */     and al,0x7f
_0x8838:  /*E61A        */     out 0x1a,al      ; parallel port / joystick?
_0x883a:  /*D0E8        */     shr al,1
_0x883c:  /*E418        */     in al,0x18       ; joystick
_0x883e:  /*22C4        */     and al,ah
_0x8840:  /*E0F8        */     loopne 0x883a
_0x8842:  /*E41A        */     in al,0x1a       ; parallel port  / joystick?
_0x8844:  /*A2027C      */     mov [0x7c02],al
_0x8847:  /*E418        */     in al,0x18       ; joystick
_0x8849:  /*FB          */     sti
_0x884a:  /*8AE1        */     mov ah,cl
_0x884c:  /*0AE9        */     or ch,cl
_0x884e:  /*7502        */     jnz _0x8852
_0x8850:  /*F9          */     stc
_0x8851:  /*C3          */     ret

; ─────────────────────────────────────────────────────────────────────

_0x8852:  /*8ACC        */     mov cl,ah
_0x8854:  /*32ED        */     xor ch,ch
_0x8856:  /*E300        */     jcxz 0x8858
_0x8858:  /*F6DC        */     neg ah
_0x885a:  /*F8          */     clc
_0x885b:  /*C3          */     ret

; ─────────────────────────────────────────────────────────────────────

_0x885c:  /*E41A        */     in al,0x1a       ; parallel port  / joystick?
_0x885e:  /*A2027C      */     mov [0x7c02],al
_0x8861:  /*B101        */     mov cl,0x1
_0x8863:  /*C706037C0000*/     mov word [0x7c03],0x0
_0x8869:  /*E8B3FF      */     call _0x881f
_0x886c:  /*7304        */     jnc _0x8872
_0x886e:  /*FE06037C    */     inc byte [0x7c03]
_0x8872:  /*B103        */     mov cl,0x3
_0x8874:  /*E8A8FF      */     call _0x881f
_0x8877:  /*7304        */     jnc _0x887d
_0x8879:  /*FE06047C    */     inc byte [0x7c04]
_0x887d:  /*C3          */     ret
_0x887e:  /*E43A        */     in al,0x3a       ; keyboard command/status
_0x8880:  /*A802        */     test al,0x2
_0x8882:  /*C3          */     ret

; ─────────────────────────────────────────────────────────────────────

_0x8883:  /*50          */     push ax
_0x8884:  /*53          */     push bx
_0x8885:  /*06          */     push es
_0x8886:  /*1E          */     push ds
_0x8887:  /*E8F4FF      */     call _0x887e
_0x888a:  /*7422        */     jz _0x88ae
_0x888c:  /*8CCB        */     mov bx,cs
_0x888e:  /*8EDB        */     mov ds,bx
_0x8890:  /*A808        */     test al,0x8
_0x8892:  /*C41EEB7B    */     les bx,[0x7beb]
_0x8896:  /*7404        */     jz _0x889c
_0x8898:  /*C41EEF7B    */     les bx,[0x7bef]
_0x889c:  /*33C0        */     xor ax,ax
_0x889e:  /*E438        */     in al,0x38         ; keyboard data
_0x88a0:  /*D1E0        */     shl ax,1
_0x88a2:  /*03D8        */     add bx,ax
_0x88a4:  /*B035        */     mov al,0x35
_0x88a6:  /*E63A        */     out 0x3a,al        ; keyboard command
_0x88a8:  /*268B07      */     mov ax,[es:bx]
_0x88ab:  /*E80500      */     call _0x88b3
_0x88ae:  /*1F          */     pop ds
_0x88af:  /*07          */     pop es
_0x88b0:  /*5B          */     pop bx
_0x88b1:  /*58          */     pop ax
_0x88b2:  /*CF          */     iret

; ─────────────────────────────────────────────────────────────────────

_0x88b3:  /*32FF        */     xor bh,bh
_0x88b5:  /*8A1ED97B    */     mov bl,[0x7bd9]
_0x88b9:  /*8987DB7B    */     mov [bx+0x7bdb],ax
_0x88bd:  /*80C302      */     add bl,0x2
_0x88c0:  /*80E30F      */     and bl,0xf
_0x88c3:  /*8A3EDA7B    */     mov bh,[0x7bda]
_0x88c7:  /*3ADF        */     cmp bl,bh
_0x88c9:  /*7506        */     jnz _0x88d1
_0x88cb:  /*80EB02      */     sub bl,0x2
_0x88ce:  /*80E30F      */     and bl,0xf
_0x88d1:  /*891ED97B    */     mov [0x7bd9],bx
_0x88d5:  /*C3          */     ret

; ─────────────────────────────────────────────────────────────────────

_0x88d6:  /*53          */     push bx
_0x88d7:  /*FECC        */     dec ah
_0x88d9:  /*7804        */     js _0x88df
_0x88db:  /*7429        */     jz _0x8906
_0x88dd:  /*5B          */     pop bx
_0x88de:  /*C3          */     ret
_0x88df:  /*A0DA7B      */     mov al,[0x7bda]
_0x88e2:  /*3A06D97B    */     cmp al,[0x7bd9]
_0x88e6:  /*74F7        */     jz _0x88df
_0x88e8:  /*32FF        */     xor bh,bh
_0x88ea:  /*8AD8        */     mov bl,al
_0x88ec:  /*8B87DB7B    */     mov ax,[bx+0x7bdb]
_0x88f0:  /*80C302      */     add bl,0x2
_0x88f3:  /*80E30F      */     and bl,0xf
_0x88f6:  /*881EDA7B    */     mov [0x7bda],bl
_0x88fa:  /*BB1987      */     mov bx,0x8719
_0x88fd:  /*87DD        */     xchg bp,bx
_0x88ff:  /*50          */     push ax
_0x8900:  /*E8EDFE      */     call _0x87f0
_0x8903:  /*58          */     pop ax
_0x8904:  /*5B          */     pop bx
_0x8905:  /*C3          */     ret

; ─────────────────────────────────────────────────────────────────────

_0x8906:  /*FA          */     cli
_0x8907:  /*32FF        */     xor bh,bh
_0x8909:  /*A0DA7B      */     mov al,[0x7bda]
_0x890c:  /*3A06D97B    */     cmp al,[0x7bd9]
_0x8910:  /*8AD8        */     mov bl,al
_0x8912:  /*8B87DB7B    */     mov ax,[bx+0x7bdb]
_0x8916:  /*FB          */     sti
_0x8917:  /*5B          */     pop bx
_0x8918:  /*C3          */     ret

; ─────────────────────────────────────────────────────────────────────

; DATA

; times 0x7C3 db

; ─────────────────────────────────────────────────────────────────────

begin:

_0x90db:  /*FA          */     cli
_0x90dc:  /*8CC8        */     mov ax,cs
_0x90de:  /*8ED8        */     mov ds,ax
_0x90e0:  /*8EC0        */     mov es,ax
_0x90e2:  /*8ED0        */     mov ss,ax
_0x90e4:  /*BC3089      */     mov sp,0x8930
_0x90e7:  /*FB          */     sti
_0x90e8:  /*E80C1D      */     call _0xadf7

_0x90eb:  /*E8DA05      */     call _0x96c8
_0x90ee:  /*72FB        */     jc _0x90eb

_0x90f0:  /*E8F90C      */     call _0x9dec
_0x90f3:  /*E8FF00      */     call _0x91f5
_0x90f6:  /*E8A016      */     call _0xa799
_0x90f9:  /*E82518      */     call _0xa921
_0x90fc:  /*E82B1D      */     call _0xae2a
_0x90ff:  /*E81B17      */     call _0xa81d
_0x9102:  /*E89A09      */     call _0x9a9f
_0x9105:  /*BC3089      */     mov sp,0x8930
_0x9108:  /*E8EF0C      */     call _0x9dfa
_0x910b:  /*BB1C8F      */     mov bx,0x8f1c
_0x910e:  /*833F00      */     cmp word [bx],byte +0x0
_0x9111:  /*74F8        */     jz _0x910b
_0x9113:  /*53          */     push bx
_0x9114:  /*FF17        */     call _[bx]
_0x9116:  /*5B          */     pop bx
_0x9117:  /*83C302      */     add bx,byte +0x2
_0x911a:  /*EBF2        */     jmp short _0x910e

; ─────────────────────────────────────────────────────────────────────

;  DATA ????

; ???????????????

; _0x911c:  /*D7          */     xlatb
; _0x911d:  /*96          */     xchg ax,si
; _0x911e:  /*96          */     xchg ax,si
; _0x911f:  /*9E          */     sahf
; _0x9120:  /*46          */     inc si
; _0x9121:  /*A14A8F      */     mov ax,[0x8f4a]
; _0x9124:  /*49          */     dec cx
; _0x9125:  /*A0A18F      */     mov al,[0x8fa1]
; _0x9128:  /*FA          */     cli
; _0x9129:  /*9BFA        */     wait cli
; _0x912b:  /*9B3D9FBC    */     wait cmp ax,0xbc9f
; _0x912f:  /*9F          */     lahf
; _0x9130:  /*8792FE95    */     xchg [bp+si-0x6a02],dx
; _0x9134:  /*F290        */     repne nop
; _0x9136:  /*62965D96    */     bound dx,[bp-0x69a3]
; _0x913a:  /*7B92        */     jpo 0x90ce
; _0x913c:  /*6E          */     outsb
; _0x913d:  /*97          */     xchg ax,di
; _0x913e:  /*0AADE4A0    */     or ch,[di-0x5f1c]
; _0x9142:  /*D000        */     rol byte [bx+si],1
; _0x9144:  /*84A6D000    */     test [bp+0xd0],ah
; _0x9148:  /*0000        */     add [bx+si],al

; ─────────────────────────────────────────────────────────────────────

_0x914a:  /*BE4E89      */     mov si,0x894e
_0x914d:  /*E80300      */     call _0x9153
_0x9150:  /*BE8389      */     mov si,0x8983
_0x9153:  /*F604FF      */     test byte [si],0xff
_0x9156:  /*7901        */     jns _0x9159
_0x9158:  /*C3          */     ret

; ─────────────────────────────────────────────────────────────────────

_0x9159:  /*8B7C2F      */     mov di,[si+0x2f]
_0x915c:  /*BA3001      */     mov dx,0x130
_0x915f:  /*BB3089      */     mov bx,0x8930
_0x9162:  /*807C2E00    */     cmp byte [si+0x2e],0x0
_0x9166:  /*7528        */     jnz _0x9190
_0x9168:  /*803C00      */     cmp byte [si],0x0
_0x916b:  /*7507        */     jnz _0x9174
_0x916d:  /*833EF48D00  */     cmp word [0x8df4],byte +0x0
_0x9172:  /*750B        */     jnz _0x917f
_0x9174:  /*C6443103    */     mov byte [si+0x31],0x3
_0x9178:  /*8B36D18D    */     mov si,[0x8dd1]
_0x917c:  /*E9281D      */     jmp _0xaea7
_0x917f:  /*807C3101    */     cmp byte [si+0x31],0x1
_0x9183:  /*7501        */     jnz _0x9186
_0x9185:  /*C3          */     ret

; ─────────────────────────────────────────────────────────────────────

_0x9186:  /*C6443101    */     mov byte [si+0x31],0x1
_0x918a:  /*BEF00A      */     mov si,0xaf0
_0x918d:  /*E9171D      */     jmp _0xaea7
_0x9190:  /*807C3102    */     cmp byte [si+0x31],0x2
_0x9194:  /*7501        */     jnz _0x9197
_0x9196:  /*C3          */     ret

; ─────────────────────────────────────────────────────────────────────

_0x9197:  /*C6443102    */     mov byte [si+0x31],0x2
_0x919b:  /*BE300A      */     mov si,0xa30
_0x919e:  /*E9061D      */     jmp _0xaea7
_0x91a1:  /*803E4E8900  */     cmp byte [0x894e],0x0
_0x91a6:  /*7501        */     jnz _0x91a9
_0x91a8:  /*C3          */     ret

; ─────────────────────────────────────────────────────────────────────

_0x91a9:  /*803E838900  */     cmp byte [0x8983],0x0
_0x91ae:  /*7501        */     jnz _0x91b1
_0x91b0:  /*C3          */     ret

; ─────────────────────────────────────────────────────────────────────

_0x91b1:  /*FE06D38D    */     inc byte [0x8dd3]
_0x91b5:  /*803ED38D05  */     cmp byte [0x8dd3],0x5
_0x91ba:  /*7301        */     jnc _0x91bd
_0x91bc:  /*C3          */     ret

; ─────────────────────────────────────────────────────────────────────

_0x91bd:  /*BA0100      */     mov dx,0x1
_0x91c0:  /*B93F00      */     mov cx,0x3f
_0x91c3:  /*52          */     push dx
_0x91c4:  /*51          */     push cx
_0x91c5:  /*E8ECF2      */     call _0x84b4
_0x91c8:  /*A1C18D      */     mov ax,[0x8dc1]
_0x91cb:  /*8B1EC38D    */     mov bx,[0x8dc3]
_0x91cf:  /*BECB8C      */     mov si,0x8ccb
_0x91d2:  /*E822F3      */     call _0x84f7
_0x91d5:  /*B9EE02      */     mov cx,0x2ee
_0x91d8:  /*E2FE        */     loop _0x91d8
_0x91da:  /*59          */     pop cx
_0x91db:  /*5A          */     pop dx
_0x91dc:  /*81C20101    */     add dx,0x101
_0x91e0:  /*81E20707    */     and dx,0x707
_0x91e4:  /*E2DD        */     loop _0x91c3
_0x91e6:  /*BE4E89      */     mov si,0x894e
_0x91e9:  /*E81F0A      */     call _0x9c0b
_0x91ec:  /*BE8389      */     mov si,0x8983
_0x91ef:  /*E8190A      */     call _0x9c0b
_0x91f2:  /*E9FEFE      */     jmp _0x90f3

; ─────────────────────────────────────────────────────────────────────

_0x91f5:  /*C706A88D6E7C*/     mov word [0x8da8],0x7c6e
_0x91fb:  /*C606DD8D17  */     mov byte [0x8ddd],0x17
_0x9200:  /*C7065989500B*/     mov word [0x8959],0xb50
_0x9206:  /*C606798903  */     mov byte [0x8979],0x3
_0x920b:  /*C606D98D00  */     mov byte [0x8dd9],0x0
_0x9210:  /*C606A68DFF  */     mov byte [0x8da6],0xff
_0x9215:  /*C606A78D00  */     mov byte [0x8da7],0x0
_0x921a:  /*C3          */     ret

; ─────────────────────────────────────────────────────────────────────

_0x921b:  /*C706007C0000*/     mov word [0x7c00],0x0
_0x9221:  /*C606FE7B50  */     mov byte [0x7bfe],0x50
_0x9226:  /*C606FF7B50  */     mov byte [0x7bff],0x50
_0x922b:  /*8A1EA68D    */     mov bl,[0x8da6]
_0x922f:  /*80FB04      */     cmp bl,0x4
_0x9232:  /*7708        */     ja _0x923c
_0x9234:  /*FE0EA78D    */     dec byte [0x8da7]
_0x9238:  /*7402        */     jz _0x923c
_0x923a:  /*EB0F        */     jmp short _0x924b
_0x923c:  /*8B36A88D    */     mov si,[0x8da8]
_0x9240:  /*8A1C        */     mov bl,[si]
_0x9242:  /*881EA68D    */     mov [0x8da6],bl
_0x9246:  /*46          */     inc si
_0x9247:  /*8936A88D    */     mov [0x8da8],si
_0x924b:  /*32FF        */     xor bh,bh
_0x924d:  /*D1E3        */     shl bx,1
_0x924f:  /*83FB08      */     cmp bx,byte +0x8
_0x9252:  /*770F        */     ja _0x9263
_0x9254:  /*F606A78DFF  */     test byte [0x8da7],0xff
_0x9259:  /*7508        */     jnz _0x9263
_0x925b:  /*AC          */     lodsb
_0x925c:  /*A2A78D      */     mov [0x8da7],al
_0x925f:  /*8936A88D    */     mov [0x8da8],si
_0x9263:  /*FFA7C98E    */     jmp [bx-0x7137]
_0x9267:  /*C3          */     ret

; ─────────────────────────────────────────────────────────────────────

_0x9268:  /*C606FE7B50  */     mov byte [0x7bfe],0x50
_0x926d:  /*C606FF7B00  */     mov byte [0x7bff],0x0
_0x9272:  /*C3          */     ret

; ─────────────────────────────────────────────────────────────────────

_0x9273:  /*C606FE7B96  */     mov byte [0x7bfe],0x96
_0x9278:  /*C606FF7B50  */     mov byte [0x7bff],0x50
_0x927d:  /*C3          */     ret

; ─────────────────────────────────────────────────────────────────────

_0x927e:  /*C606FE7B50  */     mov byte [0x7bfe],0x50
_0x9283:  /*C606FF7B96  */     mov byte [0x7bff],0x96
_0x9288:  /*C3          */     ret

; ─────────────────────────────────────────────────────────────────────

_0x9289:  /*C606FE7B00  */     mov byte [0x7bfe],0x0
_0x928e:  /*C606FF7B50  */     mov byte [0x7bff],0x50
_0x9293:  /*C3          */     ret

; ─────────────────────────────────────────────────────────────────────

_0x9294:  /*56          */     push si
_0x9295:  /*BA0607      */     mov dx,0x706
_0x9298:  /*E819F2      */     call _0x84b4
_0x929b:  /*5E          */     pop si
_0x929c:  /*B80900      */     mov ax,0x9
_0x929f:  /*BB0800      */     mov bx,0x8
_0x92a2:  /*E852F2      */     call _0x84f7
_0x92a5:  /*8936A88D    */     mov [0x8da8],si
_0x92a9:  /*C3          */     ret

; ─────────────────────────────────────────────────────────────────────

_0x92aa:  /*B80900      */     mov ax,0x9
_0x92ad:  /*BB0800      */     mov bx,0x8
_0x92b0:  /*BE898E      */     mov si,0x8e89
_0x92b3:  /*E941F2      */     jmp _0x84f7
_0x92b6:  /*C606007C01  */     mov byte [0x7c00],0x1
_0x92bb:  /*C3          */     ret

; ─────────────────────────────────────────────────────────────────────

_0x92bc:  /*8936A88D    */     mov [0x8da8],si
_0x92c0:  /*8306A88D04  */     add word [0x8da8],byte +0x4
_0x92c5:  /*8BFE        */     mov di,si
_0x92c7:  /*E8B400      */     call _0x937e
_0x92ca:  /*E89E00      */     call _0x936b
_0x92cd:  /*87F7        */     xchg di,si
_0x92cf:  /*AD          */     lodsw
_0x92d0:  /*8905        */     mov [di],ax
_0x92d2:  /*D0E0        */     shl al,1
_0x92d4:  /*D0E4        */     shl ah,1
_0x92d6:  /*894504      */     mov [di+0x4],ax
_0x92d9:  /*AD          */     lodsw
_0x92da:  /*884508      */     mov [di+0x8],al
_0x92dd:  /*886509      */     mov [di+0x9],ah
_0x92e0:  /*87FE        */     xchg si,di
_0x92e2:  /*E87001      */     call _0x9455
_0x92e5:  /*803EDD8D18  */     cmp byte [0x8ddd],0x18
_0x92ea:  /*7401        */     jz _0x92ed
_0x92ec:  /*C3          */     ret

; ─────────────────────────────────────────────────────────────────────

_0x92ed:  /*C6440AFF    */     mov byte [si+0xa],0xff
_0x92f1:  /*C3          */     ret

; ─────────────────────────────────────────────────────────────────────

_0x92f2:  /*BB3689      */     mov bx,0x8936
_0x92f5:  /*BDE960      */     mov bp,0x60e9
_0x92f8:  /*A00A8E      */     mov al,[0x8e0a]
_0x92fb:  /*FEC0        */     inc al
_0x92fd:  /*2403        */     and al,0x3
_0x92ff:  /*A20A8E      */     mov [0x8e0a],al
_0x9302:  /*B4C0        */     mov ah,0xc0
_0x9304:  /*F6E4        */     mul ah
_0x9306:  /*BE4E3A      */     mov si,0x3a4e
_0x9309:  /*03F0        */     add si,ax
_0x930b:  /*8B0EF88D    */     mov cx,[0x8df8]
_0x930f:  /*56          */     push si
_0x9310:  /*E81C00      */     call _0x932f
_0x9313:  /*5E          */     pop si
_0x9314:  /*81C60003    */     add si,0x300
_0x9318:  /*8936D18D    */     mov [0x8dd1],si
_0x931c:  /*B90100      */     mov cx,0x1
_0x931f:  /*BD068E      */     mov bp,0x8e06
_0x9322:  /*803EDD8D01  */     cmp byte [0x8ddd],0x1
_0x9327:  /*7506        */     jnz _0x932f
_0x9329:  /*B91500      */     mov cx,0x15
_0x932c:  /*BD9460      */     mov bp,0x6094
_0x932f:  /*8B16048E    */     mov dx,[0x8e04]
_0x9333:  /*51          */     push cx
_0x9334:  /*32E4        */     xor ah,ah
_0x9336:  /*8A4600      */     mov al,[bp+0x0]
_0x9339:  /*45          */     inc bp
_0x933a:  /*8BF8        */     mov di,ax
_0x933c:  /*D1E7        */     shl di,1
_0x933e:  /*D1E7        */     shl di,1
_0x9340:  /*D1E7        */     shl di,1
_0x9342:  /*D1E7        */     shl di,1
_0x9344:  /*8A4600      */     mov al,[bp+0x0]
_0x9347:  /*45          */     inc bp
_0x9348:  /*0AC0        */     or al,al
_0x934a:  /*781B        */     js _0x9367
_0x934c:  /*F626018E    */     mul byte [0x8e01]
_0x9350:  /*D1E0        */     shl ax,1
_0x9352:  /*D1E0        */     shl ax,1
_0x9354:  /*D1E0        */     shl ax,1
_0x9356:  /*D1E0        */     shl ax,1
_0x9358:  /*D1E0        */     shl ax,1
_0x935a:  /*D1E0        */     shl ax,1
_0x935c:  /*03F8        */     add di,ax
_0x935e:  /*8BC6        */     mov ax,si
_0x9360:  /*55          */     push bp
_0x9361:  /*E8431B      */     call _0xaea7
_0x9364:  /*5D          */     pop bp
_0x9365:  /*8BF0        */     mov si,ax
_0x9367:  /*59          */     pop cx
_0x9368:  /*E2C9        */     loop _0x9333
_0x936a:  /*C3          */     ret

; ─────────────────────────────────────────────────────────────────────

_0x936b:  /*57          */     push di
_0x936c:  /*8BFE        */     mov di,si
_0x936e:  /*B91100      */     mov cx,0x11
_0x9371:  /*B000        */     mov al,0x0
_0x9373:  /*F3AA        */     rep stosb

_0x9375:  /*C684F800FF  */     mov byte [si+0xf8],0xff
_0x937a:  /*FE0C        */     dec byte [si]
_0x937c:  /*5F          */     pop di
_0x937d:  /*C3          */     ret

; ─────────────────────────────────────────────────────────────────────

_0x937e:  /*BE6F8A      */     mov si,0x8a6f
_0x9381:  /*B90A00      */     mov cx,0xa
_0x9384:  /*803CFF      */     cmp byte [si],0xff
_0x9387:  /*7406        */     jz _0x938f
_0x9389:  /*83C611      */     add si,byte +0x11
_0x938c:  /*E2F6        */     loop _0x9384
_0x938e:  /*58          */     pop ax
_0x938f:  /*C3          */     ret

; ─────────────────────────────────────────────────────────────────────

_0x9390:  /*BA0604      */     mov dx,0x406
_0x9393:  /*81FE4E89    */     cmp si,0x894e
_0x9397:  /*7503        */     jnz _0x939c
_0x9399:  /*BA0703      */     mov dx,0x307
_0x939c:  /*BD2B8C      */     mov bp,0x8c2b
_0x939f:  /*B90800      */     mov cx,0x8
_0x93a2:  /*F64600FF    */     test byte [bp+0x0],0xff
_0x93a6:  /*7406        */     jz _0x93ae
_0x93a8:  /*83C50A      */     add bp,byte +0xa
_0x93ab:  /*E2F5        */     loop _0x93a2
_0x93ad:  /*C3          */     ret

; ─────────────────────────────────────────────────────────────────────

_0x93ae:  /*895605      */     mov [bp+0x5],dx
_0x93b1:  /*C646001F    */     mov byte [bp+0x0],0x1f
_0x93b5:  /*B20A        */     mov dl,0xa
_0x93b7:  /*F6F2        */     div dl
_0x93b9:  /*0D3030      */     or ax,0x3030
_0x93bc:  /*894607      */     mov [bp+0x7],ax
_0x93bf:  /*8B441B      */     mov ax,[si+0x1b]
_0x93c2:  /*8ADC        */     mov bl,ah
_0x93c4:  /*32E4        */     xor ah,ah
_0x93c6:  /*32FF        */     xor bh,bh
_0x93c8:  /*B103        */     mov cl,0x3
_0x93ca:  /*D3E0        */     shl ax,cl
_0x93cc:  /*FEC1        */     inc cl
_0x93ce:  /*D3E3        */     shl bx,cl
_0x93d0:  /*40          */     inc ax
_0x93d1:  /*83C302      */     add bx,byte +0x2
_0x93d4:  /*894601      */     mov [bp+0x1],ax
_0x93d7:  /*895E03      */     mov [bp+0x3],bx
_0x93da:  /*C3          */     ret

; ─────────────────────────────────────────────────────────────────────

_0x93db:  /*8B1EFA8D    */     mov bx,[0x8dfa]
_0x93df:  /*D1E3        */     shl bx,1
_0x93e1:  /*8B87E960    */     mov ax,[bx+0x60e9]
_0x93e5:  /*D1EB        */     shr bx,1
_0x93e7:  /*43          */     inc bx
_0x93e8:  /*3B1EF88D    */     cmp bx,[0x8df8]
_0x93ec:  /*7202        */     jc _0x93f0
_0x93ee:  /*33DB        */     xor bx,bx
_0x93f0:  /*891EFA8D    */     mov [0x8dfa],bx
_0x93f4:  /*C3          */     ret

; ─────────────────────────────────────────────────────────────────────

_0x93f5:  /*E886FF      */     call _0x937e
_0x93f8:  /*E870FF      */     call _0x936b
_0x93fb:  /*E8DDFF      */     call _0x93db
_0x93fe:  /*8904        */     mov [si],ax
_0x9400:  /*D0E0        */     shl al,1
_0x9402:  /*D0E4        */     shl ah,1
_0x9404:  /*894404      */     mov [si+0x4],ax
_0x9407:  /*E84EF2      */     call _0x8658
_0x940a:  /*80E503      */     and ch,0x3
_0x940d:  /*886C07      */     mov [si+0x7],ch
_0x9410:  /*886C09      */     mov [si+0x9],ch
_0x9413:  /*B84501      */     mov ax,0x145
_0x9416:  /*803EDE8D00  */     cmp byte [0x8dde],0x0
_0x941b:  /*7503        */     jnz _0x9420
_0x941d:  /*B85802      */     mov ax,0x258
_0x9420:  /*803EDE8D0D  */     cmp byte [0x8dde],0xd
_0x9425:  /*7203        */     jc _0x942a
_0x9427:  /*B81400      */     mov ax,0x14
_0x942a:  /*3906CF8D    */     cmp [0x8dcf],ax
_0x942e:  /*770A        */     ja _0x943a
_0x9430:  /*F6C670      */     test dh,0x70
_0x9433:  /*7516        */     jnz _0x944b
_0x9435:  /*80E607      */     and dh,0x7
_0x9438:  /*7504        */     jnz _0x943e
_0x943a:  /*B609        */     mov dh,0x9
_0x943c:  /*EB14        */     jmp short _0x9452

; ─────────────────────────────────────────────────────────────────────

_0x943e:  /*FECE        */     dec dh
_0x9440:  /*80FE06      */     cmp dh,0x6
_0x9443:  /*7406        */     jz _0x944b
_0x9445:  /*80C603      */     add dh,0x3
_0x9448:  /*EB08        */     jmp short _0x9452

; ─────────────────────────────────────────────────────────────────────

_0x944a:  /*90          */     nop
_0x944b:  /*80E601      */     and dh,0x1
_0x944e:  /*0236FF8D    */     add dh,[0x8dff]
_0x9452:  /*887408      */     mov [si+0x8],dh
_0x9455:  /*8A4408      */     mov al,[si+0x8]
_0x9458:  /*8AE0        */     mov ah,al
_0x945a:  /*BB9C8D      */     mov bx,0x8d9c
_0x945d:  /*D7          */     xlatb
_0x945e:  /*80E107      */     and cl,0x7
_0x9461:  /*D2C0        */     rol al,cl
_0x9463:  /*803EDE8D06  */     cmp byte [0x8dde],0x6
_0x9468:  /*7202        */     jc _0x946c
_0x946a:  /*B0FF        */     mov al,0xff
_0x946c:  /*88440A      */     mov [si+0xa],al
_0x946f:  /*8AC4        */     mov al,ah
_0x9471:  /*BB443A      */     mov bx,0x3a44
_0x9474:  /*D7          */     xlatb
_0x9475:  /*884406      */     mov [si+0x6],al
_0x9478:  /*E92C0D      */     jmp _0xa1a7

; ─────────────────────────────────────────────────────────────────────

_0x947b:  /*BE4D8A      */     mov si,0x8a4d
_0x947e:  /*BF3B8B      */     mov di,0x8b3b
_0x9481:  /*B97800      */     mov cx,0x78
_0x9484:  /*F3A5        */     rep movsw

_0x9486:  /*C3          */     ret

; ─────────────────────────────────────────────────────────────────────

_0x9487:  /*BE4D8A      */     mov si,0x8a4d
_0x948a:  /*BD0E00      */     mov bp,0xe
_0x948d:  /*8A6408      */     mov ah,[si+0x8]
_0x9490:  /*80FC03      */     cmp ah,0x3
_0x9493:  /*720A        */     jc _0x949f
_0x9495:  /*8A5C0E      */     mov bl,[si+0xe]
_0x9498:  /*FEC3        */     inc bl
_0x949a:  /*7403        */     jz _0x949f
_0x949c:  /*885C0E      */     mov [si+0xe],bl
_0x949f:  /*803CFF      */     cmp byte [si],0xff
_0x94a2:  /*7503        */     jnz _0x94a7
_0x94a4:  /*E98701      */     jmp _0x962e

; ─────────────────────────────────────────────────────────────────────

_0x94a7:  /*A0D48D      */     mov al,[0x8dd4]
_0x94aa:  /*22440A      */     and al,[si+0xa]
_0x94ad:  /*7503        */     jnz _0x94b2
_0x94af:  /*E97C01      */     jmp _0x962e

; ─────────────────────────────────────────────────────────────────────

_0x94b2:  /*80FC03      */     cmp ah,0x3
_0x94b5:  /*7209        */     jc _0x94c0
_0x94b7:  /*807C0E08    */     cmp byte [si+0xe],0x8
_0x94bb:  /*7703        */     ja _0x94c0
_0x94bd:  /*E94301      */     jmp _0x9603

; ─────────────────────────────────────────────────────────────────────

_0x94c0:  /*C606D68D00  */     mov byte [0x8dd6],0x0
_0x94c5:  /*8B4402      */     mov ax,[si+0x2]
_0x94c8:  /*0BC0        */     or ax,ax
_0x94ca:  /*755F        */     jnz _0x952b
_0x94cc:  /*E889F1      */     call _0x8658
_0x94cf:  /*807C0803    */     cmp byte [si+0x8],0x3
_0x94d3:  /*7256        */     jc _0x952b
_0x94d5:  /*F6C610      */     test dh,0x10
_0x94d8:  /*7551        */     jnz _0x952b
_0x94da:  /*FE06D68D    */     inc byte [0x8dd6]
_0x94de:  /*8A5C23      */     mov bl,[si+0x23]
_0x94e1:  /*A0CF8D      */     mov al,[0x8dcf]
_0x94e4:  /*A810        */     test al,0x10
_0x94e6:  /*743B        */     jz _0x9523
_0x94e8:  /*BF8389      */     mov di,0x8983
_0x94eb:  /*F6068389FF  */     test byte [0x8983],0xff
_0x94f0:  /*7804        */     js _0x94f6
_0x94f2:  /*A820        */     test al,0x20
_0x94f4:  /*7403        */     jz _0x94f9
_0x94f6:  /*BF4E89      */     mov di,0x894e
_0x94f9:  /*B401        */     mov ah,0x1
_0x94fb:  /*8A451D      */     mov al,[di+0x1d]
_0x94fe:  /*2A4404      */     sub al,[si+0x4]
_0x9501:  /*7904        */     jns _0x9507
_0x9503:  /*F6D8        */     neg al
_0x9505:  /*B403        */     mov ah,0x3
_0x9507:  /*3C02        */     cmp al,0x2
_0x9509:  /*730C        */     jnc _0x9517
_0x950b:  /*32E4        */     xor ah,ah
_0x950d:  /*8A451E      */     mov al,[di+0x1e]
_0x9510:  /*2A4405      */     sub al,[si+0x5]
_0x9513:  /*7802        */     js _0x9517
_0x9515:  /*B402        */     mov ah,0x2
_0x9517:  /*886409      */     mov [si+0x9],ah
_0x951a:  /*53          */     push bx
_0x951b:  /*56          */     push si
_0x951c:  /*E81901      */     call _0x9638
_0x951f:  /*5E          */     pop si
_0x9520:  /*5B          */     pop bx
_0x9521:  /*EB08        */     jmp short _0x952b

; ─────────────────────────────────────────────────────────────────────

_0x9523:  /*D0EA        */     shr dl,1
_0x9525:  /*80E203      */     and dl,0x3
_0x9528:  /*885409      */     mov [si+0x9],dl
_0x952b:  /*807C0803    */     cmp byte [si+0x8],0x3
_0x952f:  /*720A        */     jc _0x953b
_0x9531:  /*A0D58D      */     mov al,[0x8dd5]
_0x9534:  /*0AC0        */     or al,al
_0x9536:  /*7403        */     jz _0x953b
_0x9538:  /*E9C800      */     jmp _0x9603

; ─────────────────────────────────────────────────────────────────────

_0x953b:  /*8A4409      */     mov al,[si+0x9]
_0x953e:  /*FEC8        */     dec al
_0x9540:  /*7812        */     js _0x9554
_0x9542:  /*FEC8        */     dec al
_0x9544:  /*785B        */     js _0x95a1
_0x9546:  /*FEC8        */     dec al
_0x9548:  /*7831        */     js _0x957b
_0x954a:  /*FEC8        */     dec al
_0x954c:  /*7903        */     jns _0x9551
_0x954e:  /*E98A00      */     jmp _0x95db

; ─────────────────────────────────────────────────────────────────────

_0x9551:  /*E9AF00      */     jmp _0x9603

; ─────────────────────────────────────────────────────────────────────

_0x9554:  /*F64403FF    */     test byte [si+0x3],0xff
_0x9558:  /*7518        */     jnz _0x9572
_0x955a:  /*F64401FF    */     test byte [si+0x1],0xff
_0x955e:  /*7503        */     jnz _0x9563
_0x9560:  /*E9A000      */     jmp _0x9603

; ─────────────────────────────────────────────────────────────────────

_0x9563:  /*A0018E      */     mov al,[0x8e01]
_0x9566:  /*F6D8        */     neg al
_0x9568:  /*E81501      */     call _0x9680
_0x956b:  /*C6440302    */     mov byte [si+0x3],0x2
_0x956f:  /*FE4C01      */     dec byte [si+0x1]
_0x9572:  /*FE4C05      */     dec byte [si+0x5]
_0x9575:  /*FE4C03      */     dec byte [si+0x3]
_0x9578:  /*E98800      */     jmp _0x9603

; ─────────────────────────────────────────────────────────────────────

_0x957b:  /*F64403FF    */     test byte [si+0x3],0xff
_0x957f:  /*7510        */     jnz _0x9591
_0x9581:  /*8A4401      */     mov al,[si+0x1]
_0x9584:  /*40          */     inc ax
_0x9585:  /*3A06008E    */     cmp al,[0x8e00]
_0x9589:  /*7478        */     jz _0x9603
_0x958b:  /*A0018E      */     mov al,[0x8e01]
_0x958e:  /*E8EF00      */     call _0x9680
_0x9591:  /*FE4405      */     inc byte [si+0x5]
_0x9594:  /*8A4403      */     mov al,[si+0x3]
_0x9597:  /*3401        */     xor al,0x1
_0x9599:  /*884403      */     mov [si+0x3],al
_0x959c:  /*004401      */     add [si+0x1],al
_0x959f:  /*EB62        */     jmp short _0x9603

; ─────────────────────────────────────────────────────────────────────

_0x95a1:  /*F64402FF    */     test byte [si+0x2],0xff
_0x95a5:  /*750E        */     jnz _0x95b5
_0x95a7:  /*8A04        */     mov al,[si]
_0x95a9:  /*40          */     inc ax
_0x95aa:  /*3A06018E    */     cmp al,[0x8e01]
_0x95ae:  /*7453        */     jz _0x9603
_0x95b0:  /*B001        */     mov al,0x1
_0x95b2:  /*E8CB00      */     call _0x9680
_0x95b5:  /*FE4404      */     inc byte [si+0x4]
_0x95b8:  /*8A4402      */     mov al,[si+0x2]
_0x95bb:  /*3401        */     xor al,0x1
_0x95bd:  /*884402      */     mov [si+0x2],al
_0x95c0:  /*0004        */     add [si],al
_0x95c2:  /*8A6406      */     mov ah,[si+0x6]
_0x95c5:  /*F6C404      */     test ah,0x4
_0x95c8:  /*7439        */     jz _0x9603
_0x95ca:  /*C7440F8001  */     mov word [si+0xf],0x180
_0x95cf:  /*F6C402      */     test ah,0x2
_0x95d2:  /*742F        */     jz _0x9603
_0x95d4:  /*C7440F0003  */     mov word [si+0xf],0x300
_0x95d9:  /*EB28        */     jmp short _0x9603

; ─────────────────────────────────────────────────────────────────────

_0x95db:  /*F64402FF    */     test byte [si+0x2],0xff
_0x95df:  /*7511        */     jnz _0x95f2
_0x95e1:  /*F64404FF    */     test byte [si+0x4],0xff
_0x95e5:  /*741C        */     jz _0x9603
_0x95e7:  /*B0FF        */     mov al,0xff
_0x95e9:  /*E89400      */     call _0x9680
_0x95ec:  /*FE0C        */     dec byte [si]
_0x95ee:  /*C6440202    */     mov byte [si+0x2],0x2
_0x95f2:  /*FE4C04      */     dec byte [si+0x4]
_0x95f5:  /*FE4C02      */     dec byte [si+0x2]
_0x95f8:  /*F6440604    */     test byte [si+0x6],0x4
_0x95fc:  /*7405        */     jz _0x9603
_0x95fe:  /*C7440F0000  */     mov word [si+0xf],0x0
_0x9603:  /*807C0801    */     cmp byte [si+0x8],0x1
_0x9607:  /*7410        */     jz _0x9619
_0x9609:  /*807C0802    */     cmp byte [si+0x8],0x2
_0x960d:  /*7714        */     ja _0x9623
_0x960f:  /*F74402FFFF  */     test word [si+0x2],0xffff
_0x9614:  /*7403        */     jz _0x9619
_0x9616:  /*E922FF      */     jmp _0x953b

; ─────────────────────────────────────────────────────────────────────

_0x9619:  /*FE4C0E      */     dec byte [si+0xe]
_0x961c:  /*7505        */     jnz _0x9623
_0x961e:  /*E84AFD      */     call _0x936b
_0x9621:  /*EB0B        */     jmp short _0x962e

; ─────────────────────────────────────────────────────────────────────

_0x9623:  /*FE4407      */     inc byte [si+0x7]
_0x9626:  /*8A4406      */     mov al,[si+0x6]
_0x9629:  /*2403        */     and al,0x3
_0x962b:  /*204407      */     and [si+0x7],al
_0x962e:  /*83C611      */     add si,byte +0x11
_0x9631:  /*4D          */     dec bp
_0x9632:  /*7403        */     jz _0x9637
_0x9634:  /*E956FE      */     jmp _0x948d

; ─────────────────────────────────────────────────────────────────────

_0x9637:  /*C3          */     ret
_0x9638:  /*807C0809    */     cmp byte [si+0x8],0x9
_0x963c:  /*7401        */     jz _0x963f
_0x963e:  /*C3          */     ret

; ─────────────────────────────────────────────────────────────────────

_0x963f:  /*F74402FFFF  */     test word [si+0x2],0xffff
_0x9644:  /*7401        */     jz _0x9647
_0x9646:  /*C3          */     ret

; ─────────────────────────────────────────────────────────────────────

_0x9647:  /*87F7        */     xchg di,si
_0x9649:  /*E832FD      */     call _0x937e
_0x964c:  /*E81CFD      */     call _0x936b
_0x964f:  /*8A4509      */     mov al,[di+0x9]
_0x9652:  /*884409      */     mov [si+0x9],al
_0x9655:  /*C6440603    */     mov byte [si+0x6],0x3
_0x9659:  /*8B05        */     mov ax,[di]
_0x965b:  /*8904        */     mov [si],ax
_0x965d:  /*8B4504      */     mov ax,[di+0x4]
_0x9660:  /*894404      */     mov [si+0x4],ax
_0x9663:  /*C6440E10    */     mov byte [si+0xe],0x10
_0x9667:  /*C6440802    */     mov byte [si+0x8],0x2
_0x966b:  /*B80600      */     mov ax,0x6
_0x966e:  /*E8316C      */     call _0x2a2
_0x9671:  /*56          */     push si
_0x9672:  /*53          */     push bx
_0x9673:  /*55          */     push bp
_0x9674:  /*BB428E      */     mov bx,0x8e42
_0x9677:  /*E80917      */     call _0xad83
_0x967a:  /*5D          */     pop bp
_0x967b:  /*5B          */     pop bx
_0x967c:  /*5E          */     pop si
_0x967d:  /*E9D5FD      */     jmp _0x9455

; ─────────────────────────────────────────────────────────────────────

_0x9680:  /*98          */     cbw
_0x9681:  /*8BF8        */     mov di,ax
_0x9683:  /*037C0B      */     add di,[si+0xb]
_0x9686:  /*8A05        */     mov al,[di]
_0x9688:  /*3C78        */     cmp al,0x78
_0x968a:  /*7421        */     jz _0x96ad
_0x968c:  /*807C0EFF    */     cmp byte [si+0xe],0xff
_0x9690:  /*7408        */     jz _0x969a
_0x9692:  /*3C40        */     cmp al,0x40
_0x9694:  /*7404        */     jz _0x969a
_0x9696:  /*3C72        */     cmp al,0x72
_0x9698:  /*7504        */     jnz _0x969e
_0x969a:  /*897C0B      */     mov [si+0xb],di
_0x969d:  /*C3          */     ret

; ─────────────────────────────────────────────────────────────────────

_0x969e:  /*3C50        */     cmp al,0x50
_0x96a0:  /*720B        */     jc _0x96ad
_0x96a2:  /*3C53        */     cmp al,0x53
_0x96a4:  /*7707        */     ja _0x96ad
_0x96a6:  /*2C50        */     sub al,0x50
_0x96a8:  /*3A4409      */     cmp al,[si+0x9]
_0x96ab:  /*75ED        */     jnz _0x969a
_0x96ad:  /*58          */     pop ax
_0x96ae:  /*F606D68DFF  */     test byte [0x8dd6],0xff
_0x96b3:  /*740A        */     jz _0x96bf
_0x96b5:  /*FE0ED68D    */     dec byte [0x8dd6]
_0x96b9:  /*885C09      */     mov [si+0x9],bl
_0x96bc:  /*E96CFE      */     jmp _0x952b

; ─────────────────────────────────────────────────────────────────────

_0x96bf:  /*80E503      */     and ch,0x3
_0x96c2:  /*886C09      */     mov [si+0x9],ch
_0x96c5:  /*E93BFF      */     jmp _0x9603

; ─────────────────────────────────────────────────────────────────────

_0x96c8:  /*B202        */     mov dl,0x2
_0x96ca:  /*B90300      */     mov cx,0x3
_0x96cd:  /*80F203      */     xor dl,0x3
_0x96d0:  /*51          */     push cx
_0x96d1:  /*52          */     push dx
_0x96d2:  /*E81B00      */     call _0x96f0
_0x96d5:  /*5A          */     pop dx
_0x96d6:  /*59          */     pop cx
_0x96d7:  /*7304        */     jnc _0x96dd
_0x96d9:  /*E2F5        */     loop _0x96d0
_0x96db:  /*EBED        */     jmp short _0x96ca

; ─────────────────────────────────────────────────────────────────────

_0x96dd:  /*BB4D8A      */     mov bx,0x8a4d
_0x96e0:  /*BA0800      */     mov dx,0x8
_0x96e3:  /*33C0        */     xor ax,ax
_0x96e5:  /*B90100      */     mov cx,0x1
_0x96e8:  /*E8CB71      */     call _0x8b6
_0x96eb:  /*0AC0        */     or al,al
_0x96ed:  /*74EE        */     jz _0x96dd
_0x96ef:  /*C3          */     ret

; ─────────────────────────────────────────────────────────────────────

_0x96f0:  /*32C0        */     xor al,al
_0x96f2:  /*E61C        */     out 0x1c,al         ; floppy
_0x96f4:  /*B004        */     mov al,0x4
_0x96f6:  /*E61E        */     out 0x1e,al         ; PPI control
_0x96f8:  /*B9041A      */     mov cx,0x1a04
_0x96fb:  /*E2FE        */     loop _0x96fb
_0x96fd:  /*B008        */     mov al,0x8
_0x96ff:  /*E608        */     out 0x8,al          ; floppy
_0x9701:  /*D40A        */     aam
_0x9703:  /*D40A        */     aam
_0x9705:  /*D40A        */     aam
_0x9707:  /*E408        */     in al,0x8           ; floppy
_0x9709:  /*A801        */     test al,0x1
_0x970b:  /*75FA        */     jnz _0x9707
_0x970d:  /*A880        */     test al,0x80
_0x970f:  /*740A        */     jz _0x971b
_0x9711:  /*B008        */     mov al,0x8
_0x9713:  /*E608        */     out 0x8,al         ; floppy
_0x9715:  /*D40A        */     aam
_0x9717:  /*D40A        */     aam
_0x9719:  /*EBEC        */     jmp short _0x9707

; ─────────────────────────────────────────────────────────────────────

_0x971b:  /*FA          */     cli
_0x971c:  /*FC          */     cld
_0x971d:  /*B9511B      */     mov cx,0x1b51
_0x9720:  /*E2FE        */     loop _0x9720
_0x9722:  /*8AC2        */     mov al,dl
_0x9724:  /*E60E        */     out 0xe,al          ; floppy
_0x9726:  /*B018        */     mov al,0x18
_0x9728:  /*E608        */     out 0x8,al          ; floppy
_0x972a:  /*D40A        */     aam
_0x972c:  /*D40A        */     aam
_0x972e:  /*D40A        */     aam
_0x9730:  /*D40A        */     aam
_0x9732:  /*D40A        */     aam
_0x9734:  /*E408        */     in al,0x8           ; floppy
_0x9736:  /*A801        */     test al,0x1
_0x9738:  /*75FA        */     jnz _0x9734
_0x973a:  /*A880        */     test al,0x80
_0x973c:  /*7402        */     jz _0x9740
_0x973e:  /*EBDD        */     jmp short _0x971d

; ─────────────────────────────────────────────────────────────────────

_0x9740:  /*B9511B      */     mov cx,0x1b51
_0x9743:  /*E2FE        */     loop _0x9743
_0x9745:  /*BA0800      */     mov dx,0x8
_0x9748:  /*BF4D8A      */     mov di,0x8a4d
_0x974b:  /*B7FC        */     mov bh,0xfc
_0x974d:  /*B302        */     mov bl,0x2
_0x974f:  /*B90002      */     mov cx,0x200
_0x9752:  /*B0E4        */     mov al,0xe4
_0x9754:  /*EE          */     out dx,al         ; floppy
_0x9755:  /*D40A        */     aam
_0x9757:  /*D40A        */     aam
_0x9759:  /*EC          */     in al,dx          ; floppy
_0x975a:  /*A801        */     test al,0x1
_0x975c:  /*74FB        */     jz _0x9759
_0x975e:  /*84C7        */     test bh,al
_0x9760:  /*753A        */     jnz _0x979c
_0x9762:  /*EC          */     in al,dx          ; floppy
_0x9763:  /*84C3        */     test bl,al
_0x9765:  /*7407        */     jz _0x976e
_0x9767:  /*E40E        */     in al,0xe          ; floppy
_0x9769:  /*AA          */     stosb
_0x976a:  /*E2F6        */     loop _0x9762
_0x976c:  /*EB2E        */     jmp short _0x979c

; ─────────────────────────────────────────────────────────────────────

_0x976e:  /*EC          */     in al,dx          ; floppy
_0x976f:  /*84C3        */     test bl,al
_0x9771:  /*7407        */     jz _0x977a
_0x9773:  /*E40E        */     in al,0xe          ; floppy
_0x9775:  /*AA          */     stosb
_0x9776:  /*E2EA        */     loop _0x9762
_0x9778:  /*EB22        */     jmp short _0x979c

; ─────────────────────────────────────────────────────────────────────

_0x977a:  /*EC          */     in al,dx          ; floppy
_0x977b:  /*84C3        */     test bl,al
_0x977d:  /*7407        */     jz _0x9786
_0x977f:  /*E40E        */     in al,0xe          ; floppy
_0x9781:  /*AA          */     stosb
_0x9782:  /*E2DE        */     loop _0x9762
_0x9784:  /*EB16        */     jmp short _0x979c

; ─────────────────────────────────────────────────────────────────────

_0x9786:  /*EC          */     in al,dx          ; floppy
_0x9787:  /*84C3        */     test bl,al
_0x9789:  /*7407        */     jz _0x9792
_0x978b:  /*E40E        */     in al,0xe          ; floppy
_0x978d:  /*AA          */     stosb
_0x978e:  /*E2D2        */     loop _0x9762
_0x9790:  /*EB0A        */     jmp short _0x979c

; ─────────────────────────────────────────────────────────────────────

_0x9792:  /*EC          */     in al,dx          ; floppy
_0x9793:  /*84C3        */     test bl,al
_0x9795:  /*74C7        */     jz _0x975e
_0x9797:  /*E40E        */     in al,0xe          ; floppy
_0x9799:  /*AA          */     stosb
_0x979a:  /*E2C6        */     loop _0x9762
_0x979c:  /*EC          */     in al,dx          ; floppy
_0x979d:  /*FB          */     sti
_0x979e:  /*24F8        */     and al,0xf8
_0x97a0:  /*7402        */     jz _0x97a4
_0x97a2:  /*F9          */     stc
_0x97a3:  /*C3          */     ret

; ─────────────────────────────────────────────────────────────────────

_0x97a4:  /*BEE395      */     mov si,0x95e3
_0x97a7:  /*E81C00      */     call _0x97c6
_0x97aa:  /*7301        */     jnc _0x97ad
_0x97ac:  /*C3          */     ret

; ─────────────────────────────────────────────────────────────────────

_0x97ad:  /*BEEA95      */     mov si,0x95ea
_0x97b0:  /*E81300      */     call _0x97c6
_0x97b3:  /*7301        */     jnc _0x97b6
_0x97b5:  /*C3          */     ret

; ─────────────────────────────────────────────────────────────────────

_0x97b6:  /*BEF395      */     mov si,0x95f3
_0x97b9:  /*E80A00      */     call _0x97c6
_0x97bc:  /*7301        */     jnc _0x97bf
_0x97be:  /*C3          */     ret

; ─────────────────────────────────────────────────────────────────────

_0x97bf:  /*BEF995      */     mov si,0x95f9
_0x97c2:  /*E80100      */     call _0x97c6
_0x97c5:  /*C3          */     ret

; ─────────────────────────────────────────────────────────────────────

_0x97c6:  /*BB4D8A      */     mov bx,0x8a4d
_0x97c9:  /*8BFB        */     mov di,bx
_0x97cb:  /*8B0C        */     mov cx,[si]
_0x97cd:  /*56          */     push si
_0x97ce:  /*83C602      */     add si,byte +0x2
_0x97d1:  /*F3A6        */     repe cmpsb
_0x97d3:  /*5E          */     pop si
_0x97d4:  /*7409        */     jz _0x97df
_0x97d6:  /*43          */     inc bx
_0x97d7:  /*81FB4D8E    */     cmp bx,0x8e4d
_0x97db:  /*7404        */     jz _0x97e1
_0x97dd:  /*EBEA        */     jmp short _0x97c9

; ─────────────────────────────────────────────────────────────────────

_0x97df:  /*F8          */     clc
_0x97e0:  /*C3          */     ret

─────────────────────────────────────────────────────────────────────

_0x97e1:  /*F9          */     stc
_0x97e2:  /*C3          */     ret

─────────────────────────────────────────────────────────────────────

_0x97e3:  /*050087      */     add ax,0x8700
_0x97e6:  /*004300      */     add [bp+di+0x0],al
_0x97e9:  /*0D0700      */     or ax,0x7
_0x97ec:  /*55          */     push bp
_0x97ed:  /*F755F6      */     not word [di-0xa]
_0x97f0:  /*55          */     push bp
_0x97f1:  /*F5          */     cmc
_0x97f2:  /*55          */     push bp
_0x97f3:  /*0400        */     add al,0x0
_0x97f5:  /*2DEEFF      */     sub ax,0xffee
_0x97f8:  /*4E          */     dec si
_0x97f9:  /*0300        */     add ax,[bx+si]
_0x97fb:  /*BC57FF      */     mov sp,0xff57
_0x97fe:  /*FE06F77B    */     inc byte [0x7bf7]
_0x9802:  /*A1048E      */     mov ax,[0x8e04]
_0x9805:  /*051000      */     add ax,0x10
_0x9808:  /*A3D17B      */     mov [0x7bd1],ax
_0x980b:  /*C706D37B3689*/     mov word [0x7bd3],0x8936
_0x9811:  /*BE2B8C      */     mov si,0x8c2b
_0x9814:  /*C706D78D0800*/     mov word [0x8dd7],0x8
_0x981a:  /*F604FF      */     test byte [si],0xff
_0x981d:  /*7424        */     jz _0x9843
_0x981f:  /*FE0C        */     dec byte [si]
_0x9821:  /*740A        */     jz _0x982d
_0x9823:  /*803C05      */     cmp byte [si],0x5
_0x9826:  /*7205        */     jc _0x982d
_0x9828:  /*803C1E      */     cmp byte [si],0x1e
_0x982b:  /*7516        */     jnz _0x9843
_0x982d:  /*8B5405      */     mov dx,[si+0x5]
_0x9830:  /*56          */     push si
_0x9831:  /*E880EC      */     call _0x84b4
_0x9834:  /*5E          */     pop si
_0x9835:  /*56          */     push si
_0x9836:  /*8B4401      */     mov ax,[si+0x1]
_0x9839:  /*8B5C03      */     mov bx,[si+0x3]
_0x983c:  /*8D7407      */     lea si,[si+0x7]
_0x983f:  /*E8B5EC      */     call _0x84f7
_0x9842:  /*5E          */     pop si
_0x9843:  /*83C60A      */     add si,byte +0xa
_0x9846:  /*FF0ED78D    */     dec word [0x8dd7]
_0x984a:  /*75CE        */     jnz _0x981a
_0x984c:  /*C706D17B4001*/     mov word [0x7bd1],0x140
_0x9852:  /*C706D37B3089*/     mov word [0x7bd3],0x8930
_0x9858:  /*FE0EF77B    */     dec byte [0x7bf7]
_0x985c:  /*C3          */     ret

; ─────────────────────────────────────────────────────────────────────

_0x985d:  /*BB3B8B      */     mov bx,0x8b3b
_0x9860:  /*EB03        */     jmp short _0x9865

; ─────────────────────────────────────────────────────────────────────

_0x9862:  /*BB4D8A      */     mov bx,0x8a4d
_0x9865:  /*C706D78D0E00*/     mov word [0x8dd7],0xe
_0x986b:  /*803FFF      */     cmp byte [bx],0xff
_0x986e:  /*745D        */     jz _0x98cd
_0x9870:  /*A0D48D      */     mov al,[0x8dd4]
_0x9873:  /*22470A      */     and al,[bx+0xa]
_0x9876:  /*7455        */     jz _0x98cd
_0x9878:  /*32F6        */     xor dh,dh
_0x987a:  /*8A5704      */     mov dl,[bx+0x4]
_0x987d:  /*8BFA        */     mov di,dx
_0x987f:  /*D1E7        */     shl di,1
_0x9881:  /*D1E7        */     shl di,1
_0x9883:  /*D1E7        */     shl di,1
_0x9885:  /*8A4705      */     mov al,[bx+0x5]
_0x9888:  /*F626018E    */     mul byte [0x8e01]
_0x988c:  /*D1E0        */     shl ax,1
_0x988e:  /*D1E0        */     shl ax,1
_0x9890:  /*D1E0        */     shl ax,1
_0x9892:  /*D1E0        */     shl ax,1
_0x9894:  /*D1E0        */     shl ax,1
_0x9896:  /*03F8        */     add di,ax
_0x9898:  /*8A5708      */     mov dl,[bx+0x8]
_0x989b:  /*8BF2        */     mov si,dx
_0x989d:  /*D1E6        */     shl si,1
_0x989f:  /*8BB4303A    */     mov si,[si+0x3a30]
_0x98a3:  /*8A5707      */     mov dl,[bx+0x7]
_0x98a6:  /*D1E2        */     shl dx,1
_0x98a8:  /*D1E2        */     shl dx,1
_0x98aa:  /*D1E2        */     shl dx,1
_0x98ac:  /*D1E2        */     shl dx,1
_0x98ae:  /*D1E2        */     shl dx,1
_0x98b0:  /*D1E2        */     shl dx,1
_0x98b2:  /*8BC2        */     mov ax,dx
_0x98b4:  /*D1E2        */     shl dx,1
_0x98b6:  /*03F0        */     add si,ax
_0x98b8:  /*03F2        */     add si,dx
_0x98ba:  /*03770F      */     add si,[bx+0xf]
_0x98bd:  /*53          */     push bx
_0x98be:  /*807F0809    */     cmp byte [bx+0x8],0x9
_0x98c2:  /*BB1200      */     mov bx,0x12
_0x98c5:  /*7402        */     jz _0x98c9
_0x98c7:  /*33DB        */     xor bx,bx
_0x98c9:  /*E86E05      */     call _0x9e3a
_0x98cc:  /*5B          */     pop bx
_0x98cd:  /*83C311      */     add bx,byte +0x11
_0x98d0:  /*FF0ED78D    */     dec word [0x8dd7]
_0x98d4:  /*7595        */     jnz _0x986b
_0x98d6:  /*C3          */     ret

; ─────────────────────────────────────────────────────────────────────

_0x98d7:  /*E8F3ED      */     call _0x86cd
_0x98da:  /*A1057C      */     mov ax,[0x7c05]
_0x98dd:  /*3C53        */     cmp al,0x53
_0x98df:  /*7404        */     jz _0x98e5
_0x98e1:  /*3C73        */     cmp al,0x73
_0x98e3:  /*7505        */     jnz _0x98ea
_0x98e5:  /*8036B88D01  */     xor byte [0x8db8],0x1
_0x98ea:  /*3C11        */     cmp al,0x11
_0x98ec:  /*7503        */     jnz _0x98f1
_0x98ee:  /*E902F8      */     jmp _0x90f3

; ─────────────────────────────────────────────────────────────────────

_0x98f1:  /*803EDD8D16  */     cmp byte [0x8ddd],0x16
_0x98f6:  /*7642        */     jna 0x993a
_0x98f8:  /*80EC3B      */     sub ah,0x3b
_0x98fb:  /*7901        */     jns _0x98fe
_0x98fd:  /*C3          */     ret

; ─────────────────────────────────────────────────────────────────────

_0x98fe:  /*3A26DA8D    */     cmp ah,[0x8dda]
_0x9902:  /*7201        */     jc _0x9905
_0x9904:  /*C3          */     ret

; ─────────────────────────────────────────────────────────────────────

_0x9905:  /*C606798901  */     mov byte [0x8979],0x1
_0x990a:  /*C70659890000*/     mov word [0x8959],0x0
_0x9910:  /*C606AE8900  */     mov byte [0x89ae],0x0
_0x9915:  /*C606D98D00  */     mov byte [0x8dd9],0x0
_0x991a:  /*C606DD8D01  */     mov byte [0x8ddd],0x1
_0x991f:  /*0AE4        */     or ah,ah
_0x9921:  /*7504        */     jnz _0x9927
_0x9923:  /*FE0E7989    */     dec byte [0x8979]
_0x9927:  /*80FC02      */     cmp ah,0x2
_0x992a:  /*7605        */     jna 0x9931
_0x992c:  /*C606AE8902  */     mov byte [0x89ae],0x2
_0x9931:  /*7204        */     jc _0x9937
_0x9933:  /*FE06D98D    */     inc byte [0x8dd9]
_0x9937:  /*E9BCF7      */     jmp _0x90f6

; ─────────────────────────────────────────────────────────────────────

_0x993a:  /*3C70        */     cmp al,0x70
_0x993c:  /*7405        */     jz _0x9943
_0x993e:  /*3C50        */     cmp al,0x50
_0x9940:  /*7401        */     jz _0x9943
_0x9942:  /*C3          */     ret

; ─────────────────────────────────────────────────────────────────────

_0x9943:  /*BA0307      */     mov dx,0x703
_0x9946:  /*E86BEB      */     call _0x84b4
_0x9949:  /*A1C18D      */     mov ax,[0x8dc1]
_0x994c:  /*8B1EC38D    */     mov bx,[0x8dc3]
_0x9950:  /*BE858C      */     mov si,0x8c85
_0x9953:  /*E8A1EB      */     call _0x84f7
_0x9956:  /*E874ED      */     call _0x86cd
_0x9959:  /*803E057C20  */     cmp byte [0x7c05],0x20
_0x995e:  /*75F6        */     jnz _0x9956
_0x9960:  /*A1C18D      */     mov ax,[0x8dc1]
_0x9963:  /*8B1EC38D    */     mov bx,[0x8dc3]
_0x9967:  /*BE998C      */     mov si,0x8c99
_0x996a:  /*E88AEB      */     call _0x84f7
_0x996d:  /*C3          */     ret

; ─────────────────────────────────────────────────────────────────────

_0x996e:  /*F606D58DFF  */     test byte [0x8dd5],0xff
_0x9973:  /*7404        */     jz _0x9979
_0x9975:  /*FE0ED58D    */     dec byte [0x8dd5]
_0x9979:  /*D006D48D    */     rol byte [0x8dd4],1
_0x997d:  /*FF06CF8D    */     inc word [0x8dcf]
_0x9981:  /*7506        */     jnz _0x9989
_0x9983:  /*812ECF8D0001*/     sub word [0x8dcf],0x100
_0x9989:  /*803EDD8D16  */     cmp byte [0x8ddd],0x16
_0x998e:  /*773F        */     ja _0x99cf
_0x9990:  /*B00F        */     mov al,0xf
_0x9992:  /*813ECF8D4501*/     cmp word [0x8dcf],0x145
_0x9998:  /*770C        */     ja _0x99a6
_0x999a:  /*B007        */     mov al,0x7
_0x999c:  /*813ECF8D9600*/     cmp word [0x8dcf],0x96
_0x99a2:  /*7202        */     jc _0x99a6
_0x99a4:  /*B003        */     mov al,0x3
_0x99a6:  /*8406CF8D    */     test [0x8dcf],al
_0x99aa:  /*7503        */     jnz _0x99af
_0x99ac:  /*E846FA      */     call _0x93f5
_0x99af:  /*B84501      */     mov ax,0x145
_0x99b2:  /*803EDE8D00  */     cmp byte [0x8dde],0x0
_0x99b7:  /*7703        */     ja _0x99bc
_0x99b9:  /*B85802      */     mov ax,0x258
_0x99bc:  /*3906CF8D    */     cmp [0x8dcf],ax
_0x99c0:  /*750D        */     jnz _0x99cf
_0x99c2:  /*A1C18D      */     mov ax,[0x8dc1]
_0x99c5:  /*8B1EC38D    */     mov bx,[0x8dc3]
_0x99c9:  /*BEDF8C      */     mov si,0x8cdf
_0x99cc:  /*E828EB      */     call _0x84f7
_0x99cf:  /*C3          */     ret

; ─────────────────────────────────────────────────────────────────────

_0x99d0:  /*8BFB        */     mov di,bx
_0x99d2:  /*81E7F8FF    */     and di,0xfff8
_0x99d6:  /*D1EF        */     shr di,1
_0x99d8:  /*8AC8        */     mov cl,al
_0x99da:  /*80E103      */     and cl,0x3
_0x99dd:  /*32ED        */     xor ch,ch
_0x99df:  /*03F9        */     add di,cx
_0x99e1:  /*24FC        */     and al,0xfc
_0x99e3:  /*B450        */     mov ah,0x50
_0x99e5:  /*F6E4        */     mul ah
_0x99e7:  /*03F8        */     add di,ax
_0x99e9:  /*8E063289    */     mov es,[0x8932]
_0x99ed:  /*8E1E3489    */     mov ds,[0x8934]
_0x99f1:  /*C3          */     ret

; ─────────────────────────────────────────────────────────────────────

_0x99f2:  /*E8DBFF      */     call _0x99d0
_0x99f5:  /*8BCB        */     mov cx,bx
_0x99f7:  /*81E10700    */     and cx,0x7
_0x99fb:  /*740C        */     jz _0x9a09
_0x99fd:  /*B0FF        */     mov al,0xff
_0x99ff:  /*D2E8        */     shr al,cl
_0x9a01:  /*24CC        */     and al,0xcc
_0x9a03:  /*8805        */     mov [di],al
_0x9a05:  /*AA          */     stosb
_0x9a06:  /*83C703      */     add di,byte +0x3
_0x9a09:  /*8BCA        */     mov cx,dx
_0x9a0b:  /*83C307      */     add bx,byte +0x7
_0x9a0e:  /*81E3F8FF    */     and bx,0xfff8
_0x9a12:  /*2BCB        */     sub cx,bx
_0x9a14:  /*41          */     inc cx
_0x9a15:  /*D1E9        */     shr cx,1
_0x9a17:  /*D1E9        */     shr cx,1
_0x9a19:  /*D1E9        */     shr cx,1
_0x9a1b:  /*B0CC        */     mov al,0xcc
_0x9a1d:  /*8805        */     mov [di],al
_0x9a1f:  /*AA          */     stosb
_0x9a20:  /*83C703      */     add di,byte +0x3
_0x9a23:  /*E2F8        */     loop _0x9a1d
_0x9a25:  /*8BCA        */     mov cx,dx
_0x9a27:  /*81E10700    */     and cx,0x7
_0x9a2b:  /*740C        */     jz _0x9a39
_0x9a2d:  /*41          */     inc cx
_0x9a2e:  /*B0FF        */     mov al,0xff
_0x9a30:  /*D2E8        */     shr al,cl
_0x9a32:  /*F6D0        */     not al
_0x9a34:  /*24CC        */     and al,0xcc
_0x9a36:  /*8805        */     mov [di],al
_0x9a38:  /*AA          */     stosb
_0x9a39:  /*8CC8        */     mov ax,cs
_0x9a3b:  /*8ED8        */     mov ds,ax
_0x9a3d:  /*8EC0        */     mov es,ax
_0x9a3f:  /*C3          */     ret

; ─────────────────────────────────────────────────────────────────────

_0x9a40:  /*50          */     push ax
_0x9a41:  /*E88CFF      */     call _0x99d0
_0x9a44:  /*B8CC33      */     mov ax,0x33cc
_0x9a47:  /*B5C0        */     mov ch,0xc0
_0x9a49:  /*8ACB        */     mov cl,bl
_0x9a4b:  /*80E107      */     and cl,0x7
_0x9a4e:  /*D2CD        */     ror ch,cl
_0x9a50:  /*22C5        */     and al,ch
_0x9a52:  /*22E5        */     and ah,ch
_0x9a54:  /*5B          */     pop bx
_0x9a55:  /*2AD3        */     sub dl,bl
_0x9a57:  /*32F6        */     xor dh,dh
_0x9a59:  /*42          */     inc dx
_0x9a5a:  /*8BCA        */     mov cx,dx
_0x9a5c:  /*0805        */     or [di],al
_0x9a5e:  /*260805      */     or [es:di],al
_0x9a61:  /*47          */     inc di
_0x9a62:  /*86C4        */     xchg ah,al
_0x9a64:  /*F7C70300    */     test di,0x3
_0x9a68:  /*7404        */     jz _0x9a6e
_0x9a6a:  /*E2F0        */     loop _0x9a5c
_0x9a6c:  /*EB06        */     jmp short _0x9a74

; ─────────────────────────────────────────────────────────────────────

_0x9a6e:  /*81C73C01    */     add di,0x13c
_0x9a72:  /*E2E8        */     loop _0x9a5c
_0x9a74:  /*8CC8        */     mov ax,cs
_0x9a76:  /*8ED8        */     mov ds,ax
_0x9a78:  /*8EC0        */     mov es,ax
_0x9a7a:  /*C3          */     ret

; ─────────────────────────────────────────────────────────────────────

_0x9a7b:  /*F7C30300    */     test bx,0x3
_0x9a7f:  /*7407        */     jz _0x9a88
_0x9a81:  /*83C304      */     add bx,byte +0x4
_0x9a84:  /*81E3FCFF    */     and bx,0xfffc
_0x9a88:  /*8BCB        */     mov cx,bx
_0x9a8a:  /*83C302      */     add bx,byte +0x2
_0x9a8d:  /*50          */     push ax
_0x9a8e:  /*24FE        */     and al,0xfe
_0x9a90:  /*8BD0        */     mov dx,ax
_0x9a92:  /*D1E2        */     shl dx,1
_0x9a94:  /*B050        */     mov al,0x50
_0x9a96:  /*F6E1        */     mul cl
_0x9a98:  /*03D0        */     add dx,ax
_0x9a9a:  /*83C218      */     add dx,byte +0x18
_0x9a9d:  /*58          */     pop ax
_0x9a9e:  /*C3          */     ret

; ─────────────────────────────────────────────────────────────────────

_0x9a9f:  /*8B36FC8D    */     mov si,[0x8dfc]
_0x9aa3:  /*A1048E      */     mov ax,[0x8e04]
_0x9aa6:  /*051000      */     add ax,0x10
_0x9aa9:  /*A3D17B      */     mov [0x7bd1],ax
_0x9aac:  /*C706D37B3689*/     mov word [0x7bd3],0x8936
_0x9ab2:  /*E842EA      */     call _0x84f7
_0x9ab5:  /*C706D17B4001*/     mov word [0x7bd1],0x140
_0x9abb:  /*C706D37B3089*/     mov word [0x7bd3],0x8930
_0x9ac1:  /*56          */     push si
_0x9ac2:  /*E8D0EB      */     call _0x8695
_0x9ac5:  /*8B36C58D    */     mov si,[0x8dc5]
_0x9ac9:  /*803CFF      */     cmp byte [si],0xff
_0x9acc:  /*740C        */     jz _0x9ada
_0x9ace:  /*AD          */     lodsw
_0x9acf:  /*8BD8        */     mov bx,ax
_0x9ad1:  /*AD          */     lodsw
_0x9ad2:  /*8BD0        */     mov dx,ax
_0x9ad4:  /*AC          */     lodsb
_0x9ad5:  /*E81AFF      */     call _0x99f2
_0x9ad8:  /*EBEF        */     jmp short _0x9ac9

; ─────────────────────────────────────────────────────────────────────

_0x9ada:  /*46          */     inc si
_0x9adb:  /*803CFF      */     cmp byte [si],0xff
_0x9ade:  /*7410        */     jz _0x9af0
_0x9ae0:  /*AC          */     lodsb
_0x9ae1:  /*8AC8        */     mov cl,al
_0x9ae3:  /*AC          */     lodsb
_0x9ae4:  /*8AD0        */     mov dl,al
_0x9ae6:  /*AD          */     lodsw
_0x9ae7:  /*8BD8        */     mov bx,ax
_0x9ae9:  /*8AC1        */     mov al,cl
_0x9aeb:  /*E852FF      */     call _0x9a40
_0x9aee:  /*EBEB        */     jmp short _0x9adb

; ─────────────────────────────────────────────────────────────────────

_0x9af0:  /*BA0603      */     mov dx,0x306
_0x9af3:  /*E8BEE9      */     call _0x84b4
_0x9af6:  /*A1B98D      */     mov ax,[0x8db9]
_0x9af9:  /*8ADC        */     mov bl,ah
_0x9afb:  /*0AE0        */     or ah,al
_0x9afd:  /*7424        */     jz _0x9b23
_0x9aff:  /*32E4        */     xor ah,ah
_0x9b01:  /*32FF        */     xor bh,bh
_0x9b03:  /*BE7B8C      */     mov si,0x8c7b
_0x9b06:  /*E8EEE9      */     call _0x84f7
_0x9b09:  /*BEB58C      */     mov si,0x8cb5
_0x9b0c:  /*803E7489FF  */     cmp byte [0x8974],0xff
_0x9b11:  /*7403        */     jz _0x9b16
_0x9b13:  /*BEC48C      */     mov si,0x8cc4
_0x9b16:  /*E8DEE9      */     call _0x84f7
_0x9b19:  /*E85FFF      */     call _0x9a7b
_0x9b1c:  /*89167D89    */     mov [0x897d],dx
_0x9b20:  /*E8D4E9      */     call _0x84f7
_0x9b23:  /*BA0604      */     mov dx,0x406
_0x9b26:  /*E88BE9      */     call _0x84b4
_0x9b29:  /*A1BB8D      */     mov ax,[0x8dbb]
_0x9b2c:  /*8ADC        */     mov bl,ah
_0x9b2e:  /*0AE0        */     or ah,al
_0x9b30:  /*7424        */     jz _0x9b56
_0x9b32:  /*32E4        */     xor ah,ah
_0x9b34:  /*32FF        */     xor bh,bh
_0x9b36:  /*BE7B8C      */     mov si,0x8c7b
_0x9b39:  /*E8BBE9      */     call _0x84f7
_0x9b3c:  /*BEB58C      */     mov si,0x8cb5
_0x9b3f:  /*803EA989FF  */     cmp byte [0x89a9],0xff
_0x9b44:  /*7403        */     jz _0x9b49
_0x9b46:  /*BEC48C      */     mov si,0x8cc4
_0x9b49:  /*E8ABE9      */     call _0x84f7
_0x9b4c:  /*E82CFF      */     call _0x9a7b
_0x9b4f:  /*8916B289    */     mov [0x89b2],dx
_0x9b53:  /*E8A1E9      */     call _0x84f7
_0x9b56:  /*FE0E5789    */     dec byte [0x8957]
_0x9b5a:  /*FF0E5189    */     dec word [0x8951]
_0x9b5e:  /*FE0E8C89    */     dec byte [0x898c]
_0x9b62:  /*FF0E8689    */     dec word [0x8986]
_0x9b66:  /*FE067689    */     inc byte [0x8976]
_0x9b6a:  /*F606D98DFF  */     test byte [0x8dd9],0xff
_0x9b6f:  /*7404        */     jz _0x9b75
_0x9b71:  /*FE06AB89    */     inc byte [0x89ab]
_0x9b75:  /*E89213      */     call _0xaf0a
_0x9b78:  /*BA0306      */     mov dx,0x603
_0x9b7b:  /*E836E9      */     call _0x84b4
_0x9b7e:  /*A1BD8D      */     mov ax,[0x8dbd]
_0x9b81:  /*8ADC        */     mov bl,ah
_0x9b83:  /*32E4        */     xor ah,ah
_0x9b85:  /*32FF        */     xor bh,bh
_0x9b87:  /*5E          */     pop si
_0x9b88:  /*E86CE9      */     call _0x84f7
_0x9b8b:  /*803EDD8D16  */     cmp byte [0x8ddd],0x16
_0x9b90:  /*7732        */     ja _0x9bc4
_0x9b92:  /*050200      */     add ax,0x2
_0x9b95:  /*53          */     push bx
_0x9b96:  /*8A1EDD8D    */     mov bl,[0x8ddd]
_0x9b9a:  /*32FF        */     xor bh,bh
_0x9b9c:  /*8A977960    */     mov dl,[bx+0x6079]
_0x9ba0:  /*D0EA        */     shr dl,1
_0x9ba2:  /*D0EA        */     shr dl,1
_0x9ba4:  /*FEC2        */     inc dl
_0x9ba6:  /*80CA30      */     or dl,0x30
_0x9ba9:  /*8816AE8C    */     mov [0x8cae],dl
_0x9bad:  /*8A977960    */     mov dl,[bx+0x6079]
_0x9bb1:  /*80E203      */     and dl,0x3
_0x9bb4:  /*FEC2        */     inc dl
_0x9bb6:  /*80CA40      */     or dl,0x40
_0x9bb9:  /*8816AF8C    */     mov [0x8caf],dl
_0x9bbd:  /*5B          */     pop bx
_0x9bbe:  /*BEAD8C      */     mov si,0x8cad
_0x9bc1:  /*E833E9      */     call _0x84f7
_0x9bc4:  /*E82F00      */     call _0x9bf6
_0x9bc7:  /*803EDD8D16  */     cmp byte [0x8ddd],0x16
_0x9bcc:  /*7701        */     ja _0x9bcf
_0x9bce:  /*C3          */     ret
_0x9bcf:  /*B86600      */     mov ax,0x66
_0x9bd2:  /*BB5600      */     mov bx,0x56
_0x9bd5:  /*8A0EDA8D    */     mov cl,[0x8dda]
_0x9bd9:  /*32ED        */     xor ch,ch
_0x9bdb:  /*80F904      */     cmp cl,0x4
_0x9bde:  /*740B        */     jz _0x9beb
_0x9be0:  /*BB5C00      */     mov bx,0x5c
_0x9be3:  /*80F903      */     cmp cl,0x3
_0x9be6:  /*7403        */     jz _0x9beb
_0x9be8:  /*BB6800      */     mov bx,0x68
_0x9beb:  /*BE077C      */     mov si,0x7c07
_0x9bee:  /*51          */     push cx
_0x9bef:  /*E805E9      */     call _0x84f7
_0x9bf2:  /*59          */     pop cx
_0x9bf3:  /*E2F9        */     loop _0x9bee
_0x9bf5:  /*C3          */     ret
_0x9bf6:  /*A1BF8D      */     mov ax,[0x8dbf]
_0x9bf9:  /*8ADC        */     mov bl,ah
_0x9bfb:  /*32E4        */     xor ah,ah
_0x9bfd:  /*32FF        */     xor bh,bh
_0x9bff:  /*BEB889      */     mov si,0x89b8
_0x9c02:  /*E8F2E8      */     call _0x84f7
_0x9c05:  /*83C304      */     add bx,byte +0x4
_0x9c08:  /*E9ECE8      */     jmp _0x84f7

; ─────────────────────────────────────────────────────────────────────

_0x9c0b:  /*F604FF      */     test byte [si],0xff
_0x9c0e:  /*7901        */     jns _0x9c11
_0x9c10:  /*C3          */     ret
_0x9c11:  /*8B4403      */     mov ax,[si+0x3]
_0x9c14:  /*BB438A      */     mov bx,0x8a43
_0x9c17:  /*8B16BF8D    */     mov dx,[0x8dbf]
_0x9c1b:  /*81C20010    */     add dx,0x1000
_0x9c1f:  /*BFD389      */     mov di,0x89d3
_0x9c22:  /*B90500      */     mov cx,0x5
_0x9c25:  /*3B07        */     cmp ax,[bx]
_0x9c27:  /*770C        */     ja _0x9c35
_0x9c29:  /*83C302      */     add bx,byte +0x2
_0x9c2c:  /*83C717      */     add di,byte +0x17
_0x9c2f:  /*80C60C      */     add dh,0xc
_0x9c32:  /*E2F1        */     loop _0x9c25
_0x9c34:  /*C3          */     ret

; ─────────────────────────────────────────────────────────────────────

_0x9c35:  /*8916C78D    */     mov [0x8dc7],dx
_0x9c39:  /*56          */     push si
_0x9c3a:  /*57          */     push di
_0x9c3b:  /*49          */     dec cx
_0x9c3c:  /*BD4B8A      */     mov bp,0x8a4b
_0x9c3f:  /*7422        */     jz _0x9c63
_0x9c41:  /*BF2F8A      */     mov di,0x8a2f
_0x9c44:  /*BE188A      */     mov si,0x8a18
_0x9c47:  /*51          */     push cx
_0x9c48:  /*56          */     push si
_0x9c49:  /*57          */     push di
_0x9c4a:  /*B91300      */     mov cx,0x13
_0x9c4d:  /*F3A4        */     rep movsb

_0x9c4f:  /*5F          */     pop di
_0x9c50:  /*5E          */     pop si
_0x9c51:  /*59          */     pop cx
_0x9c52:  /*83EF17      */     sub di,byte +0x17
_0x9c55:  /*83EE17      */     sub si,byte +0x17
_0x9c58:  /*8B56FE      */     mov dx,[bp-0x2]
_0x9c5b:  /*895600      */     mov [bp+0x0],dx
_0x9c5e:  /*83ED02      */     sub bp,byte +0x2
_0x9c61:  /*E2E4        */     loop _0x9c47
_0x9c63:  /*894600      */     mov [bp+0x0],ax
_0x9c66:  /*5F          */     pop di
_0x9c67:  /*5E          */     pop si
_0x9c68:  /*57          */     push di
_0x9c69:  /*B91300      */     mov cx,0x13
_0x9c6c:  /*B020        */     mov al,0x20
_0x9c6e:  /*F3AA        */     rep stosb

_0x9c70:  /*5F          */     pop di
_0x9c71:  /*4F          */     dec di
_0x9c72:  /*B90500      */     mov cx,0x5
_0x9c75:  /*56          */     push si
_0x9c76:  /*8D7404      */     lea si,[si+0x4]
_0x9c79:  /*47          */     inc di
_0x9c7a:  /*46          */     inc si
_0x9c7b:  /*803C30      */     cmp byte [si],0x30
_0x9c7e:  /*E1F9        */     loope 0x9c79
_0x9c80:  /*41          */     inc cx
_0x9c81:  /*F3A4        */     rep movsb

_0x9c83:  /*47          */     inc di
_0x9c84:  /*893EC98D    */     mov [0x8dc9],di
_0x9c88:  /*C706CB8D0000*/     mov word [0x8dcb],0x0
_0x9c8e:  /*E865FF      */     call _0x9bf6
_0x9c91:  /*5E          */     pop si
_0x9c92:  /*BA0406      */     mov dx,0x604
_0x9c95:  /*81FE4E89    */     cmp si,0x894e
_0x9c99:  /*BEF68C      */     mov si,0x8cf6
_0x9c9c:  /*7403        */     jz _0x9ca1
_0x9c9e:  /*BE0A8D      */     mov si,0x8d0a
_0x9ca1:  /*81EA0101    */     sub dx,0x101
_0x9ca5:  /*81E20707    */     and dx,0x707
_0x9ca9:  /*52          */     push dx
_0x9caa:  /*56          */     push si
_0x9cab:  /*E806E8      */     call _0x84b4
_0x9cae:  /*A1C18D      */     mov ax,[0x8dc1]
_0x9cb1:  /*8B1EC38D    */     mov bx,[0x8dc3]
_0x9cb5:  /*E83FE8      */     call _0x84f7
_0x9cb8:  /*E812EA      */     call _0x86cd
_0x9cbb:  /*A1057C      */     mov ax,[0x7c05]
_0x9cbe:  /*0AE4        */     or ah,ah
_0x9cc0:  /*7428        */     jz _0x9cea
_0x9cc2:  /*3C20        */     cmp al,0x20
_0x9cc4:  /*7224        */     jc _0x9cea
_0x9cc6:  /*3C7A        */     cmp al,0x7a
_0x9cc8:  /*7720        */     ja _0x9cea
_0x9cca:  /*3C61        */     cmp al,0x61
_0x9ccc:  /*7202        */     jc _0x9cd0
_0x9cce:  /*24DF        */     and al,0xdf
_0x9cd0:  /*3C5A        */     cmp al,0x5a
_0x9cd2:  /*7716        */     ja _0x9cea
_0x9cd4:  /*8B1ECB8D    */     mov bx,[0x8dcb]
_0x9cd8:  /*8B3EC98D    */     mov di,[0x8dc9]
_0x9cdc:  /*8801        */     mov [bx+di],al
_0x9cde:  /*43          */     inc bx
_0x9cdf:  /*83FB0D      */     cmp bx,byte +0xd
_0x9ce2:  /*7439        */     jz _0x9d1d
_0x9ce4:  /*891ECB8D    */     mov [0x8dcb],bx
_0x9ce8:  /*EB33        */     jmp short _0x9d1d

; ─────────────────────────────────────────────────────────────────────

_0x9cea:  /*3C08        */     cmp al,0x8
_0x9cec:  /*751B        */     jnz _0x9d09
_0x9cee:  /*FF0ECB8D    */     dec word [0x8dcb]
_0x9cf2:  /*7904        */     jns _0x9cf8
_0x9cf4:  /*FF06CB8D    */     inc word [0x8dcb]
_0x9cf8:  /*8B1ECB8D    */     mov bx,[0x8dcb]
_0x9cfc:  /*8B3EC98D    */     mov di,[0x8dc9]
_0x9d00:  /*C60120      */     mov byte [bx+di],0x20
_0x9d03:  /*C6450C20    */     mov byte [di+0xc],0x20
_0x9d07:  /*EB14        */     jmp short _0x9d1d

; ─────────────────────────────────────────────────────────────────────

_0x9d09:  /*3C0D        */     cmp al,0xd
_0x9d0b:  /*7506        */     jnz _0x9d13
_0x9d0d:  /*83C404      */     add sp,byte +0x4
_0x9d10:  /*EB2F        */     jmp short _0x9d41

; ─────────────────────────────────────────────────────────────────────

_0x9d12:  /*90          */     nop
_0x9d13:  /*3D0053      */     cmp ax,0x5300
_0x9d16:  /*74D6        */     jz _0x9cee
_0x9d18:  /*3D004B      */     cmp ax,0x4b00
_0x9d1b:  /*74D1        */     jz _0x9cee
_0x9d1d:  /*A1C78D      */     mov ax,[0x8dc7]
_0x9d20:  /*8ADC        */     mov bl,ah
_0x9d22:  /*32E4        */     xor ah,ah
_0x9d24:  /*32FF        */     xor bh,bh
_0x9d26:  /*8B36C98D    */     mov si,[0x8dc9]
_0x9d2a:  /*83EE06      */     sub si,byte +0x6
_0x9d2d:  /*FF7413      */     push word [si+0x13]
_0x9d30:  /*C6441300    */     mov byte [si+0x13],0x0
_0x9d34:  /*56          */     push si
_0x9d35:  /*E8BFE7      */     call _0x84f7
_0x9d38:  /*5E          */     pop si
_0x9d39:  /*8F4413      */     pop word [si+0x13]
_0x9d3c:  /*5E          */     pop si
_0x9d3d:  /*5A          */     pop dx
_0x9d3e:  /*E960FF      */     jmp _0x9ca1

; ─────────────────────────────────────────────────────────────────────

_0x9d41:  /*33C0        */     xor ax,ax
_0x9d43:  /*B90100      */     mov cx,0x1
_0x9d46:  /*BA0700      */     mov dx,0x7
_0x9d49:  /*BBD089      */     mov bx,0x89d0
_0x9d4c:  /*E9506C      */     jmp _0x99f

; ─────────────────────────────────────────────────────────────────────

_0x9d4f:  /*A0DB8D      */     mov al,[0x8ddb]
_0x9d52:  /*B414        */     mov ah,0x14
_0x9d54:  /*F6E4        */     mul ah
_0x9d56:  /*8BF0        */     mov si,ax
_0x9d58:  /*81C62A61    */     add si,0x612a
_0x9d5c:  /*AC          */     lodsb
_0x9d5d:  /*32E4        */     xor ah,ah
_0x9d5f:  /*A3B28D      */     mov [0x8db2],ax
_0x9d62:  /*AC          */     lodsb
_0x9d63:  /*A3B08D      */     mov [0x8db0],ax
_0x9d66:  /*AD          */     lodsw
_0x9d67:  /*A3AC8D      */     mov [0x8dac],ax
_0x9d6a:  /*AD          */     lodsw
_0x9d6b:  /*A3AE8D      */     mov [0x8dae],ax
_0x9d6e:  /*AD          */     lodsw
_0x9d6f:  /*A3B98D      */     mov [0x8db9],ax
_0x9d72:  /*0416        */     add al,0x16
_0x9d74:  /*A24F89      */     mov [0x894f],al
_0x9d77:  /*88265089    */     mov [0x8950],ah
_0x9d7b:  /*AD          */     lodsw
_0x9d7c:  /*A3BB8D      */     mov [0x8dbb],ax
_0x9d7f:  /*0416        */     add al,0x16
_0x9d81:  /*A28489      */     mov [0x8984],al
_0x9d84:  /*88268589    */     mov [0x8985],ah
_0x9d88:  /*AD          */     lodsw
_0x9d89:  /*A3BD8D      */     mov [0x8dbd],ax
_0x9d8c:  /*AD          */     lodsw
_0x9d8d:  /*A3BF8D      */     mov [0x8dbf],ax
_0x9d90:  /*AD          */     lodsw
_0x9d91:  /*A38E89      */     mov [0x898e],ax
_0x9d94:  /*AD          */     lodsw
_0x9d95:  /*8ADC        */     mov bl,ah
_0x9d97:  /*32FF        */     xor bh,bh
_0x9d99:  /*32E4        */     xor ah,ah
_0x9d9b:  /*A3C18D      */     mov [0x8dc1],ax
_0x9d9e:  /*891EC38D    */     mov [0x8dc3],bx
_0x9da2:  /*AD          */     lodsw
_0x9da3:  /*A3C58D      */     mov [0x8dc5],ax
_0x9da6:  /*A1B28D      */     mov ax,[0x8db2]
_0x9da9:  /*D1E0        */     shl ax,1
_0x9dab:  /*8BD0        */     mov dx,ax
_0x9dad:  /*2D4001      */     sub ax,0x140
_0x9db0:  /*F7D8        */     neg ax
_0x9db2:  /*A3B48D      */     mov [0x8db4],ax
_0x9db5:  /*32E4        */     xor ah,ah
_0x9db7:  /*A0018E      */     mov al,[0x8e01]
_0x9dba:  /*D1E0        */     shl ax,1
_0x9dbc:  /*D1E0        */     shl ax,1
_0x9dbe:  /*D1E0        */     shl ax,1
_0x9dc0:  /*D1E0        */     shl ax,1
_0x9dc2:  /*2BC2        */     sub ax,dx
_0x9dc4:  /*A3B68D      */     mov [0x8db6],ax
_0x9dc7:  /*32E4        */     xor ah,ah
_0x9dc9:  /*A0018E      */     mov al,[0x8e01]
_0x9dcc:  /*D1E0        */     shl ax,1
_0x9dce:  /*8B1EB28D    */     mov bx,[0x8db2]
_0x9dd2:  /*D1EB        */     shr bx,1
_0x9dd4:  /*D1EB        */     shr bx,1
_0x9dd6:  /*2BC3        */     sub ax,bx
_0x9dd8:  /*A2AA8D      */     mov [0x8daa],al
_0x9ddb:  /*A0008E      */     mov al,[0x8e00]
_0x9dde:  /*D1E0        */     shl ax,1
_0x9de0:  /*8B1EB08D    */     mov bx,[0x8db0]
_0x9de4:  /*D1EB        */     shr bx,1
_0x9de6:  /*2BC3        */     sub ax,bx
_0x9de8:  /*A2AB8D      */     mov [0x8dab],al
_0x9deb:  /*C3          */     ret

; ─────────────────────────────────────────────────────────────────────

_0x9dec:  /*BBD089      */     mov bx,0x89d0
_0x9def:  /*33C0        */     xor ax,ax
_0x9df1:  /*B90100      */     mov cx,0x1
_0x9df4:  /*BA0700      */     mov dx,0x7
_0x9df7:  /*E9BC6A      */     jmp _0x8b6

; ─────────────────────────────────────────────────────────────────────

_0x9dfa:  /*BE4E89      */     mov si,0x894e
_0x9dfd:  /*33DB        */     xor bx,bx
_0x9dff:  /*F6064E89FF  */     test byte [0x894e],0xff
_0x9e04:  /*7803        */     js _0x9e09
_0x9e06:  /*E80E00      */     call _0x9e17
_0x9e09:  /*BE8389      */     mov si,0x8983
_0x9e0c:  /*F6068389FF  */     test byte [0x8983],0xff
_0x9e11:  /*7901        */     jns _0x9e14
_0x9e13:  /*C3          */     ret

; ─────────────────────────────────────────────────────────────────────

_0x9e14:  /*BB0600      */     mov bx,0x6
_0x9e17:  /*803C02      */     cmp byte [si],0x2
_0x9e1a:  /*7203        */     jc _0x9e1f
_0x9e1c:  /*BB0C00      */     mov bx,0xc
_0x9e1f:  /*803C01      */     cmp byte [si],0x1
_0x9e22:  /*7502        */     jnz _0x9e26
_0x9e24:  /*FE04        */     inc byte [si]
_0x9e26:  /*8B7C11      */     mov di,[si+0x11]
_0x9e29:  /*8B440F      */     mov ax,[si+0xf]
_0x9e2c:  /*894411      */     mov [si+0x11],ax
_0x9e2f:  /*8B5415      */     mov dx,[si+0x15]
_0x9e32:  /*8B4413      */     mov ax,[si+0x13]
_0x9e35:  /*894415      */     mov [si+0x15],ax
_0x9e38:  /*8BF2        */     mov si,dx
_0x9e3a:  /*8B16048E    */     mov dx,[0x8e04]
_0x9e3e:  /*B90200      */     mov cx,0x2
_0x9e41:  /*03D1        */     add dx,cx
_0x9e43:  /*8E873689    */     mov es,[bx-0x76ca]
_0x9e47:  /*8BEF        */     mov bp,di
_0x9e49:  /*AD          */     lodsw

_0x9e4a: times 31 db 0x26,0x31,0x05,0x03,0xF9,0xAD  ; =  MACRO: xor [es:di],ax  \n   add di,cx  \n   lodsw

_0x9f04:  /*263105      */     xor [es:di],ax
_0x9f07:  /*8BFD        */     mov di,bp
_0x9f09:  /*8E873889    */     mov es,[bx-0x76c8]
_0x9f0d:  /*AD          */     lodsw

_0x9f0e: times 31 db 0x26,0x31,0x05,0x03,0xF9,0xAD  ; =  MACRO: xor [es:di],ax  \n   add di,cx  \n   lodsw

_0x9fc8:  /*263105      */     xor [es:di],ax
_0x9fcb:  /*8BFD        */     mov di,bp
_0x9fcd:  /*8E873A89    */     mov es,[bx-0x76c6]
_0x9fd1:  /*AD          */     lodsw

_0x9fd2: times 31 db 0x26,0x31,0x05,0x03,0xF9,0xAD  ; =  MACRO: xor [es:di],ax  \n   add di,cx  \n   lodsw

_0xa08c:  /*263105      */     xor [es:di],ax
_0xa08f:  /*8BFD        */     mov di,bp
_0xa091:  /*8CC8        */     mov ax,cs
_0xa093:  /*8EC0        */     mov es,ax
_0xa095:  /*C3          */     ret

; ─────────────────────────────────────────────────────────────────────

_0xa096:  /*BE4E89      */     mov si,0x894e
_0xa099:  /*F6064E89FF  */     test byte [0x894e],0xff
_0xa09e:  /*7803        */     js _0xa0a3
_0xa0a0:  /*E80B00      */     call _0xa0ae
_0xa0a3:  /*BE8389      */     mov si,0x8983
_0xa0a6:  /*F6068389FF  */     test byte [0x8983],0xff
_0xa0ab:  /*7901        */     jns _0xa0ae
_0xa0ad:  /*C3          */     ret

; ─────────────────────────────────────────────────────────────────────

_0xa0ae:  /*8A5C2B      */     mov bl,[si+0x2b]
_0xa0b1:  /*32FF        */     xor bh,bh
_0xa0b3:  /*56          */     push si
_0xa0b4:  /*E810E6      */     call _0x86c7
_0xa0b7:  /*5E          */     pop si
_0xa0b8:  /*F64432FF    */     test byte [si+0x32],0xff
_0xa0bc:  /*7413        */     jz _0xa0d1
_0xa0be:  /*FE4C32      */     dec byte [si+0x32]
_0xa0c1:  /*C606FE7B50  */     mov byte [0x7bfe],0x50
_0xa0c6:  /*C606FF7B50  */     mov byte [0x7bff],0x50
_0xa0cb:  /*C706007C0000*/     mov word [0x7c00],0x0
_0xa0d1:  /*8A4423      */     mov al,[si+0x23]
_0xa0d4:  /*884424      */     mov [si+0x24],al
_0xa0d7:  /*98          */     cbw
_0xa0d8:  /*8BD8        */     mov bx,ax
_0xa0da:  /*8B441D      */     mov ax,[si+0x1d]
_0xa0dd:  /*89441F      */     mov [si+0x1f],ax
_0xa0e0:  /*0AC4        */     or al,ah
_0xa0e2:  /*2401        */     and al,0x1
_0xa0e4:  /*884425      */     mov [si+0x25],al
_0xa0e7:  /*33D2        */     xor dx,dx
_0xa0e9:  /*B402        */     mov ah,0x2
_0xa0eb:  /*32C0        */     xor al,al
_0xa0ed:  /*803EFF7B3C  */     cmp byte [0x7bff],0x3c
_0xa0f2:  /*7703        */     ja _0xa0f7
_0xa0f4:  /*B401        */     mov ah,0x1
_0xa0f6:  /*4A          */     dec dx
_0xa0f7:  /*803EFF7B64  */     cmp byte [0x7bff],0x64
_0xa0fc:  /*7205        */     jc _0xa103
_0xa0fe:  /*B004        */     mov al,0x4
_0xa100:  /*B4FF        */     mov ah,0xff
_0xa102:  /*4A          */     dec dx
_0xa103:  /*803EFE7B64  */     cmp byte [0x7bfe],0x64
_0xa108:  /*7203        */     jc _0xa10d
_0xa10a:  /*02C4        */     add al,ah
_0xa10c:  /*4A          */     dec dx
_0xa10d:  /*803EFE7B3C  */     cmp byte [0x7bfe],0x3c
_0xa112:  /*7705        */     ja _0xa119
_0xa114:  /*2AC4        */     sub al,ah
_0xa116:  /*2407        */     and al,0x7
_0xa118:  /*4A          */     dec dx
_0xa119:  /*0BD2        */     or dx,dx
_0xa11b:  /*7915        */     jns _0xa132
_0xa11d:  /*D1E3        */     shl bx,1
_0xa11f:  /*D1E3        */     shl bx,1
_0xa121:  /*D1E3        */     shl bx,1
_0xa123:  /*81C32C8D    */     add bx,0x8d2c
_0xa127:  /*D7          */     xlatb
_0xa128:  /*884423      */     mov [si+0x23],al
_0xa12b:  /*C6442A02    */     mov byte [si+0x2a],0x2
_0xa12f:  /*FE4425      */     inc byte [si+0x25]
_0xa132:  /*F606007CFF  */     test byte [0x7c00],0xff
_0xa137:  /*7403        */     jz _0xa13c
_0xa139:  /*FE442C      */     inc byte [si+0x2c]
_0xa13c:  /*C3          */     ret

; ─────────────────────────────────────────────────────────────────────

_0xa13d:  /*BF4E89      */     mov di,0x894e
_0xa140:  /*BE4D8A      */     mov si,0x8a4d
_0xa143:  /*F6064E89FF  */     test byte [0x894e],0xff
_0xa148:  /*7803        */     js _0xa14d
_0xa14a:  /*E80E00      */     call _0xa15b
_0xa14d:  /*BF8389      */     mov di,0x8983
_0xa150:  /*BE198B      */     mov si,0x8b19
_0xa153:  /*F6068389FF  */     test byte [0x8983],0xff
_0xa158:  /*7901        */     jns _0xa15b
_0xa15a:  /*C3          */     ret

; ─────────────────────────────────────────────────────────────────────

_0xa15b:  /*F6452CFF    */     test byte [di+0x2c],0xff
_0xa15f:  /*745A        */     jz _0xa1bb
_0xa161:  /*F74521FFFF  */     test word [di+0x21],0xffff
_0xa166:  /*7553        */     jnz _0xa1bb
_0xa168:  /*803CFF      */     cmp byte [si],0xff
_0xa16b:  /*7408        */     jz _0xa175
_0xa16d:  /*83C611      */     add si,byte +0x11
_0xa170:  /*803CFF      */     cmp byte [si],0xff
_0xa173:  /*7546        */     jnz _0xa1bb
_0xa175:  /*E8F3F1      */     call _0x936b
_0xa178:  /*8A4523      */     mov al,[di+0x23]
_0xa17b:  /*884409      */     mov [si+0x9],al
_0xa17e:  /*C6440603    */     mov byte [si+0x6],0x3
_0xa182:  /*8B4519      */     mov ax,[di+0x19]
_0xa185:  /*8904        */     mov [si],ax
_0xa187:  /*8B451D      */     mov ax,[di+0x1d]
_0xa18a:  /*894404      */     mov [si+0x4],ax
_0xa18d:  /*C6440AFF    */     mov byte [si+0xa],0xff
_0xa191:  /*B00A        */     mov al,0xa
_0xa193:  /*803D01      */     cmp byte [di],0x1
_0xa196:  /*7502        */     jnz _0xa19a
_0xa198:  /*B003        */     mov al,0x3
_0xa19a:  /*88440E      */     mov [si+0xe],al
_0xa19d:  /*C6452C00    */     mov byte [di+0x2c],0x0
_0xa1a1:  /*B80200      */     mov ax,0x2
_0xa1a4:  /*E8FB60      */     call _0x2a2
_0xa1a7:  /*8A4401      */     mov al,[si+0x1]
_0xa1aa:  /*F626018E    */     mul byte [0x8e01]
_0xa1ae:  /*8A1C        */     mov bl,[si]
_0xa1b0:  /*32FF        */     xor bh,bh
_0xa1b2:  /*03D8        */     add bx,ax
_0xa1b4:  /*81C3C05C    */     add bx,0x5cc0
_0xa1b8:  /*895C0B      */     mov [si+0xb],bx
_0xa1bb:  /*C3          */     ret
_0xa1bc:  /*BE4D8A      */     mov si,0x8a4d
_0xa1bf:  /*BD4E89      */     mov bp,0x894e
_0xa1c2:  /*C706D78D0200*/     mov word [0x8dd7],0x2
_0xa1c8:  /*E80C00      */     call _0xa1d7
_0xa1cb:  /*BE198B      */     mov si,0x8b19
_0xa1ce:  /*BD8389      */     mov bp,0x8983
_0xa1d1:  /*C706D78D0200*/     mov word [0x8dd7],0x2
_0xa1d7:  /*803CFF      */     cmp byte [si],0xff
_0xa1da:  /*7463        */     jz _0xa23f
_0xa1dc:  /*BF6F8A      */     mov di,0x8a6f
_0xa1df:  /*B90A00      */     mov cx,0xa
_0xa1e2:  /*803DFF      */     cmp byte [di],0xff
_0xa1e5:  /*7453        */     jz _0xa23a
_0xa1e7:  /*807D0803    */     cmp byte [di+0x8],0x3
_0xa1eb:  /*724D        */     jc _0xa23a
_0xa1ed:  /*8A4404      */     mov al,[si+0x4]
_0xa1f0:  /*2A4504      */     sub al,[di+0x4]
_0xa1f3:  /*7902        */     jns _0xa1f7
_0xa1f5:  /*F6D8        */     neg al
_0xa1f7:  /*3C01        */     cmp al,0x1
_0xa1f9:  /*773F        */     ja _0xa23a
_0xa1fb:  /*8A4405      */     mov al,[si+0x5]
_0xa1fe:  /*2A4505      */     sub al,[di+0x5]
_0xa201:  /*7902        */     jns _0xa205
_0xa203:  /*F6D8        */     neg al
_0xa205:  /*3C01        */     cmp al,0x1
_0xa207:  /*7731        */     ja _0xa23a
_0xa209:  /*C604FF      */     mov byte [si],0xff
_0xa20c:  /*C684F800FF  */     mov byte [si+0xf8],0xff
_0xa211:  /*C6450801    */     mov byte [di+0x8],0x1
_0xa215:  /*C6450904    */     mov byte [di+0x9],0x4
_0xa219:  /*C6450E05    */     mov byte [di+0xe],0x5
_0xa21d:  /*C6450603    */     mov byte [di+0x6],0x3
_0xa221:  /*C6450AFF    */     mov byte [di+0xa],0xff
_0xa225:  /*C7450F0000  */     mov word [di+0xf],0x0
_0xa22a:  /*C685F800FF  */     mov byte [di+0xf8],0xff
_0xa22f:  /*80462803    */     add byte [bp+0x28],0x3
_0xa233:  /*33C0        */     xor ax,ax
_0xa235:  /*E86A60      */     call _0x2a2
_0xa238:  /*EB05        */     jmp short _0xa23f
_0xa23a:  /*83C711      */     add di,byte +0x11
_0xa23d:  /*E2A3        */     loop _0xa1e2
_0xa23f:  /*83C611      */     add si,byte +0x11
_0xa242:  /*FF0ED78D    */     dec word [0x8dd7]
_0xa246:  /*758F        */     jnz _0xa1d7
_0xa248:  /*C3          */     ret

; ─────────────────────────────────────────────────────────────────────

_0xa249:  /*BD8389      */     mov bp,0x8983
_0xa24c:  /*BF4E89      */     mov di,0x894e
_0xa24f:  /*BE6F8A      */     mov si,0x8a6f
_0xa252:  /*F6064E89FF  */     test byte [0x894e],0xff
_0xa257:  /*7803        */     js _0xa25c
_0xa259:  /*E81100      */     call _0xa26d
_0xa25c:  /*F6068389FF  */     test byte [0x8983],0xff
_0xa261:  /*7901        */     jns _0xa264
_0xa263:  /*C3          */     ret

; ─────────────────────────────────────────────────────────────────────

_0xa264:  /*BF8389      */     mov di,0x8983
_0xa267:  /*BE4D8A      */     mov si,0x8a4d
_0xa26a:  /*BD4E89      */     mov bp,0x894e
_0xa26d:  /*B90C00      */     mov cx,0xc
_0xa270:  /*803CFF      */     cmp byte [si],0xff
_0xa273:  /*7422        */     jz _0xa297
_0xa275:  /*807C0801    */     cmp byte [si+0x8],0x1
_0xa279:  /*741C        */     jz _0xa297
_0xa27b:  /*8A451D      */     mov al,[di+0x1d]
_0xa27e:  /*2A4404      */     sub al,[si+0x4]
_0xa281:  /*7902        */     jns _0xa285
_0xa283:  /*F6D8        */     neg al
_0xa285:  /*3C01        */     cmp al,0x1
_0xa287:  /*770E        */     ja _0xa297
_0xa289:  /*8A451E      */     mov al,[di+0x1e]
_0xa28c:  /*2A4405      */     sub al,[si+0x5]
_0xa28f:  /*7902        */     jns _0xa293
_0xa291:  /*F6D8        */     neg al
_0xa293:  /*3C02        */     cmp al,0x2
_0xa295:  /*7206        */     jc _0xa29d
_0xa297:  /*83C611      */     add si,byte +0x11
_0xa29a:  /*E2D4        */     loop _0xa270
_0xa29c:  /*C3          */     ret

; ─────────────────────────────────────────────────────────────────────

_0xa29d:  /*B80100      */     mov ax,0x1
_0xa2a0:  /*E8FF5F      */     call _0x2a2
_0xa2a3:  /*C6452D01    */     mov byte [di+0x2d],0x1
_0xa2a7:  /*E8C1F0      */     call _0x936b
_0xa2aa:  /*F605FF      */     test byte [di],0xff
_0xa2ad:  /*7405        */     jz _0xa2b4
_0xa2af:  /*C6453214    */     mov byte [di+0x32],0x14
_0xa2b3:  /*C3          */     ret
_0xa2b4:  /*FE4D26      */     dec byte [di+0x26]
_0xa2b7:  /*7801        */     js _0xa2ba
_0xa2b9:  /*C3          */     ret

; ─────────────────────────────────────────────────────────────────────

_0xa2ba:  /*C60501      */     mov byte [di],0x1
_0xa2bd:  /*8A4501      */     mov al,[di+0x1]
_0xa2c0:  /*2C16        */     sub al,0x16
_0xa2c2:  /*8A5D02      */     mov bl,[di+0x2]
_0xa2c5:  /*80C30C      */     add bl,0xc
_0xa2c8:  /*32E4        */     xor ah,ah
_0xa2ca:  /*32FF        */     xor bh,bh
_0xa2cc:  /*57          */     push di
_0xa2cd:  /*55          */     push bp
_0xa2ce:  /*BEB28C      */     mov si,0x8cb2
_0xa2d1:  /*E823E2      */     call _0x84f7
_0xa2d4:  /*5D          */     pop bp
_0xa2d5:  /*5F          */     pop di
_0xa2d6:  /*F6452EFF    */     test byte [di+0x2e],0xff
_0xa2da:  /*7501        */     jnz _0xa2dd
_0xa2dc:  /*C3          */     ret

; ─────────────────────────────────────────────────────────────────────

_0xa2dd:  /*FE4D2E      */     dec byte [di+0x2e]
_0xa2e0:  /*FE462E      */     inc byte [bp+0x2e]
_0xa2e3:  /*C3          */     ret

; ─────────────────────────────────────────────────────────────────────

_0xa2e4:  /*BA0703      */     mov dx,0x307
_0xa2e7:  /*BE4E89      */     mov si,0x894e
_0xa2ea:  /*F6064E89FF  */     test byte [0x894e],0xff
_0xa2ef:  /*7503        */     jnz _0xa2f4
_0xa2f1:  /*E80E00      */     call _0xa302
_0xa2f4:  /*BE8389      */     mov si,0x8983
_0xa2f7:  /*F6068389FF  */     test byte [0x8983],0xff
_0xa2fc:  /*7401        */     jz _0xa2ff
_0xa2fe:  /*C3          */     ret

; ─────────────────────────────────────────────────────────────────────

_0xa2ff:  /*BA0605      */     mov dx,0x506
_0xa302:  /*8A4426      */     mov al,[si+0x26]
_0xa305:  /*3A4427      */     cmp al,[si+0x27]
_0xa308:  /*7501        */     jnz _0xa30b
_0xa30a:  /*C3          */     ret

; ─────────────────────────────────────────────────────────────────────

_0xa30b:  /*8A4427      */     mov al,[si+0x27]
_0xa30e:  /*C606CD8D3E  */     mov byte [0x8dcd],0x3e
_0xa313:  /*770B        */     ja _0xa320
_0xa315:  /*FEC8        */     dec al
_0xa317:  /*C606CD8D20  */     mov byte [0x8dcd],0x20
_0xa31c:  /*806C2702    */     sub byte [si+0x27],0x2
_0xa320:  /*FE4427      */     inc byte [si+0x27]
_0xa323:  /*50          */     push ax
_0xa324:  /*56          */     push si
_0xa325:  /*E88CE1      */     call _0x84b4
_0xa328:  /*5E          */     pop si
_0xa329:  /*58          */     pop ax
_0xa32a:  /*8AE0        */     mov ah,al
_0xa32c:  /*D0E0        */     shl al,1
_0xa32e:  /*02C4        */     add al,ah
_0xa330:  /*024401      */     add al,[si+0x1]
_0xa333:  /*2C16        */     sub al,0x16
_0xa335:  /*8A5C02      */     mov bl,[si+0x2]
_0xa338:  /*80C30C      */     add bl,0xc
_0xa33b:  /*32E4        */     xor ah,ah
_0xa33d:  /*32FF        */     xor bh,bh
_0xa33f:  /*BECD8D      */     mov si,0x8dcd
_0xa342:  /*E8B2E1      */     call _0x84f7
_0xa345:  /*C3          */     ret

; ─────────────────────────────────────────────────────────────────────

_0xa346:  /*BE4E89      */     mov si,0x894e
_0xa349:  /*F6064E89FF  */     test byte [0x894e],0xff
_0xa34e:  /*7803        */     js _0xa353
_0xa350:  /*E82400      */     call _0xa377
_0xa353:  /*E81E03      */     call _0xa674
_0xa356:  /*BE8389      */     mov si,0x8983
_0xa359:  /*F6068389FF  */     test byte [0x8983],0xff
_0xa35e:  /*7803        */     js _0xa363
_0xa360:  /*E81400      */     call _0xa377
_0xa363:  /*E90E03      */     jmp _0xa674

; ─────────────────────────────────────────────────────────────────────

_0xa366:  /*58          */     pop ax
_0xa367:  /*8A4424      */     mov al,[si+0x24]
_0xa36a:  /*3A4423      */     cmp al,[si+0x23]
_0xa36d:  /*7505        */     jnz _0xa374
_0xa36f:  /*C6442500    */     mov byte [si+0x25],0x0
_0xa373:  /*C3          */     ret

; ─────────────────────────────────────────────────────────────────────

_0xa374:  /*884423      */     mov [si+0x23],al
_0xa377:  /*F64425FF    */     test byte [si+0x25],0xff
_0xa37b:  /*7501        */     jnz _0xa37e
_0xa37d:  /*C3          */     ret

; ─────────────────────────────────────────────────────────────────────

_0xa37e:  /*8B4419      */     mov ax,[si+0x19]
_0xa381:  /*89441B      */     mov [si+0x1b],ax
_0xa384:  /*8A5C23      */     mov bl,[si+0x23]
_0xa387:  /*32FF        */     xor bh,bh
_0xa389:  /*D1E3        */     shl bx,1
_0xa38b:  /*FFA7C18E    */     jmp [bx-0x713f]

; ─────────────────────────────────────────────────────────────────────

_0xa38f:  /*F64421FF    */     test byte [si+0x21],0xff
_0xa393:  /*7402        */     jz _0xa397
_0xa395:  /*EBD0        */     jmp short _0xa367

; ─────────────────────────────────────────────────────────────────────

_0xa397:  /*F64422FF    */     test byte [si+0x22],0xff
_0xa39b:  /*751F        */     jnz _0xa3bc
_0xa39d:  /*FE4C1C      */     dec byte [si+0x1c]
_0xa3a0:  /*7917        */     jns _0xa3b9
_0xa3a2:  /*A0008E      */     mov al,[0x8e00]
_0xa3a5:  /*FEC8        */     dec al
_0xa3a7:  /*88441A      */     mov [si+0x1a],al
_0xa3aa:  /*88441C      */     mov [si+0x1c],al
_0xa3ad:  /*FE4422      */     inc byte [si+0x22]
_0xa3b0:  /*D0E0        */     shl al,1
_0xa3b2:  /*FEC0        */     inc al
_0xa3b4:  /*88441E      */     mov [si+0x1e],al
_0xa3b7:  /*EB03        */     jmp short _0xa3bc

; ─────────────────────────────────────────────────────────────────────

_0xa3b9:  /*E8BD00      */     call _0xa479
_0xa3bc:  /*80742201    */     xor byte [si+0x22],0x1
_0xa3c0:  /*7403        */     jz _0xa3c5
_0xa3c2:  /*FE4C1A      */     dec byte [si+0x1a]
_0xa3c5:  /*FE4C1E      */     dec byte [si+0x1e]
_0xa3c8:  /*C3          */     ret
_0xa3c9:  /*F64422FF    */     test byte [si+0x22],0xff
_0xa3cd:  /*7402        */     jz _0xa3d1
_0xa3cf:  /*EB96        */     jmp short _0xa367

; ─────────────────────────────────────────────────────────────────────

_0xa3d1:  /*F64421FF    */     test byte [si+0x21],0xff
_0xa3d5:  /*751F        */     jnz _0xa3f6
_0xa3d7:  /*FE4C1B      */     dec byte [si+0x1b]
_0xa3da:  /*7917        */     jns _0xa3f3
_0xa3dc:  /*A0018E      */     mov al,[0x8e01]
_0xa3df:  /*FEC8        */     dec al
_0xa3e1:  /*884419      */     mov [si+0x19],al
_0xa3e4:  /*88441B      */     mov [si+0x1b],al
_0xa3e7:  /*FE4421      */     inc byte [si+0x21]
_0xa3ea:  /*D0E0        */     shl al,1
_0xa3ec:  /*FEC0        */     inc al
_0xa3ee:  /*88441D      */     mov [si+0x1d],al
_0xa3f1:  /*EB03        */     jmp short _0xa3f6

; ─────────────────────────────────────────────────────────────────────

_0xa3f3:  /*E88300      */     call _0xa479
_0xa3f6:  /*80742101    */     xor byte [si+0x21],0x1
_0xa3fa:  /*7403        */     jz _0xa3ff
_0xa3fc:  /*FE4C19      */     dec byte [si+0x19]
_0xa3ff:  /*FE4C1D      */     dec byte [si+0x1d]
_0xa402:  /*C3          */     ret
_0xa403:  /*F64421FF    */     test byte [si+0x21],0xff
_0xa407:  /*7403        */     jz _0xa40c
_0xa409:  /*E95BFF      */     jmp _0xa367

; ─────────────────────────────────────────────────────────────────────

_0xa40c:  /*F64422FF    */     test byte [si+0x22],0xff
_0xa410:  /*751F        */     jnz _0xa431
_0xa412:  /*FE441C      */     inc byte [si+0x1c]
_0xa415:  /*A0008E      */     mov al,[0x8e00]
_0xa418:  /*38441C      */     cmp [si+0x1c],al
_0xa41b:  /*7511        */     jnz _0xa42e
_0xa41d:  /*C6441AFF    */     mov byte [si+0x1a],0xff
_0xa421:  /*C6441CFF    */     mov byte [si+0x1c],0xff
_0xa425:  /*FE4422      */     inc byte [si+0x22]
_0xa428:  /*C6441EFF    */     mov byte [si+0x1e],0xff
_0xa42c:  /*EB03        */     jmp short _0xa431

; ─────────────────────────────────────────────────────────────────────

_0xa42e:  /*E84800      */     call _0xa479
_0xa431:  /*80742201    */     xor byte [si+0x22],0x1
_0xa435:  /*7503        */     jnz _0xa43a
_0xa437:  /*FE441A      */     inc byte [si+0x1a]
_0xa43a:  /*FE441E      */     inc byte [si+0x1e]
_0xa43d:  /*C3          */     ret
_0xa43e:  /*F64422FF    */     test byte [si+0x22],0xff
_0xa442:  /*7403        */     jz _0xa447
_0xa444:  /*E920FF      */     jmp _0xa367

; ─────────────────────────────────────────────────────────────────────

_0xa447:  /*F64421FF    */     test byte [si+0x21],0xff
_0xa44b:  /*751F        */     jnz _0xa46c
_0xa44d:  /*FE441B      */     inc byte [si+0x1b]
_0xa450:  /*A0018E      */     mov al,[0x8e01]
_0xa453:  /*38441B      */     cmp [si+0x1b],al
_0xa456:  /*7511        */     jnz _0xa469
_0xa458:  /*C64419FF    */     mov byte [si+0x19],0xff
_0xa45c:  /*C6441BFF    */     mov byte [si+0x1b],0xff
_0xa460:  /*FE4421      */     inc byte [si+0x21]
_0xa463:  /*C6441DFF    */     mov byte [si+0x1d],0xff
_0xa467:  /*EB03        */     jmp short _0xa46c

; ─────────────────────────────────────────────────────────────────────

_0xa469:  /*E80D00      */     call _0xa479
_0xa46c:  /*80742101    */     xor byte [si+0x21],0x1
_0xa470:  /*7503        */     jnz _0xa475
_0xa472:  /*FE4419      */     inc byte [si+0x19]
_0xa475:  /*FE441D      */     inc byte [si+0x1d]
_0xa478:  /*C3          */     ret

; ─────────────────────────────────────────────────────────────────────

_0xa479:  /*32FF        */     xor bh,bh
_0xa47b:  /*8A5C1B      */     mov bl,[si+0x1b]
_0xa47e:  /*A0018E      */     mov al,[0x8e01]
_0xa481:  /*F6641C      */     mul byte [si+0x1c]
_0xa484:  /*03D8        */     add bx,ax
_0xa486:  /*81C3C05C    */     add bx,0x5cc0
_0xa48a:  /*8A07        */     mov al,[bx]
_0xa48c:  /*3C40        */     cmp al,0x40
_0xa48e:  /*7501        */     jnz _0xa491
_0xa490:  /*C3          */     ret

; ─────────────────────────────────────────────────────────────────────

_0xa491:  /*3C78        */     cmp al,0x78
_0xa493:  /*7501        */     jnz _0xa496
_0xa495:  /*C3          */     ret

; ─────────────────────────────────────────────────────────────────────

_0xa496:  /*3C50        */     cmp al,0x50
_0xa498:  /*7303        */     jnc _0xa49d
_0xa49a:  /*EB1C        */     jmp short _0xa4b8

; ─────────────────────────────────────────────────────────────────────

_0xa49c:  /*90          */     nop
_0xa49d:  /*3C72        */     cmp al,0x72
_0xa49f:  /*7417        */     jz _0xa4b8
_0xa4a1:  /*7603        */     jna 0xa4a6
_0xa4a3:  /*E94701      */     jmp _0xa5ed

; ─────────────────────────────────────────────────────────────────────

_0xa4a6:  /*3C54        */     cmp al,0x54
_0xa4a8:  /*7203        */     jc _0xa4ad
_0xa4aa:  /*E9B9FE      */     jmp _0xa366

; ─────────────────────────────────────────────────────────────────────

_0xa4ad:  /*2C50        */     sub al,0x50
_0xa4af:  /*3A4423      */     cmp al,[si+0x23]
_0xa4b2:  /*7503        */     jnz _0xa4b7
_0xa4b4:  /*E9AFFE      */     jmp _0xa366

; ─────────────────────────────────────────────────────────────────────

_0xa4b7:  /*C3          */     ret

; ─────────────────────────────────────────────────────────────────────

_0xa4b8:  /*A2088E      */     mov [0x8e08],al
_0xa4bb:  /*3C41        */     cmp al,0x41
_0xa4bd:  /*7446        */     jz _0xa505
_0xa4bf:  /*3C42        */     cmp al,0x42
_0xa4c1:  /*7415        */     jz _0xa4d8
_0xa4c3:  /*3C72        */     cmp al,0x72
_0xa4c5:  /*7503        */     jnz _0xa4ca
_0xa4c7:  /*E9D700      */     jmp _0xa5a1

; ─────────────────────────────────────────────────────────────────────

_0xa4ca:  /*3C47        */     cmp al,0x47
_0xa4cc:  /*725C        */     jc _0xa52a
_0xa4ce:  /*3C50        */     cmp al,0x50
_0xa4d0:  /*7303        */     jnc _0xa4d5
_0xa4d2:  /*E98700      */     jmp _0xa55c
_0xa4d5:  /*E98EFE      */     jmp _0xa366
_0xa4d8:  /*F604FF      */     test byte [si],0xff
_0xa4db:  /*7403        */     jz _0xa4e0
_0xa4dd:  /*E986FE      */     jmp _0xa366

; ─────────────────────────────────────────────────────────────────────

_0xa4e0:  /*F6442EFF    */     test byte [si+0x2e],0xff
_0xa4e4:  /*7403        */     jz _0xa4e9
_0xa4e6:  /*E97DFE      */     jmp _0xa366

; ─────────────────────────────────────────────────────────────────────

_0xa4e9:  /*FE442E      */     inc byte [si+0x2e]
_0xa4ec:  /*FF0EF48D    */     dec word [0x8df4]
_0xa4f0:  /*C60740      */     mov byte [bx],0x40
_0xa4f3:  /*B80F00      */     mov ax,0xf
_0xa4f6:  /*004428      */     add [si+0x28],al
_0xa4f9:  /*E894EE      */     call _0x9390
_0xa4fc:  /*B80300      */     mov ax,0x3
_0xa4ff:  /*E8A05D      */     call _0x2a2
_0xa502:  /*E9AD00      */     jmp _0xa5b2

; ─────────────────────────────────────────────────────────────────────

_0xa505:  /*F6442EFF    */     test byte [si+0x2e],0xff
_0xa509:  /*7503        */     jnz _0xa50e
_0xa50b:  /*E958FE      */     jmp _0xa366

; ─────────────────────────────────────────────────────────────────────

_0xa50e:  /*C60740      */     mov byte [bx],0x40
_0xa511:  /*B81900      */     mov ax,0x19
_0xa514:  /*004428      */     add [si+0x28],al
_0xa517:  /*E876EE      */     call _0x9390
_0xa51a:  /*FF0EF68D    */     dec word [0x8df6]
_0xa51e:  /*FE4C2E      */     dec byte [si+0x2e]
_0xa521:  /*B80400      */     mov ax,0x4
_0xa524:  /*E87B5D      */     call _0x2a2
_0xa527:  /*E98800      */     jmp _0xa5b2

; ─────────────────────────────────────────────────────────────────────

_0xa52a:  /*C60740      */     mov byte [bx],0x40
_0xa52d:  /*8006DC8D0A  */     add byte [0x8ddc],0xa
_0xa532:  /*A0DC8D      */     mov al,[0x8ddc]
_0xa535:  /*004428      */     add [si+0x28],al
_0xa538:  /*8AD8        */     mov bl,al
_0xa53a:  /*80C314      */     add bl,0x14
_0xa53d:  /*D0EB        */     shr bl,1
_0xa53f:  /*D0EB        */     shr bl,1
_0xa541:  /*881ED58D    */     mov [0x8dd5],bl
_0xa545:  /*32E4        */     xor ah,ah
_0xa547:  /*F604FF      */     test byte [si],0xff
_0xa54a:  /*7503        */     jnz _0xa54f
_0xa54c:  /*E841EE      */     call _0x9390
_0xa54f:  /*FE06E18D    */     inc byte [0x8de1]
_0xa553:  /*B80500      */     mov ax,0x5
_0xa556:  /*E8495D      */     call _0x2a2
_0xa559:  /*EB57        */     jmp short _0xa5b2

; ─────────────────────────────────────────────────────────────────────

_0xa55b:  /*90          */     nop
_0xa55c:  /*C60740      */     mov byte [bx],0x40
_0xa55f:  /*B063        */     mov al,0x63
_0xa561:  /*004428      */     add [si+0x28],al
_0xa564:  /*32E4        */     xor ah,ah
_0xa566:  /*F604FF      */     test byte [si],0xff
_0xa569:  /*7503        */     jnz _0xa56e
_0xa56b:  /*E822EE      */     call _0x9390
_0xa56e:  /*FE06E18D    */     inc byte [0x8de1]
_0xa572:  /*B80700      */     mov ax,0x7
_0xa575:  /*E82A5D      */     call _0x2a2
_0xa578:  /*57          */     push di
_0xa579:  /*53          */     push bx
_0xa57a:  /*A0DD8D      */     mov al,[0x8ddd]
_0xa57d:  /*BF088E      */     mov di,0x8e08
_0xa580:  /*83C704      */     add di,byte +0x4
_0xa583:  /*3805        */     cmp [di],al
_0xa585:  /*75F9        */     jnz _0xa580
_0xa587:  /*C7050100    */     mov word [di],0x1
_0xa58b:  /*8B1E308E    */     mov bx,[0x8e30]
_0xa58f:  /*FF06308E    */     inc word [0x8e30]
_0xa593:  /*D1E3        */     shl bx,1
_0xa595:  /*8B874460    */     mov ax,[bx+0x6044]
_0xa599:  /*894502      */     mov [di+0x2],ax
_0xa59c:  /*5B          */     pop bx
_0xa59d:  /*5F          */     pop di
_0xa59e:  /*EB12        */     jmp short _0xa5b2

; ─────────────────────────────────────────────────────────────────────

_0xa5a0:  /*90          */     nop
_0xa5a1:  /*C60754      */     mov byte [bx],0x54
_0xa5a4:  /*C606088E54  */     mov byte [0x8e08],0x54
_0xa5a9:  /*FE4428      */     inc byte [si+0x28]
_0xa5ac:  /*E80300      */     call _0xa5b2
_0xa5af:  /*E9B4FD      */     jmp _0xa366

; ─────────────────────────────────────────────────────────────────────

_0xa5b2:  /*8A541B      */     mov dl,[si+0x1b]
_0xa5b5:  /*32F6        */     xor dh,dh
_0xa5b7:  /*D1E2        */     shl dx,1
_0xa5b9:  /*D1E2        */     shl dx,1
_0xa5bb:  /*D1E2        */     shl dx,1
_0xa5bd:  /*D1E2        */     shl dx,1
_0xa5bf:  /*8A441C      */     mov al,[si+0x1c]
_0xa5c2:  /*F626018E    */     mul byte [0x8e01]
_0xa5c6:  /*D1E0        */     shl ax,1
_0xa5c8:  /*D1E0        */     shl ax,1
_0xa5ca:  /*D1E0        */     shl ax,1
_0xa5cc:  /*D1E0        */     shl ax,1
_0xa5ce:  /*D1E0        */     shl ax,1
_0xa5d0:  /*D1E0        */     shl ax,1
_0xa5d2:  /*8BF8        */     mov di,ax
_0xa5d4:  /*03FA        */     add di,dx
_0xa5d6:  /*A0088E      */     mov al,[0x8e08]
_0xa5d9:  /*2C40        */     sub al,0x40
_0xa5db:  /*B4C0        */     mov ah,0xc0
_0xa5dd:  /*F6E4        */     mul ah
_0xa5df:  /*56          */     push si
_0xa5e0:  /*8BF0        */     mov si,ax
_0xa5e2:  /*81C67009    */     add si,0x970
_0xa5e6:  /*33DB        */     xor bx,bx
_0xa5e8:  /*E84FF8      */     call _0x9e3a
_0xa5eb:  /*5E          */     pop si
_0xa5ec:  /*C3          */     ret

; ─────────────────────────────────────────────────────────────────────

_0xa5ed:  /*803EDD8D01  */     cmp byte [0x8ddd],0x1
_0xa5f2:  /*7532        */     jnz _0xa626
_0xa5f4:  /*BB0100      */     mov bx,0x1
_0xa5f7:  /*8B4419      */     mov ax,[si+0x19]
_0xa5fa:  /*BD9260      */     mov bp,0x6092
_0xa5fd:  /*BF7960      */     mov di,0x6079
_0xa600:  /*83C502      */     add bp,byte +0x2
_0xa603:  /*43          */     inc bx
_0xa604:  /*83FB16      */     cmp bx,byte +0x16
_0xa607:  /*7603        */     jna 0xa60c
_0xa609:  /*E95AFD      */     jmp _0xa366

; ─────────────────────────────────────────────────────────────────────

_0xa60c:  /*F601FF      */     test byte [bx+di],0xff
_0xa60f:  /*78EF        */     js _0xa600
_0xa611:  /*3B4600      */     cmp ax,[bp+0x0]
_0xa614:  /*75EA        */     jnz _0xa600
_0xa616:  /*881EDD8D    */     mov [0x8ddd],bl
_0xa61a:  /*FE067A60    */     inc byte [0x607a]
_0xa61e:  /*80267A600F  */     and byte [0x607a],0xf
_0xa623:  /*E9D3EA      */     jmp _0x90f9

; ─────────────────────────────────────────────────────────────────────

_0xa626:  /*8A1EDD8D    */     mov bl,[0x8ddd]
_0xa62a:  /*32FF        */     xor bh,bh
_0xa62c:  /*80FB19      */     cmp bl,0x19
_0xa62f:  /*7503        */     jnz _0xa634
_0xa631:  /*E9BFEA      */     jmp _0x90f3

; ─────────────────────────────────────────────────────────────────────

_0xa634:  /*80FB16      */     cmp bl,0x16
_0xa637:  /*771E        */     ja _0xa657
_0xa639:  /*81C37960    */     add bx,0x6079
_0xa63d:  /*8A07        */     mov al,[bx]
_0xa63f:  /*FEC0        */     inc al
_0xa641:  /*240F        */     and al,0xf
_0xa643:  /*7502        */     jnz _0xa647
_0xa645:  /*FEC8        */     dec al
_0xa647:  /*8807        */     mov [bx],al
_0xa649:  /*7804        */     js _0xa64f
_0xa64b:  /*2403        */     and al,0x3
_0xa64d:  /*7500        */     jnz _0xa64f
_0xa64f:  /*C606DD8D01  */     mov byte [0x8ddd],0x1
_0xa654:  /*E9A2EA      */     jmp _0x90f9

; ─────────────────────────────────────────────────────────────────────

_0xa657:  /*FEC3        */     inc bl
_0xa659:  /*881EDD8D    */     mov [0x8ddd],bl
_0xa65d:  /*C706A88DD281*/     mov word [0x8da8],0x81d2
_0xa663:  /*80FB18      */     cmp bl,0x18
_0xa666:  /*7406        */     jz _0xa66e
_0xa668:  /*C706A88D5282*/     mov word [0x8da8],0x8252
_0xa66e:  /*E88FEB      */     call _0x9200
_0xa671:  /*E982EA      */     jmp _0x90f6

; ─────────────────────────────────────────────────────────────────────

_0xa674:  /*8A441D      */     mov al,[si+0x1d]
_0xa677:  /*2A4417      */     sub al,[si+0x17]
_0xa67a:  /*3A06AC8D    */     cmp al,[0x8dac]
_0xa67e:  /*7E1A        */     jng 0xa69a
_0xa680:  /*3A06AD8D    */     cmp al,[0x8dad]
_0xa684:  /*7D22        */     jnl 0xa6a8
_0xa686:  /*8A441E      */     mov al,[si+0x1e]
_0xa689:  /*2A4418      */     sub al,[si+0x18]
_0xa68c:  /*3A06AE8D    */     cmp al,[0x8dae]
_0xa690:  /*7E3A        */     jng 0xa6cc
_0xa692:  /*3A06AF8D    */     cmp al,[0x8daf]
_0xa696:  /*7D40        */     jnl 0xa6d8
_0xa698:  /*EB5E        */     jmp short _0xa6f8

; ─────────────────────────────────────────────────────────────────────

_0xa69a:  /*8A441F      */     mov al,[si+0x1f]
_0xa69d:  /*2A441D      */     sub al,[si+0x1d]
_0xa6a0:  /*74E4        */     jz _0xa686
_0xa6a2:  /*3CFF        */     cmp al,0xff
_0xa6a4:  /*74E0        */     jz _0xa686
_0xa6a6:  /*EB0C        */     jmp short _0xa6b4

; ─────────────────────────────────────────────────────────────────────

_0xa6a8:  /*8A441F      */     mov al,[si+0x1f]
_0xa6ab:  /*2A441D      */     sub al,[si+0x1d]
_0xa6ae:  /*74D6        */     jz _0xa686
_0xa6b0:  /*3C01        */     cmp al,0x1
_0xa6b2:  /*74D2        */     jz _0xa686
_0xa6b4:  /*284417      */     sub [si+0x17],al
_0xa6b7:  /*7906        */     jns _0xa6bf
_0xa6b9:  /*C6441700    */     mov byte [si+0x17],0x0
_0xa6bd:  /*EB39        */     jmp short _0xa6f8

; ─────────────────────────────────────────────────────────────────────

_0xa6bf:  /*A0AA8D      */     mov al,[0x8daa]
_0xa6c2:  /*3A4417      */     cmp al,[si+0x17]
_0xa6c5:  /*7331        */     jnc _0xa6f8
_0xa6c7:  /*884417      */     mov [si+0x17],al
_0xa6ca:  /*EB2C        */     jmp short _0xa6f8

; ─────────────────────────────────────────────────────────────────────

_0xa6cc:  /*8A4420      */     mov al,[si+0x20]
_0xa6cf:  /*2A441E      */     sub al,[si+0x1e]
_0xa6d2:  /*3CFF        */     cmp al,0xff
_0xa6d4:  /*7422        */     jz _0xa6f8
_0xa6d6:  /*EB0A        */     jmp short _0xa6e2

; ─────────────────────────────────────────────────────────────────────

_0xa6d8:  /*8A4420      */     mov al,[si+0x20]
_0xa6db:  /*2A441E      */     sub al,[si+0x1e]
_0xa6de:  /*3C01        */     cmp al,0x1
_0xa6e0:  /*7416        */     jz _0xa6f8
_0xa6e2:  /*284418      */     sub [si+0x18],al
_0xa6e5:  /*7906        */     jns _0xa6ed
_0xa6e7:  /*C6441800    */     mov byte [si+0x18],0x0
_0xa6eb:  /*EB0B        */     jmp short _0xa6f8

; ─────────────────────────────────────────────────────────────────────

_0xa6ed:  /*A0AB8D      */     mov al,[0x8dab]
_0xa6f0:  /*3A4418      */     cmp al,[si+0x18]
_0xa6f3:  /*7303        */     jnc _0xa6f8
_0xa6f5:  /*884418      */     mov [si+0x18],al
_0xa6f8:  /*32F6        */     xor dh,dh
_0xa6fa:  /*8A5417      */     mov dl,[si+0x17]
_0xa6fd:  /*D1E2        */     shl dx,1
_0xa6ff:  /*D1E2        */     shl dx,1
_0xa701:  /*D1E2        */     shl dx,1
_0xa703:  /*8A4418      */     mov al,[si+0x18]
_0xa706:  /*F626018E    */     mul byte [0x8e01]
_0xa70a:  /*D1E0        */     shl ax,1
_0xa70c:  /*D1E0        */     shl ax,1
_0xa70e:  /*D1E0        */     shl ax,1
_0xa710:  /*D1E0        */     shl ax,1
_0xa712:  /*D1E0        */     shl ax,1
_0xa714:  /*03C2        */     add ax,dx
_0xa716:  /*89440D      */     mov [si+0xd],ax
_0xa719:  /*32F6        */     xor dh,dh
_0xa71b:  /*8A541D      */     mov dl,[si+0x1d]
_0xa71e:  /*D1E2        */     shl dx,1
_0xa720:  /*D1E2        */     shl dx,1
_0xa722:  /*D1E2        */     shl dx,1
_0xa724:  /*8A441E      */     mov al,[si+0x1e]
_0xa727:  /*F626018E    */     mul byte [0x8e01]
_0xa72b:  /*D1E0        */     shl ax,1
_0xa72d:  /*D1E0        */     shl ax,1
_0xa72f:  /*D1E0        */     shl ax,1
_0xa731:  /*D1E0        */     shl ax,1
_0xa733:  /*D1E0        */     shl ax,1
_0xa735:  /*03C2        */     add ax,dx
_0xa737:  /*89440F      */     mov [si+0xf],ax
_0xa73a:  /*F64425FF    */     test byte [si+0x25],0xff
_0xa73e:  /*752B        */     jnz _0xa76b
_0xa740:  /*FE4C2A      */     dec byte [si+0x2a]
_0xa743:  /*7801        */     js _0xa746
_0xa745:  /*C3          */     ret

; ─────────────────────────────────────────────────────────────────────

_0xa746:  /*C6442A00    */     mov byte [si+0x2a],0x0
_0xa74a:  /*FE4429      */     inc byte [si+0x29]
_0xa74d:  /*8A4429      */     mov al,[si+0x29]
_0xa750:  /*8AE0        */     mov ah,al
_0xa752:  /*D0E8        */     shr al,1
_0xa754:  /*D0E8        */     shr al,1
_0xa756:  /*241F        */     and al,0x1f
_0xa758:  /*BB5C8D      */     mov bx,0x8d5c
_0xa75b:  /*D7          */     xlatb
_0xa75c:  /*BB7C8D      */     mov bx,0x8d7c
_0xa75f:  /*D0E0        */     shl al,1
_0xa761:  /*D0E0        */     shl al,1
_0xa763:  /*80E403      */     and ah,0x3
_0xa766:  /*02C4        */     add al,ah
_0xa768:  /*D7          */     xlatb
_0xa769:  /*EB13        */     jmp short _0xa77e

; ─────────────────────────────────────────────────────────────────────

_0xa76b:  /*A0CF8D      */     mov al,[0x8dcf]
_0xa76e:  /*2403        */     and al,0x3
_0xa770:  /*32FF        */     xor bh,bh
_0xa772:  /*8A5C23      */     mov bl,[si+0x23]
_0xa775:  /*D0E3        */     shl bl,1
_0xa777:  /*D0E3        */     shl bl,1
_0xa779:  /*81C34C8D    */     add bx,0x8d4c
_0xa77d:  /*D7          */     xlatb
_0xa77e:  /*32E4        */     xor ah,ah
_0xa780:  /*D1E0        */     shl ax,1
_0xa782:  /*D1E0        */     shl ax,1
_0xa784:  /*D1E0        */     shl ax,1
_0xa786:  /*D1E0        */     shl ax,1
_0xa788:  /*D1E0        */     shl ax,1
_0xa78a:  /*D1E0        */     shl ax,1
_0xa78c:  /*8BD0        */     mov dx,ax
_0xa78e:  /*D1E0        */     shl ax,1
_0xa790:  /*03C2        */     add ax,dx
_0xa792:  /*05302E      */     add ax,0x2e30
_0xa795:  /*894413      */     mov [si+0x13],ax
_0xa798:  /*C3          */     ret

; ─────────────────────────────────────────────────────────────────────

_0xa799:  /*E8A700      */     call _0xa843
_0xa79c:  /*E8BDE0      */     call _0x885c
_0xa79f:  /*C706D37B3089*/     mov word [0x7bd3],0x8930
_0xa7a5:  /*C606DA8D01  */     mov byte [0x8dda],0x1
_0xa7aa:  /*F606037CFF  */     test byte [0x7c03],0xff
_0xa7af:  /*7510        */     jnz _0xa7c1
_0xa7b1:  /*C606DA8D03  */     mov byte [0x8dda],0x3
_0xa7b6:  /*F606047CFF  */     test byte [0x7c04],0xff
_0xa7bb:  /*7504        */     jnz _0xa7c1
_0xa7bd:  /*FE06DA8D    */     inc byte [0x8dda]
_0xa7c1:  /*E81E00      */     call _0xa7e2
_0xa7c4:  /*33C0        */     xor ax,ax
_0xa7c6:  /*A3308E      */     mov [0x8e30],ax
_0xa7c9:  /*BF7A60      */     mov di,0x607a
_0xa7cc:  /*B91900      */     mov cx,0x19
_0xa7cf:  /*F3AA        */     rep stosb

_0xa7d1:  /*BF0C8E      */     mov di,0x8e0c
_0xa7d4:  /*BE5660      */     mov si,0x6056
_0xa7d7:  /*B91200      */     mov cx,0x12
_0xa7da:  /*F3A5        */     rep movsw

_0xa7dc:  /*C606D48D01  */     mov byte [0x8dd4],0x1
_0xa7e1:  /*C3          */     ret
_0xa7e2:  /*C6064E8900  */     mov byte [0x894e],0x0
_0xa7e7:  /*B0FF        */     mov al,0xff
_0xa7e9:  /*F606D98DFF  */     test byte [0x8dd9],0xff
_0xa7ee:  /*7401        */     jz _0xa7f1
_0xa7f0:  /*40          */     inc ax
_0xa7f1:  /*A28389      */     mov [0x8983],al
_0xa7f4:  /*BB4E89      */     mov bx,0x894e
_0xa7f7:  /*E80300      */     call _0xa7fd
_0xa7fa:  /*BB8389      */     mov bx,0x8983
_0xa7fd:  /*B90500      */     mov cx,0x5
_0xa800:  /*B030        */     mov al,0x30
_0xa802:  /*8D7F05      */     lea di,[bx+0x5]
_0xa805:  /*F3AA        */     rep stosb

_0xa807:  /*33C0        */     xor ax,ax
_0xa809:  /*894703      */     mov [bx+0x3],ax
_0xa80c:  /*C647260A    */     mov byte [bx+0x26],0xa
_0xa810:  /*884728      */     mov [bx+0x28],al
_0xa813:  /*88472D      */     mov [bx+0x2d],al
_0xa816:  /*88472C      */     mov [bx+0x2c],al
_0xa819:  /*884731      */     mov [bx+0x31],al
_0xa81c:  /*C3          */     ret

; ─────────────────────────────────────────────────────────────────────

_0xa81d:  /*E8775A      */     call _0x297
_0xa820:  /*33C0        */     xor ax,ax
_0xa822:  /*A3CF8D      */     mov [0x8dcf],ax
_0xa825:  /*A2D38D      */     mov [0x8dd3],al
_0xa828:  /*BF2B8C      */     mov di,0x8c2b
_0xa82b:  /*B92800      */     mov cx,0x28
_0xa82e:  /*F3AB        */     rep stosw
_0xa830:  /*BE4D8A      */     mov si,0x8a4d
_0xa833:  /*B90E00      */     mov cx,0xe
_0xa836:  /*51          */     push cx
_0xa837:  /*E831EB      */     call _0x936b
_0xa83a:  /*59          */     pop cx
_0xa83b:  /*83C611      */     add si,byte +0x11
_0xa83e:  /*E2F6        */     loop _0xa836
_0xa840:  /*E938EC      */     jmp _0x947b

; ─────────────────────────────────────────────────────────────────────

_0xa843:  /*B8A9AD      */     mov ax,0xada9
_0xa846:  /*8CCA        */     mov dx,cs
_0xa848:  /*D1E8        */     shr ax,1
_0xa84a:  /*D1E8        */     shr ax,1
_0xa84c:  /*D1E8        */     shr ax,1
_0xa84e:  /*D1E8        */     shr ax,1
_0xa850:  /*40          */     inc ax
_0xa851:  /*03D0        */     add dx,ax
_0xa853:  /*89163689    */     mov [0x8936],dx
_0xa857:  /*89164889    */     mov [0x8948],dx
_0xa85b:  /*81C2A005    */     add dx,0x5a0
_0xa85f:  /*89163889    */     mov [0x8938],dx
_0xa863:  /*89163E89    */     mov [0x893e],dx
_0xa867:  /*89164C89    */     mov [0x894c],dx
_0xa86b:  /*81C2A005    */     add dx,0x5a0
_0xa86f:  /*89163A89    */     mov [0x893a],dx
_0xa873:  /*89164089    */     mov [0x8940],dx
_0xa877:  /*89164289    */     mov [0x8942],dx
_0xa87b:  /*89164489    */     mov [0x8944],dx
_0xa87f:  /*89164689    */     mov [0x8946],dx
_0xa883:  /*C3          */     ret

; ─────────────────────────────────────────────────────────────────────

_0xa884:  /*BE4E89      */     mov si,0x894e
_0xa887:  /*F6064E89FF  */     test byte [0x894e],0xff
_0xa88c:  /*7803        */     js _0xa891
_0xa88e:  /*E80B00      */     call _0xa89c
_0xa891:  /*BE8389      */     mov si,0x8983
_0xa894:  /*F6068389FF  */     test byte [0x8983],0xff
_0xa899:  /*7901        */     jns _0xa89c
_0xa89b:  /*C3          */     ret
_0xa89c:  /*F6442DFF    */     test byte [si+0x2d],0xff
_0xa8a0:  /*740E        */     jz _0xa8b0
_0xa8a2:  /*A13689      */     mov ax,[0x8936]
_0xa8a5:  /*87063889    */     xchg [0x8938],ax
_0xa8a9:  /*87063A89    */     xchg [0x893a],ax
_0xa8ad:  /*A33689      */     mov [0x8936],ax
_0xa8b0:  /*8B2EB28D    */     mov bp,[0x8db2]
_0xa8b4:  /*8B16B08D    */     mov dx,[0x8db0]
_0xa8b8:  /*8B7C0B      */     mov di,[si+0xb]
_0xa8bb:  /*56          */     push si
_0xa8bc:  /*8B740D      */     mov si,[si+0xd]
_0xa8bf:  /*8BC6        */     mov ax,si
_0xa8c1:  /*8BDF        */     mov bx,di
_0xa8c3:  /*8BCD        */     mov cx,bp
_0xa8c5:  /*2E8E1E3689  */     mov ds,[cs:0x8936]
_0xa8ca:  /*2E8E063089  */     mov es,[cs:0x8930]
_0xa8cf:  /*F3A5        */     rep movsw

_0xa8d1:  /*8BF0        */     mov si,ax
_0xa8d3:  /*8BFB        */     mov di,bx
_0xa8d5:  /*8BCD        */     mov cx,bp
_0xa8d7:  /*2E8E1E3889  */     mov ds,[cs:0x8938]
_0xa8dc:  /*2E8E063289  */     mov es,[cs:0x8932]
_0xa8e1:  /*F3A5        */     rep movsw

_0xa8e3:  /*8BF0        */     mov si,ax
_0xa8e5:  /*8BFB        */     mov di,bx
_0xa8e7:  /*8BCD        */     mov cx,bp
_0xa8e9:  /*2E8E1E3A89  */     mov ds,[cs:0x893a]
_0xa8ee:  /*2E8E063489  */     mov es,[cs:0x8934]
_0xa8f3:  /*F3A5        */     rep movsw

_0xa8f5:  /*8CC8        */     mov ax,cs
_0xa8f7:  /*8ED8        */     mov ds,ax
_0xa8f9:  /*033EB48D    */     add di,[0x8db4]
_0xa8fd:  /*0336B68D    */     add si,[0x8db6]
_0xa901:  /*4A          */     dec dx
_0xa902:  /*75BB        */     jnz _0xa8bf
_0xa904:  /*8CC8        */     mov ax,cs
_0xa906:  /*8EC0        */     mov es,ax
_0xa908:  /*5E          */     pop si
_0xa909:  /*F6442DFF    */     test byte [si+0x2d],0xff
_0xa90d:  /*7411        */     jz _0xa920
_0xa90f:  /*A13A89      */     mov ax,[0x893a]
_0xa912:  /*87063889    */     xchg [0x8938],ax
_0xa916:  /*87063689    */     xchg [0x8936],ax
_0xa91a:  /*A33A89      */     mov [0x893a],ax
_0xa91d:  /*FE4C2D      */     dec byte [si+0x2d]
_0xa920:  /*C3          */     ret

; ─────────────────────────────────────────────────────────────────────

_0xa921:  /*33C0        */     xor ax,ax
_0xa923:  /*A3FA8D      */     mov [0x8dfa],ax
_0xa926:  /*A2DC8D      */     mov [0x8ddc],al
_0xa929:  /*A2DF8D      */     mov [0x8ddf],al
_0xa92c:  /*A2E08D      */     mov [0x8de0],al
_0xa92f:  /*C606E18D01  */     mov byte [0x8de1],0x1
_0xa934:  /*A0DD8D      */     mov al,[0x8ddd]
_0xa937:  /*BB7960      */     mov bx,0x6079
_0xa93a:  /*D7          */     xlatb
_0xa93b:  /*A2DE8D      */     mov [0x8dde],al
_0xa93e:  /*8AD8        */     mov bl,al
_0xa940:  /*803EDD8D01  */     cmp byte [0x8ddd],0x1
_0xa945:  /*750C        */     jnz _0xa953
_0xa947:  /*32C0        */     xor al,al
_0xa949:  /*A2DE8D      */     mov [0x8dde],al
_0xa94c:  /*D0E3        */     shl bl,1
_0xa94e:  /*D0E3        */     shl bl,1
_0xa950:  /*80E30C      */     and bl,0xc
_0xa953:  /*D0E8        */     shr al,1
_0xa955:  /*D016DF8D    */     rcl byte [0x8ddf],1
_0xa959:  /*D0E8        */     shr al,1
_0xa95b:  /*D016E08D    */     rcl byte [0x8de0],1
_0xa95f:  /*32E4        */     xor ah,ah
_0xa961:  /*8AC3        */     mov al,bl
_0xa963:  /*D0E8        */     shr al,1
_0xa965:  /*D0E8        */     shr al,1
_0xa967:  /*8BF0        */     mov si,ax
_0xa969:  /*D1E6        */     shl si,1
_0xa96b:  /*8BB46379    */     mov si,[si+0x7963]
_0xa96f:  /*A0DD8D      */     mov al,[0x8ddd]
_0xa972:  /*48          */     dec ax
_0xa973:  /*D1E0        */     shl ax,1
_0xa975:  /*8BD8        */     mov bx,ax
_0xa977:  /*D1E0        */     shl ax,1
_0xa979:  /*03F0        */     add si,ax
_0xa97b:  /*03F3        */     add si,bx
_0xa97d:  /*AD          */     lodsw
_0xa97e:  /*A3E28D      */     mov [0x8de2],ax
_0xa981:  /*AD          */     lodsw
_0xa982:  /*A3E48D      */     mov [0x8de4],ax
_0xa985:  /*AD          */     lodsw
_0xa986:  /*A3E68D      */     mov [0x8de6],ax
_0xa989:  /*8A1EDD8D    */     mov bl,[0x8ddd]
_0xa98d:  /*32FF        */     xor bh,bh
_0xa98f:  /*D1E3        */     shl bx,1
_0xa991:  /*8B872F79    */     mov ax,[bx+0x792f]
_0xa995:  /*A3E88D      */     mov [0x8de8],ax
_0xa998:  /*8B872C68    */     mov ax,[bx+0x682c]
_0xa99c:  /*A3EA8D      */     mov [0x8dea],ax
_0xa99f:  /*8B875664    */     mov ax,[bx+0x6456]
_0xa9a3:  /*A3EC8D      */     mov [0x8dec],ax
_0xa9a6:  /*8B871E66    */     mov ax,[bx+0x661e]
_0xa9aa:  /*A3EE8D      */     mov [0x8dee],ax
_0xa9ad:  /*8B872667    */     mov ax,[bx+0x6726]
_0xa9b1:  /*A3F08D      */     mov [0x8df0],ax
_0xa9b4:  /*8BB74E58    */     mov si,[bx+0x584e]
_0xa9b8:  /*E8A901      */     call _0xab64
_0xa9bb:  /*E891F3      */     call _0x9d4f
_0xa9be:  /*E82F03      */     call _0xacf0
_0xa9c1:  /*8936FC8D    */     mov [0x8dfc],si
_0xa9c5:  /*E8EA03      */     call _0xadb2
_0xa9c8:  /*BD1E8D      */     mov bp,0x8d1e
_0xa9cb:  /*E822DE      */     call _0x87f0
_0xa9ce:  /*8B36EA8D    */     mov si,[0x8dea]
_0xa9d2:  /*A1E48D      */     mov ax,[0x8de4]
_0xa9d5:  /*BF0A61      */     mov di,0x610a
_0xa9d8:  /*E86401      */     call _0xab3f
_0xa9db:  /*890EF28D    */     mov [0x8df2],cx
_0xa9df:  /*BE0A61      */     mov si,0x610a
_0xa9e2:  /*C606088E43  */     mov byte [0x8e08],0x43
_0xa9e7:  /*FE060B8E    */     inc byte [0x8e0b]
_0xa9eb:  /*E81E01      */     call _0xab0c
_0xa9ee:  /*FE0E0B8E    */     dec byte [0x8e0b]
_0xa9f2:  /*8B36EC8D    */     mov si,[0x8dec]
_0xa9f6:  /*A1E68D      */     mov ax,[0x8de6]
_0xa9f9:  /*BF0A61      */     mov di,0x610a
_0xa9fc:  /*E84001      */     call _0xab3f
_0xa9ff:  /*890EF88D    */     mov [0x8df8],cx
_0xaa03:  /*BE0A61      */     mov si,0x610a
_0xaa06:  /*BFE960      */     mov di,0x60e9
_0xaa09:  /*F3A5        */     rep movsw

_0xaa0b:  /*8B36EE8D    */     mov si,[0x8dee]
_0xaa0f:  /*A1E28D      */     mov ax,[0x8de2]
_0xaa12:  /*BF0A61      */     mov di,0x610a
_0xaa15:  /*E82701      */     call _0xab3f
_0xaa18:  /*890EF68D    */     mov [0x8df6],cx
_0xaa1c:  /*890EF48D    */     mov [0x8df4],cx
_0xaa20:  /*BE0A61      */     mov si,0x610a
_0xaa23:  /*C606088E42  */     mov byte [0x8e08],0x42
_0xaa28:  /*E8E100      */     call _0xab0c
_0xaa2b:  /*8B36F08D    */     mov si,[0x8df0]
_0xaa2f:  /*B80000      */     mov ax,0x0
_0xaa32:  /*8B0EF68D    */     mov cx,[0x8df6]
_0xaa36:  /*F9          */     stc
_0xaa37:  /*D1D0        */     rcl ax,1
_0xaa39:  /*E2FB        */     loop _0xaa36
_0xaa3b:  /*BF0A61      */     mov di,0x610a
_0xaa3e:  /*E8FE00      */     call _0xab3f
_0xaa41:  /*BE0A61      */     mov si,0x610a
_0xaa44:  /*C606088E41  */     mov byte [0x8e08],0x41
_0xaa49:  /*E8C000      */     call _0xab0c
_0xaa4c:  /*BF9460      */     mov di,0x6094
_0xaa4f:  /*BEBE60      */     mov si,0x60be
_0xaa52:  /*BB7B60      */     mov bx,0x607b
_0xaa55:  /*B91500      */     mov cx,0x15
_0xaa58:  /*8A07        */     mov al,[bx]
_0xaa5a:  /*43          */     inc bx
_0xaa5b:  /*0AC0        */     or al,al
_0xaa5d:  /*780C        */     js _0xaa6b
_0xaa5f:  /*AC          */     lodsb
_0xaa60:  /*E86D02      */     call _0xacd0
_0xaa63:  /*AA          */     stosb
_0xaa64:  /*AC          */     lodsb
_0xaa65:  /*E87802      */     call _0xace0
_0xaa68:  /*AA          */     stosb
_0xaa69:  /*EB0A        */     jmp short _0xaa75

; ─────────────────────────────────────────────────────────────────────

_0xaa6b:  /*C705FFFF    */     mov word [di],0xffff
_0xaa6f:  /*83C702      */     add di,byte +0x2
_0xaa72:  /*83C602      */     add si,byte +0x2
_0xaa75:  /*E2E1        */     loop _0xaa58
_0xaa77:  /*BB99AD      */     mov bx,0xad99
_0xaa7a:  /*E80603      */     call _0xad83
_0xaa7d:  /*33FF        */     xor di,di
_0xaa7f:  /*BE4E89      */     mov si,0x894e
_0xaa82:  /*F6064E89FF  */     test byte [0x894e],0xff
_0xaa87:  /*7803        */     js _0xaa8c
_0xaa89:  /*E80E00      */     call _0xaa9a
_0xaa8c:  /*BE8389      */     mov si,0x8983
_0xaa8f:  /*F6068389FF  */     test byte [0x8983],0xff
_0xaa94:  /*7901        */     jns _0xaa97
_0xaa96:  /*C3          */     ret

; ─────────────────────────────────────────────────────────────────────

_0xaa97:  /*BF0200      */     mov di,0x2
_0xaa9a:  /*8A1EDD8D    */     mov bl,[0x8ddd]
_0xaa9e:  /*32FF        */     xor bh,bh
_0xaaa0:  /*D1E3        */     shl bx,1
_0xaaa2:  /*D1E3        */     shl bx,1
_0xaaa4:  /*8B819269    */     mov ax,[bx+di+0x6992]
_0xaaa8:  /*E82502      */     call _0xacd0
_0xaaab:  /*884419      */     mov [si+0x19],al
_0xaaae:  /*D0E0        */     shl al,1
_0xaab0:  /*88441D      */     mov [si+0x1d],al
_0xaab3:  /*88441F      */     mov [si+0x1f],al
_0xaab6:  /*2C08        */     sub al,0x8
_0xaab8:  /*7902        */     jns _0xaabc
_0xaaba:  /*32C0        */     xor al,al
_0xaabc:  /*3A06AA8D    */     cmp al,[0x8daa]
_0xaac0:  /*7603        */     jna 0xaac5
_0xaac2:  /*A0AA8D      */     mov al,[0x8daa]
_0xaac5:  /*884417      */     mov [si+0x17],al
_0xaac8:  /*8AC4        */     mov al,ah
_0xaaca:  /*E81302      */     call _0xace0
_0xaacd:  /*88441A      */     mov [si+0x1a],al
_0xaad0:  /*D0E0        */     shl al,1
_0xaad2:  /*88441E      */     mov [si+0x1e],al
_0xaad5:  /*884420      */     mov [si+0x20],al
_0xaad8:  /*2C04        */     sub al,0x4
_0xaada:  /*7902        */     jns _0xaade
_0xaadc:  /*32C0        */     xor al,al
_0xaade:  /*3A06AB8D    */     cmp al,[0x8dab]
_0xaae2:  /*7603        */     jna 0xaae7
_0xaae4:  /*A0AB8D      */     mov al,[0x8dab]
_0xaae7:  /*884418      */     mov [si+0x18],al
_0xaaea:  /*33C0        */     xor ax,ax
_0xaaec:  /*894421      */     mov [si+0x21],ax
_0xaaef:  /*894423      */     mov [si+0x23],ax
_0xaaf2:  /*C6442E00    */     mov byte [si+0x2e],0x0
_0xaaf6:  /*884429      */     mov [si+0x29],al
_0xaaf9:  /*884427      */     mov [si+0x27],al
_0xaafc:  /*E8F9FB      */     call _0xa6f8
_0xaaff:  /*8B440F      */     mov ax,[si+0xf]
_0xab02:  /*894411      */     mov [si+0x11],ax
_0xab05:  /*8B4413      */     mov ax,[si+0x13]
_0xab08:  /*894415      */     mov [si+0x15],ax
_0xab0b:  /*C3          */     ret

; ─────────────────────────────────────────────────────────────────────

_0xab0c:  /*BFC05C      */     mov di,0x5cc0
_0xab0f:  /*AC          */     lodsb
_0xab10:  /*32E4        */     xor ah,ah
_0xab12:  /*03F8        */     add di,ax
_0xab14:  /*AC          */     lodsb
_0xab15:  /*F626018E    */     mul byte [0x8e01]
_0xab19:  /*03F8        */     add di,ax
_0xab1b:  /*8A26088E    */     mov ah,[0x8e08]
_0xab1f:  /*F6060B8EFF  */     test byte [0x8e0b],0xff
_0xab24:  /*7414        */     jz _0xab3a
_0xab26:  /*56          */     push si
_0xab27:  /*57          */     push di
_0xab28:  /*51          */     push cx
_0xab29:  /*E82CDB      */     call _0x8658
_0xab2c:  /*D1EA        */     shr dx,1
_0xab2e:  /*81E20300    */     and dx,0x3
_0xab32:  /*80C243      */     add dl,0x43
_0xab35:  /*59          */     pop cx
_0xab36:  /*5F          */     pop di
_0xab37:  /*5E          */     pop si
_0xab38:  /*8AE2        */     mov ah,dl
_0xab3a:  /*8825        */     mov [di],ah
_0xab3c:  /*E2CE        */     loop _0xab0c
_0xab3e:  /*C3          */     ret
_0xab3f:  /*33C9        */     xor cx,cx
_0xab41:  /*57          */     push di
_0xab42:  /*D1E8        */     shr ax,1
_0xab44:  /*7314        */     jnc _0xab5a
_0xab46:  /*50          */     push ax
_0xab47:  /*8A04        */     mov al,[si]
_0xab49:  /*E88401      */     call _0xacd0
_0xab4c:  /*AA          */     stosb
_0xab4d:  /*8A4401      */     mov al,[si+0x1]
_0xab50:  /*E88D01      */     call _0xace0
_0xab53:  /*AA          */     stosb
_0xab54:  /*58          */     pop ax
_0xab55:  /*41          */     inc cx
_0xab56:  /*0BC0        */     or ax,ax
_0xab58:  /*7405        */     jz _0xab5f
_0xab5a:  /*83C602      */     add si,byte +0x2
_0xab5d:  /*EBE3        */     jmp short _0xab42

; ─────────────────────────────────────────────────────────────────────

_0xab5f:  /*5E          */     pop si
_0xab60:  /*884CFF      */     mov [si-0x1],cl
_0xab63:  /*C3          */     ret
_0xab64:  /*8BD6        */     mov dx,si
_0xab66:  /*A0DD8D      */     mov al,[0x8ddd]
_0xab69:  /*B405        */     mov ah,0x5
_0xab6b:  /*F6E4        */     mul ah
_0xab6d:  /*8BF0        */     mov si,ax
_0xab6f:  /*81C6D663    */     add si,0x63d6
_0xab73:  /*32E4        */     xor ah,ah
_0xab75:  /*AC          */     lodsb
_0xab76:  /*A2018E      */     mov [0x8e01],al
_0xab79:  /*48          */     dec ax
_0xab7a:  /*D1E0        */     shl ax,1
_0xab7c:  /*D1E0        */     shl ax,1
_0xab7e:  /*D1E0        */     shl ax,1
_0xab80:  /*D1E0        */     shl ax,1
_0xab82:  /*A3048E      */     mov [0x8e04],ax
_0xab85:  /*33C0        */     xor ax,ax
_0xab87:  /*AC          */     lodsb
_0xab88:  /*A2008E      */     mov [0x8e00],al
_0xab8b:  /*AC          */     lodsb
_0xab8c:  /*A2DB8D      */     mov [0x8ddb],al
_0xab8f:  /*AC          */     lodsb
_0xab90:  /*F606D98DFF  */     test byte [0x8dd9],0xff
_0xab95:  /*7503        */     jnz _0xab9a
_0xab97:  /*A2DB8D      */     mov [0x8ddb],al
_0xab9a:  /*AC          */     lodsb
_0xab9b:  /*A2FE8D      */     mov [0x8dfe],al
_0xab9e:  /*B303        */     mov bl,0x3
_0xaba0:  /*B403        */     mov ah,0x3
_0xaba2:  /*3C55        */     cmp al,0x55
_0xaba4:  /*7418        */     jz _0xabbe
_0xaba6:  /*80C302      */     add bl,0x2
_0xaba9:  /*3C58        */     cmp al,0x58
_0xabab:  /*7411        */     jz _0xabbe
_0xabad:  /*80C302      */     add bl,0x2
_0xabb0:  /*B401        */     mov ah,0x1
_0xabb2:  /*3C5B        */     cmp al,0x5b
_0xabb4:  /*7408        */     jz _0xabbe
_0xabb6:  /*B404        */     mov ah,0x4
_0xabb8:  /*3C6D        */     cmp al,0x6d
_0xabba:  /*7402        */     jz _0xabbe
_0xabbc:  /*32E4        */     xor ah,ah
_0xabbe:  /*8826098E    */     mov [0x8e09],ah
_0xabc2:  /*881EFF8D    */     mov [0x8dff],bl
_0xabc6:  /*8BF2        */     mov si,dx
_0xabc8:  /*A0008E      */     mov al,[0x8e00]
_0xabcb:  /*F626018E    */     mul byte [0x8e01]
_0xabcf:  /*A3028E      */     mov [0x8e02],ax
_0xabd2:  /*33C9        */     xor cx,cx
_0xabd4:  /*32E4        */     xor ah,ah
_0xabd6:  /*32C0        */     xor al,al
_0xabd8:  /*50          */     push ax
_0xabd9:  /*E81700      */     call _0xabf3
_0xabdc:  /*52          */     push dx
_0xabdd:  /*E81F00      */     call _0xabff
_0xabe0:  /*5A          */     pop dx
_0xabe1:  /*58          */     pop ax
_0xabe2:  /*41          */     inc cx
_0xabe3:  /*40          */     inc ax
_0xabe4:  /*3A06018E    */     cmp al,[0x8e01]
_0xabe8:  /*72EE        */     jc _0xabd8
_0xabea:  /*FEC4        */     inc ah
_0xabec:  /*3A26008E    */     cmp ah,[0x8e00]
_0xabf0:  /*72E4        */     jc _0xabd6
_0xabf2:  /*C3          */     ret

; ─────────────────────────────────────────────────────────────────────

_0xabf3:  /*F7C10700    */     test cx,0x7
_0xabf7:  /*7503        */     jnz _0xabfc
_0xabf9:  /*8A14        */     mov dl,[si]
_0xabfb:  /*46          */     inc si
_0xabfc:  /*D0E2        */     shl dl,1
_0xabfe:  /*C3          */     ret

; ─────────────────────────────────────────────────────────────────────

_0xabff:  /*9C          */     pushf
_0xac00:  /*E8CD00      */     call _0xacd0
_0xac03:  /*8AD8        */     mov bl,al
_0xac05:  /*8AC4        */     mov al,ah
_0xac07:  /*E8D600      */     call _0xace0
_0xac0a:  /*F626018E    */     mul byte [0x8e01]
_0xac0e:  /*32FF        */     xor bh,bh
_0xac10:  /*03D8        */     add bx,ax
_0xac12:  /*B440        */     mov ah,0x40
_0xac14:  /*9D          */     popf
_0xac15:  /*732A        */     jnc _0xac41
_0xac17:  /*51          */     push cx
_0xac18:  /*53          */     push bx
_0xac19:  /*E83CDA      */     call _0x8658
_0xac1c:  /*803E098E00  */     cmp byte [0x8e09],0x0
_0xac21:  /*750B        */     jnz _0xac2e
_0xac23:  /*B472        */     mov ah,0x72
_0xac25:  /*80E606      */     and dh,0x6
_0xac28:  /*7515        */     jnz _0xac3f
_0xac2a:  /*B454        */     mov ah,0x54
_0xac2c:  /*EB11        */     jmp short _0xac3f

; ─────────────────────────────────────────────────────────────────────

_0xac2e:  /*D1EA        */     shr dx,1
_0xac30:  /*D1EA        */     shr dx,1
_0xac32:  /*8BC2        */     mov ax,dx
_0xac34:  /*251F00      */     and ax,0x1f
_0xac37:  /*F636098E    */     div byte [0x8e09]
_0xac3b:  /*0226FE8D    */     add ah,[0x8dfe]
_0xac3f:  /*5B          */     pop bx
_0xac40:  /*59          */     pop cx
_0xac41:  /*88A7C05C    */     mov [bx+0x5cc0],ah
_0xac45:  /*C3          */     ret

; ─────────────────────────────────────────────────────────────────────

_0xac46:  /*F606E08DFF  */     test byte [0x8de0],0xff
_0xac4b:  /*741B        */     jz _0xac68
_0xac4d:  /*E88000      */     call _0xacd0
_0xac50:  /*8A26088E    */     mov ah,[0x8e08]
_0xac54:  /*80FC71      */     cmp ah,0x71
_0xac57:  /*7410        */     jz _0xac69
_0xac59:  /*80FC5E      */     cmp ah,0x5e
_0xac5c:  /*740D        */     jz _0xac6b
_0xac5e:  /*80FC68      */     cmp ah,0x68
_0xac61:  /*7408        */     jz _0xac6b
_0xac63:  /*80FC62      */     cmp ah,0x62
_0xac66:  /*7405        */     jz _0xac6d
_0xac68:  /*C3          */     ret
_0xac69:  /*FEC8        */     dec al
_0xac6b:  /*FEC8        */     dec al
_0xac6d:  /*FEC8        */     dec al
_0xac6f:  /*C3          */     ret

; ─────────────────────────────────────────────────────────────────────

_0xac70:  /*F606DF8DFF  */     test byte [0x8ddf],0xff
_0xac75:  /*7420        */     jz _0xac97
_0xac77:  /*E86600      */     call _0xace0
_0xac7a:  /*8A26088E    */     mov ah,[0x8e08]
_0xac7e:  /*80FC5E      */     cmp ah,0x5e
_0xac81:  /*7415        */     jz _0xac98
_0xac83:  /*80FC68      */     cmp ah,0x68
_0xac86:  /*7410        */     jz _0xac98
_0xac88:  /*80FC71      */     cmp ah,0x71
_0xac8b:  /*740B        */     jz _0xac98
_0xac8d:  /*80FC62      */     cmp ah,0x62
_0xac90:  /*7408        */     jz _0xac9a
_0xac92:  /*80FC66      */     cmp ah,0x66
_0xac95:  /*7403        */     jz _0xac9a
_0xac97:  /*C3          */     ret
_0xac98:  /*FEC8        */     dec al
_0xac9a:  /*FEC8        */     dec al
_0xac9c:  /*C3          */     ret

; ─────────────────────────────────────────────────────────────────────

_0xac9d:  /*F606E08DFF  */     test byte [0x8de0],0xff
_0xaca2:  /*7412        */     jz _0xacb6
_0xaca4:  /*3C51        */     cmp al,0x51
_0xaca6:  /*7505        */     jnz _0xacad
_0xaca8:  /*C606088E53  */     mov byte [0x8e08],0x53
_0xacad:  /*3C53        */     cmp al,0x53
_0xacaf:  /*7505        */     jnz _0xacb6
_0xacb1:  /*C606088E51  */     mov byte [0x8e08],0x51
_0xacb6:  /*F606DF8DFF  */     test byte [0x8ddf],0xff
_0xacbb:  /*7412        */     jz _0xaccf
_0xacbd:  /*3C52        */     cmp al,0x52
_0xacbf:  /*7505        */     jnz _0xacc6
_0xacc1:  /*C606088E50  */     mov byte [0x8e08],0x50
_0xacc6:  /*3C50        */     cmp al,0x50
_0xacc8:  /*7505        */     jnz _0xaccf
_0xacca:  /*C606088E52  */     mov byte [0x8e08],0x52
_0xaccf:  /*C3          */     ret
_0xacd0:  /*F606E08DFF  */     test byte [0x8de0],0xff
_0xacd5:  /*7408        */     jz _0xacdf
_0xacd7:  /*2A06018E    */     sub al,[0x8e01]
_0xacdb:  /*FEC0        */     inc al
_0xacdd:  /*F6D8        */     neg al
_0xacdf:  /*C3          */     ret

; ─────────────────────────────────────────────────────────────────────

_0xace0:  /*F606DF8DFF  */     test byte [0x8ddf],0xff
_0xace5:  /*7408        */     jz _0xacef
_0xace7:  /*2A06008E    */     sub al,[0x8e00]
_0xaceb:  /*FEC0        */     inc al
_0xaced:  /*F6D8        */     neg al
_0xacef:  /*C3          */     ret

; ─────────────────────────────────────────────────────────────────────

_0xacf0:  /*8B36E88D    */     mov si,[0x8de8]
_0xacf4:  /*AC          */     lodsb
_0xacf5:  /*3C40        */     cmp al,0x40
_0xacf7:  /*74F6        */     jz _0xacef
_0xacf9:  /*7224        */     jc _0xad1f
_0xacfb:  /*A2088E      */     mov [0x8e08],al
_0xacfe:  /*E89CFF      */     call _0xac9d
_0xad01:  /*3C73        */     cmp al,0x73
_0xad03:  /*75EF        */     jnz _0xacf4
_0xad05:  /*803EDD8D01  */     cmp byte [0x8ddd],0x1
_0xad0a:  /*74E8        */     jz _0xacf4
_0xad0c:  /*8A04        */     mov al,[si]
_0xad0e:  /*E8BFFF      */     call _0xacd0
_0xad11:  /*A2068E      */     mov [0x8e06],al
_0xad14:  /*8A4401      */     mov al,[si+0x1]
_0xad17:  /*E8C6FF      */     call _0xace0
_0xad1a:  /*A2078E      */     mov [0x8e07],al
_0xad1d:  /*EBD5        */     jmp short _0xacf4

; ─────────────────────────────────────────────────────────────────────

_0xad1f:  /*BFC05C      */     mov di,0x5cc0
_0xad22:  /*E821FF      */     call _0xac46
_0xad25:  /*32E4        */     xor ah,ah
_0xad27:  /*03F8        */     add di,ax
_0xad29:  /*AC          */     lodsb
_0xad2a:  /*E843FF      */     call _0xac70
_0xad2d:  /*F626018E    */     mul byte [0x8e01]
_0xad31:  /*03F8        */     add di,ax
_0xad33:  /*A0088E      */     mov al,[0x8e08]
_0xad36:  /*3C77        */     cmp al,0x77
_0xad38:  /*750A        */     jnz _0xad44
_0xad3a:  /*E81BD9      */     call _0x8658
_0xad3d:  /*80E660      */     and dh,0x60
_0xad40:  /*B040        */     mov al,0x40
_0xad42:  /*75B0        */     jnz _0xacf4
_0xad44:  /*8805        */     mov [di],al
_0xad46:  /*BB328E      */     mov bx,0x8e32
_0xad49:  /*8A07        */     mov al,[bx]
_0xad4b:  /*0AC0        */     or al,al
_0xad4d:  /*74A5        */     jz _0xacf4
_0xad4f:  /*3A06088E    */     cmp al,[0x8e08]
_0xad53:  /*7405        */     jz _0xad5a
_0xad55:  /*83C303      */     add bx,byte +0x3
_0xad58:  /*EBEF        */     jmp short _0xad49

; ─────────────────────────────────────────────────────────────────────

_0xad5a:  /*8B5F01      */     mov bx,[bx+0x1]
_0xad5d:  /*8A17        */     mov dl,[bx]
_0xad5f:  /*0AD2        */     or dl,dl
_0xad61:  /*7491        */     jz _0xacf4
_0xad63:  /*32E4        */     xor ah,ah
_0xad65:  /*8A4701      */     mov al,[bx+0x1]
_0xad68:  /*8BE8        */     mov bp,ax
_0xad6a:  /*8A4702      */     mov al,[bx+0x2]
_0xad6d:  /*F626018E    */     mul byte [0x8e01]
_0xad71:  /*03E8        */     add bp,ax
_0xad73:  /*8813        */     mov [bp+di],dl
_0xad75:  /*83C303      */     add bx,byte +0x3
_0xad78:  /*EBE3        */     jmp short _0xad5d

; ─────────────────────────────────────────────────────────────────────

_0xad7a:  /*59          */     pop cx
_0xad7b:  /*81F983AB    */     cmp cx,0xab83
_0xad7f:  /*741B        */     jz _0xad9c
_0xad81:  /*FFE1        */     jmp cx

; ─────────────────────────────────────────────────────────────────────

_0xad83:  /*8B4F0C      */     mov cx,[bx+0xc]
_0xad86:  /*FE4F0E      */     dec byte [bx+0xe]
_0xad89:  /*E0FB        */     loopne 0xad86
_0xad8b:  /*E3ED        */     jcxz 0xad7a
_0xad8d:  /*51          */     push cx
_0xad8e:  /*8B5706      */     mov dx,[bx+0x6]
_0xad91:  /*8B4F0A      */     mov cx,[bx+0xa]
_0xad94:  /*2B4F08      */     sub cx,[bx+0x8]
_0xad97:  /*D1E9        */     shr cx,1
_0xad99:  /*8B7708      */     mov si,[bx+0x8]
_0xad9c:  /*D1CA        */     ror dx,1
_0xad9e:  /*AD          */     lodsw
_0xad9f:  /*03D0        */     add dx,ax
_0xada1:  /*E2F9        */     loop _0xad9c
_0xada3:  /*58          */     pop ax
_0xada4:  /*2B5704      */     sub dx,[bx+0x4]
_0xada7:  /*74D1        */     jz _0xad7a
_0xada9:  /*C7069EABAB00*/     mov word [0xab9e],0xab
_0xadaf:  /*EBE8        */     jmp short _0xad99

; ─────────────────────────────────────────────────────────────────────

_0xadb1:  /*C3          */     ret

; ─────────────────────────────────────────────────────────────────────

_0xadb2:  /*BE0C8E      */     mov si,0x8e0c
_0xadb5:  /*8A16DD8D    */     mov dl,[0x8ddd]
_0xadb9:  /*8A36DE8D    */     mov dh,[0x8dde]
_0xadbd:  /*B90900      */     mov cx,0x9
_0xadc0:  /*8B1E308E    */     mov bx,[0x8e30]
_0xadc4:  /*80C347      */     add bl,0x47
_0xadc7:  /*80FA01      */     cmp dl,0x1
_0xadca:  /*7501        */     jnz _0xadcd
_0xadcc:  /*4B          */     dec bx
_0xadcd:  /*3B14        */     cmp dx,[si]
_0xadcf:  /*7503        */     jnz _0xadd4
_0xadd1:  /*E80600      */     call _0xadda
_0xadd4:  /*83C604      */     add si,byte +0x4
_0xadd7:  /*E2F4        */     loop _0xadcd
_0xadd9:  /*C3          */     ret

; ─────────────────────────────────────────────────────────────────────

_0xadda:  /*BFC05C      */     mov di,0x5cc0
_0xaddd:  /*8A4402      */     mov al,[si+0x2]
_0xade0:  /*E8EDFE      */     call _0xacd0
_0xade3:  /*32E4        */     xor ah,ah
_0xade5:  /*03F8        */     add di,ax
_0xade7:  /*8A4403      */     mov al,[si+0x3]
_0xadea:  /*E8F3FE      */     call _0xace0
_0xaded:  /*F626018E    */     mul byte [0x8e01]
_0xadf1:  /*03F8        */     add di,ax
_0xadf3:  /*881D        */     mov [di],bl
_0xadf5:  /*4B          */     dec bx
_0xadf6:  /*C3          */     ret

; ─────────────────────────────────────────────────────────────────────

_0xadf7:  /*FA          */     cli
_0xadf8:  /*33C0        */     xor ax,ax
_0xadfa:  /*8EC0        */     mov es,ax
_0xadfc:  /*B90001      */     mov cx,0x100
_0xadff:  /*33FF        */     xor di,di
_0xae01:  /*FC          */     cld

_0xae02:  /*33C0        */     xor ax,ax
_0xae04:  /*AB          */     stosw
_0xae05:  /*B84000      */     mov ax,0x40
_0xae08:  /*AB          */     stosw
_0xae09:  /*E2F7        */     loop _0xae02

_0xae0b:  /*B88386      */     mov ax,0x8683
_0xae0e:  /*BFEC03      */     mov di,0x3ec
_0xae11:  /*AB          */     stosw

_0xae12:  /*B84000      */     mov ax,0x40
_0xae15:  /*AB          */     stosw
_0xae16:  /*5D          */     pop bp
_0xae17:  /*33FF        */     xor di,di
_0xae19:  /*33F6        */     xor si,si
_0xae1b:  /*8EC0        */     mov es,ax
_0xae1d:  /*B9A9AD      */     mov cx,0xada9
_0xae20:  /*F3A4        */     rep movsb

_0xae22:  /*8ED8        */     mov ds,ax
_0xae24:  /*8ED0        */     mov ss,ax
_0xae26:  /*50          */     push ax
_0xae27:  /*55          */     push bp
_0xae28:  /*FB          */     sti
_0xae29:  /*CB          */     retf

; ─────────────────────────────────────────────────────────────────────

_0xae2a:  /*BEC05C      */     mov si,0x5cc0
_0xae2d:  /*33FF        */     xor di,di
_0xae2f:  /*8B16048E    */     mov dx,[0x8e04]
_0xae33:  /*BB3689      */     mov bx,0x8936
_0xae36:  /*32E4        */     xor ah,ah
_0xae38:  /*32C0        */     xor al,al
_0xae3a:  /*50          */     push ax
_0xae3b:  /*AC          */     lodsb
_0xae3c:  /*3C72        */     cmp al,0x72
_0xae3e:  /*7222        */     jc _0xae62
_0xae40:  /*7502        */     jnz _0xae44
_0xae42:  /*B040        */     mov al,0x40
_0xae44:  /*3C78        */     cmp al,0x78
_0xae46:  /*7502        */     jnz _0xae4a
_0xae48:  /*B040        */     mov al,0x40
_0xae4a:  /*3C73        */     cmp al,0x73
_0xae4c:  /*7502        */     jnz _0xae50
_0xae4e:  /*B040        */     mov al,0x40
_0xae50:  /*3C74        */     cmp al,0x74
_0xae52:  /*7502        */     jnz _0xae56
_0xae54:  /*B055        */     mov al,0x55
_0xae56:  /*3C75        */     cmp al,0x75
_0xae58:  /*7502        */     jnz _0xae5c
_0xae5a:  /*B058        */     mov al,0x58
_0xae5c:  /*3C76        */     cmp al,0x76
_0xae5e:  /*7502        */     jnz _0xae62
_0xae60:  /*B05B        */     mov al,0x5b
_0xae62:  /*3C71        */     cmp al,0x71
_0xae64:  /*7502        */     jnz _0xae68
_0xae66:  /*B068        */     mov al,0x68
_0xae68:  /*56          */     push si
_0xae69:  /*E82200      */     call _0xae8e
_0xae6c:  /*5E          */     pop si
_0xae6d:  /*58          */     pop ax
_0xae6e:  /*83C710      */     add di,byte +0x10
_0xae71:  /*40          */     inc ax
_0xae72:  /*3A06018E    */     cmp al,[0x8e01]
_0xae76:  /*72C2        */     jc _0xae3a
_0xae78:  /*83C730      */     add di,byte +0x30
_0xae7b:  /*03FA        */     add di,dx
_0xae7d:  /*03FA        */     add di,dx
_0xae7f:  /*03FA        */     add di,dx
_0xae81:  /*FEC4        */     inc ah
_0xae83:  /*3A26008E    */     cmp ah,[0x8e00]
_0xae87:  /*72AF        */     jc _0xae38
_0xae89:  /*8CC8        */     mov ax,cs
_0xae8b:  /*8EC0        */     mov es,ax
_0xae8d:  /*C3          */     ret

; ─────────────────────────────────────────────────────────────────────

; draw something ?


_0xae8e:  /*BE7009      */     mov si,0x970
_0xae91:  /*2C40        */     sub al,0x40
_0xae93:  /*32E4        */     xor ah,ah
_0xae95:  /*D1E0        */     shl ax,1
_0xae97:  /*D1E0        */     shl ax,1
_0xae99:  /*D1E0        */     shl ax,1
_0xae9b:  /*D1E0        */     shl ax,1
_0xae9d:  /*D1E0        */     shl ax,1
_0xae9f:  /*D1E0        */     shl ax,1
_0xaea1:  /*03F0        */     add si,ax
_0xaea3:  /*D1E0        */     shl ax,1
_0xaea5:  /*03F0        */     add si,ax
_0xaea7:  /*8E07        */     mov es,[bx]
_0xaea9:  /*8BEF        */     mov bp,di
_0xaeab:  /*B90800      */     mov cx,0x8
_0xaeae:  /*F3A5        */     rep movsw

_0xaeb0:  /*03FA        */     add di,dx
_0xaeb2:  /*B90800      */     mov cx,0x8
_0xaeb5:  /*F3A5        */     rep movsw

_0xaeb7:  /*03FA        */     add di,dx
_0xaeb9:  /*B90800      */     mov cx,0x8
_0xaebc:  /*F3A5        */     rep movsw

_0xaebe:  /*03FA        */     add di,dx
_0xaec0:  /*B90800      */     mov cx,0x8
_0xaec3:  /*F3A5        */     rep movsw

_0xaec5:  /*8BFD        */     mov di,bp
_0xaec7:  /*8E4702      */     mov es,[bx+0x2]
_0xaeca:  /*B90800      */     mov cx,0x8
_0xaecd:  /*F3A5        */     rep movsw

_0xaecf:  /*03FA        */     add di,dx
_0xaed1:  /*B90800      */     mov cx,0x8
_0xaed4:  /*F3A5        */     rep movsw

_0xaed6:  /*03FA        */     add di,dx
_0xaed8:  /*B90800      */     mov cx,0x8
_0xaedb:  /*F3A5        */     rep movsw

_0xaedd:  /*03FA        */     add di,dx
_0xaedf:  /*B90800      */     mov cx,0x8
_0xaee2:  /*F3A5        */     rep movsw

_0xaee4:  /*8BFD        */     mov di,bp
_0xaee6:  /*8E4704      */     mov es,[bx+0x4]
_0xaee9:  /*B90800      */     mov cx,0x8
_0xaeec:  /*F3A5        */     rep movsw

_0xaeee:  /*03FA        */     add di,dx
_0xaef0:  /*B90800      */     mov cx,0x8
_0xaef3:  /*F3A5        */     rep movsw

_0xaef5:  /*03FA        */     add di,dx
_0xaef7:  /*B90800      */     mov cx,0x8
_0xaefa:  /*F3A5        */     rep movsw

_0xaefc:  /*03FA        */     add di,dx
_0xaefe:  /*B90800      */     mov cx,0x8
_0xaf01:  /*F3A5        */     rep movsw

_0xaf03:  /*8BFD        */     mov di,bp
_0xaf05:  /*8CC9        */     mov cx,cs
_0xaf07:  /*8EC1        */     mov es,cx
_0xaf09:  /*C3          */     ret

; ─────────────────────────────────────────────────────────────────────

_0xaf0a:  /*BE4E89      */     mov si,0x894e
_0xaf0d:  /*BA0703      */     mov dx,0x307
_0xaf10:  /*F6064E89FF  */     test byte [0x894e],0xff
_0xaf15:  /*7803        */     js _0xaf1a
_0xaf17:  /*E80E00      */     call _0xaf28
_0xaf1a:  /*BA0605      */     mov dx,0x506
_0xaf1d:  /*BE8389      */     mov si,0x8983
_0xaf20:  /*F6068389FF  */     test byte [0x8983],0xff
_0xaf25:  /*7901        */     jns _0xaf28
_0xaf27:  /*C3          */     ret

; ─────────────────────────────────────────────────────────────────────

_0xaf28:  /*F64428FF    */     test byte [si+0x28],0xff
_0xaf2c:  /*7501        */     jnz _0xaf2f
_0xaf2e:  /*C3          */     ret

; ─────────────────────────────────────────────────────────────────────

_0xaf2f:  /*FE4C28      */     dec byte [si+0x28]
_0xaf32:  /*833ECF8D00  */     cmp word [0x8dcf],byte +0x0
_0xaf37:  /*7405        */     jz _0xaf3e
_0xaf39:  /*F604FF      */     test byte [si],0xff
_0xaf3c:  /*753D        */     jnz _0xaf7b
_0xaf3e:  /*FF4403      */     inc word [si+0x3]
_0xaf41:  /*837C03FF    */     cmp word [si+0x3],byte -0x1
_0xaf45:  /*7503        */     jnz _0xaf4a
_0xaf47:  /*FF4C03      */     dec word [si+0x3]
_0xaf4a:  /*8D5C0A      */     lea bx,[si+0xa]
_0xaf4d:  /*B90500      */     mov cx,0x5
_0xaf50:  /*4B          */     dec bx
_0xaf51:  /*FE07        */     inc byte [bx]
_0xaf53:  /*803F3A      */     cmp byte [bx],0x3a
_0xaf56:  /*7523        */     jnz _0xaf7b
_0xaf58:  /*C60730      */     mov byte [bx],0x30
_0xaf5b:  /*83F904      */     cmp cx,byte +0x4
_0xaf5e:  /*7509        */     jnz _0xaf69
_0xaf60:  /*807C260F    */     cmp byte [si+0x26],0xf
_0xaf64:  /*7303        */     jnc _0xaf69
_0xaf66:  /*FE4426      */     inc byte [si+0x26]
_0xaf69:  /*E2E5        */     loop _0xaf50
_0xaf6b:  /*8A4401      */     mov al,[si+0x1]
_0xaf6e:  /*8A5C02      */     mov bl,[si+0x2]
_0xaf71:  /*32E4        */     xor ah,ah
_0xaf73:  /*32FF        */     xor bh,bh
_0xaf75:  /*BEA58C      */     mov si,0x8ca5
_0xaf78:  /*E97CD5      */     jmp _0x84f7

; ─────────────────────────────────────────────────────────────────────

_0xaf7b:  /*56          */     push si
_0xaf7c:  /*E835D5      */     call _0x84b4
_0xaf7f:  /*5E          */     pop si
_0xaf80:  /*8A4401      */     mov al,[si+0x1]
_0xaf83:  /*8A5C02      */     mov bl,[si+0x2]
_0xaf86:  /*32E4        */     xor ah,ah
_0xaf88:  /*32FF        */     xor bh,bh
_0xaf8a:  /*8D7404      */     lea si,[si+0x4]
_0xaf8d:  /*B90500      */     mov cx,0x5
_0xaf90:  /*46          */     inc si
_0xaf91:  /*803C30      */     cmp byte [si],0x30
_0xaf94:  /*E1FA        */     loope 0xaf90
_0xaf96:  /*E95ED5      */     jmp _0x84f7

; ─────────────────────────────────────────────────────────────────────

; DATA

times 0x67 db 0     ; L A S T . X  ....
