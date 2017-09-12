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

 CALL setIllegalHandler
 CALL setTimerHandler

endless:
 ;JMP    endless

 Print  'CMOVB AX,BX - '
 STC
 TCMOVB AX,BX
 JNE    bug
 CLC
 TCMOVB AX,BX
 JE     bug
 TEST  [fatal],-1
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
 MOV    WORD [6 * 4 + 0],AX
 MOV    WORD [6 * 4 + 2],illegalHandler

 POP    DS
 RET
;-------------------------------------------------------
illegalHandler:

 MOV [fatal],-1
 IRET
;-------------------------------------------------------
setTimerHandler:
 
 PUSH   DS

 XOR    AX,AX
 MOV    DS,AX

 MOV    AX,WORD [8 * 4 + 0]
 MOV    [CS:timerSaveOffs],AX
 MOV    AX,WORD [8 * 4 + 2]
 MOV    [CS:timerSaveSeg],AX

 CLI
 MOV    WORD [8 * 4 + 0],timerHandler
 MOV    AX,CS
 MOV    WORD [8 * 4 + 2],AX
 STI

 POP    DS
 RET
;-------------------------------------------------------
timerHandler:

 PUSH   DS
 PUSH   0b800H
 POP    DS
 INC    BYTE [0]
 POP    DS

 JMP    DWORD [CS:timerSaveOffs]
