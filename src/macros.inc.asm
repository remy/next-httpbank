CSP_BREAK MACRO : IFDEF TESTING : break : ENDIF : ENDM

call48k MACRO address
		rst $18
		DEFW address
	ENDM

PrintChar MACRO
		rst $10
	ENDM


PrintMsg MACRO Address
		ld 	hl, Address
		call 	PrintRst16
	ENDM

PrintText MACRO Text
		push 	hl
		ld 	hl, .txt
		call 	PrintRst16
		pop	hl
		jr 	.txtE
.txt
		DB Text
		DB CR
		DB 0
.txtE
	ENDM


ErrorIfNoCarry MACRO ErrAddr
		jp 	c, .Continue
		ld 	hl, ErrAddr
.Stop:
		Border 	2
		jr 	.Stop
.Continue:
	ENDM

EspSend MACRO Text
		ld 	hl, .txtB
		ld 	e, .txtE - .txtB
		call 	espSend
		jr 	.txtE
.txtB
	DB Text
.txtE
	ENDM

EspCmd MACRO Text
		ld 	hl, .txtB
		ld 	e, .txtE - .txtB
		call 	espSend
		jr 	.txtE
.txtB
	DB Text
	DB 13, 10
.txtE
	ENDM

EspCmdOkErr MACRO text
		EspCmd text
		call checkOkErr
	ENDM

NextRegRead MACRO Register
		ld bc, $243B             ; Port.NextReg = $243B
		ld a, Register
		call NextRegReadProc
	ENDM
