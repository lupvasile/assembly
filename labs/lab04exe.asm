;The program calculates the sum of a row of numbers at SIR address and
;length specified in LGSIR variable; the result will be put in SUM location.

DATA SEGMENT PARA PUBLIC 'DATA'
	SIR 	DW 1,2,3,4
	LGSIR 	DB ($-SIR)/(TYPE SIR)
	SUM 	DD 0	
DATA ENDS

CODE SEGMENT PARA PUBLIC 'CODE'
	ASSUME CS:CODE, DS:DATA

	MAIN PROC FAR
		
		PUSH DS
		XOR AX,AX
		PUSH AX;initialize returning
		
		MOV AX,DATA
		MOV DS,AX;initialize ds
		
		MOV CL,LGSIR;Initialize counter with the sir length
		MOV CH,0
		
		MOV SI,0;Initialize index
		MOV AX,0;Initialize accumulator
		MOV BX,0;The sum will be held in BX:AX
		
		NEXT:
			ADD AX,SIR[SI]
			ADC BX,0
			ADD SI,TYPE SIR
			LOOP NEXT	
		
		MOV WORD PTR [SUM[1]],BX
		MOV WORD PTR [SUM[0]],AX
		
		
		RET;return to OS
	MAIN ENDP

CODE ENDS

END MAIN