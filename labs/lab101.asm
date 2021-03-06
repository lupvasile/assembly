COD SEGMENT PARA PUBLIC 'CODE'
ASSUME CS:COD

	DELAY PROC
		MOV CX,10000
		
		NEXT1:
			push cx
			mov cx,10000
			NEXT2:
				
				LOOP NEXT2
			pop cx
			LOOP NEXT1;
		
		RET
	DELAY ENDP
	
	VLINE PROC;DX-LINE, CX-COLUMN, BX-LENGTH
		
		;MOV DX,5;INITIAL LINE
		;MOV CX,100;INITIAL COLUMN
		;MOV BX,100;COUNT 
		NEXT:
			MOV AH,0CH;SHOW POINT ON SCREEN
			;MOV AL,5;COLOR
			INT 10H
			INC DX;MOVE ON COLUMN
			DEC BX
			JNZ NEXT

		RET
	VLINE ENDP
	
	
	HLINE PROC;DX-LINE, CX-COLUMN, BX-LENGTH
		
		;MOV DX,5;INITIAL LINE
		;MOV CX,100;INITIAL COLUMN
		;MOV BX,100;COUNT 
		NEXT3:
			MOV AH,0CH;SHOW POINT ON SCREEN
			;MOV AL,5;COLOR
			INT 10H
			INC CX;MOVE ON LINE
			DEC BX
			JNZ NEXT3

		RET
	HLINE ENDP
	
	SQUARE PROC;DX- INITIAL LINE, CX-INITIAL LINE, BX-SIZE
		PUSH DX
		PUSH CX
		PUSH BX
		
		CALL VLINE
		
		POP BX
		POP CX
		POP DX
		PUSH DX
		PUSH CX
		PUSH BX
		
		CALL HLINE
		
		POP BX
		POP CX
		POP DX
		
		ADD DX,BX
		PUSH DX
		PUSH CX
		PUSH BX
		
		CALL HLINE

		POP BX
		POP CX
		POP DX
	
		SUB DX,BX
		ADD CX,BX
		DEC CX
		PUSH BX
		CALL VLINE
		
		POP BX
		RET
	SQUARE ENDP

	SQUAREF PROC;DX- INITIAL LINE, CX-INITIAL LINE, BX-SIZE
		
		MOV SI,BX
		NXT6:
			PUSH DX
			PUSH CX
			PUSH BX
			
			CALL VLINE
			
			POP BX
			POP CX
			POP DX
			
			INC CX
			DEC SI
			JNZ NXT6
		
		RET
	SQUAREF ENDP
	
	
	MAIN PROC FAR
		PUSH DS
		XOR AX,AX
		PUSH AX
		
		MOV AH,0FH
		INT 10H
		PUSH AX
		PUSH BX;SAVE THE CURRENT VIDEO SETTINGS
		
		MOV AH,0;SET THE GRAPHIC MODE
		MOV AL,13H;640*200
		INT 10H
		
		MOV DX,100
		MOV CX,10
		MOV BX,40
		MOV AL,2
		CALL SQUAREF

		MOV DX,50
		MOV CX,25
		MOV BX,40
		MOV AL,4
		CALL SQUAREF
		
		MOV DX,60
		MOV CX,100
		MOV BX,100
		MOV AL,5
		CALL SQUAREF
		
		MOV DX,60
		MOV CX,100
		MOV BX,100
		MOV AL,10
		call Delay
		CALL SQUARE
		
		
		POP BX
		POP AX
		MOV AH,0
		
		INT 10H
		RET
	MAIN ENDP
COD ENDS
END MAIN