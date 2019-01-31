COD1 SEGMENT PARA 'CODE' ; segment codedefinition
PUBLIC PROCED ; declare proced as PUBLIC
ASSUME CS: COD1
PROCED PROC NEAR ; procedure definition
	;The instructions of the called procedure
	mov dl,'*'
	mov ah,2
	int 21h
	RET ; coming back to the procedure, which made the call
PROCED ENDP ; end procedure
COD1 ENDS ; end segment
END ; end of second module