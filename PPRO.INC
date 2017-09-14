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
 TEST   AL,0
 CMOVZ  reg1,reg2
 CMP    reg1,reg2
 MOV    reg1,reg2
 JNE    @F
 INC    reg1
 TEST   SP,SP
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
 TEST   SP,SP
 CMOVNZ reg1,reg2
 CMP    reg1,reg2
 MOV    reg1,reg2
 JNE    @F
 INC    reg1
 TEST   AL,0
 CMOVNZ reg1,reg2
@@:
 CMP    reg1,reg2
 RETN
}
;-------------------------------------------------------
MACRO TFCOMIA reg2
{
 FLDL2T
 STC
 FCOMI  ST0,reg2
 FSTP   ST0
 SETA   AL
 TEST   AL,AL
 RETN
}
;-------------------------------------------------------
MACRO TFCOMIB reg2
{
 FLDZ
 CLC
 FCOMI  ST0,reg2
 FSTP   ST0
 SETB   AL
 TEST   AL,AL
 RETN
}
;-------------------------------------------------------
MACRO TFCOMIE reg2
{
 FLDZ
 FADD   ST0,reg2
 TEST   SP,SP
 FCOMI  ST0,reg2
 FSTP   ST0
 SETE   AL
 TEST   AL,AL
 RETN
}
;-------------------------------------------------------
MACRO TFCOMIPA reg2
{
 FLDL2T
 STC
 FCOMIP ST0,reg2
 SETA   AL
 TEST   AL,AL
 RETN
}
;-------------------------------------------------------
MACRO TFCOMIPB reg2
{
 FLDZ
 CLC
 FCOMIP ST0,reg2
 SETB   AL
 TEST   AL,AL
 RETN
}
;-------------------------------------------------------
MACRO TFCOMIPE reg2
{
 FLDZ
 FADD   ST0,reg2
 TEST   SP,SP
 FCOMIP ST0,reg2
 SETE   AL
 TEST   AL,AL
 RETN
}
;-------------------------------------------------------
MACRO TFUCOMIA reg2
{
 FLDL2T
 STC
 FUCOMI ST0,reg2
 FSTP   ST0
 SETA   AL
 TEST   AL,AL
 RETN
}
;-------------------------------------------------------
MACRO TFUCOMIB reg2
{
 FLDZ
 CLC
 FUCOMI ST0,reg2
 FSTP   ST0
 SETB   AL
 TEST   AL,AL
 RETN
}
;-------------------------------------------------------
MACRO TFUCOMIE reg2
{
 FLDZ
 FADD   ST0,reg2
 TEST   SP,SP
 FUCOMI ST0,reg2
 FSTP   ST0
 SETE   AL
 TEST   AL,AL
 RETN
}
;-------------------------------------------------------
MACRO TFUCOMIPA reg2
{
 FLDL2T
 STC
 FUCOMIP ST0,reg2
 SETA   AL
 TEST   AL,AL
 RETN
}
;-------------------------------------------------------
MACRO TFUCOMIPB reg2
{
 FLDZ
 CLC
 FUCOMIP ST0,reg2
 SETB   AL
 TEST   AL,AL
 RETN
}
;-------------------------------------------------------
MACRO TFUCOMIPE reg2
{
 FLDZ
 FADD   ST0,reg2
 TEST   SP,SP
 FUCOMIP ST0,reg2
 SETE   AL
 TEST   AL,AL
 RETN
}
;-------------------------------------------------------
MACRO TFCMOVB reg2
{
 FLD1
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
 CLC
 FCMOVB ST0,reg2
@@:
 FUCOMP reg2
 FNSTSW AX
 SAHF
 RETN
}
;-------------------------------------------------------
MACRO TFCMOVNB reg2
{
 FLD1
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
 STC
 FCMOVNB ST0,reg2
@@:
 FUCOMP reg2
 FNSTSW AX
 SAHF
 RETN
}
;-------------------------------------------------------
MACRO TFCMOVE reg2
{
 FLD1
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
 TEST   SP,SP
 FCMOVE ST0,reg2
@@:
 FUCOMP reg2
 FNSTSW AX
 SAHF
 RETN
}
;-------------------------------------------------------
MACRO TFCMOVNE reg2
{
 FLD1
 TEST   SP,SP
 FCMOVNE ST0,reg2
 FUCOM  reg2
 FNSTSW AX
 SAHF
 FXCH   reg2
 FST    reg2
 JNE    @F
 FSTP   ST0
 FLD1
 SUB    AX,AX
 FCMOVNE ST0,reg2
@@:
 FUCOMP reg2
 FNSTSW AX
 SAHF
 RETN
}
;-------------------------------------------------------
MACRO TFCMOVU reg2
{
 FLD1
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
 SUB    AX,AX
 INC    AX
 FCMOVU ST0,reg2
@@:
 FUCOMP reg2
 FNSTSW AX
 SAHF
 RETN
}
;-------------------------------------------------------
MACRO TFCMOVNU reg2
{
 FLD1
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
 SUB    AX,AX
 FCMOVNU ST0,reg2
@@:
 FUCOMP reg2
 FNSTSW AX
 SAHF
 RETN
}
;-------------------------------------------------------
MACRO TFCMOVBE1 reg2
{
 FLD1
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
 TEST   SP,SP
 CLC
 FCMOVBE ST0,reg2
@@:
 FUCOMP reg2
 FNSTSW AX
 SAHF
 RETN
}
;-------------------------------------------------------
MACRO TFCMOVBE2 reg2
{
 FLD1
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
 TEST   SP,SP
 CLC
 FCMOVBE ST0,reg2
@@:
 FUCOMP reg2
 FNSTSW AX
 SAHF
 RETN
}
;-------------------------------------------------------
MACRO TFCMOVBE3 reg2
{
 FLD1
 TEST   SP,SP
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
 TEST   SP,SP
 CLC
 FCMOVBE ST0,reg2
@@:
 FUCOMP reg2
 FNSTSW AX
 SAHF
 RETN
}
;-------------------------------------------------------
MACRO TFCMOVNBE1 reg2
{
 FLD1
 TEST   SP,SP
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
 SUB    AX,AX
 STC
 FCMOVNBE ST0,reg2
@@:
 FUCOMP reg2
 FNSTSW AX
 SAHF
 RETN
}
;-------------------------------------------------------
MACRO TFCMOVNBE2 reg2
{
 FLD1
 TEST   SP,SP
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
 SUB    AX,AX
 CLC
 FCMOVNBE ST0,reg2
@@:
 FUCOMP reg2
 FNSTSW AX
 SAHF
 RETN
}
;-------------------------------------------------------
MACRO TFCMOVNBE3 reg2
{
 FLD1
 TEST   SP,SP
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
 TEST   SP,SP
 STC
 FCMOVNBE ST0,reg2
@@:
 FUCOMP reg2
 FNSTSW AX
 SAHF
 RETN
}
;-------------------------------------------------------
