DATA SEGMENT PARA PUBLIC 'DATA'


DATA ENDS

DATA1 SEGMENT PARA PUBLIC 'DATA'

	S_ARRAY DB 'This is a text'
	LEN DW $-S_ARRAY
	S_PTR DD S_ARRAY
	D_PTR DD D_ARRAY

DATA1 ENDS

DATA2 SEGMENT PARA PUBLIC 'DATA'

	D_ARRAY DB 100 DUP('#')

DATA2 ENDS


_code SEGMENT PAGE PUBLIC 'code'
ASSUME CS:_CODE, DS:DATA1
MAIN PROC near
label3:

	PUSH DS
	XOR AX,AX
	PUSH 0
	;MOV AX,WORD PTR DATA2:D_ARRAY
	;MOV DS,1234
	OUT 0F8H,AX
	
	push word ptr ?
	xlat
	MOV Ax,0102
	sub AL,08
	AAS
	NOP
	lea bx,s_array
	RET

_CODE ENDS

MAIN ENDP
END label3	
END main

