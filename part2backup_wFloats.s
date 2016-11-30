array1:
.double 1.0
.double 2.0
.double 3.0
.double 4.0
.double 5.0
.double 6.0
.double 7.0
.double 8.0
.double 9.0
.double 10.0
.double 11.0
.double 12.0
.double 13.0
.double 14.0
.double 15.0
.double 16.0

array2: 
.double 16.0
.double 15.0
.double 14.0
.double 13.0
.double 12.0
.double 11.0
.double 10.0
.double 9.0
.double 8.0
.double 7.0
.double 6.0
.double 5.0
.double 4.0
.double 3.0
.double 2.0
.double 1.0

array_sol:
.double 0.0
.double 0.0
.double 0.0
.double 0.0
.double 0.0
.double 0.0
.double 0.0
.double 0.0
.double 0.0
.double 0.0
.double 0.0
.double 0.0
.double 0.0
.double 0.0
.double 0.0
.double 0.0

//array1:
//.word 1
//.word 0
//.word 2
//.word 0
//.word 3
//.word 0
//.word 4
//.word 0
//.word 5
//.word 0
//.word 6
//.word 0
//.word 7
//.word 0
//.word 8
//.word 0
//.word 9
//.word 0
//.word 10
//.word 0
//.word 11
//.word 0
//.word 12
//.word 0
//.word 13
//.word 0
//.word 14
//.word 0
//.word 15
//.word 0
//.word 16
//.word 0

//array2: 
//.word 16
//.word 0
//.word 15
//.word 0
//.word 14
//.word 0
//.word 13
//.word 0
//.word 12
//.word 0
//.word 11
//.word 0
//.word 10
//.word 0
//.word 9
//.word 0
//.word 8
//.word 0
//.word 7
//.word 0
//.word 6
//.word 0
//.word 5
//.word 0
//.word 4
//.word 0
//.word 3
//.word 0
//.word 2
//.word 0
//.word 1
//.word 0


//array_sol:
//.word 0
//.word 0
//.word 0
//.word 0
//.word 0
//.word 0
//.word 0
//.word 0
//.word 0
//.word 0
//.word 0
//.word 0
//.word 0
//.word 0
//.word 0
//.word 0
//.word 0
//.word 0
//.word 0
//.word 0
//.word 0
//.word 0
//.word 0
//.word 0
//.word 0
//.word 0
//.word 0
//.word 0
//.word 0
//.word 0
//.word 0
//.word 0

N:
.word 4

SUM:
.double 0.0

.include "address_map_arm.s"
.text
.global _start

_start:

matrix_multiply:

	MOV R0, #0		//define R0 as i=0
	MOV R1, #0		//define R1 as j=0
	MOV R2, #0		//define R2 as k=0
	
	LDR R3, N		//Load N in to R3=128
	LDR R4, =array1  //Load R4 as the base of array1
	LDR R5, =array2  //Load R5 as the base of array2
	
	LDR R7, =SUM
	//LDR R6, SUM		//define R6 as sum = 0.0  //NEED TO CHANGE****
	.word 0xED976B00	//1111, 1101, 1001, 0111, 0110, 1011, 0000, 0000
iloopreturn:
	CMP R0, R3
	BLT iLoop
done:	B done // Finished excution!!!
	
iLoop:
	ADD R0, R0, #1
jloopreturn:
	CMP R1, R3
	BLT jLoop
	MOV R1, #0
	MOV R2, #0
	B iloopreturn  	//if not less then go back to iLoop
	
jLoop:
	ADD R1, R1, #1

	MOV R6, #0		//Make Sum equals to 0 NEED TO CHANGE*******
	.word 0xEE266B06	//1111, 1110, 0010, 0110, 0110, 1011, 0000, 0110 
kloopreturn:
	CMP R2, R3
	BLT kLoop
				//Below code place sum into array3
	MOV R7, #0		//Clear R7
	SUB R0, R0, #1
	SUB R1, R1, #1
	SUB R2, R2, #1
	
	MUL R7, R0, R3	//Multiply i by N and place in R7
	Add R7, R7, R1	//Add value of R7 to j
	
	ADD R0, R0, #1
	ADD R1, R1, #1
	ADD R2, R2, #1
	B EvenOddTest3
Fini3:
	LDR R7, =array_sol
	ADD R7, R7, R9
	//STR R6, [R7, R9]	//NEED TO CHANGE*******
	.word 0xED876B00	//1111, 1101, 1000, 0111, 0110, 0000, 0000
	MOV R2, #0
	B jloopreturn	//if not less than go back to jLoop
	
kLoop:
	ADD R2, R2, #1
	MOV R7, #0 		//Clear R7
	
	SUB R0, R0, #1
	SUB R1, R1, #1
	SUB R2, R2, #1
	MUL R7, R0, R3	//Multiply i by N and place in R7
	ADD R7, R7, R2  //Add value of R7 to k
	
	ADD R0, R0, #1
	ADD R1, R1, #1
	ADD R2, R2, #1
	B EvenOddTest1
	
Fini1:
	//MOV R7, #0		//Clear R7
	//ADD R7, R4, R9  //Obtain final address of element in array1
	//LDR R11, [R4, R9]	//place that element in R11********
	ADD R7, R4, R9
	.word 0xED97BB00	//1111, 1101, 1001, 0111, 1011, 1011, 0000, 0000	

	MOV R7, #0      //Clear R7
	
	SUB R0, R0, #1
	SUB R1, R1, #1
	SUB R2, R2, #1
	MUl R7, R2, R3  //Multiply k by N and place in R7
	ADD R7, R7, R1	//Add value of R7 to j
	
	ADD R0, R0, #1
	ADD R1, R1, #1
	ADD R2, R2, #1
	B EvenOddTest2
Fini2:
	//MOV R7, #0		//Clear R7
	//ADD R7, R5, R9  //Obtain final address of element in array1
	//LDR R12, [R5, R9]	//place that element in R12
	ADD R7, R5, R9
	.word 0xED97CB00	//1111, 1101, 1001, 0111, 1100, 1011, 0000, 0000
	B SumCalc
	
SumCalc:
	MOV R10, #0 	//Clear R12
	//MUL R10, R11, R12 //Multiple R10 and R11 (element of two arrays) NEED TO CHANGE*******
	.word 0xEE2BAB0C
	//ADD R6, R6, R10 	//ADD sum to R10 and place as sum NEED TO CHANGE*******
	.word 0xEE36AB06
	//LDR r11, = LEDR_BASE
	//STR r6, [r11]
	B kloopreturn
	
//================================================================	
EvenOddTest1:	
	MOV R8, #0		//Tracks number of Right shifts
	MOV R9, #0		//This will be the actual address

	TST R7, #1
	BNE ODD1
	B EVEN1

ODD1:
	LSR R7, #1
	MOV R10, #16
	MUL R9, R7, R10
	ADD R9, R9, #8
	B Fini1
	
EVEN1:
	LSR R7, #1
	MOV R10, #16
	MUL R9, R7, R10
	B Fini1
	
	
//EVEN1:	
//	CMP R7, #0		
//	BEQ is01
//	CMP R7, #1
//	BEQ iseven11
//	LSR R7, #1
//	ADD R8, R8, #1
//	B EVEN1
	
//iseven11:
//	MOV R10, #16
//	Mul R8, R8, R10
//	MOV R9, R8
//	B Fini1

//is01:
//	MOV R10, #16
//	MUL R8, R8, R10 //Multiply number of shifts by 10
//	MOV R9, R8		//places address into R9 	
//	B Fini1

//ODD1:
//	CMP R7, #1
//	BEQ is11
//	LSR R7, #1
//	ADD R8, R8, #1
//	B ODD1
	
//is11:
//	MOV R10, #16
//	MUL R8, R8, R10 //Multiply number of shifts by 10
//	ADD R8, R8, #8
//	MOV R9, R8
//	B Fini1
//===============================================================	
EvenOddTest2:	
	MOV R8, #0		//Tracks number of Right shifts
	MOV R9, #0		//This will be the actual address
	
	TST R7, #1
	BNE ODD2
	B EVEN2

ODD2:
	LSR R7, #1
	MOV R10, #16
	MUL R9, R7, R10
	ADD R9, R9, #8
	B Fini2
	
EVEN2:
	LSR R7, #1
	MOV R10, #16
	MUL R9, R7, R10
	B Fini2


//EVEN2:
//	CMP R7, #0		
//	BEQ is02
//	CMP R7, #1
//	BEQ iseven12
//	LSR R7, #1
//	ADD R8, R8, #1
//	B EVEN2
	
//iseven12:
//	MOV R10, #16
//	Mul R8, R8, R10
//	MOV R9, R8
//	B Fini2

//is02:
//	MOV R10, #16
//	MUL R8, R8, R10 //Multiply number of shifts by 10
//	MOV R9, R8		//places address into R9 	
//	B Fini2

//ODD2:
//	CMP R7, #1
//	BEQ is12
//	LSR R7, #1
//	ADD R8, R8, #1
//	B ODD2
	
//is12:
//	MOV R10, #16
//	MUL R8, R8, R10 //Multiply number of shifts by 10
//	ADD R8, R8, #8
//	MOV R9, R8
//	B Fini2

//===============================================================	
	EvenOddTest3:	
	MOV R8, #0		//Tracks number of Right shifts
	MOV R9, #0		//This will be the actual address

	TST R7, #1
	BNE ODD3
	B EVEN3
	
ODD3:
	LSR R7, #1
	MOV R10, #16
	MUL R9, R7, R10
	ADD R9, R9, #8
	B Fini3
	
EVEN3:
	LSR R7, #1
	MOV R10, #16
	MUL R9, R7, R10
	B Fini3
	
	
//EVEN3:
//	CMP R7, #0		
//	BEQ is03
//	CMP R7, #1
//	BEQ iseven13
//	LSR R7, #1
//	ADD R8, R8, #1
//	B EVEN3
	
//iseven13:
//	MOV R10, #16
//	Mul R8, R8, R10
//	MOV R9, R8
//	B Fini3

//is03:
//	MOV R10, #16
//	MUL R8, R8, R10 //Multiply number of shifts by 10
//	MOV R9, R8		//places address into R9 	
//	B Fini3

//ODD3:
//	CMP R7, #1
//	BEQ is13
//	LSR R7, #1
//	ADD R8, R8, #1
//	B ODD3
	
//is13:
//	MOV R10, #16
//	MUL R8, R8, R10 
//	ADD R8, R8, #8
//	MOV R9, R8
//	B Fini3






 