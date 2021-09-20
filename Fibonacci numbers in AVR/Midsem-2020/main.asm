;
; Midsem-2020.asm
;
; Created: 11/2/2020 2:22:21 PM
;														EE2016 MIDSEM PARTB
;													Author : KATARI HARI CHANDAN
;													ROLL NO: EE19B032


; Replace with your application code



.CSEG
 LDI ZL, LOW(N << 1);		Pointer z in register memory takes the address of the input N.
 LDI ZH, HIGH(N << 1);
 LDI XL, 0X60;				Let Fibonacci series start from adress location $0060.
 LDI XH, 0X00;
 LDI YL, 0X61;				
 LDI YH, 0X00;
 LPM R20, Z;				We have assigned the input number(N) to a general register R20.
 LDI ZL, 0X62;
 LDI ZH, 0X00;				X,Y,Z are given consecutive locations so that F(n+2) is stored in Z, F(n+1) is stored in Y, F(n) is stored in X. By this all the numbers in the series will be in consecutive locations. 
 

 LDI R16, 0X00;				Let the starting elements of the series 0,1 be stored in R16,R17.
 LDI R17, 0X01;
 ST X,R16 ;					We are storing the value in R16,R17 in adress locations pointed by X,Y.
 ST Y,R17;
 DEC R20;					Since we already stored 1st 2 numbers is locations $0060,$0061 we have to decrement N twice because if we send the same N into the loop, we'll get 2 extra numbers which should not occur in the output. 
 DEC R20;					

 LOOP: LD R16,X+;			The loop begins here. The values in adresses pointed by X,Y are loaded into R16,R17 and pointers X,Y are incremented to point next location.  
 LD R17,Y+; 
 ADD R16,R17;				We add the 2 numbers and the result in goes to R16.
 ST Z+,R16;					The result in R16 is stored in adress pointed by Z and the pointer Z is incremented
 DEC R20;					
 BRNE LOOP;					R20 keeps on decrementing and the loop continues to execute until R20 becomes '0'.

 LDI ZL, LOW(N << 1);		Pointer z in register memory takes the address of the input N.
 LDI ZH, HIGH(N << 1);
 LDI XL, 0X60;				Again let the Fibonacci series start at adress location $0060.
 LDI XH, 0X00;
 LDI YL, 0X80;				Let the output whether the given Fibonacci number is odd or even start at adress location $0080.
 LDI YH, 0X00;
 LPM R20, Z;				We have assigned the input number(N) to a general register R20.

 REPEAT: LDI R30, 0X00;		We define a '0' in a new register. (This is for storing 1 if ODD and 2 if EVEN)
 LDI R31, 0X01;				We define a '1' in a another register. (This is for ANDing the Fibonacci number with '1'. If output of AND gate is 1, it is odd or else it is even)
 LD R18, X+;				X is incremented to get the next address location in the next loop.
 AND R18,R31;				AND gate result is stored in R18 and if it 1 then R30 IS INCREMENTED ONLY ONCE OR ELSE TWICE.
 BRNE L1;
 INC R30;
 L1: INC R30;
 ST Y+, R30;				The final value of R30( 1 or 2) is stored in Y and it is incremented to next adress.
 DEC R20;					R20 keeps on decrementing and the loop continues to execute until R20 becomes '0'.
 BRNE REPEAT;

 NOP;
 N: .DB 0X0B, 0X00;		The input which says number of Fibonacci Number we want in output. {Ensure that it is less than or equal to 14(0x000E) and greater than or equal to 3(0x0003) because it is written for single byte}