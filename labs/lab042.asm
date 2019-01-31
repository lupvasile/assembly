DATA SEGMENT PARA PUBLIC 'DATA' 
SIR DB 1,2,3,4
LGSIR DB $-SIR
SUM DB 0
DATA ENDS 

CODE SEGMENT PARA PUBLIC 'CODE'

START PROC FAR
ASSUME CS:CODE, DS:DATA
 PUSH DS
 XOR AX,AX
 PUSH AX ; the initialization for the returning
 MOV AX,DATA
 MOV DS, AX ; the initialization of DS date segment 

ENTRY:
 MOV CH,0
 MOV CL,LGSIR ; in CX is the length’s row
 MOV AL,0 ; the initialization of the register where the sum is
 ; calculated
 MOV SI,0 ; the index’s initialization
NEXT:
 ADD AL,SIR[SI] ; the add of the current element
 INC SI ; passing at the next element in the row
 LOOP NEXT ; CX decrementing and jump to next
; element if CX differs from 0
 MOV SUM,AL
; end of program
RET
START ENDP
CODE ENDS
END START 