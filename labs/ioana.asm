DATA SEGMENT PARA PUBLIC 'DATA'
	readLEN DB 4,?,4 DUP(?) ; aici citesc lungimea de al tastatura
	LEN DB ? 	; aici pun lungimea dupa ce folosesc toNUMBER ca sa convertesc ce am citit in readLEN in numar
	ARRAY DB 20 DUP(?)	; aici pun numerele PE care le citesc
	readELEMENT DB 5, ? ,5 DUP(?)	; asa citesc un element	
	ELEMENT DB ?	; da cum citesc elementul ca string, il convertesc in numar si il pun in ELEMENT pe care il pun in ARRAY
	min db ? ; aici calculez minimul 
	result db 5 dup(?),'$' ;	asta tiparesc pe ecran, dupa ce convertesc cu toSTRING ca sa pot tipari
	MESSAGE1 DB 'Introduce the number of elements of the array: ','$'
	MESSAGE2 DB 0ah,0dh,'Introduce an element: ','$'
	MESSAGE4 DB 0AH,0DH,'min ','$'
DATA ENDS
 
 ;DOAR MACRO PENTRU TIPARIRE, CITIRE, CONVERSIE STRING IN NUMAR, CONVERSIE NUMAR IN STRING
PRINT MACRO MESSAGE
	MOV AH, 09H
	MOV DX, OFFSET MESSAGE
	INT 21H
ENDM PRINT

READ MACRO TEXT
	MOV AH, 0AH
	MOV DX, OFFSET TEXT
	INT 21H
ENDM READ

toNUMBER MACRO STRING,newNUMBER
LOCAL loop1
MOV CL,STRING[1]
MOV CH,0
MOV BL,10
MOV DI,2
MOV AX,0
MOV DL,0

loop1:
		SUB STRING[DI],'0'
		MOV DL,STRING[DI]
		MUL BL
		ADD AL,DL
		INC DI
		LOOP loop1
		
	MOV newNUMBER,AL
 
ENDM toNUMBER

toSTRING MACRO NR,newSTRING
LOCAL loop2

MOV AH,0
MOV AL,NR
MOV BL,10
MOV DI,1

loop2:
		DIV BL
		MOV newSTRING[DI],AH
		ADD newSTRING[DI],'0'
		DEC DI
		MOV AH,0
		CMP AL,0
		JNE loop2
ENDM toSTRING


CODE SEGMENT PARA PUBLIC 'CODE'
;EXTRN UPDATE:NEAR
ASSUME DS:DATA,CS:CODE
START PROC FAR

	PUSH DS
	MOV AX,0
	PUSH AX
	MOV AX,DATA
	MOV DS,AX

	; PANA AICI AU FOST ALEA DE BAZA PE CARE LE SCRIEM MEREU 
	
	; ACUM CITESC LUNGIMEA ARRAYULUI SI O CONVERTESC SI O PUN IN LEN
	PRINT MESSAGE1
	READ readLEN
	toNUMBER readLEN,LEN
	
	; acum citesc cate un element pe rand si il pun in array
	MOV SI,0	; incep de la pozitia 0 sa pun in array
	MOV BH,1 ; TO COUNT THE ELEMENTS - asta e sa stiu cand sa ma opresc cu bucla getELEMENTS
	
getELEMENTS: 
		;citesc un element si il convertesc 
		PRINT MESSAGE2
		READ readELEMENT
		toNUMBER readELEMENT,ELEMENT
		
		;pun elementul convertit in array
		MOV BL,ELEMENT
		MOV ARRAY[SI],BL
		;verific daca mai am de citit, daca nu mai am trec la NEXT unde aflu minimul
		CMP BH,LEN
		JE NEXT
		;daca mai am de citit, well,tot citesc..
		INC SI
		INC BH
		LOOP getELEMENTS
	
	;aici aflu minimul
NEXT:
	MOV CL,LEN ;pun in CL lungimea arrayului
	MOV CH,0
	MOV SI,1 ; incep de la pozitia 1 , pentru ca ce am pe pozitia 0 o sa consider ca e minimul
	MOV AX, 0
	
	MOV BL,ARRAY[0] ; aici mi-am salvat minimul, il voi considera ca e primul element din array
	
	findmin:
			MOV AL,ARRAY[SI] ; iau elementul de pe poz SI 
			CMP AL,BL ; il compar cu BL in care am minimul
			JL UPDATE ; daca e mai mic atunci fac update
			CMP AL,BL
			JGE NO_UPDATE ; daca e mai mare sau  e egal cu el, nu fac nimic..e bine,da nu ma ajuta
			
	UPDATE:	; aici fac update
		MOV BL,AL ; mut in BL noul meu minim care e in AL momentan
		CMP CX,0 ; verific daca mai am elemente in array 
		JE FINISH ; daca am terminat ma duc la finish
		
		INC SI ; altfel mai parcurg arrayul
		LOOP findmin
		
	NO_UPDATE:	
		CMP CX,0 ; nu fac update, ci fac iar loop
		JE FINISH
		INC SI
		LOOP findmin
		
	FINISH:
		MOV min,BL	; mut in min ce am in BL - in BL am calculat minimul
		
	;acum convertesc minimul in string si il tiparesc
		toSTRING min,result
		PRINT MESSAGE4
		PRINT result
	;ies din program
	JMP EXIT

EXIT:
	MOV AH,4CH
	INT 21H

RET
START ENDP
CODE ENDS
END START
