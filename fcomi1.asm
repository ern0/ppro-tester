; FASM source

org 100H

	lea 	dx,[hello]
	mov 	ah,9
	int 	21H

	lea 	dx,[okay]
	fldz
	fldz
	fcomi st1
	je 		print
	lea 	dx,[fail]

print:
	mov 	ah,9
	int 	21H

	mov 	ax,4c00H
	int 	21H


hello 	db "FCOMI tester - $"
okay 		db "okay",13,10,'$'
fail		db "fail",13,10,'$'