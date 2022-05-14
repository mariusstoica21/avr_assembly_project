; Arduino Mega - Master
; Author : Marius Stoica


.INCLUDE "M2560DEF.INC"


.ORG 0 ;location for reset
	JMP MAIN

.ORG 0x000A ;vector location for external interrupt 0
	JMP EX0_ISR

.ORG 0x0022 ;location for Timer1 compare match
	JMP T1_CM_ISR


// Main function
;*********************************************************

MAIN: 
	LDI R16,HIGH(RAMEND)
	OUT SPH,R16
	LDI R16,LOW(RAMEND)
	OUT SPL,R16 

	LDI R16,0xFF
	OUT DDRA, R16

	LDI R31,0x00

	LDI R16,0b0000_0011
	OUT DDRC, R16

	SBI DDRE,5
	SBI DDRB,6 
	SBI DDRB,5 
	SBI DDRB,4 

	SBI PORTE,5

	LDI R22,0b011
	LSL R22
	LSL R22
	LSL R22
	LSL R22

	CBI DDRE,4
	SBI PORTE,4 
	LDI R16,1<<INT4 
	OUT EIMSK,R16
	

	LDI R16,0
	STS EICRA,R16
	LDI R16,0x01
	STS EICRB,R16

	LDI R16,(1<<OCIE1A)
	STS TIMSK1,R16 
	LDI R16,0x00
	STS TCCR1A,R16
	LDI R16,0xD
	STS TCCR1B,R16 
	LDI R16,HIGH(15624)
	STS OCR1AH,R16 
	LDI R16,LOW(15624) 
	STS OCR1AL,R16  

	SEI ;enable interrupts

	HERE:

	
	CALL I2C_INIT 
	CALL I2C_START 
	LDI R27, 0b0001000_0 
	CALL I2C_WRITE 
	MOV R27, R31 
	CALL I2C_WRITE 
	CALL I2C_STOP 
	

	READ_ADC:

	OUT PORTB,R22

	LDI	R16, 0b0000_0011
	STS	DIDR1, R16


	LDI	R16, 0b0000_0001
	STS	DIDR0, R16

	STS ADCSRB, R16

	LDI R16, 0b1010_0111      
	STS ADCSRA, R16 

	LDI R16, 0b0100_0000      
	STS ADMUX, R16

	LDI R16, 0b1110_0111
	STS ADCSRA, R16
	                  
	BUSY:                   
		LDS R19, ADCSRA
		SBRC R19, 6              
		RJMP BUSY  
		
		LDI  R25, ADCSRA;           
		LDI R26, 0b01000000
		OR R26,R25
		STS ADCSRA,R26

		
		LDS R23, ADCL             
		OUT PORTA, R23
		LDS R24, ADCH
		OUT PORTC, R24
		

		JMP HERE ;stay here forever
;*********************************************************

//I2C Protocol functions

;*********************************************************
I2C_INIT:
	LDI R21, 0b0000_0000
	STS TWSR,R21 
	LDI R21, 0x48 
	STS TWBR,R21 
	LDI R21, (1<<TWEN) 
	STS TWCR,R21 
	RET

;*********************************************************
I2C_START:
	LDI R21, (1<<TWINT)|(1<<TWSTA)|(1<<TWEN)
	STS TWCR,R21 
	WAIT1:
	LDS R21, TWCR 
	SBRS R21, TWINT 
	RJMP WAIT1 
	RET
;*********************************************************
I2C_WRITE:
	STS TWDR, R27 
	LDI R21, (1<<TWINT)|(1<<TWEN)
	STS TWCR, R21 
	WAIT3:
	LDS R21, TWCR
	SBRS R21, TWINT 
	RJMP WAIT3
	RET
;*********************************************************
I2C_STOP:
	LDI R21, (1<<TWINT)|(1<<TWSTO)|(1<<TWEN)
	STS TWCR, R21 
	RET

//External interrupt ISR

EX0_ISR:
	LSR R22
	LSR R22
	LSR R22
	LSR R22
	INC R22
	LSL R22
	LSL R22
	LSL R22
	LSL R22
	INC R31
	RETI

//Internal interrupt ISR

T1_CM_ISR:
	IN R29,PORTE
	LDI R30,0b0010_0000 
	EOR R29,R30
	OUT PORTE,R29 
	RETI 


