CPU 186

VideoSegment equ 0x400

Section Loader
LoaderStart:
    call InitCode+LoaderEnd-LoaderStart
LoaderEnd:

section BIOS align=1 vstart=0
BV:
.Serial     dw 0
            dw 0
            dw 0
            dw 0
.Parallel   dw 0x1a
            dw 0
            dw 0
            dw 0
.Equipment  dw 0x4021 ;4061 for 2 floppies; autodetected
            db 0
.TotalRAM   dw 768
            db 0
            db 0
.KeyStatus  dw 0
            db 0
.NextKey    dw .KeyBuffer
.FirstFreeKey   dw .KeyBuffer
.KeyBuffer  times 16 dw 0
.EndKeyBuffer   db 0
            db 0
            iret    ;0:0x40 is the default interrupt handler
.DiskLastStatus db 0
            db 0
            db 0
            db 0
            db 0
.XFCount    db 0
            db 0
            db 0

;Start mode change clear range
.CurMode    db 0x2
.ScreenCols dw 0;80
.PageSize   dw 0x1000 ;4000
.PageStart  dw 0
.CursorPos  times 8 dw 0
.CEndLine   db 8
.CStartLine db 7
.CurPage    db 0
.CRTCBase   dw 0x3d4
.CurModeSelect  db 0xd
.CurCGAPalette  db 0
;End mode change clear range
            dd 0
            db 0
.TimerTicksL    dw 0
.TimerTicksH    dw 0
.DaysPassed db 0
.CtrlBrk    db 0
            dw 0
            db 0
            db 0
            db 0
            db 0
            times 4 db 0
            times 4 db 0
.KeyBufferStart dw .KeyBuffer
.KeyBufferEnd   dw .EndKeyBuffer
times 0x84-($-$$) db 0
.ScreenRows db 0;24
times 0x200-($-$$) db 0
.XFlags     db 0    ;bit 0=V20 present, 1=CGA present
.LFlags     db 0    ;bit 0=OnboardVid 1=CGA 2=Disk 3=BIOSMenus
            ;    4=RunTimerTick 5=RunKeyClick 6=RunBIOSMenu
.FloppyIntCount db 0
.SectorsPerTrack db 10,10 ;actually SPT+1
.AuxTickCount   dw 0
.EncKey   times 8 dd 0

;DriveData
.DTrack db 0,0
;.DName  times 16 db 0 ;8 each
.DFlags  db 0,0 ;bit 0: disk encryption active
;.KeyCache
;.KName  times 3 dd 0,0
;.KKey   times 24 dd 0 ;32B each
;.KExpT  times 3 dw 0
.DSubkeys    times 120 dd 0
.CRTC_Profile
    dw 0
.CRTC_DisplayAddress
    dw 0
.LStackStart    dw 0x5a00 ;test pattern for coprocessor detection
                times 47 dw 0
.LocalStack
.EncIV          times 4 dd 0
.SectorBuffer   times 128 dd 0

startCode

startOnboardv
%include "onboardv.asm" ;Onboard Video
endOnboardv
startCga
%include "cga.asm"      ;CGA Video
endCga
startDisk
%include "disk.asm"     ;Disk Functions
endDisk
startKeyboard
%include "keyboard.asm" ;Keyboard API & Interrupt handler
endKeyboard
startMisc
%include "misc.asm"     ;Minor interrupt handlers, BIOS display routines
endMisc
startTimer
%include "timer.asm"    ;Timer chip support
endTimer
startMenu
%include "menu.asm"     ;Breakout menu
endMenu
startCrtc
%include "crtc.asm"     ;CRTC configuration routines and screen profiles
endCrtc
startCrypto
%include "crypto.asm"   ;Encryption support routines
endCrypto

%define rijndael_empty_data ;tables are generated at boot, saving disk space
startRijndael
%include "rijndael.asm" ;Main Rijndael encryption routines
endRijndael
EndOfResident:

startInit
%include "init.asm" ;HW Init and 3rd stage bootloader code
endInit

InitCode:   ;relocate to 40:0
cli
push cs
pop ds
mov cx,InitCode
mov ax,0x40
mov es,ax
xor di,di
pop si  ;first byte after call
cld
rep movsb ;for great justice
jmp 0x40:BIOSEntry

%ifdef SizeSummary
    dw endInit - startInit
    db "<INIT"
    dw endOnboardv - startOnboardv
    db "<ONBOARDV"
    dw endCga - startCga
    db "<CGA"
    dw endDisk - startDisk
    db "<DISK"
    dw endKeyboard - startKeyboard
    db "<KEYBOARD"
    dw endMisc - startMisc
    db "<MISC"
    dw endTimer - startTimer
    db "<TIMER"
    dw endMenu - startMenu
    db "<MENU"
    dw endCrtc - startCrtc
    db "<CRTC"
    dw endCrypto - startCrypto
    db "<CRYPTO"
    dw endRijndael - startRijndael
    db "<RIJNDAEL"
    dw endRijInit - startRijInit
    db "<RIJINIT"
    dw startCode - BV
    db "<VARS"
%endif