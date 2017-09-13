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

 XOR    AX,AX         ; set up illegal handler
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
 MOV    BX,[pointer]  ; pick next table item
 ADD    [pointer],2
 TEST   WORD [BX],-1
 JZ     quit

 MOV    AH,9          ; print title
 LEA    DX,[txt_pre]
 INT    21H
 MOV    DX,[BX]
 INT    21H
 MOV    AH,9
 LEA    DX,[txt_wait]
 INT    21H

 MOV    DI,[BX]       ; skip title
 MOV    AL,'$'
 REPNZ SCASB

 MOV    [jump],DI     ; perform test
 JMP    [jump]

okay:
 MOV   AH,9
 LEA   DX,[txt_okay]
 INT   21H
 JMP   next

illegal:
 MOV   SP,[stdstack]  ; reset stack, then fail

fail:
 MOV   AH,9
 LEA   DX,[txt_fail]
 INT   21H
 JMP   next

quit:
 MOV    SI,[iloffset] ; restore illegal handler
 MOV    DI,[ilsegment]
 XOR    AX,AX
 MOV    DS,AX
 MOV    WORD [6 * 4 + 0],SI
 MOV    WORD [6 * 4 + 2],DI

 MOV    AX,4C00H      ; exit
 INT    21H
;-------------------------------------------------------
; Data

tab:
 DW     test_force_okay
 DW     test_force_fail
 DW     test_cmovb_ax_bx
 DW     test_cmovb_ax_bx
 DW     0

txt_pre: db " testing $"
txt_wait: db " - $"
txt_okay: db "okay",13,10,'$'
txt_fail: db "FAIL",13,10,'$'

;-------------------------------------------------------
test_cmovb_ax_bx DB "CMOVB AX,BX$"

 STC
 TCMOVB AX,BX
 JNE    fail
 CLC
 TCMOVB AX,BX
 JE     fail
 JMP    okay
;-------------------------------------------------------
test_force_okay DB "force okay$"

 JMP okay
;-------------------------------------------------------
test_force_fail DB "force fail$"

 JMP fail
;-------------------------------------------------------
; BSS

stdstack  DW 0
pointer   DW 0
jump      DW 0
iloffset  DW 0
ilsegment DW 0
