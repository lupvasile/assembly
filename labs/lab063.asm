CODE SEGMENT PARA PUBLIC 'CODE'
ASSUME CS:CODE

	MAIN PROC FAR
	PUSH DS
	XOR AX,AX
	PUSH AX
		
	PUSH 3
	PUSH 8
	
	MOV BP,SP
	SUB SP,4
	
	MOV AX,[BP]
	MOV [BP-4],AX
	
	MOV AX,[BP+2]
	MOV [BP-2],AX
	
	ADD SP,8
	RET
	MAIN ENDP
CODE ENDS
END MAIN