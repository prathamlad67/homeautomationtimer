// HOME AUTOMATION RIMER PROJECT, 
// 3 DIGIT 7 SEG WITH 3 PUSH BUTTONS
// 1 button FOR UP, 1 FOR DOWN AND 1 FOR THE TIME DELAY TO THE RELAY
// DELAY SHOULD BE DISPLAYED NUMBER TIMES MINUTE
ORG 00H
  LCALL MAIN
  
ORG 3BH    ; PIN INTERRUPT ISR VECTOR TABLE
  LCALL PIN_INTRPT
  MOV PIF, #00H
  RETI
  
MAIN:
  ; PORT0 IN PUSH PULL MODE
  P0M1 EQU 0B1H
  P0M2 EQU 0B2H
  MOV P0M1, #0H
  MOV P0M2, #0FFH 

  ; PORT1: PIN 4,5,7 INPUT ONLY MODE AND OTHER PUSH PULL MODE
  P1M1 EQU 0B3H
  P1M2 EQU 0B4H
  MOV P1M1, #10110000B
  MOV P1M2, #00001111B
  
  ; PORT3 IN PUSH PULL MODE
  P3M1 EQU 0ACH
  P3M2 EQU 0ADH
  MOV P3M1, #0H
  MOV P3M2, #0FFH
    
  P10 BIT P1.0
  P11 BIT P1.1
  P12 BIT P1.2
	  
  CLR P1.3
  
  ; INTERRUPT ENABLING INSTRUNCTIONS
  EIE EQU 09BH
  PICON EQU 0E9H
  PIPEN EQU 0EBH
  PIF EQU 0ECH
  MOV PICON, #11000001B ; ENABLING PORT1 PIN 4,5,6,7 FOR PIN INTERRUPT
  MOV PIPEN, #10110000B ; PIN 4,5,7 POSITIVE POLARITY
  MOV PIF, #0H ; CLEAR PIN INTERRUPT FLAG
  MOV IE, #80H ; ENABLE EA
  MOV EIE, #02H ; ENABLE PIN INTERRUPT
  
  ; 7SEG INITIAL INSTRUCTION
  MOV DPTR, #SEG_DATA
  MOV R0, #0
  MOV R1, #0
  MOV R2, #0
//-------------------------------------
//	MAIN LOOP CODE 
//-------------------------------------
MAIN1:
  ACALL DISPLAY
  SJMP MAIN1
  
  
//-------------------------------------
//	INTERRUPT HANDLING
//-------------------------------------  
PIN_INTRPT:
  MOV A, PIF
  //------------------------------------
  //  BUTTON 0
    CJNE A, #10000000B, CHECK1
      INC R0
      CJNE R0, #10, DEFAULT
      MOV R0, #0
      INC R1
      CJNE R1, #10, DEFAULT
      MOV R1, #0
      INC R2
      CJNE R2, #10, DEFAULT
      MOV R2, #0
    RET
  //------------------------------------
  //  BUTTON 2
  CHECK1:
    CJNE A, #00100000B, CHECK2
      DEC R0
      CJNE R0, #0FFH, DEFAULT
      MOV R0, #9
      DEC R1
      CJNE R1, #0FFH, DEFAULT
      MOV R1, #9
      DEC R2
      CJNE R2, #0FFH, DEFAULT
      MOV R2, #9
    RET
  //------------------------------------
  //  BUTTON 1
  CHECK2:
    CJNE A, #00010000B, DEFAULT
	setb P1.3
	ACALL SET_RELAY
	clr P1.3
	MOV R0, #0
	MOV R1, #0
	MOV R2, #0
    RET
  DEFAULT:  RET
  
//------------------------------------
//  3 DIGIT 7SEG LED
//------------------------------------
DISPLAY:
DIGIT2:
  CLR P12
  MOV A, R2
  MOVC A, @A+DPTR
  MOV P0, A
  SETB P10 ; DIGIT2 ON
DIGIT1:
  CLR P10
  MOV A, R1
  MOVC A, @A+DPTR
  MOV P0, A
  SETB P11 ; DIGIT1 ON
DIGIT0:
  CLR P11 
  MOV A, R0
  MOVC A, @A+DPTR
  MOV P0, A
  SETB P12 ; DIGIT0 ON
RET

//------------------------------------
//  GIVING DELAY TO THE RELAY
//------------------------------------	
SET_RELAY:	

	CJNE R2, #0, M2
C1:	CJNE R1, #0, M1
C0:	CJNE R0, #0, M0
	RET 
M2:	MOV R7,#100
	L3:	MOV A, R2
		MOV R6, A
	SL3: ACALL MIN_DELAY
		 DJNZ R6, SL3
		 DJNZ R7, L3
	SJMP C1
		 
M1:	MOV R7,#10
	L2:	MOV A, R1
		MOV R6, A
	SL2: ACALL MIN_DELAY
		 DJNZ R6, SL2
		 DJNZ R7, L2
	SJMP C0
	
M0:	MOV A, R0
	MOV R6, A
	SL1: ACALL MIN_DELAY
		 DJNZ R6, SL1
	RET
	
; 1 MINUTE DELAY FOR THE 16MHZ FREQUENCY OF N76E003
MIN_DELAY:
			MOV R5, #60
	ML2:	MOV R4, #25
	ML1:	MOV TMOD, #10H
			MOV TH1, #02FH
			MOV TL1, #0A7H
			SETB TR1
			HERE:	MOV R0, #10
				MOV R1, #10
				MOV R2, #10
				ACALL DISPLAY
				JNB TF1, HERE
			CLR TR1
			CLR TF1
			DJNZ R4, ML1
			DJNZ R5, ML2
	RET
//----------------------------------
// SEGMENT DATA
SEG_DATA:
  DB 0C0H, 0F9H, 0A4H, 0B0H, 99H, 92H, 82H, 0F8H, 80H, 90H , 0BFH
END