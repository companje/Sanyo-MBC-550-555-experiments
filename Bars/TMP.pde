      //; xor     ah, ah         ; ah=0, al=sine result
      //; mov     bx, ax         ; copy of AX in BX
      //; mov     cl, 7
      //; shl     ax, cl         ; AX = x * 128
      //; dec     cl
      //; shl     bx, cl         ; BX = x * 64
      //; add     ax, bx         ; AX = x * 192
      //; mov     al, ah         ; shr 8 is niet nodig nu als je alleen AH pakt
