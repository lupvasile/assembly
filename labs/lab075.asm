CODE SEGMENT PARA PUBLIC 'CODE'

ASSUME CS:CODE

TABEL DB "0123456789"
DISPLAY_AX_RECURSIVE PROC;ax must have only al set
	PUSH AX
	PUSH DX
	PUSH BX;save used registers
	
	CMP AX,10
	JB SHORT FINISH;go to finish if ax<10
	
	XOR DX,DX;for div
	MOV BX,10
	DIV BX;ax = ax/10, dx = ax%10
	
	CALL DISPLAY_AX;if ax>=10, display_ax of ax/10 first
	
	MOV AX,DX;put back in ax the value ax%10 from the beginning
	
	FINISH:
	MOV AH,02H;for int21h
	LEA BX,TABEL;for xlat
	XLAT CS:TABEL;al = char for al 
	MOV DL,AL;for int21
	INT 21H;show al (which is ax%10)
	
	POP BX;restore used registers
	POP DX
	POP AX
	RET
DISPLAY_AX_RECURSIVE ENDP

DISPLAY_AX PROC
	PUSH AX
	PUSH BX
	PUSH CX
	PUSH DX
	
	XOR CX,CX
	
	COMPARARE:
		XOR DX,DX;for div
		MOV BX,10
		DIV BX;ax = ax/10, dx = ax%10
		ADD DX,'0';prepare dx character
		PUSH DX;save current cifra in order to display it
		INC CX;increase nr of cifre
		CMP AX,0
		JE SCRIERE
		JMP COMPARARE
		
	SCRIERE:
		MOV AH,02H
		POP DX
		INT 21H
		LOOP SCRIERE;afisam toate cifrele
	
	POP DX
	POP CX
	POP BX
	POP AX
	RET
DISPLAY_AX ENDP

	MAIN PROC FAR
	PUSH DS
	PUSH 0
	
		MOV AX,1234
		CALL DISPLAY_AX
		
	RET
	MAIN ENDP

CODE ENDS
END MAIN