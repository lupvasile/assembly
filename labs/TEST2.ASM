DATA SEGMENT PARA PUBLIC 'DATA'
NO1 DD 17.6
NO2 DD -23.5
NO3 DW 100
NO4 DW -100
DATA ENDS
CODE SEGMENT PARA PUBLIC 'CODE'
ASSUME CS:CODE, DS:DATA
START PROC FAR
 ADD AX,0
 ADD AX, NO3
 MOV BX, NO4
;OTHER PROGRAM INSTRUCTIONS
RET
START ENDP
CODE ENDS
END START 
