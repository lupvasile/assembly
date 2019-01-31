CODE SEGMENT PARA PUBLIC 'CODE'
 ASSUME CS:CODE, DS:CODE
 ORG 100H
START: JMP ENTRY
SIR DB 1,2,3,4
LGSIR DB $-SIR
SUM DB 0
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
 MOV AX,4C00h
 INT 21H
CODE ENDS
END START 
