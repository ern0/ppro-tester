;FASM source

include 'ppro.inc'

;-------------------------------------------------------
MACRO Print string
{
 CALL @F
 DB string,'$'
@@:
 POP	DX
 MOV	AH,9
 INT	21H
}
;-------------------------------------------------------
MACRO PrintLN string
{
 CALL @F
 DB string,10,13,'$'
@@:
 POP	DX
 MOV	AH,9
 INT	21H
}
;-------------------------------------------------------
ORG 256

 PrintLN 'PentiumPro instruction set tester'

 XOR	AX,AX	      ; set up illegal handler
 MOV	DS,AX
 MOV	SI,[6 * 4 + 0]
 MOV	DI,[6 * 4 + 2]
 MOV	AX,CS
 MOV	WORD [6 * 4 + 0],illegal
 MOV	WORD [6 * 4 + 2],AX
 MOV	DS,AX
 MOV	ES,AX
 MOV	[iloffset],SI
 MOV	[ilsegment],DI

 MOV	[stdstack],SP
 MOV	[pointer],tab

next:
 MOV	BX,[pointer]  ; pick next table item
 ADD	[pointer],2
 TEST	WORD [BX],-1
 JZ	quit

 MOV	AH,9	      ; print title
 LEA	DX,[txt_pre]
 INT	21H
 MOV	DX,[BX]
 INT	21H
 MOV	AH,9
 LEA	DX,[txt_wait]
 INT	21H

 MOV	DI,[BX]       ; skip title
 MOV	AL,'$'
 REPNZ SCASB

 MOV	[jump],DI     ; perform test
 JMP	[jump]

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
 MOV	SI,[iloffset] ; restore illegal handler
 MOV	DI,[ilsegment]
 XOR	AX,AX
 MOV	DS,AX
 MOV	WORD [6 * 4 + 0],SI
 MOV	WORD [6 * 4 + 2],DI

 MOV	AX,4C00H      ; exit
 INT	21H
;-------------------------------------------------------
; Data

tab:
 DW	test_force_okay
 DW	test_force_fail
 DW	test_cmovb_ax_bx
 DW	test_cmovb_ax_cx
 DW	test_cmovb_ax_dx
 DW	test_cmovb_ax_si
 DW	test_cmovb_ax_di
 DW	test_cmovb_ax_bp
 DW	test_cmovb_ax_sp
 DW	test_cmovb_bx_ax
 DW	test_cmovb_bx_cx
 DW	test_cmovb_bx_dx
 DW	test_cmovb_bx_si
 DW	test_cmovb_bx_di
 DW	test_cmovb_bx_bp
 DW	test_cmovb_bx_sp
 DW	test_cmovb_cx_ax
 DW	test_cmovb_cx_bx
 DW	test_cmovb_cx_dx
 DW	test_cmovb_cx_si
 DW	test_cmovb_cx_di
 DW	test_cmovb_cx_bp
 DW	test_cmovb_cx_sp
 DW	test_cmovb_dx_ax
 DW	test_cmovb_dx_bx
 DW	test_cmovb_dx_cx
 DW	test_cmovb_dx_si
 DW	test_cmovb_dx_di
 DW	test_cmovb_dx_bp
 DW	test_cmovb_dx_sp
 DW	test_cmovb_si_ax
 DW	test_cmovb_si_bx
 DW	test_cmovb_si_cx
 DW	test_cmovb_si_dx
 DW	test_cmovb_si_di
 DW	test_cmovb_si_bp
 DW	test_cmovb_si_sp
 DW	test_cmovb_di_ax
 DW	test_cmovb_di_bx
 DW	test_cmovb_di_cx
 DW	test_cmovb_di_dx
 DW	test_cmovb_di_si
 DW	test_cmovb_di_bp
 DW	test_cmovb_di_sp
 DW	test_cmovb_bp_ax
 DW	test_cmovb_bp_bx
 DW	test_cmovb_bp_cx
 DW	test_cmovb_bp_dx
 DW	test_cmovb_bp_si
 DW	test_cmovb_bp_di
 DW	test_cmovb_bp_sp

 DW	test_cmovb_eax_ebx
 DW	test_cmovb_eax_ecx
 DW	test_cmovb_eax_edx
 DW	test_cmovb_eax_esi
 DW	test_cmovb_eax_edi
 DW	test_cmovb_eax_ebp
 DW	test_cmovb_eax_esp
 DW	test_cmovb_ebx_eax
 DW	test_cmovb_ebx_ecx
 DW	test_cmovb_ebx_edx
 DW	test_cmovb_ebx_esi
 DW	test_cmovb_ebx_edi
 DW	test_cmovb_ebx_ebp
 DW	test_cmovb_ebx_esp
 DW	test_cmovb_ecx_eax
 DW	test_cmovb_ecx_ebx
 DW	test_cmovb_ecx_edx
 DW	test_cmovb_ecx_esi
 DW	test_cmovb_ecx_edi
 DW	test_cmovb_ecx_ebp
 DW	test_cmovb_ecx_esp
 DW	test_cmovb_edx_eax
 DW	test_cmovb_edx_ebx
 DW	test_cmovb_edx_ecx
 DW	test_cmovb_edx_esi
 DW	test_cmovb_edx_edi
 DW	test_cmovb_edx_ebp
 DW	test_cmovb_edx_esp
 DW	test_cmovb_esi_eax
 DW	test_cmovb_esi_ebx
 DW	test_cmovb_esi_ecx
 DW	test_cmovb_esi_edx
 DW	test_cmovb_esi_edi
 DW	test_cmovb_esi_ebp
 DW	test_cmovb_esi_esp
 DW	test_cmovb_edi_eax
 DW	test_cmovb_edi_ebx
 DW	test_cmovb_edi_ecx
 DW	test_cmovb_edi_edx
 DW	test_cmovb_edi_esi
 DW	test_cmovb_edi_ebp
 DW	test_cmovb_edi_esp
 DW	test_cmovb_ebp_eax
 DW	test_cmovb_ebp_ebx
 DW	test_cmovb_ebp_ecx
 DW	test_cmovb_ebp_edx
 DW	test_cmovb_ebp_esi
 DW	test_cmovb_ebp_edi
 DW	test_cmovb_ebp_esp
 DW	0

txt_pre: db " testing $"
txt_wait: db " - $"
txt_okay: db "okay",13,10,'$'
txt_fail: db "FAIL",13,10,'$'

;-------------------------------------------------------
test_cmovb_ax_bx DB "CMOVB AX,BX$"
 TCMOVB AX,BX
test_cmovb_ax_cx DB "CMOVB AX,CX$"
 TCMOVB AX,CX
test_cmovb_ax_dx DB "CMOVB AX,DX$"
 TCMOVB AX,DX
test_cmovb_ax_si DB "CMOVB AX,SI$"
 TCMOVB AX,SI
test_cmovb_ax_di DB "CMOVB AX,DI$"
 TCMOVB AX,DI
test_cmovb_ax_bp DB "CMOVB AX,BP$"
 TCMOVB AX,BP
test_cmovb_ax_sp DB "CMOVB AX,SP$"
 TCMOVB AX,SP
;-------------------------------------------------------
test_cmovb_bx_ax DB "CMOVB BX,AX$"
 TCMOVB BX,AX
test_cmovb_bx_cx DB "CMOVB BX,CX$"
 TCMOVB BX,CX
test_cmovb_bx_dx DB "CMOVB BX,DX$"
 TCMOVB BX,DX
test_cmovb_bx_si DB "CMOVB BX,SI$"
 TCMOVB BX,SI
test_cmovb_bx_di DB "CMOVB BX,DI$"
 TCMOVB BX,DI
test_cmovb_bx_bp DB "CMOVB BX,BP$"
 TCMOVB BX,BP
test_cmovb_bx_sp DB "CMOVB BX,SP$"
 TCMOVB BX,SP
;-------------------------------------------------------
test_cmovb_cx_ax DB "CMOVB CX,AX$"
 TCMOVB CX,AX
test_cmovb_cx_bx DB "CMOVB CX,BX$"
 TCMOVB CX,BX
test_cmovb_cx_dx DB "CMOVB CX,DX$"
 TCMOVB CX,DX
test_cmovb_cx_si DB "CMOVB CX,SI$"
 TCMOVB CX,SI
test_cmovb_cx_di DB "CMOVB CX,DI$"
 TCMOVB CX,DI
test_cmovb_cx_bp DB "CMOVB CX,BP$"
 TCMOVB CX,BP
test_cmovb_cx_sp DB "CMOVB CX,SP$"
 TCMOVB CX,SP
;-------------------------------------------------------
test_cmovb_dx_ax DB "CMOVB DX,AX$"
 TCMOVB DX,AX
test_cmovb_dx_bx DB "CMOVB DX,BX$"
 TCMOVB DX,BX
test_cmovb_dx_cx DB "CMOVB DX,CX$"
 TCMOVB DX,CX
test_cmovb_dx_si DB "CMOVB DX,SI$"
 TCMOVB DX,SI
test_cmovb_dx_di DB "CMOVB DX,DI$"
 TCMOVB DX,DI
test_cmovb_dx_bp DB "CMOVB DX,BP$"
 TCMOVB DX,BP
test_cmovb_dx_sp DB "CMOVB DX,SP$"
 TCMOVB DX,SP
;-------------------------------------------------------
test_cmovb_si_ax DB "CMOVB SI,AX$"
 TCMOVB SI,AX
test_cmovb_si_bx DB "CMOVB SI,BX$"
 TCMOVB SI,BX
test_cmovb_si_cx DB "CMOVB SI,CX$"
 TCMOVB SI,CX
test_cmovb_si_dx DB "CMOVB SI,DX$"
 TCMOVB SI,DX
test_cmovb_si_di DB "CMOVB SI,DI$"
 TCMOVB SI,DI
test_cmovb_si_bp DB "CMOVB SI,BP$"
 TCMOVB SI,BP
test_cmovb_si_sp DB "CMOVB SI,SP$"
 TCMOVB SI,SP
;-------------------------------------------------------
test_cmovb_di_ax DB "CMOVB DI,AX$"
 TCMOVB DI,AX
test_cmovb_di_bx DB "CMOVB DI,BX$"
 TCMOVB DI,BX
test_cmovb_di_cx DB "CMOVB DI,CX$"
 TCMOVB DI,CX
test_cmovb_di_dx DB "CMOVB DI,DX$"
 TCMOVB DI,DX
test_cmovb_di_si DB "CMOVB DI,SI$"
 TCMOVB DI,SI
test_cmovb_di_bp DB "CMOVB DI,BP$"
 TCMOVB DI,BP
test_cmovb_di_sp DB "CMOVB DI,SP$"
 TCMOVB DI,SP
;-------------------------------------------------------
test_cmovb_bp_ax DB "CMOVB BP,AX$"
 TCMOVB BP,AX
test_cmovb_bp_bx DB "CMOVB BP,BX$"
 TCMOVB BP,BX
test_cmovb_bp_cx DB "CMOVB BP,CX$"
 TCMOVB BP,CX
test_cmovb_bp_dx DB "CMOVB BP,DX$"
 TCMOVB BP,DX
test_cmovb_bp_si DB "CMOVB BP,SI$"
 TCMOVB BP,SI
test_cmovb_bp_di DB "CMOVB BP,DI$"
 TCMOVB BP,DI
test_cmovb_bp_sp DB "CMOVB BP,SP$"
 TCMOVB BP,SP

;-------------------------------------------------------
test_cmovb_eax_ebx DB "CMOVB EAX,EBX$"
 TCMOVB EAX,EBX
test_cmovb_eax_ecx DB "CMOVB EAX,ECX$"
 TCMOVB EAX,ECX
test_cmovb_eax_edx DB "CMOVB EAX,EDX$"
 TCMOVB EAX,EDX
test_cmovb_eax_esi DB "CMOVB EAX,ESI$"
 TCMOVB EAX,ESI
test_cmovb_eax_edi DB "CMOVB EAX,EDI$"
 TCMOVB EAX,EDI
test_cmovb_eax_ebp DB "CMOVB EAX,EBP$"
 TCMOVB EAX,EBP
test_cmovb_eax_esp DB "CMOVB EAX,ESP$"
 TCMOVB EAX,ESP
;-------------------------------------------------------
test_cmovb_ebx_eax DB "CMOVB EBX,EAX$"
 TCMOVB EBX,EAX
test_cmovb_ebx_ecx DB "CMOVB EBX,ECX$"
 TCMOVB EBX,ECX
test_cmovb_ebx_edx DB "CMOVB EBX,EDX$"
 TCMOVB EBX,EDX
test_cmovb_ebx_esi DB "CMOVB EBX,ESI$"
 TCMOVB EBX,ESI
test_cmovb_ebx_edi DB "CMOVB EBX,EDI$"
 TCMOVB EBX,EDI
test_cmovb_ebx_ebp DB "CMOVB EBX,EBP$"
 TCMOVB EBX,EBP
test_cmovb_ebx_esp DB "CMOVB EBX,ESP$"
 TCMOVB EBX,ESP
;-------------------------------------------------------
test_cmovb_ecx_eax DB "CMOVB ECX,EAX$"
 TCMOVB ECX,EAX
test_cmovb_ecx_ebx DB "CMOVB ECX,EBX$"
 TCMOVB ECX,EBX
test_cmovb_ecx_edx DB "CMOVB ECX,EDX$"
 TCMOVB ECX,EDX
test_cmovb_ecx_esi DB "CMOVB ECX,ESI$"
 TCMOVB ECX,ESI
test_cmovb_ecx_edi DB "CMOVB ECX,EDI$"
 TCMOVB ECX,EDI
test_cmovb_ecx_ebp DB "CMOVB ECX,EBP$"
 TCMOVB ECX,EBP
test_cmovb_ecx_esp DB "CMOVB ECX,ESP$"
 TCMOVB ECX,ESP
;-------------------------------------------------------
test_cmovb_edx_eax DB "CMOVB EDX,EAX$"
 TCMOVB EDX,EAX
test_cmovb_edx_ebx DB "CMOVB EDX,BX$"
 TCMOVB EDX,EBX
test_cmovb_edx_ecx DB "CMOVB EDX,ECX$"
 TCMOVB EDX,ECX
test_cmovb_edx_esi DB "CMOVB EDX,ESI$"
 TCMOVB EDX,ESI
test_cmovb_edx_edi DB "CMOVB EDX,EDI$"
 TCMOVB EDX,EDI
test_cmovb_edx_ebp DB "CMOVB EDX,EBP$"
 TCMOVB EDX,EBP
test_cmovb_edx_esp DB "CMOVB EDX,ESP$"
 TCMOVB EDX,ESP
;-------------------------------------------------------
test_cmovb_esi_eax DB "CMOVB ESI,EAX$"
 TCMOVB ESI,EAX
test_cmovb_esi_ebx DB "CMOVB ESI,EBX$"
 TCMOVB ESI,EBX
test_cmovb_esi_ecx DB "CMOVB ESI,ECX$"
 TCMOVB ESI,ECX
test_cmovb_esi_edx DB "CMOVB ESI,EDX$"
 TCMOVB ESI,EDX
test_cmovb_esi_edi DB "CMOVB ESI,EDI$"
 TCMOVB ESI,EDI
test_cmovb_esi_ebp DB "CMOVB ESI,EBP$"
 TCMOVB ESI,EBP
test_cmovb_esi_esp DB "CMOVB ESI,ESP$"
 TCMOVB ESI,ESP
;-------------------------------------------------------
test_cmovb_edi_eax DB "CMOVB EDI,EAX$"
 TCMOVB EDI,EAX
test_cmovb_edi_ebx DB "CMOVB EDI,EBX$"
 TCMOVB EDI,EBX
test_cmovb_edi_ecx DB "CMOVB EDI,ECX$"
 TCMOVB EDI,ECX
test_cmovb_edi_edx DB "CMOVB EDI,EDX$"
 TCMOVB EDI,EDX
test_cmovb_edi_esi DB "CMOVB EDI,ESI$"
 TCMOVB EDI,ESI
test_cmovb_edi_ebp DB "CMOVB EDI,EBP$"
 TCMOVB EDI,EBP
test_cmovb_edi_esp DB "CMOVB EDI,ESP$"
 TCMOVB EDI,ESP
;-------------------------------------------------------
test_cmovb_ebp_eax DB "CMOVB EBP,EAX$"
 TCMOVB EBP,EAX
test_cmovb_ebp_ebx DB "CMOVB EBP,EBX$"
 TCMOVB EBP,EBX
test_cmovb_ebp_ecx DB "CMOVB EBP,ECX$"
 TCMOVB EBP,ECX
test_cmovb_ebp_edx DB "CMOVB EBP,EDX$"
 TCMOVB EBP,EDX
test_cmovb_ebp_esi DB "CMOVB EBP,ESI$"
 TCMOVB EBP,ESI
test_cmovb_ebp_edi DB "CMOVB EBP,EDI$"
 TCMOVB EBP,EDI
test_cmovb_ebp_esp DB "CMOVB EBP,ESP$"
 TCMOVB EBP,ESP
;-------------------------------------------------------
test_force_okay DB "force okay$"
 JMP okay
test_force_fail DB "force fail$"
 JMP fail
;-------------------------------------------------------
; BSS

stdstack  DW 0
pointer   DW 0
jump	  DW 0
iloffset  DW 0
ilsegment DW 0
