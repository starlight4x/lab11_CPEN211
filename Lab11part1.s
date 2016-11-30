	.text
	.global _start

_start:
	BL CONFIG_VIRTUAL_MEMORY

	MOV R0, #0
	MCR p15, 0, R0, c9, c12, 5
	MOV R1, #0x11
	MCR p15, 0, R1, c9, c13, 1

	MOV R0, #1
	MCR p15, 0, R0, c9, c12, 1

	MOV R0, #3
	MCR p15, 0, R0, c9, c12, 0

	MOV R1, #0X00100000
	MOV R2, #0X100
	MOV R3, #2
	MOV r4, #0
	Mov R6, #12 
L_outer_loop1:
	MOV R5, #0
	ADD R6, R6, #1
L_inner_loop1:
	LDR R6, [R1, R5, LSL #2]
	ADD R5, R5, #1
	CMP R5, R2
	ADD R6, R6, #3
	BLT L_inner_loop1
	ADD R4, R4, #1
	CMP R4, R3
	ADD R6, R6, #2
	BLT L_outer_loop1

	MOV R0, #0
	MCR p15, 0, R0, c9, c12, 0
	
	MOV R0, #0
	MCR p15, 0, R0, c9, c12, 5
 	MRC p15, 0, R3, c9, c13, 2
	ADD R6, R6, #5
	B Second
Second:
	MOV R0, #0
	MCR p15, 0, R0, c9, c12, 5
	MOV R1, #0x6
	MCR p15, 0, R1, c9, c13, 1

	MOV R0, #1
	MCR p15, 0, R0, c9, c12, 1

	MOV R0, #3
	MCR p15, 0, R0, c9, c12, 0

	MOV R1, #0X00100000
	MOV R2, #0X100
	MOV R3, #2
	MOV r4, #0
L_outer_loop2:
	MOV R5, #0
L_inner_loop2:
	LDR R6, [R1, R5, LSL #2]
	ADD R5, R5, #1
	CMP R5, R2
	BLT L_inner_loop2
	ADD R4, R4, #1
	CMP R4, R3
	BLT L_outer_loop2

	MOV R0, #0
	MCR p15, 0, R0, c9, c12, 0
	
	MOV R0, #0
	MCR p15, 0, R0, c9, c12, 5
 	MRC p15, 0, R3, c9, c13, 2
	MOV R0, #0
	MCR p15, 0, R1, c9, c13, 1
	B Third
Third:
	MOV R0, #1
	MCR p15, 0, R0, c9, c12, 1

	MOV R0, #0x3
	MCR p15, 0, R0, c9, c12, 0

	MOV R1, #0X00100000
	MOV R2, #0X100
	MOV R3, #2
	MOV r4, #0
L_outer_loop3:
	MOV R5, #0
L_inner_loop3:
	LDR R6, [R1, R5, LSL #2]
	ADD R5, R5, #1
	CMP R5, R2
	BLT L_inner_loop3
	ADD R4, R4, #1
	CMP R4, R3
	BLT L_outer_loop3

	MOV R0, #0
	MCR p15, 0, R0, c9, c12, 0
	
	MOV R0, #0
	MCR p15, 0, R0, c9, c12, 5
 	MRC p15, 0, R3, c9, c13, 2
end:	B end
	 	