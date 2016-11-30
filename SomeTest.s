.include "address_map_arm.s"
.text
.globl _start

_start:	
	LDR r10, = LEDR_BASE
	MOV r0, #16
	MOV r5, #21
	MOV r6, #42

	TST r0, #1
	BNE Odd
	STR r5, [r10] 
Back:	B Back


Odd:
	STR r6, [r10]
	B Back