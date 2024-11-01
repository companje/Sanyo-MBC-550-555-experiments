Timer0:
    cli
    push ax
    push dx
    push ds
    push cs
    pop ds
    mov dx,[BV.AuxTickCount]

    ;read timer 1
    in al,0x22
    mov ah,al
    in al,0x22
    xchg ah,al

    mov [BV.AuxTickCount],ax
    sub dx,ax
    shl dx,1 ;multiply dx by two because sanyo ticks are half as fast as normal IBM

    ;dx now has the amount of ticks elapsed since last time
    ;carry has an overflow bit
    adc word [BV.TimerTicksH],byte 0
    add word [BV.TimerTicksL],dx
    adc word [BV.TimerTicksH],byte 0
    cmp word [BV.TimerTicksH],byte 0x18 ;check for 24 hours
    jb .carry2
    sub word [BV.TimerTicksH],byte 0x18 ;24 hours
    inc byte [BV.DaysPassed]
    .carry2
    sti
    int 0x1c
    int 0x8
    .exit
    pop ds
    pop dx
    pop ax
    iret


;And some time/date API:
INT1A:
    cli ;don't want the time changing while we access it!!
    cmp ah,0x1
    je .set
    jnb .exit

.get ;Get system time
    cs mov al,[0x70]
    cs mov cx,[BV.TimerTicksH];[0x6e]
    cs mov dx,[BV.TimerTicksL];[0x6c]

.set ;Set system time
    cs mov byte [0x70],0x0 ;clear day counter
    cs mov [BV.TimerTicksH],cx
    cs mov [BV.TimerTicksL],dx
.exit
    iret
