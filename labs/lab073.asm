DATA SEGMENT PARA PUBLIC 'DATA'
	SIR DB 1,2,3,4,5,6,7,8,9,10
	SIR_LEN DB $-SIR
	DEF_MESSAGE DB "The average is: $"
DATA ENDS

CODE SEGMENT PARA PUBLIC 'CODE'
ASSUME CS:CODE,DS:DATA
	MAIN PROC FAR
	PUSH DS
	PUSH 0
	MOV AX,DATA
	MOV DS,AX
		
		XOR AX,AX;initialize ax with 0
		MOV CL,SIR_LEN
		XOR CH,CH
		XOR SI,SI
		
		NEXT:
			ADD AL,SIR[SI];add new element to sum
			ADC AH,0
			INC SI
			LOOP NEXT
			
		DIV SIR_LEN;compute the average;the average is stored in AL
		
		LEA DX,DEF_MESSAGE
		MOV AH,09H
		INT 21H;display message
		
		XOR AH,AH;the average is now in AX
		CALL DISPLAY_AX
		
	RET
	MAIN ENDP

	DISPLAY_AX PROC
		PUSH AX
		PUSH BX
		PUSH CX
		PUSH DX
		
		XOR CX,CX;cx will store nr de cifre
		MOV BX,10;for division
		
		AGAIN:
			XOR DX,DX;prepare dx:ax for division
			DIV BX;ax = ax/10,dx = ax%10
			PUSH DX;put ax%10 on stack
			INC CX;increase nr of digits
			CMP AX,0
			JNE AGAIN
		
		MOV AH,02H;for int21
		
		AFIS:
			POP DX;retrieve digit
			ADD DX,'0';make it ascii
			INT 21H;display the digit
			LOOP AFIS
		
		POP DX
		POP CX
		POP BX
		POP AX
		RET
	DISPLAY_AX ENDP
	
CODE ENDS
END MAIN