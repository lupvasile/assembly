CODE SEGMENT PARA PUBLIC 'CODE'
ASSUME CS:CODE

	MAIN PROC FAR
		PUSH DS
		PUSH 0
		
		CALL READ_AX
		CALL DISPLAY_AX
		
		RET	
	MAIN ENDP
		
	READ_AX PROC
		PUSH BX
		PUSH CX
		PUSH DX
		
		XOR BX,BX;bx will store the number
		XOR CH,CH;cx will store the new digit for computations
		
		
		CITIRE:	MOV AH,01H	;for int21h
				INT 21H		;read new character in AL
				CMP AL,13	;compare with enter key
				JE CIRIRE_GATA;enter key was pressed
		
		
		
		;******************extra********************************
				CMP AL,'0'		
				JB INVALID_CHAR	;astea is extra
				CMP AL,'9'
				JA INVALID_CHAR	
		;**************************************************
		
		
		
				SUB AL,'0'	;transform al from ascii to number
				MOV CL,AL	;save the digit
				
				MOV AX,10
				MUL BX
				MOV BX,AX	;bx = bx*10
				
				ADD BX,CX	;bx = bx*10 + cx->which stores the new digit
				JMP CITIRE
			
		
		
		;******************extra********************************
		INVALID_CHAR_MESSAGE DB 10,13,'Invalid digit input,discarding...',10,13,'$'
		
		INVALID_CHAR:	PUSH DS	;astea is extra
						MOV DX,CS
						MOV DS,DX;prepare ds for int21h
						LEA DX,INVALID_CHAR_MESSAGE
						MOV AH,09H
						INT 21H
						POP DS
						JMP CITIRE
		;**************************************************
		
		
		
		CIRIRE_GATA: MOV AX,BX		
		
		
		POP DX
		POP CX
		POP BX
		RET
	READ_AX ENDP
	
	DISPLAY_AX PROC
		PUSH AX
		PUSH BX
		PUSH CX
		PUSH DX
		
		XOR CX,CX			;cx will store nr de cifre
		MOV BX,10			;for division
		
		
		AGAIN:	XOR DX,DX	;prepare dx:ax for division
				DIV BX		;ax = ax/10,dx = ax%10
				PUSH DX		;put ax%10 on stack
				INC CX		;increase nr of digits
				CMP AX,0
				JNE AGAIN
		
		MOV AH,02H			;for int21
		
		AFIS:	POP DX		;retrieve digit
				ADD DX,'0'	;make it ascii
				INT 21H		;display the digit
				LOOP AFIS
		
		POP DX
		POP CX
		POP BX
		POP AX
		RET
	DISPLAY_AX ENDP
	
CODE ENDS
END MAIN