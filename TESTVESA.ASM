;VESATEST by TomCat/Abaddon
;FAST code / FASM source

RESX EQU 640
RESY EQU 480
RADIUS EQU 90

ORG 256
 PUSH   3
 PUSH   0A000H
 POP    ES

 MOV    BX,121H
video:
 MOV    AX,4F02H
 INT    10H
 MOV    BL,12H
 CMP    AH,BH
 JE     video

 FNINIT                         ; -
 SUB    BX,BX                   ; BX:0
 CWD
 MOV    DI,SP
 MOV    CX,RESY*3
nextline:
 MOV    BP,RESX*4
nextpixel:
 SUB    DI,SP
 JNZ    nobank
 MOV    AX,4F05H
 INT    10H
 INC    DX
nobank:
 PUSHA
 XCHG   AX,BP
 CBW
 IMUL   AL
 XCHG   AX,CX
 CBW
 IMUL   AL
 ADD    AX,CX
 MOV    SI,COLOR0
 CMP    AX,RADIUS*RADIUS
 JNC    .1
 MOV    SI,COLOR2
.1:
 MOVSD
 POPA
 ADD    BP,SP
 JNZ    nextpixel
 DEC    CX
 DEC    CX
 LOOP   nextline

 MOV    AH,0
 INT    16H

 POP    AX
 INT    10H
RETN

COLOR0  DB 255,20,0             ; B,G,R - background
COLOR2  DB 67,28,236            ; B,G,R - pokeball
