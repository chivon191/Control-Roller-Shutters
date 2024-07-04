
_main:

;bluetooth.c,3 :: 		void main()
;bluetooth.c,5 :: 		ADCON1=0X0F;
	MOVLW       15
	MOVWF       ADCON1+0 
;bluetooth.c,6 :: 		CMCON=0X00;
	CLRF        CMCON+0 
;bluetooth.c,8 :: 		TRISB = 0XFF;
	MOVLW       255
	MOVWF       TRISB+0 
;bluetooth.c,9 :: 		PORTB = 0X00; LATB = 0X00;
	CLRF        PORTB+0 
	CLRF        LATB+0 
;bluetooth.c,11 :: 		TRISC = 0XFF;
	MOVLW       255
	MOVWF       TRISC+0 
;bluetooth.c,12 :: 		PORTC = 0X00; LATC = 0X00;
	CLRF        PORTC+0 
	CLRF        LATC+0 
;bluetooth.c,14 :: 		TRISE = 0X00;
	CLRF        TRISE+0 
;bluetooth.c,15 :: 		PORTE = 0X00; LATE = 0X00;
	CLRF        PORTE+0 
	CLRF        LATE+0 
;bluetooth.c,17 :: 		TRISD = 0X00;
	CLRF        TRISD+0 
;bluetooth.c,18 :: 		PORTD = 0X00; LATD = 0X00;
	CLRF        PORTD+0 
	CLRF        LATD+0 
;bluetooth.c,20 :: 		LATE0_bit = 1;
	BSF         LATE0_bit+0, BitPos(LATE0_bit+0) 
;bluetooth.c,21 :: 		LATD0_bit = 1;
	BSF         LATD0_bit+0, BitPos(LATD0_bit+0) 
;bluetooth.c,22 :: 		LATD1_bit = 1;
	BSF         LATD1_bit+0, BitPos(LATD1_bit+0) 
;bluetooth.c,24 :: 		UART1_Init(9600);
	BSF         BAUDCON+0, 3, 0
	MOVLW       2
	MOVWF       SPBRGH+0 
	MOVLW       8
	MOVWF       SPBRG+0 
	BSF         TXSTA+0, 2, 0
	CALL        _UART1_Init+0, 0
;bluetooth.c,25 :: 		delay_ms(100);
	MOVLW       3
	MOVWF       R11, 0
	MOVLW       138
	MOVWF       R12, 0
	MOVLW       85
	MOVWF       R13, 0
L_main0:
	DECFSZ      R13, 1, 1
	BRA         L_main0
	DECFSZ      R12, 1, 1
	BRA         L_main0
	DECFSZ      R11, 1, 1
	BRA         L_main0
	NOP
	NOP
;bluetooth.c,27 :: 		while(1)
L_main1:
;bluetooth.c,29 :: 		if(UART1_Data_Ready() == 1)
	CALL        _UART1_Data_Ready+0, 0
	MOVF        R0, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_main3
;bluetooth.c,31 :: 		Receive = UART1_Read();
	CALL        _UART1_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _Receive+0 
;bluetooth.c,32 :: 		if(Receive == 'O'&& Button(&PORTC, 2, 1, 1) && LATD0_BIT == 1)  // openok mo
	MOVF        R0, 0 
	XORLW       79
	BTFSS       STATUS+0, 2 
	GOTO        L_main6
	MOVLW       PORTC+0
	MOVWF       FARG_Button_port+0 
	MOVLW       hi_addr(PORTC+0)
	MOVWF       FARG_Button_port+1 
	MOVLW       2
	MOVWF       FARG_Button_pin+0 
	MOVLW       1
	MOVWF       FARG_Button_time_ms+0 
	MOVLW       1
	MOVWF       FARG_Button_active_state+0 
	CALL        _Button+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_main6
	BTFSS       LATD0_bit+0, BitPos(LATD0_bit+0) 
	GOTO        L_main6
L__main62:
;bluetooth.c,34 :: 		LATD1_BIT = 0;  //quay thuan
	BCF         LATD1_bit+0, BitPos(LATD1_bit+0) 
;bluetooth.c,35 :: 		LATD0_BIT = 0;
	BCF         LATD0_bit+0, BitPos(LATD0_bit+0) 
;bluetooth.c,36 :: 		Transmit = 'o';
	MOVLW       111
	MOVWF       _Transmit+0 
;bluetooth.c,37 :: 		UART1_Write(Transmit);
	MOVLW       111
	MOVWF       FARG_UART1_Write_data_+0 
	CALL        _UART1_Write+0, 0
;bluetooth.c,38 :: 		}
	GOTO        L_main7
L_main6:
;bluetooth.c,39 :: 		else if(Receive == 'C'&& Button(&PORTC, 0, 1, 1) && LATD0_BIT == 1)  //closeok mo
	MOVF        _Receive+0, 0 
	XORLW       67
	BTFSS       STATUS+0, 2 
	GOTO        L_main10
	MOVLW       PORTC+0
	MOVWF       FARG_Button_port+0 
	MOVLW       hi_addr(PORTC+0)
	MOVWF       FARG_Button_port+1 
	CLRF        FARG_Button_pin+0 
	MOVLW       1
	MOVWF       FARG_Button_time_ms+0 
	MOVLW       1
	MOVWF       FARG_Button_active_state+0 
	CALL        _Button+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_main10
	BTFSS       LATD0_bit+0, BitPos(LATD0_bit+0) 
	GOTO        L_main10
L__main61:
;bluetooth.c,41 :: 		LATD1_BIT = 1;  //quay nguoc
	BSF         LATD1_bit+0, BitPos(LATD1_bit+0) 
;bluetooth.c,42 :: 		LATD0_BIT = 0;
	BCF         LATD0_bit+0, BitPos(LATD0_bit+0) 
;bluetooth.c,43 :: 		Transmit = 'c';
	MOVLW       99
	MOVWF       _Transmit+0 
;bluetooth.c,44 :: 		UART1_Write(Transmit);
	MOVLW       99
	MOVWF       FARG_UART1_Write_data_+0 
	CALL        _UART1_Write+0, 0
;bluetooth.c,45 :: 		}
	GOTO        L_main11
L_main10:
;bluetooth.c,46 :: 		else if(Receive == 'S')    //stop
	MOVF        _Receive+0, 0 
	XORLW       83
	BTFSS       STATUS+0, 2 
	GOTO        L_main12
;bluetooth.c,48 :: 		LATD0_BIT = 1;
	BSF         LATD0_bit+0, BitPos(LATD0_bit+0) 
;bluetooth.c,49 :: 		Transmit = 's';
	MOVLW       115
	MOVWF       _Transmit+0 
;bluetooth.c,50 :: 		UART1_Write(Transmit);
	MOVLW       115
	MOVWF       FARG_UART1_Write_data_+0 
	CALL        _UART1_Write+0, 0
;bluetooth.c,51 :: 		}
L_main12:
L_main11:
L_main7:
;bluetooth.c,52 :: 		if(LATD0_BIT == 0 && LATD1_bit == 0)   //motor dang mo
	BTFSC       LATD0_bit+0, BitPos(LATD0_bit+0) 
	GOTO        L_main15
	BTFSC       LATD1_bit+0, BitPos(LATD1_bit+0) 
	GOTO        L_main15
L__main60:
;bluetooth.c,54 :: 		if(Receive == 'C')
	MOVF        _Receive+0, 0 
	XORLW       67
	BTFSS       STATUS+0, 2 
	GOTO        L_main16
;bluetooth.c,56 :: 		LATE0_BIT = 1;   //den canh bao
	BSF         LATE0_bit+0, BitPos(LATE0_bit+0) 
;bluetooth.c,57 :: 		LATD0_bit = 1;
	BSF         LATD0_bit+0, BitPos(LATD0_bit+0) 
;bluetooth.c,58 :: 		Transmit = 's';
	MOVLW       115
	MOVWF       _Transmit+0 
;bluetooth.c,59 :: 		UART1_Write(Transmit);
	MOVLW       115
	MOVWF       FARG_UART1_Write_data_+0 
	CALL        _UART1_Write+0, 0
;bluetooth.c,60 :: 		delay_ms(7000);
	MOVLW       178
	MOVWF       R11, 0
	MOVLW       143
	MOVWF       R12, 0
	MOVLW       19
	MOVWF       R13, 0
L_main17:
	DECFSZ      R13, 1, 1
	BRA         L_main17
	DECFSZ      R12, 1, 1
	BRA         L_main17
	DECFSZ      R11, 1, 1
	BRA         L_main17
;bluetooth.c,61 :: 		LATD1_BIT = 1;  //quay nguoc
	BSF         LATD1_bit+0, BitPos(LATD1_bit+0) 
;bluetooth.c,62 :: 		Transmit = 'c';
	MOVLW       99
	MOVWF       _Transmit+0 
;bluetooth.c,63 :: 		UART1_Write(Transmit);
	MOVLW       99
	MOVWF       FARG_UART1_Write_data_+0 
	CALL        _UART1_Write+0, 0
;bluetooth.c,64 :: 		LATD0_BIT = 0;
	BCF         LATD0_bit+0, BitPos(LATD0_bit+0) 
;bluetooth.c,65 :: 		}
L_main16:
;bluetooth.c,66 :: 		}
L_main15:
;bluetooth.c,67 :: 		if(LATD0_BIT == 0 && LATD1_bit == 1)  //motor dang dong
	BTFSC       LATD0_bit+0, BitPos(LATD0_bit+0) 
	GOTO        L_main20
	BTFSS       LATD1_bit+0, BitPos(LATD1_bit+0) 
	GOTO        L_main20
L__main59:
;bluetooth.c,69 :: 		if(Receive == 'O')
	MOVF        _Receive+0, 0 
	XORLW       79
	BTFSS       STATUS+0, 2 
	GOTO        L_main21
;bluetooth.c,71 :: 		LATE0_BIT = 1;
	BSF         LATE0_bit+0, BitPos(LATE0_bit+0) 
;bluetooth.c,72 :: 		LATD0_bit = 1;
	BSF         LATD0_bit+0, BitPos(LATD0_bit+0) 
;bluetooth.c,73 :: 		Transmit = 's';
	MOVLW       115
	MOVWF       _Transmit+0 
;bluetooth.c,74 :: 		UART1_Write(Transmit);
	MOVLW       115
	MOVWF       FARG_UART1_Write_data_+0 
	CALL        _UART1_Write+0, 0
;bluetooth.c,75 :: 		delay_ms(7000);
	MOVLW       178
	MOVWF       R11, 0
	MOVLW       143
	MOVWF       R12, 0
	MOVLW       19
	MOVWF       R13, 0
L_main22:
	DECFSZ      R13, 1, 1
	BRA         L_main22
	DECFSZ      R12, 1, 1
	BRA         L_main22
	DECFSZ      R11, 1, 1
	BRA         L_main22
;bluetooth.c,76 :: 		LATD1_BIT = 0;
	BCF         LATD1_bit+0, BitPos(LATD1_bit+0) 
;bluetooth.c,77 :: 		LATD0_BIT = 0;
	BCF         LATD0_bit+0, BitPos(LATD0_bit+0) 
;bluetooth.c,78 :: 		Transmit = 'o';
	MOVLW       111
	MOVWF       _Transmit+0 
;bluetooth.c,79 :: 		UART1_Write(Transmit);
	MOVLW       111
	MOVWF       FARG_UART1_Write_data_+0 
	CALL        _UART1_Write+0, 0
;bluetooth.c,80 :: 		}
L_main21:
;bluetooth.c,81 :: 		}
L_main20:
;bluetooth.c,82 :: 		}
L_main3:
;bluetooth.c,83 :: 		if(Button(&PORTB, 2, 1, 0))    //stop
	MOVLW       PORTB+0
	MOVWF       FARG_Button_port+0 
	MOVLW       hi_addr(PORTB+0)
	MOVWF       FARG_Button_port+1 
	MOVLW       2
	MOVWF       FARG_Button_pin+0 
	MOVLW       1
	MOVWF       FARG_Button_time_ms+0 
	CLRF        FARG_Button_active_state+0 
	CALL        _Button+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_main23
;bluetooth.c,85 :: 		while(Button(&PORTB, 2, 1, 0)){}
L_main24:
	MOVLW       PORTB+0
	MOVWF       FARG_Button_port+0 
	MOVLW       hi_addr(PORTB+0)
	MOVWF       FARG_Button_port+1 
	MOVLW       2
	MOVWF       FARG_Button_pin+0 
	MOVLW       1
	MOVWF       FARG_Button_time_ms+0 
	CLRF        FARG_Button_active_state+0 
	CALL        _Button+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_main25
	GOTO        L_main24
L_main25:
;bluetooth.c,86 :: 		LATD0_BIT = 1;
	BSF         LATD0_bit+0, BitPos(LATD0_bit+0) 
;bluetooth.c,87 :: 		Transmit = 's';
	MOVLW       115
	MOVWF       _Transmit+0 
;bluetooth.c,88 :: 		UART1_Write(Transmit);
	MOVLW       115
	MOVWF       FARG_UART1_Write_data_+0 
	CALL        _UART1_Write+0, 0
;bluetooth.c,89 :: 		delay_ms(7000);
	MOVLW       178
	MOVWF       R11, 0
	MOVLW       143
	MOVWF       R12, 0
	MOVLW       19
	MOVWF       R13, 0
L_main26:
	DECFSZ      R13, 1, 1
	BRA         L_main26
	DECFSZ      R12, 1, 1
	BRA         L_main26
	DECFSZ      R11, 1, 1
	BRA         L_main26
;bluetooth.c,90 :: 		}
L_main23:
;bluetooth.c,91 :: 		if(Button(&PORTB, 0, 1, 0) && Button(&PORTC, 2, 1, 1) && LATD0_BIT == 1)  //open, openok, motor dung
	MOVLW       PORTB+0
	MOVWF       FARG_Button_port+0 
	MOVLW       hi_addr(PORTB+0)
	MOVWF       FARG_Button_port+1 
	CLRF        FARG_Button_pin+0 
	MOVLW       1
	MOVWF       FARG_Button_time_ms+0 
	CLRF        FARG_Button_active_state+0 
	CALL        _Button+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_main29
	MOVLW       PORTC+0
	MOVWF       FARG_Button_port+0 
	MOVLW       hi_addr(PORTC+0)
	MOVWF       FARG_Button_port+1 
	MOVLW       2
	MOVWF       FARG_Button_pin+0 
	MOVLW       1
	MOVWF       FARG_Button_time_ms+0 
	MOVLW       1
	MOVWF       FARG_Button_active_state+0 
	CALL        _Button+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_main29
	BTFSS       LATD0_bit+0, BitPos(LATD0_bit+0) 
	GOTO        L_main29
L__main58:
;bluetooth.c,93 :: 		while(Button(&PORTB, 0, 1, 0)){}
L_main30:
	MOVLW       PORTB+0
	MOVWF       FARG_Button_port+0 
	MOVLW       hi_addr(PORTB+0)
	MOVWF       FARG_Button_port+1 
	CLRF        FARG_Button_pin+0 
	MOVLW       1
	MOVWF       FARG_Button_time_ms+0 
	CLRF        FARG_Button_active_state+0 
	CALL        _Button+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_main31
	GOTO        L_main30
L_main31:
;bluetooth.c,94 :: 		LATD1_BIT = 0;
	BCF         LATD1_bit+0, BitPos(LATD1_bit+0) 
;bluetooth.c,95 :: 		LATD0_BIT = 0;
	BCF         LATD0_bit+0, BitPos(LATD0_bit+0) 
;bluetooth.c,96 :: 		Transmit = 'o';
	MOVLW       111
	MOVWF       _Transmit+0 
;bluetooth.c,97 :: 		UART1_Write(Transmit);
	MOVLW       111
	MOVWF       FARG_UART1_Write_data_+0 
	CALL        _UART1_Write+0, 0
;bluetooth.c,98 :: 		}
L_main29:
;bluetooth.c,99 :: 		while(LATD0_bit == 0)
L_main32:
	BTFSC       LATD0_bit+0, BitPos(LATD0_bit+0) 
	GOTO        L_main33
;bluetooth.c,101 :: 		LATE0_BIT = 0;
	BCF         LATE0_bit+0, BitPos(LATE0_bit+0) 
;bluetooth.c,102 :: 		delay_ms(300);
	MOVLW       8
	MOVWF       R11, 0
	MOVLW       157
	MOVWF       R12, 0
	MOVLW       5
	MOVWF       R13, 0
L_main34:
	DECFSZ      R13, 1, 1
	BRA         L_main34
	DECFSZ      R12, 1, 1
	BRA         L_main34
	DECFSZ      R11, 1, 1
	BRA         L_main34
	NOP
	NOP
;bluetooth.c,103 :: 		LATE0_BIT = 1;
	BSF         LATE0_bit+0, BitPos(LATE0_bit+0) 
;bluetooth.c,104 :: 		delay_ms(300);
	MOVLW       8
	MOVWF       R11, 0
	MOVLW       157
	MOVWF       R12, 0
	MOVLW       5
	MOVWF       R13, 0
L_main35:
	DECFSZ      R13, 1, 1
	BRA         L_main35
	DECFSZ      R12, 1, 1
	BRA         L_main35
	DECFSZ      R11, 1, 1
	BRA         L_main35
	NOP
	NOP
;bluetooth.c,105 :: 		if(Button(&PORTB, 0, 1, 0)||Button(&PORTB, 1, 1, 0)||Button(&PORTB, 2, 1, 0)||Button(&PORTC, 0, 1, 0)||Button(&PORTC, 2, 1, 0)||(UART1_Data_Ready() == 1))
	MOVLW       PORTB+0
	MOVWF       FARG_Button_port+0 
	MOVLW       hi_addr(PORTB+0)
	MOVWF       FARG_Button_port+1 
	CLRF        FARG_Button_pin+0 
	MOVLW       1
	MOVWF       FARG_Button_time_ms+0 
	CLRF        FARG_Button_active_state+0 
	CALL        _Button+0, 0
	MOVF        R0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L__main57
	MOVLW       PORTB+0
	MOVWF       FARG_Button_port+0 
	MOVLW       hi_addr(PORTB+0)
	MOVWF       FARG_Button_port+1 
	MOVLW       1
	MOVWF       FARG_Button_pin+0 
	MOVLW       1
	MOVWF       FARG_Button_time_ms+0 
	CLRF        FARG_Button_active_state+0 
	CALL        _Button+0, 0
	MOVF        R0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L__main57
	MOVLW       PORTB+0
	MOVWF       FARG_Button_port+0 
	MOVLW       hi_addr(PORTB+0)
	MOVWF       FARG_Button_port+1 
	MOVLW       2
	MOVWF       FARG_Button_pin+0 
	MOVLW       1
	MOVWF       FARG_Button_time_ms+0 
	CLRF        FARG_Button_active_state+0 
	CALL        _Button+0, 0
	MOVF        R0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L__main57
	MOVLW       PORTC+0
	MOVWF       FARG_Button_port+0 
	MOVLW       hi_addr(PORTC+0)
	MOVWF       FARG_Button_port+1 
	CLRF        FARG_Button_pin+0 
	MOVLW       1
	MOVWF       FARG_Button_time_ms+0 
	CLRF        FARG_Button_active_state+0 
	CALL        _Button+0, 0
	MOVF        R0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L__main57
	MOVLW       PORTC+0
	MOVWF       FARG_Button_port+0 
	MOVLW       hi_addr(PORTC+0)
	MOVWF       FARG_Button_port+1 
	MOVLW       2
	MOVWF       FARG_Button_pin+0 
	MOVLW       1
	MOVWF       FARG_Button_time_ms+0 
	CLRF        FARG_Button_active_state+0 
	CALL        _Button+0, 0
	MOVF        R0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L__main57
	CALL        _UART1_Data_Ready+0, 0
	MOVF        R0, 0 
	XORLW       1
	BTFSC       STATUS+0, 2 
	GOTO        L__main57
	GOTO        L_main38
L__main57:
;bluetooth.c,106 :: 		break;   // co tac dong tu nut nhan, thoat vong lap
	GOTO        L_main33
L_main38:
;bluetooth.c,107 :: 		}
	GOTO        L_main32
L_main33:
;bluetooth.c,108 :: 		if(LATD1_bit == 0)  //led chieu mo
	BTFSC       LATD1_bit+0, BitPos(LATD1_bit+0) 
	GOTO        L_main39
;bluetooth.c,110 :: 		if(Button(&PORTB, 1, 1, 0)) //close
	MOVLW       PORTB+0
	MOVWF       FARG_Button_port+0 
	MOVLW       hi_addr(PORTB+0)
	MOVWF       FARG_Button_port+1 
	MOVLW       1
	MOVWF       FARG_Button_pin+0 
	MOVLW       1
	MOVWF       FARG_Button_time_ms+0 
	CLRF        FARG_Button_active_state+0 
	CALL        _Button+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_main40
;bluetooth.c,112 :: 		LATE0_BIT = 1;
	BSF         LATE0_bit+0, BitPos(LATE0_bit+0) 
;bluetooth.c,113 :: 		LATD0_bit = 1;
	BSF         LATD0_bit+0, BitPos(LATD0_bit+0) 
;bluetooth.c,114 :: 		Transmit = 's';
	MOVLW       115
	MOVWF       _Transmit+0 
;bluetooth.c,115 :: 		UART1_Write(Transmit);
	MOVLW       115
	MOVWF       FARG_UART1_Write_data_+0 
	CALL        _UART1_Write+0, 0
;bluetooth.c,116 :: 		delay_ms(7000);
	MOVLW       178
	MOVWF       R11, 0
	MOVLW       143
	MOVWF       R12, 0
	MOVLW       19
	MOVWF       R13, 0
L_main41:
	DECFSZ      R13, 1, 1
	BRA         L_main41
	DECFSZ      R12, 1, 1
	BRA         L_main41
	DECFSZ      R11, 1, 1
	BRA         L_main41
;bluetooth.c,117 :: 		LATD1_BIT = 1;
	BSF         LATD1_bit+0, BitPos(LATD1_bit+0) 
;bluetooth.c,118 :: 		Transmit = 'c';
	MOVLW       99
	MOVWF       _Transmit+0 
;bluetooth.c,119 :: 		UART1_Write(Transmit);
	MOVLW       99
	MOVWF       FARG_UART1_Write_data_+0 
	CALL        _UART1_Write+0, 0
;bluetooth.c,120 :: 		LATD0_BIT = 0;
	BCF         LATD0_bit+0, BitPos(LATD0_bit+0) 
;bluetooth.c,121 :: 		}
	GOTO        L_main42
L_main40:
;bluetooth.c,122 :: 		else if(Button(&PORTC, 2, 1, 0))   //closeok
	MOVLW       PORTC+0
	MOVWF       FARG_Button_port+0 
	MOVLW       hi_addr(PORTC+0)
	MOVWF       FARG_Button_port+1 
	MOVLW       2
	MOVWF       FARG_Button_pin+0 
	MOVLW       1
	MOVWF       FARG_Button_time_ms+0 
	CLRF        FARG_Button_active_state+0 
	CALL        _Button+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_main43
;bluetooth.c,124 :: 		LATD0_BIT = 1;
	BSF         LATD0_bit+0, BitPos(LATD0_bit+0) 
;bluetooth.c,125 :: 		Transmit = 'w';
	MOVLW       119
	MOVWF       _Transmit+0 
;bluetooth.c,126 :: 		UART1_Write(Transmit);
	MOVLW       119
	MOVWF       FARG_UART1_Write_data_+0 
	CALL        _UART1_Write+0, 0
;bluetooth.c,127 :: 		delay_ms(7000);
	MOVLW       178
	MOVWF       R11, 0
	MOVLW       143
	MOVWF       R12, 0
	MOVLW       19
	MOVWF       R13, 0
L_main44:
	DECFSZ      R13, 1, 1
	BRA         L_main44
	DECFSZ      R12, 1, 1
	BRA         L_main44
	DECFSZ      R11, 1, 1
	BRA         L_main44
;bluetooth.c,128 :: 		}
L_main43:
L_main42:
;bluetooth.c,129 :: 		}
L_main39:
;bluetooth.c,130 :: 		if(Button(&PORTB, 1, 1, 0) && Button(&PORTC, 0, 1, 1) && LATD0_BIT == 1)  //close, closeok, motor
	MOVLW       PORTB+0
	MOVWF       FARG_Button_port+0 
	MOVLW       hi_addr(PORTB+0)
	MOVWF       FARG_Button_port+1 
	MOVLW       1
	MOVWF       FARG_Button_pin+0 
	MOVLW       1
	MOVWF       FARG_Button_time_ms+0 
	CLRF        FARG_Button_active_state+0 
	CALL        _Button+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_main47
	MOVLW       PORTC+0
	MOVWF       FARG_Button_port+0 
	MOVLW       hi_addr(PORTC+0)
	MOVWF       FARG_Button_port+1 
	CLRF        FARG_Button_pin+0 
	MOVLW       1
	MOVWF       FARG_Button_time_ms+0 
	MOVLW       1
	MOVWF       FARG_Button_active_state+0 
	CALL        _Button+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_main47
	BTFSS       LATD0_bit+0, BitPos(LATD0_bit+0) 
	GOTO        L_main47
L__main56:
;bluetooth.c,132 :: 		while(Button(&PORTB, 1, 1, 0)){}
L_main48:
	MOVLW       PORTB+0
	MOVWF       FARG_Button_port+0 
	MOVLW       hi_addr(PORTB+0)
	MOVWF       FARG_Button_port+1 
	MOVLW       1
	MOVWF       FARG_Button_pin+0 
	MOVLW       1
	MOVWF       FARG_Button_time_ms+0 
	CLRF        FARG_Button_active_state+0 
	CALL        _Button+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_main49
	GOTO        L_main48
L_main49:
;bluetooth.c,133 :: 		LATD1_BIT = 1;
	BSF         LATD1_bit+0, BitPos(LATD1_bit+0) 
;bluetooth.c,134 :: 		LATD0_BIT = 0;
	BCF         LATD0_bit+0, BitPos(LATD0_bit+0) 
;bluetooth.c,135 :: 		Transmit = 'c';
	MOVLW       99
	MOVWF       _Transmit+0 
;bluetooth.c,136 :: 		UART1_Write(Transmit);
	MOVLW       99
	MOVWF       FARG_UART1_Write_data_+0 
	CALL        _UART1_Write+0, 0
;bluetooth.c,137 :: 		}
L_main47:
;bluetooth.c,138 :: 		if(LATD1_bit == 1) //chieu dong
	BTFSS       LATD1_bit+0, BitPos(LATD1_bit+0) 
	GOTO        L_main50
;bluetooth.c,140 :: 		if(Button(&PORTB, 0, 1, 0))  //open
	MOVLW       PORTB+0
	MOVWF       FARG_Button_port+0 
	MOVLW       hi_addr(PORTB+0)
	MOVWF       FARG_Button_port+1 
	CLRF        FARG_Button_pin+0 
	MOVLW       1
	MOVWF       FARG_Button_time_ms+0 
	CLRF        FARG_Button_active_state+0 
	CALL        _Button+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_main51
;bluetooth.c,142 :: 		LATE0_BIT = 1;
	BSF         LATE0_bit+0, BitPos(LATE0_bit+0) 
;bluetooth.c,143 :: 		LATD0_bit = 1;
	BSF         LATD0_bit+0, BitPos(LATD0_bit+0) 
;bluetooth.c,144 :: 		Transmit = 's';
	MOVLW       115
	MOVWF       _Transmit+0 
;bluetooth.c,145 :: 		UART1_Write(Transmit);   //dung
	MOVLW       115
	MOVWF       FARG_UART1_Write_data_+0 
	CALL        _UART1_Write+0, 0
;bluetooth.c,146 :: 		delay_ms(7000);
	MOVLW       178
	MOVWF       R11, 0
	MOVLW       143
	MOVWF       R12, 0
	MOVLW       19
	MOVWF       R13, 0
L_main52:
	DECFSZ      R13, 1, 1
	BRA         L_main52
	DECFSZ      R12, 1, 1
	BRA         L_main52
	DECFSZ      R11, 1, 1
	BRA         L_main52
;bluetooth.c,147 :: 		LATD1_BIT = 0;
	BCF         LATD1_bit+0, BitPos(LATD1_bit+0) 
;bluetooth.c,148 :: 		LATD0_BIT = 0;
	BCF         LATD0_bit+0, BitPos(LATD0_bit+0) 
;bluetooth.c,149 :: 		Transmit = 'o';
	MOVLW       111
	MOVWF       _Transmit+0 
;bluetooth.c,150 :: 		UART1_Write(Transmit);
	MOVLW       111
	MOVWF       FARG_UART1_Write_data_+0 
	CALL        _UART1_Write+0, 0
;bluetooth.c,151 :: 		}
	GOTO        L_main53
L_main51:
;bluetooth.c,152 :: 		else if(Button(&PORTC, 0, 1, 0))  //openok
	MOVLW       PORTC+0
	MOVWF       FARG_Button_port+0 
	MOVLW       hi_addr(PORTC+0)
	MOVWF       FARG_Button_port+1 
	CLRF        FARG_Button_pin+0 
	MOVLW       1
	MOVWF       FARG_Button_time_ms+0 
	CLRF        FARG_Button_active_state+0 
	CALL        _Button+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_main54
;bluetooth.c,154 :: 		LATE0_BIT = 1;
	BSF         LATE0_bit+0, BitPos(LATE0_bit+0) 
;bluetooth.c,155 :: 		LATD0_BIT = 1;
	BSF         LATD0_bit+0, BitPos(LATD0_bit+0) 
;bluetooth.c,156 :: 		Transmit = 'q';
	MOVLW       113
	MOVWF       _Transmit+0 
;bluetooth.c,157 :: 		UART1_Write(Transmit);
	MOVLW       113
	MOVWF       FARG_UART1_Write_data_+0 
	CALL        _UART1_Write+0, 0
;bluetooth.c,158 :: 		delay_ms(7000);
	MOVLW       178
	MOVWF       R11, 0
	MOVLW       143
	MOVWF       R12, 0
	MOVLW       19
	MOVWF       R13, 0
L_main55:
	DECFSZ      R13, 1, 1
	BRA         L_main55
	DECFSZ      R12, 1, 1
	BRA         L_main55
	DECFSZ      R11, 1, 1
	BRA         L_main55
;bluetooth.c,159 :: 		}
L_main54:
L_main53:
;bluetooth.c,160 :: 		}
L_main50:
;bluetooth.c,161 :: 		}
	GOTO        L_main1
;bluetooth.c,162 :: 		}
L_end_main:
	GOTO        $+0
; end of _main
