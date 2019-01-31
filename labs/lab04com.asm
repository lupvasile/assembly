;The program calculates the sum of a row of numbers at SIR address and
;length specified in LGSIR variable; the result will be put in SUM location.

CODE SEGMENT PARA PUBLIC 'CODE'
	ASSUME CS:CODE, DS:CODE
	ORG 100H
	
	DATA_DECLARATIONS: JMP ENTRY
		;Here are the data declarations
		SIR 	DB 1,2,3,4
		LGSIR 	DB $-SIR
		SUM 	DB 0

	ENTRY:
		;Here starts the code
		
		MOV CL,LGSIR;Initialize counter with the sir length
		MOV CH,0
		
		MOV SI,0;Initialize index
		MOV AX,0;Initialize accumulator
		
		NEXT:
			ADD AL,SIR[SI]
			INC SI
		LOOP NEXT
		
		MOV SUM,AL
		
		MOV AX,4C00H
		INT 21H;return to OS

CODE ENDS

END DATA_DECLARATIONS