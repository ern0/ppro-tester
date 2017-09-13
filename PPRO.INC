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
 CMOVNB  reg1,reg2
 CMP    reg1,reg2
 MOV    reg1,reg2
 JNE    @F
 INC    reg1
 STC
 CMOVNB  reg1,reg2
@@:
 CMP    reg1,reg2
 RETN
}
;-------------------------------------------------------
