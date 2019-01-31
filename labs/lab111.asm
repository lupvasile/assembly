; Program that determines the area of a circle with the radius R
; And volume of a sphere with radius R
DATE SEGMENT PARA 'DATA' ;SEGMENT
RAZA DQ 8.567
ARIE DQ ? ; RESERVE SPACE
VOLUM DQ ? ; RESULTS
PATRU DD 4.0
TREI DD 3.0
DATE ENDS
COD SEGMENT PARA 'CODE'
.8087
CALCUL PROC FAR ;
 ASSUME CS:COD, DS: DATE
 PUSH DS ; PREPARE
 XOR AX, AX ; STACK FOR
 PUSH AX ; DOS RETURN
 MOV AX, DATE ; LOADING DS
 MOV DS, AX ; WITH DATA SEGMENT 
 FINIT ;COPROCESOR INITIALIZATION
 FLD RAZA ;LOAD RAZA ON COPROC STACK
 FMUL RAZA ;COMPUTE R x R
 FLDPI ;LOAD PI TO COPROC STACK
 FMUL ;COMPUTE R x R x PI
 FSTP ARIE ;SAVING RESULT
 FWAIT ;SYNCHRONIZATION
 LEA SI, VOLUM ; VOLUM ADDRSS IN SI
 FINIT ;COPROCESOR INITIALIZATION
 FLD RAZA ; COMPUTATION
 FMUL RAZA ; R x R
 FMUL RAZA ; R x R x R
 FLDPI ; LOAD PI
 FMUL ; MULTYPLY WITH PI
 FMUL PATRU ; MULTIPLY WITH FOUR
 FDIV TREI ; DIVISION BY 3
 FSTP QWORD PTR [SI] ; SAVING RESULT
 FWAIT ; SYNCHRONIZATION
 RET
CALCUL ENDP ; END PROCEDURE
COD ENDS ; END CODE SEGMENT
 END CALCUL ; PROGRAM END 