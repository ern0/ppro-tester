;FASM source

;-------------------------------------------------------
MACRO Print string
{
 CALL @F
 DB string,'$'
@@:
 POP    DX
 MOV    AH,9
 INT    21H
}
;-------------------------------------------------------
MACRO PrintLN string
{
 CALL @F
 DB string,10,13,'$'
@@:
 POP    DX
 MOV    AH,9
 INT    21H
}
;-------------------------------------------------------
MACRO TCMOVB reg1,reg2
{
 MOV    reg1,0
 MOV    reg2,1
 CMOVB  reg1,reg2
 CMP    reg1,reg2
}
;-------------------------------------------------------
ORG 256

 PrintLN 'PentiumPro instruction set tester'

 CALL   setIllegalHandler

 Print  'CMOVB AX,BX - '
 STC
 TCMOVB AX,BX
 JNE    bug
 CLC
 TCMOVB AX,BX
 JE     bug
 PrintLN 'Ok'
 JMP    next
bug:
 PrintLN 'Error'
next:

 MOV    AX,4C00H
 INT    21H
;-------------------------------------------------------
; Some BSS

fatal   DB 0
timerSaveOffs DW 0
timerSaveSeg  DW 0
;-------------------------------------------------------
setIllegalHandler:

 PUSH   DS

 XOR    AX,AX
 MOV    DS,AX
 MOV    AX,CS
 MOV    WORD [6 * 4 + 0],illegalHandler
 MOV    WORD [6 * 4 + 2],AX

 POP    DS
 RET
;-------------------------------------------------------
illegalHandler:

 PrintLN '#Illegal'
 MOV    AX,4c00H
 INT    21H

 IRET
;-------------------------------------------------------
