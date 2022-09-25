; https://codegolf.stackexchange.com/a/204279

org 100h
lds sp,[si]
X: db 32
mov bl,7                    ; O: 3 iterations
or [si],al                  ; O: Add in new cell
cmpsw
shr byte [di],5             ; O: Shift previous value 
C: xchg cx,ax
add al,[di+bx+94]           ; O: Add in this column
add al,[si+bx-4]
add al,[si+bx+156]
dec bx                      ; O: Loop back
jnz C
mov al,[si]                 ; O: 3 = birth, 4 = stay (tricky): 
stc                         ; O: 1.00?0000x --> 0.0x100?00 (rcr 3) 
rcr al,cl                   ; O:          +---> 0.00x100?0 (rcr 4) 
jmp short X-1