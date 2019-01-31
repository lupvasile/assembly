;AX = 7*AL - 2*BX - BX/8

CODE SEGMENT PARA PUBLIC 'CODE'
ASSUME CS:CODE

	MAIN PROC FAR
		PUSH DS
		XOR AX,AX
		PUSH AX;initialize return to os
		
		MOV AX,5
		MOV BX,16
		
		MOV DX,AX;save ax
		MOV CL,3
		SHL AX,CL
		SUB AX,DX;AX = 7*AX
		
		SHL BX,1
		SUB AX,BX
		
		MOV CL,4
		SAR BX,CL
		SUB AX,BX
		
		RET
		
	MAIN ENDP
CODE ENDS

END MAIN