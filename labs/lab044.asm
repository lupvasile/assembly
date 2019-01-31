DATA SEGMENT PARA PUBLIC 'DATA' 
SIR DW 1,2,3,4
LGSIR DB ($-SIR)/2
SUM DD 0
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
 MOV AX,0 ; the initialization of the register where the sum is
 ; calculated
 MOV SI,0 ; the index’s initialization
 XOR BX,BX
 
 NEXT:
 ADD AX,SIR[SI] ; the add of the current element
 ADC BX,0 ; add the carry to bx
 INC SI ; passing at the next element in the row
 INC SI ; passing at the next element in the row
 LOOP NEXT ; CX decrementing and jump to next
; element if CX differs from 0
; MOV SUM,AX nu se mai poate
MOV WORD PTR[SUM[0]], AX ;ca sa muti ax si bx in sum,; partea de jos
MOV WORD PTR[SUM[2]], BX; partea de sus
; end of program
RET
START ENDP
CODE ENDS
END START 