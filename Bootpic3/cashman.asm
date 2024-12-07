org 0
cpu 8086

jmp _0xd8_bootloader                          

; db 0x13,0x00           
; db 0xF8             
; db 0x02,0x0F           
; db 0x02,0xFF           
; db 0x02,0x25           
; db 0x3A,0x34           
; db 0x26,0x13,0x20      
; db 0x03,0x20           
; db 0x74,0x26           
; db 0x60                
; db 0x22,0xEA           
; db 0x22,0xB6,0x26,0x5D 
; db 0x24,0x00           
; db 0x24,0x6E           
; db 0x2A,0x18           
; db 0x2A

_0x23_next_sector:
  inc dh
  cmp dh,10
  jb _0x42_read_sector                                       ; db 0x72,0x18    ; jump
  mov dh,1    ; sector
  inc dl      ; track

_0x2e_movehead:
  mov al, dl                                     ; 0x8A,0xC2 
  out 0xe,al                                     ; 00000030  E60E              
  mov al,0x18                                    ; 00000032  B018              
  out 0x8,al                                     ; 00000034  E608              
  mov al,0x0                                     ; 00000036  B000              
  out 0x1c,al                                    ; 00000038  E61C              
  aam                                            ; 0000003A  D40A              

_0x3c_head_moving:
  in al,0x8                                      ; E408  0000003C  
  test al,0x1                                    ; A801  0000003E  
  jnz _0x3c_head_moving                          ; 75FA  00000040  

_0x42_read_sector:
  mov al,dh      ;sector                                ; 8AC6     00000042  
  out 0xc,al                                     ; E60C     00000044  
  mov bp,dx                                      ; 8BEA     00000046  
  mov dx,0x8                                     ; BA0800   00000048  
  ; mov si,0x71                                    ; BE7100   0000004B  
  mov bh,0x2                                     ; B702     0000004E  
  mov bl,0x96                                    ; B396     00000050  
  mov ah,0x0                                     ; B400     00000052  
  mov al,0x80                                    ; B080     00000054  
  mov sp,di                                      ; 8BE7     00000058  
  out 0x8,al                                     ; E608     00000056  
  times 4 aam                                            ; D40A     0000005A  

_0x62_check_status_1:
  in al,dx                                      ; 00000062  EC                
  sar al,1                                      ; 00000063  D0F8              
  jnc _0x83                                     ; 00000065  731C              
  jnz _0x62_check_status_1                                     ; 00000067  75F9              

_0x69_wait_for_data:
  in al,dx                                      ; 00000069  EC                
  and al,bl                                     ; 0000006A  22C3              
  jz _0x69_wait_for_data                                      ; 0000006C  74FB              
  
_0x6e_store_byte_1:
  in al,0xe                                     ; 0000006E  E40E              
  stosb                                         ; 00000070  AA                

_0x71_check_status_2:
  in al,dx                                     ; 00000071  EC                
  dec ax                                     ; 00000072  48                
  jz _0x71_check_status_2                                     ; 00000073  74FC              
  cmp al,bh                                     ; 00000075  3AC7              
  jnz _0x83                                     ; 00000077  750A              

_0x79_store_byte_2:
  in al,0xe                                   ;00000079  E40E              
  stosb                                   ;0000007B  AA    

  in al,dx                                    ;0000007C  EC                
  cmp al,bh                                   ;0000007D  3AC7              
  jz _0x79_store_byte_2                                    ;0000007F  74F8              
  jmp _0x71_check_status_2  ; was jmp si

_0x83:
  in al,dx                                   ;00000083  EC                
  mov dx,bp                                   ;00000084  8BD5              
  test al,0x1c                                   ;00000086  A81C              
  jz _0x8e                                   ;00000088  7404              
  mov di,sp                                   ;0000008A  8BFC              
  jmp short _0x42_read_sector                                   ;0000008C  EBB4              

_0x8e:
  loop _0x23_next_sector                                ;0000008E  E293

hlt

  ; mov di,0x0                                ;00000090  BF0000
  ; mov es,di                                ;00000093  8EC7
  ; mov ax,0x50                                ;00000095  B85000
  ; mov cx,0x200                                ;00000098  B90002
  ; rep stosw                                ;0000009B  F3AB

  ; mov ds,ax                                ; 0000009D  8ED8              
  ; mov bx,ds                                ; 0000009F  8CDB              
  ; mov byte [bx],0xcf                                ; 000000A1  C607CF            
  ; mov di,0x3ec                                ; 000000A4  BFEC03            
  ; mov ax,0x2014                                ; 000000A7  B81420            
  ; stosw                                ; 000000AA  AB                

  ; mov ax,0x7f5                  ;000000AB  B8F507     
  ; stosw                  ;000000AE  AB         
  ; mov bx,0x3                  ;000000AF  BB0300     
  ; xor dx,dx                  ;000000B2  33D2       

_0xb4:
  ; mov ax,[cs:bx]      ;      000000B4  2E8B07            
  ; mov dl,ah           ; 000000B7  8AD4              
  ; out dx,al           ; 000000B9  EE                
  ; add bx,byte +0x2    ;        000000BA  83C302            
  ; cmp bx,byte +0x23   ;         000000BD  83FB23            
  ; jnz _0xb4           ; 000000C0  75F2              

  ; mov ax,0x100        ;    000000C2  B80001            
  ; mov ss,ax           ; 000000C5  8ED0              
  ; mov sp,0x50         ;   000000C7  BC5000            
  ; mov al,0x35         ;   000000CA  B035              
  ; out 0x3a,al         ;   000000CC  E63A              
  ; mov al,0xf0         ;   000000CE  B0F0              
  ; out 0x2,al          ;  000000D0  E602              
  ; sti                 ; 000000D2  FB                

  hlt
  ; jmp 0x7f5:0x0       ;      000000D3  EA0000F507        

_0xd8_bootloader:
  cli               ;                   000000D8  FA                
  cld               ;                   000000D9  FC                
  mov ax,0x1c00     ;                   000000DA  B8001C            
  mov es,ax         ;                   00000DD  8EC0              
  mov di,0x0        ;                   000000DF  BF0000            
  mov ax,0x0        ;                   000000E2  B80000            
  mov cx,0x2000     ;                   000000E5  B90020            
  rep stosw         ;                   00000E8  F3AB              

  mov al,0x5        ;                   000000EA  B005              
  out 0x10,al       ;                   000000EC  E610              
  mov ax,cs         ;                   00000EE  8CC8              
  mov ds,ax         ;                   00000F0  8ED8              
  mov ax,0x7f5      ;                   000000F2  B8F507            
  mov es,ax         ;                   00000F5  8EC0              
  mov di,0x0        ;                   000000F7  BF0000            
  mov dl,0        ; track             000000FA  B201              
  mov dh,0x1        ; sector            000000FC  B601              
  mov cx,0x48       ; NUM_SECTORS       000000FE  B94800      

  jmp _0x2e_movehead ;                  00000101  E92AFF            


times (512)-($-$$) db 0  ; finish sector bootsector

;start of sector 2 on disk  
times 512 db 65
times 512 db 66
times 512 db 67
times 512 db 68
times 512 db 69
times 512 db 70
times 512 db 71
times 512 db 72
times 512 db 73
times 512 db 74
times 512 db 75
times 512 db 76
times 512 db 77
times 512 db 78
times 512 db 79
times 512 db 80
times 512 db 81
times 512 db 82
times 512 db 83
times 512 db 84
times 512 db 85
times 512 db 86
times 512 db 87
times 512 db 88
times 512 db 89
times 512 db 90
times 512 db 91
times 512 db 92
times 512 db 93
times 512 db 94
times 512 db 95
times 512 db 96
times 512 db 97
times 512 db 98
times 512 db 99
times 512 db 100
times 512 db 101
times 512 db 102
times 512 db 103
times 512 db 104
times 512 db 105
times 512 db 106
times 512 db 107
times 512 db 108
times 512 db 109
times 512 db 110
times 512 db 111
times 512 db 112
times 512 db 113
times 512 db 114
times 512 db 115
times 512 db 116
times 512 db 117
times 512 db 118
times 512 db 119
times 512 db 120
times 512 db 121
times 512 db 122
times 512 db 123
times 512 db 124
times 512 db 125
times 512 db 126
times 512 db 127
times 512 db 128
times 512 db 129
times 512 db 130
times 512 db 131
times 512 db 132
times 512 db 133
times 512 db 134
times 512 db 135
times 512 db 136
times 512 db 137
times 512 db 138
times 512 db 139
times 512 db 140
times 512 db 141
times 512 db 142
times 512 db 143
times 512 db 144
times 512 db 145
times 512 db 146
times 512 db 147
times 512 db 148
times 512 db 149
times 512 db 150
times 512 db 151
times 512 db 152
times 512 db 153
times 512 db 154
times 512 db 155
times 512 db 156
times 512 db 157
times 512 db 158
times 512 db 159
times 512 db 160
times 512 db 161
times 512 db 162
times 512 db 163
times 512 db 164
times 512 db 165
times 512 db 166
times 512 db 167
times 512 db 168
times 512 db 169
times 512 db 170
times 512 db 171
times 512 db 172
times 512 db 173
times 512 db 174
times 512 db 175
times 512 db 176
times 512 db 177
times 512 db 178
times 512 db 179
times 512 db 180
times 512 db 181
times 512 db 182
times 512 db 183
times 512 db 184
times 512 db 185
times 512 db 186
times 512 db 187
times 512 db 188
times 512 db 189
times 512 db 190
times 512 db 191
times 512 db 192
times 512 db 193
times 512 db 194
times 512 db 195
times 512 db 196
times 512 db 197
times 512 db 198
times 512 db 199
times 512 db 200
times 512 db 201
times 512 db 202
times 512 db 203
times 512 db 204
times 512 db 205
times 512 db 206
times 512 db 207

times (180*1024)-($-$$) db '_'

