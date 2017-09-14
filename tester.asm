;FASM source
include 'ppro.inc'
;-------------------------------------------------------
ORG 256
 MOV    AH,9            ; print title
 LEA    DX,[txt_title]
 INT    21H

 FNINIT                 ; fill FPU stack
 FLDLG2
 FLDLN2
 FLDL2E
 FLDL2T
 FLD    ST3
 FADD   ST0,ST0
 FLD    ST3
 FADD   ST0,ST0
 FLD    ST3
 FADD   ST0,ST0
 FLD    ST3
 FADD   ST0,ST0

 XOR    AX,AX           ; set up illegal handler
 MOV    DS,AX
 MOV    SI,[6 * 4 + 0]
 MOV    DI,[6 * 4 + 2]
 MOV    AX,CS
 MOV    WORD [6 * 4 + 0],illegal
 MOV    WORD [6 * 4 + 2],AX
 MOV    DS,AX
 MOV    ES,AX
 MOV    [iloffset],SI
 MOV    [ilsegment],DI

 MOV    [stdstack],SP
 MOV    [pointer],tab

next:
 MOV    BX,[pointer]    ; pick next table item
 ADD    [pointer],2
 MOV    DI,[BX]
 TEST   DI,DI
 JZ     quit
 MOV    [pointer2],DI
 MOV    AH,9            ; print title
 LEA    DX,[txt_pre]
 INT    21H
 MOV    DX,DI
 INT    21H
 MOV    AH,9
 LEA    DX,[txt_wait]
 INT    21H
next2:
 MOV    DI,[pointer2]   ; pick next table item
 MOV    CX,-1

 MOV    AL,'$'          ; skip title
 REPNZ  SCASB

 TEST   WORD [DI],CX
 JZ     next
 MOV    [jump],DI       ; perform test

again:
 MOV    AL,0C3H         ; skip code
 REPNZ  SCASB
 MOV    [pointer2],DI   ; perform test

 MOV    SI,DI
@@:
 LODSB
 CMP    AL,'$'
 JE     @F
 CMP    AL,'z'
 JNA    @B
 JMP    again
@@:

 CALL   [jump]
 JZ     fail

okay:
 MOV    AH,2
 MOV    DL,'/'
 INT    21H
 JMP    next2

illegal:
 MOV   SP,[stdstack]    ; reset stack, then fail

fail:
 MOV    AH,9
 MOV    DX,[pointer2]
 INT    21H
 MOV    AH,2
 MOV    DL,'!'
 INT    21H
 MOV    DL,' '
 INT    21H
 JMP    next2

quit:

 MOV    SI,[iloffset]   ; restore illegal handler
 MOV    DI,[ilsegment]
 XOR    AX,AX
 MOV    DS,AX
 MOV    WORD [6 * 4 + 0],SI
 MOV    WORD [6 * 4 + 2],DI

 FNINIT                 ; empty FPU stack

 MOV    AX,4C00H        ; exit
 INT    21H
;-------------------------------------------------------
; Data

tab:
 DW     test_force_okay
 DW     test_force_fail
 DW     test_cmovb
 DW     test_cmovnb
 DW     test_fcmovb
 DW     test_fcmovnb
 DW     test_fcmove
 DW     test_fcmovne
 DW     test_fcmovu
 DW     test_fcmovnu
 DW     test_fcmovbe
 DW     test_fcmovnbe
 DW     0

txt_pre: db 10,13," testing $"
txt_wait: db " $"
txt_title: db "PentiumPro instruction set tester$"

;-------------------------------------------------------
test_cmovb:
 DB "CMOVB$"
 TCMOVB AX,BX
 DB "AX,BX$"
 TCMOVB AX,CX
 DB "AX,CX$"
 TCMOVB AX,DX
 DB "AX,DX$"
 TCMOVB AX,SI
 DB "AX,SI$"
 TCMOVB AX,DI
 DB "AX,DI$"
 TCMOVB AX,BP
 DB "AX,BP$"
 TCMOVB AX,SP
 DB "AX,SP$"
;-------------------------------------------------------
 TCMOVB BX,AX
 DB "BX,AX$"
 TCMOVB BX,CX
 DB "BX,CX$"
 TCMOVB BX,DX
 DB "BX,DX$"
 TCMOVB BX,SI
 DB "BX,SI$"
 TCMOVB BX,DI
 DB "BX,DI$"
 TCMOVB BX,BP
 DB "BX,BP$"
 TCMOVB BX,SP
 DB "BX,SP$"
;-------------------------------------------------------
 TCMOVB CX,AX
 DB "CX,AX$"
 TCMOVB CX,BX
 DB "CX,BX$"
 TCMOVB CX,DX
 DB "CX,DX$"
 TCMOVB CX,SI
 DB "CX,SI$"
 TCMOVB CX,DI
 DB "CX,DI$"
 TCMOVB CX,BP
 DB "CX,BP$"
 TCMOVB CX,SP
 DB "CX,SP$"
;-------------------------------------------------------
 TCMOVB DX,AX
 DB "DX,AX$"
 TCMOVB DX,BX
 DB "DX,BX$"
 TCMOVB DX,CX
 DB "DX,CX$"
 TCMOVB DX,SI
 DB "DX,SI$"
 TCMOVB DX,DI
 DB "DX,DI$"
 TCMOVB DX,BP
 DB "DX,BP$"
 TCMOVB DX,SP
 DB "DX,SP$"
;-------------------------------------------------------
 TCMOVB SI,AX
 DB "SI,AX$"
 TCMOVB SI,BX
 DB "SI,BX$"
 TCMOVB SI,CX
 DB "SI,CX$"
 TCMOVB SI,DX
 DB "SI,DX$"
 TCMOVB SI,DI
 DB "SI,DI$"
 TCMOVB SI,BP
 DB "SI,BP$"
 TCMOVB SI,SP
 DB "SI,SP$"
;-------------------------------------------------------
 TCMOVB DI,AX
 DB "DI,AX$"
 TCMOVB DI,BX
 DB "DI,BX$"
 TCMOVB DI,CX
 DB "DI,CX$"
 TCMOVB DI,DX
 DB "DI,DX$"
 TCMOVB DI,SI
 DB "DI,SI$"
 TCMOVB DI,BP
 DB "DI,BP$"
 TCMOVB DI,SP
 DB "DI,SP$"
;-------------------------------------------------------
 TCMOVB BP,AX
 DB "BP,AX$"
 TCMOVB BP,BX
 DB "BP,BX$"
 TCMOVB BP,CX
 DB "BP,CX$"
 TCMOVB BP,DX
 DB "BP,DX$"
 TCMOVB BP,SI
 DB "BP,SI$"
 TCMOVB BP,DI
 DB "BP,DI$"
 TCMOVB BP,SP
 DB "BP,SP$"
;-------------------------------------------------------
 TCMOVB EAX,EBX
 DB "EAX,EBX$"
 TCMOVB EAX,ECX
 DB "EAX,ECX$"
 TCMOVB EAX,EDX
 DB "EAX,EDX$"
 TCMOVB EAX,ESI
 DB "EAX,ESI$"
 TCMOVB EAX,EDI
 DB "EAX,EDI$"
 TCMOVB EAX,EBP
 DB "EAX,EBP$"
 TCMOVB EAX,ESP
 DB "EAX,ESP$"
;-------------------------------------------------------
 TCMOVB EBX,EAX
 DB "EBX,EAX$"
 TCMOVB EBX,ECX
 DB "EBX,ECX$"
 TCMOVB EBX,EDX
 DB "EBX,EDX$"
 TCMOVB EBX,ESI
 DB "EBX,ESI$"
 TCMOVB EBX,EDI
 DB "EBX,EDI$"
 TCMOVB EBX,EBP
 DB "EBX,EBP$"
 TCMOVB EBX,ESP
 DB "EBX,ESP$"
;-------------------------------------------------------
 TCMOVB ECX,EAX
 DB "ECX,EAX$"
 TCMOVB ECX,EBX
 DB "ECX,EBX$"
 TCMOVB ECX,EDX
 DB "ECX,EDX$"
 TCMOVB ECX,ESI
 DB "ECX,ESI$"
 TCMOVB ECX,EDI
 DB "ECX,EDI$"
 TCMOVB ECX,EBP
 DB "ECX,EBP$"
 TCMOVB ECX,ESP
 DB "ECX,ESP$"
;-------------------------------------------------------
 TCMOVB EDX,EAX
 DB "EDX,EAX$"
 TCMOVB EDX,EBX
 DB "EDX,EBX$"
 TCMOVB EDX,ECX
 DB "EDX,ECX$"
 TCMOVB EDX,ESI
 DB "EDX,ESI$"
 TCMOVB EDX,EDI
 DB "EDX,EDI$"
 TCMOVB EDX,EBP
 DB "EDX,EBP$"
 TCMOVB EDX,ESP
 DB "EDX,ESP$"
;-------------------------------------------------------
 TCMOVB ESI,EAX
 DB "ESI,EAX$"
 TCMOVB ESI,EBX
 DB "ESI,EBX$"
 TCMOVB ESI,ECX
 DB "ESI,ECX$"
 TCMOVB ESI,EDX
 DB "ESI,EDX$"
 TCMOVB ESI,EDI
 DB "ESI,EDI$"
 TCMOVB ESI,EBP
 DB "ESI,EBP$"
 TCMOVB ESI,ESP
 DB "ESI,ESP$"
;-------------------------------------------------------
 TCMOVB EDI,EAX
 DB "EDI,EAX$"
 TCMOVB EDI,EBX
 DB "EDI,EBX$"
 TCMOVB EDI,ECX
 DB "EDI,ECX$"
 TCMOVB EDI,EDX
 DB "EDI,EDX$"
 TCMOVB EDI,ESI
 DB "EDI,ESI$"
 TCMOVB EDI,EBP
 DB "EDI,EBP$"
 TCMOVB EDI,ESP
 DB "EDI,ESP$"
;-------------------------------------------------------
 TCMOVB EBP,EAX
 DB "EBP,EAX$"
 TCMOVB EBP,EBX
 DB "EBP,EBX$"
 TCMOVB EBP,ECX
 DB "EBP,ECX$"
 TCMOVB EBP,EDX
 DB "EBP,EDX$"
 TCMOVB EBP,ESI
 DB "EBP,ESI$"
 TCMOVB EBP,EDI
 DB "EBP,EDI$"
 TCMOVB EBP,ESP
 DB "EBP,ESP$"
 DW 0
;-------------------------------------------------------
test_cmovnb:
 DB "CMOVNB$"
 TCMOVNB AX,BX
 DB "AX,BX$"
 TCMOVNB AX,CX
 DB "AX,CX$"
 TCMOVNB AX,DX
 DB "AX,DX$"
 TCMOVNB AX,SI
 DB "AX,SI$"
 TCMOVNB AX,DI
 DB "AX,DI$"
 TCMOVNB AX,BP
 DB "AX,BP$"
 TCMOVNB AX,SP
 DB "AX,SP$"
;-------------------------------------------------------
 TCMOVNB BX,AX
 DB "BX,AX$"
 TCMOVNB BX,CX
 DB "BX,CX$"
 TCMOVNB BX,DX
 DB "BX,DX$"
 TCMOVNB BX,SI
 DB "BX,SI$"
 TCMOVNB BX,DI
 DB "BX,DI$"
 TCMOVNB BX,BP
 DB "BX,BP$"
 TCMOVNB BX,SP
 DB "BX,SP$"
;-------------------------------------------------------
 TCMOVNB CX,AX
 DB "CX,AX$"
 TCMOVNB CX,BX
 DB "CX,BX$"
 TCMOVNB CX,DX
 DB "CX,DX$"
 TCMOVNB CX,SI
 DB "CX,SI$"
 TCMOVNB CX,DI
 DB "CX,DI$"
 TCMOVNB CX,BP
 DB "CX,BP$"
 TCMOVNB CX,SP
 DB "CX,SP$"
;-------------------------------------------------------
 TCMOVNB DX,AX
 DB "DX,AX$"
 TCMOVNB DX,BX
 DB "DX,BX$"
 TCMOVNB DX,CX
 DB "DX,CX$"
 TCMOVNB DX,SI
 DB "DX,SI$"
 TCMOVNB DX,DI
 DB "DX,DI$"
 TCMOVNB DX,BP
 DB "DX,BP$"
 TCMOVNB DX,SP
 DB "DX,SP$"
;-------------------------------------------------------
 TCMOVNB SI,AX
 DB "SI,AX$"
 TCMOVNB SI,BX
 DB "SI,BX$"
 TCMOVNB SI,CX
 DB "SI,CX$"
 TCMOVNB SI,DX
 DB "SI,DX$"
 TCMOVNB SI,DI
 DB "SI,DI$"
 TCMOVNB SI,BP
 DB "SI,BP$"
 TCMOVNB SI,SP
 DB "SI,SP$"
;-------------------------------------------------------
 TCMOVNB DI,AX
 DB "DI,AX$"
 TCMOVNB DI,BX
 DB "DI,BX$"
 TCMOVNB DI,CX
 DB "DI,CX$"
 TCMOVNB DI,DX
 DB "DI,DX$"
 TCMOVNB DI,SI
 DB "DI,SI$"
 TCMOVNB DI,BP
 DB "DI,BP$"
 TCMOVNB DI,SP
 DB "DI,SP$"
;-------------------------------------------------------
 TCMOVNB BP,AX
 DB "BP,AX$"
 TCMOVNB BP,BX
 DB "BP,BX$"
 TCMOVNB BP,CX
 DB "BP,CX$"
 TCMOVNB BP,DX
 DB "BP,DX$"
 TCMOVNB BP,SI
 DB "BP,SI$"
 TCMOVNB BP,DI
 DB "BP,DI$"
 TCMOVNB BP,SP
 DB "BP,SP$"
;-------------------------------------------------------
 TCMOVNB EAX,EBX
 DB "EAX,EBX$"
 TCMOVNB EAX,ECX
 DB "EAX,ECX$"
 TCMOVNB EAX,EDX
 DB "EAX,EDX$"
 TCMOVNB EAX,ESI
 DB "EAX,ESI$"
 TCMOVNB EAX,EDI
 DB "EAX,EDI$"
 TCMOVNB EAX,EBP
 DB "EAX,EBP$"
 TCMOVNB EAX,ESP
 DB "EAX,ESP$"
;-------------------------------------------------------
 TCMOVNB EBX,EAX
 DB "EBX,EAX$"
 TCMOVNB EBX,ECX
 DB "EBX,ECX$"
 TCMOVNB EBX,EDX
 DB "EBX,EDX$"
 TCMOVNB EBX,ESI
 DB "EBX,ESI$"
 TCMOVNB EBX,EDI
 DB "EBX,EDI$"
 TCMOVNB EBX,EBP
 DB "EBX,EBP$"
 TCMOVNB EBX,ESP
 DB "EBX,ESP$"
;-------------------------------------------------------
 TCMOVNB ECX,EAX
 DB "ECX,EAX$"
 TCMOVNB ECX,EBX
 DB "ECX,EBX$"
 TCMOVNB ECX,EDX
 DB "ECX,EDX$"
 TCMOVNB ECX,ESI
 DB "ECX,ESI$"
 TCMOVNB ECX,EDI
 DB "ECX,EDI$"
 TCMOVNB ECX,EBP
 DB "ECX,EBP$"
 TCMOVNB ECX,ESP
 DB "ECX,ESP$"
;-------------------------------------------------------
 TCMOVNB EDX,EAX
 DB "EDX,EAX$"
 TCMOVNB EDX,EBX
 DB "EDX,EBX$"
 TCMOVNB EDX,ECX
 DB "EDX,ECX$"
 TCMOVNB EDX,ESI
 DB "EDX,ESI$"
 TCMOVNB EDX,EDI
 DB "EDX,EDI$"
 TCMOVNB EDX,EBP
 DB "EDX,EBP$"
 TCMOVNB EDX,ESP
 DB "EDX,ESP$"
;-------------------------------------------------------
 TCMOVNB ESI,EAX
 DB "ESI,EAX$"
 TCMOVNB ESI,EBX
 DB "ESI,EBX$"
 TCMOVNB ESI,ECX
 DB "ESI,ECX$"
 TCMOVNB ESI,EDX
 DB "ESI,EDX$"
 TCMOVNB ESI,EDI
 DB "ESI,EDI$"
 TCMOVNB ESI,EBP
 DB "ESI,EBP$"
 TCMOVNB ESI,ESP
 DB "ESI,ESP$"
;-------------------------------------------------------
 TCMOVNB EDI,EAX
 DB "EDI,EAX$"
 TCMOVNB EDI,EBX
 DB "EDI,EBX$"
 TCMOVNB EDI,ECX
 DB "EDI,ECX$"
 TCMOVNB EDI,EDX
 DB "EDI,EDX$"
 TCMOVNB EDI,ESI
 DB "EDI,ESI$"
 TCMOVNB EDI,EBP
 DB "EDI,EBP$"
 TCMOVNB EDI,ESP
 DB "EDI,ESP$"
;-------------------------------------------------------
 TCMOVNB EBP,EAX
 DB "EBP,EAX$"
 TCMOVNB EBP,EBX
 DB "EBP,EBX$"
 TCMOVNB EBP,ECX
 DB "EBP,ECX$"
 TCMOVNB EBP,EDX
 DB "EBP,EDX$"
 TCMOVNB EBP,ESI
 DB "EBP,ESI$"
 TCMOVNB EBP,EDI
 DB "EBP,EDI$"
 TCMOVNB EBP,ESP
 DB "EBP,ESP$"
 DW 0
;-------------------------------------------------------
test_fcmovb:
 DB "FCMOVB$"
 TFCMOVB ST1
 DB "ST0,ST1$"
 TFCMOVB ST2
 DB "ST0,ST2$"
 TFCMOVB ST3
 DB "ST0,ST3$"
 TFCMOVB ST4
 DB "ST0,ST4$"
 TFCMOVB ST5
 DB "ST0,ST5$"
 TFCMOVB ST6
 DB "ST0,ST6$"
 TFCMOVB ST7
 DB "ST0,ST7$"
 DW 0
;-------------------------------------------------------
test_fcmovnb:
 DB "FCMOVNB$"
 TFCMOVNB ST1
 DB "ST0,ST1$"
 TFCMOVNB ST2
 DB "ST0,ST2$"
 TFCMOVNB ST3
 DB "ST0,ST3$"
 TFCMOVNB ST4
 DB "ST0,ST4$"
 TFCMOVNB ST5
 DB "ST0,ST5$"
 TFCMOVNB ST6
 DB "ST0,ST6$"
 TFCMOVNB ST7
 DB "ST0,ST7$"
 DW 0
;-------------------------------------------------------
test_fcmove:
 DB "FCMOVE$"
 TFCMOVE ST1
 DB "ST0,ST1$"
 TFCMOVE ST2
 DB "ST0,ST2$"
 TFCMOVE ST3
 DB "ST0,ST3$"
 TFCMOVE ST4
 DB "ST0,ST4$"
 TFCMOVE ST5
 DB "ST0,ST5$"
 TFCMOVE ST6
 DB "ST0,ST6$"
 TFCMOVE ST7
 DB "ST0,ST7$"
 DW 0
;-------------------------------------------------------
test_fcmovne:
 DB "FCMOVNE$"
 TFCMOVNE ST1
 DB "ST0,ST1$"
 TFCMOVNE ST2
 DB "ST0,ST2$"
 TFCMOVNE ST3
 DB "ST0,ST3$"
 TFCMOVNE ST4
 DB "ST0,ST4$"
 TFCMOVNE ST5
 DB "ST0,ST5$"
 TFCMOVNE ST6
 DB "ST0,ST6$"
 TFCMOVNE ST7
 DB "ST0,ST7$"
 DW 0
;-------------------------------------------------------
test_fcmovu:
 DB "FCMOVU$"
 TFCMOVU ST1
 DB "ST0,ST1$"
 TFCMOVU ST2
 DB "ST0,ST2$"
 TFCMOVU ST3
 DB "ST0,ST3$"
 TFCMOVU ST4
 DB "ST0,ST4$"
 TFCMOVU ST5
 DB "ST0,ST5$"
 TFCMOVU ST6
 DB "ST0,ST6$"
 TFCMOVU ST7
 DB "ST0,ST7$"
 DW 0
;-------------------------------------------------------
test_fcmovnu:
 DB "FCMOVNU$"
 TFCMOVNU ST1
 DB "ST0,ST1$"
 TFCMOVNU ST2
 DB "ST0,ST2$"
 TFCMOVNU ST3
 DB "ST0,ST3$"
 TFCMOVNU ST4
 DB "ST0,ST4$"
 TFCMOVNU ST5
 DB "ST0,ST5$"
 TFCMOVNU ST6
 DB "ST0,ST6$"
 TFCMOVNU ST7
 DB "ST0,ST7$"
 DW 0
;-------------------------------------------------------
test_fcmovbe:
 DB "FCMOVBE$"
 TFCMOVBE1 ST1
 DB "ST0,ST1$"
 TFCMOVBE1 ST2
 DB "ST0,ST2$"
 TFCMOVBE1 ST3
 DB "ST0,ST3$"
 TFCMOVBE1 ST4
 DB "ST0,ST4$"
 TFCMOVBE1 ST5
 DB "ST0,ST5$"
 TFCMOVBE1 ST6
 DB "ST0,ST6$"
 TFCMOVBE1 ST7
 DB "ST0,ST7$"
 TFCMOVBE2 ST1
 DB "ST0,ST1$"
 TFCMOVBE2 ST2
 DB "ST0,ST2$"
 TFCMOVBE2 ST3
 DB "ST0,ST3$"
 TFCMOVBE2 ST4
 DB "ST0,ST4$"
 TFCMOVBE2 ST5
 DB "ST0,ST5$"
 TFCMOVBE2 ST6
 DB "ST0,ST6$"
 TFCMOVBE2 ST7
 DB "ST0,ST7$"
 TFCMOVBE3 ST1
 DB "ST0,ST1$"
 TFCMOVBE3 ST2
 DB "ST0,ST2$"
 TFCMOVBE3 ST3
 DB "ST0,ST3$"
 TFCMOVBE3 ST4
 DB "ST0,ST4$"
 TFCMOVBE3 ST5
 DB "ST0,ST5$"
 TFCMOVBE3 ST6
 DB "ST0,ST6$"
 TFCMOVBE3 ST7
 DB "ST0,ST7$"
 DW 0
;-------------------------------------------------------
test_fcmovnbe:
 DB "FCMOVNBE$"
 TFCMOVNBE1 ST1
 DB "ST0,ST1$"
 TFCMOVNBE1 ST2
 DB "ST0,ST2$"
 TFCMOVNBE1 ST3
 DB "ST0,ST3$"
 TFCMOVNBE1 ST4
 DB "ST0,ST4$"
 TFCMOVNBE1 ST5
 DB "ST0,ST5$"
 TFCMOVNBE1 ST6
 DB "ST0,ST6$"
 TFCMOVNBE1 ST7
 DB "ST0,ST7$"
 TFCMOVNBE2 ST1
 DB "ST0,ST1$"
 TFCMOVNBE2 ST2
 DB "ST0,ST2$"
 TFCMOVNBE2 ST3
 DB "ST0,ST3$"
 TFCMOVNBE2 ST4
 DB "ST0,ST4$"
 TFCMOVNBE2 ST5
 DB "ST0,ST5$"
 TFCMOVNBE2 ST6
 DB "ST0,ST6$"
 TFCMOVNBE2 ST7
 DB "ST0,ST7$"
 TFCMOVNBE3 ST1
 DB "ST0,ST1$"
 TFCMOVNBE3 ST2
 DB "ST0,ST2$"
 TFCMOVNBE3 ST3
 DB "ST0,ST3$"
 TFCMOVNBE3 ST4
 DB "ST0,ST4$"
 TFCMOVNBE3 ST5
 DB "ST0,ST5$"
 TFCMOVNBE3 ST6
 DB "ST0,ST6$"
 TFCMOVNBE3 ST7
 DB "ST0,ST7$"
 DW 0
;-------------------------------------------------------
test_force_okay:
 DB "force okay:$"
 SUB AX,AX
 INC AX
 RETN
 DB "$"
 DW 0
;-------------------------------------------------------
test_force_fail:
 DB "force fail:$"
 SUB AX,AX
 RETN
 DB "FAIL$"
 DW 0
;-------------------------------------------------------
; BSS
stdstack  DW ?
pointer   DW ?
pointer2  DW ?
jump      DW ?
iloffset  DW ?
ilsegment DW ?
