XORCRYPT PROC
;========================================================================
;ESI = Pointer to Data to Processed
;EBP = Pointer to Password String
;EDI = Pointer to Storage Buffer. Size Must be equal to the size of data.
;========================================================================
	OUTER:
		MOV EDX, EBP	;PRESERVE THE STARTING LOCATION OF PASSWORD
		INNER:
			XOR EBX,EBX		;EMPTY THE EBX REGISTER
			MOV BL, BYTE PTR [ESI]	;Load next character from STRING
			MOV BH, BYTE PTR [EBP]	;Load next character from PASSWORD
			XOR BL,BH
			XCHG EAX,EBX
			STOSB
			XCHG EAX,EBX
			INC ESI
			ADD EDX,EAX
			CMP EDX,EBP
			JZ RESETPASS
			SUB EDX,EAX
			INC EBP
		LOOP INNER
		MOV EBP,EDX
		CMP ECX,0	;If CX is already zero the next loop instruction will set CX
					;FFFFFFFF which will disturb the process.
		JZ COMPLETED_ENCRYPTION	;thats is why check it here and jump
	LOOP OUTER
		RESETPASS:
		SUB EDX,EAX
		MOV EBP,EDX
		LOOP OUTER
	COMPLETED_ENCRYPTION:
		MOV AL,0	;APPLY a null terminator
		STOSB
		RET
XORCRYPT ENDP
