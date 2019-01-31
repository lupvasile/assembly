;REZ = AL * NUM1 + (NUM2*AL+BL)

DATA SEGMENT PARA PUBLIC 'DATA'
	REZ		DW ?
	NUM1	DB 2
	NUM2	DB 3
DATA ENDS

CODE SEGMENT PARA PUBLIC 'CODE'
ASSUME CS:CODE, DS:DATA

	MAIN PROC FAR
		PUSH DS
		XOR AX,AX
		PUSH AX;initialize return to os
		MOV AX,DATA
		MOV DS,AX;initialize data segment
		
		MOV REZ,0;initialize result
		MOV AL,4
		MOV BL,1
		
		MOV BH,AL;save al
		MUL NUM1
		
		ADD REZ,AX
		
		MOV AL,BH
		MUL NUM2
		ADD REZ,AX
		
		MOV BH,0
		ADD REZ,BX
		
		
		
	MAIN ENDP
CODE ENDS

END MAIN