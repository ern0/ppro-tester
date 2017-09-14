;test macros for Pentium Pro instructions
;-------------------------------------------------------
MACRO TCMOVB reg1,reg2
{
 MOV    reg1,reg2
 INC    reg1
 STC
 CMOVB  reg1,reg2
 CMP    reg1,reg2
 MOV    reg1,reg2
 JNE    @F
 INC    reg1
 CLC
 CMOVB  reg1,reg2
@@:
 CMP    reg1,reg2
 RETN
}
;-------------------------------------------------------
MACRO TCMOVNB reg1,reg2
{
 MOV    reg1,reg2
 INC    reg1
 CLC
 CMOVNB reg1,reg2
 CMP    reg1,reg2
 MOV    reg1,reg2
 JNE    @F
 INC    reg1
 STC
 CMOVNB reg1,reg2
@@:
 CMP    reg1,reg2
 RETN
}
;-------------------------------------------------------
MACRO TCMOVZ reg1,reg2
{
 MOV    reg1,reg2
 INC    reg1
 SUB    AX,AX
 CMOVZ  reg1,reg2
 CMP    reg1,reg2
 MOV    reg1,reg2
 JNE    @F
 INC    reg1
 SUB    AX,AX
 INC    AX
 CMOVZ  reg1,reg2
@@:
 CMP    reg1,reg2
 RETN
}
;-------------------------------------------------------
MACRO TCMOVNZ reg1,reg2
{
 MOV    reg1,reg2
 INC    reg1
 SUB    AX,AX
 INC    AX
 CMOVNZ reg1,reg2
 CMP    reg1,reg2
 MOV    reg1,reg2
 JNE    @F
 INC    reg1
 SUB    AX,AX
 CMOVNZ reg1,reg2
@@:
 CMP    reg1,reg2
 RETN
}
;-------------------------------------------------------
MACRO TFCMOVB reg2
{
 FSTP   ST0
 FLD1
 FADD   ST0,reg2
 STC
 FCMOVB ST0,reg2
 FUCOM  reg2
 FNSTSW AX
 SAHF
 FXCH   reg2
 FST    reg2
 JNE    @F
 FSTP   ST0
 FLD1
 FADD   ST0,reg2
 CLC
 FCMOVB ST0,reg2
@@:
 FUCOM  reg2
 FNSTSW AX
 SAHF
 RETN
}
;-------------------------------------------------------
MACRO TFCMOVNB reg2
{
 FSTP   ST0
 FLD1
 FADD   ST0,reg2
 CLC
 FCMOVNB ST0,reg2
 FUCOM  reg2
 FNSTSW AX
 SAHF
 FXCH   reg2
 FST    reg2
 JNE    @F
 FSTP   ST0
 FLD1
 FADD   ST0,reg2
 STC
 FCMOVNB ST0,reg2
@@:
 FUCOM  reg2
 FNSTSW AX
 SAHF
 RETN
}
;-------------------------------------------------------
MACRO TFCMOVE reg2
{
 FSTP   ST0
 FLD1
 FADD   ST0,reg2
 SUB    AX,AX
 FCMOVE ST0,reg2
 FUCOM  reg2
 FNSTSW AX
 SAHF
 FXCH   reg2
 FST    reg2
 JNE    @F
 FSTP   ST0
 FLD1
 FADD   ST0,reg2
 SUB    AX,AX
 INC    AX
 FCMOVE ST0,reg2
@@:
 FUCOM  reg2
 FNSTSW AX
 SAHF
 RETN
}
;-------------------------------------------------------
MACRO TFCMOVNE reg2
{
 FSTP   ST0
 FLD1
 FADD   ST0,reg2
 SUB    AX,AX
 INC    AX
 FCMOVNE ST0,reg2
 FUCOM  reg2
 FNSTSW AX
 SAHF
 FXCH   reg2
 FST    reg2
 JNE    @F
 FSTP   ST0
 FLD1
 FADD   ST0,reg2
 SUB    AX,AX
 FCMOVNE ST0,reg2
@@:
 FUCOM  reg2
 FNSTSW AX
 SAHF
 RETN
}
;-------------------------------------------------------
MACRO TFCMOVU reg2
{
 FSTP   ST0
 FLD1
 FADD   ST0,reg2
 SUB    AX,AX
 FCMOVU ST0,reg2
 FUCOM  reg2
 FNSTSW AX
 SAHF
 FXCH   reg2
 FST    reg2
 JNE    @F
 FSTP   ST0
 FLD1
 FADD   ST0,reg2
 SUB    AX,AX
 INC    AX
 FCMOVU ST0,reg2
@@:
 FUCOM  reg2
 FNSTSW AX
 SAHF
 RETN
}
;-------------------------------------------------------
MACRO TFCMOVNU reg2
{
 FSTP   ST0
 FLD1
 FADD   ST0,reg2
 SUB    AX,AX
 INC    AX
 FCMOVNU ST0,reg2
 FUCOM  reg2
 FNSTSW AX
 SAHF
 FXCH   reg2
 FST    reg2
 JNE    @F
 FSTP   ST0
 FLD1
 FADD   ST0,reg2
 SUB    AX,AX
 FCMOVNU ST0,reg2
@@:
 FUCOM  reg2
 FNSTSW AX
 SAHF
 RETN
}
;-------------------------------------------------------
MACRO TFCMOVBE1 reg2
{
 FSTP   ST0
 FLD1
 FADD   ST0,reg2
 SUB    AX,AX
 STC
 FCMOVBE ST0,reg2
 FUCOM  reg2
 FNSTSW AX
 SAHF
 FXCH   reg2
 FST    reg2
 JNE    @F
 FSTP   ST0
 FLD1
 FADD   ST0,reg2
 SUB    AX,AX
 INC    AX
 CLC
 FCMOVBE ST0,reg2
@@:
 FUCOM  reg2
 FNSTSW AX
 SAHF
 RETN
}
;-------------------------------------------------------
MACRO TFCMOVBE2 reg2
{
 FSTP   ST0
 FLD1
 FADD   ST0,reg2
 SUB    AX,AX
 CLC
 FCMOVBE ST0,reg2
 FUCOM  reg2
 FNSTSW AX
 SAHF
 FXCH   reg2
 FST    reg2
 JNE    @F
 FSTP   ST0
 FLD1
 FADD   ST0,reg2
 SUB    AX,AX
 INC    AX
 CLC
 FCMOVBE ST0,reg2
@@:
 FUCOM  reg2
 FNSTSW AX
 SAHF
 RETN
}
;-------------------------------------------------------
MACRO TFCMOVBE3 reg2
{
 FSTP   ST0
 FLD1
 FADD   ST0,reg2
 SUB    AX,AX
 INC    AX
 STC
 FCMOVBE ST0,reg2
 FUCOM  reg2
 FNSTSW AX
 SAHF
 FXCH   reg2
 FST    reg2
 JNE    @F
 FSTP   ST0
 FLD1
 FADD   ST0,reg2
 SUB    AX,AX
 INC    AX
 CLC
 FCMOVBE ST0,reg2
@@:
 FUCOM  reg2
 FNSTSW AX
 SAHF
 RETN
}
;-------------------------------------------------------
MACRO TFCMOVNBE1 reg2
{
 FSTP   ST0
 FLD1
 FADD   ST0,reg2
 SUB    AX,AX
 INC    AX
 CLC
 FCMOVNBE ST0,reg2
 FUCOM  reg2
 FNSTSW AX
 SAHF
 FXCH   reg2
 FST    reg2
 JNE    @F
 FSTP   ST0
 FLD1
 FADD   ST0,reg2
 SUB    AX,AX
 STC
 FCMOVNBE ST0,reg2
@@:
 FUCOM  reg2
 FNSTSW AX
 SAHF
 RETN
}
;-------------------------------------------------------
MACRO TFCMOVNBE2 reg2
{
 FSTP   ST0
 FLD1
 FADD   ST0,reg2
 SUB    AX,AX
 INC    AX
 CLC
 FCMOVNBE ST0,reg2
 FUCOM  reg2
 FNSTSW AX
 SAHF
 FXCH   reg2
 FST    reg2
 JNE    @F
 FSTP   ST0
 FLD1
 FADD   ST0,reg2
 SUB    AX,AX
 CLC
 FCMOVNBE ST0,reg2
@@:
 FUCOM  reg2
 FNSTSW AX
 SAHF
 RETN
}
;-------------------------------------------------------
MACRO TFCMOVNBE3 reg2
{
 FSTP   ST0
 FLD1
 FADD   ST0,reg2
 SUB    AX,AX
 INC    AX
 CLC
 FCMOVNBE ST0,reg2
 FUCOM  reg2
 FNSTSW AX
 SAHF
 FXCH   reg2
 FST    reg2
 JNE    @F
 FSTP   ST0
 FLD1
 FADD   ST0,reg2
 SUB    AX,AX
 INC    AX
 STC
 FCMOVNBE ST0,reg2
@@:
 FUCOM  reg2
 FNSTSW AX
 SAHF
 RETN
}
;-------------------------------------------------------
