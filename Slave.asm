; Arduino Uno - Slave
; Author : Marius Stoica


.INCLUDE "M328PDEF.INC"


	LDI R21,HIGH(RAMEND)
	OUT SPH,R21
	LDI R21,LOW(RAMEND)
	OUT SPL,R21
	LDI R21, 0xFF 
	OUT DDRB,R21 

	HERE:
	CALL I2C_INIT 
	CALL I2C_LISTEN 
	CALL I2C_READ 
	OUT PORTB,R27 


	RJMP HERE 

//I2C functions

;*********************************************************
I2C_INIT:
	LDI R21, 0x10 
	STS TWAR,R21 
	LDI R21, (1<<TWEN) 
	STS TWCR,R21 
	LDI R21, (1<<TWINT)|(1<<TWEN)|(1<<TWEA)
	STS TWCR,R21 
	RET

;*********************************************************
	I2C_LISTEN:
	W1:
	LDS R21, TWCR 
	SBRS R21, TWINT 
	RJMP W1 
	RET

;*********************************************************
I2C_READ:
	LDI R21, (1<<TWINT)|(1<<TWEN)|(1<<TWEA)
	STS TWCR, R21 
	W2: LDS R21, TWCR 
	SBRS R21, TWINT 
	RJMP W2 
	LDS R27,TWDR 
	RET