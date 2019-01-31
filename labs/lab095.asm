
DATE SEGMENT PARA PUBLIC 'DATA' ; data segment definition
	SIR DB 1,2,3
	LGSIR DW $-SIR
DATE ENDS

COD1 SEGMENT PARA PUBLIC 'CODE' ; cod segment definition
ASSUME CS: COD1, DS: DATE, SS: NOTHING, ES: NOTHING

SUM PROC NEAR ; procedure definition
	;The instructions of the called procedure
	XOR AX,AX
	XOR SI,SI
	
	NXT:
		ADD AL,DS:[BX + SI]
		INC SI
	LOOP NXT
	RET ; coming back to the procedure, which made the call
SUM ENDP ; end procedure


MAIN PROC FAR ; main procedure definition

	PUSH ds ;prepare stack
	SUB ax, ax ;to return
	PUSH ax ; to DOS
	MOV AX, DATE ; load register
	MOV DS, AX ; DS with data segment
	; The instructions of the main procedure
	LEA BX, SIR
	MOV CX, LGSIR
	
	CALL SUM ; call procedure
	; Other instructions
	RET ; coming back to DOS
	MAIN ENDP ; end procedure
COD1 ENDS ; segment's end
END MAIN ; end of the first module