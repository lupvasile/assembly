DATE SEGMENT PARA PUBLIC 'DATA' ; data segment definition
	SIR DB 1,2,3
	LGSIR DW $-SIR
DATE ENDS

STAC SEGMENT PARA STACK 'stack' ;stack segment definition
	db 64 dup ('MY_STACK')
STAC ENDS

COD3 SEGMENT PARA 'CODE' ; code segment definition

ASSUME CS: COD3
SUM PROC FAR ; procedure definition
	; The instructions of the called procedure
	XOR AX,AX
	XOR SI,SI
	
	NXT:
		ADD AL,DS:[BX + SI]
		INC SI
	LOOP NXT
	RETF ; back to the procedure which made the call
SUM ENDP ; end procedure
COD3 ENDS ; end segment


COD1 SEGMENT PARA PUBLIC 'CODE' ; cod segment definition
ASSUME CS: COD1, DS: DATE, SS: STAC, ES: NOTHING
PRPRINC PROC FAR ; main procedure definition

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
	PRPRINC ENDP ; end procedure
COD1 ENDS ; segment's end
END PRPRINC ; end of the first module