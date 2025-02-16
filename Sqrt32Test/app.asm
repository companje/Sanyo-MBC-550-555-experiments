%include "sanyo.asm"

; Bereken de vierkantswortel van DX:AX
; Resultaat komt in AX (wortel van DX:AX)

setup:
  mov ax,25152
  mov dx,64468
  call sqrt_16bit

  print_ax
  hlt



orig_high: dw 0
orig_low: dw 0
times (180*1024)-($-$$) db 0



