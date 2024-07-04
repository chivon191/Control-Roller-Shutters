#line 1 "D:/IUH/Nam ba/HK2/Giao tiep thiet bi ngoai vi/Project/DK cua cuon/bluetooth - Clone/bluetooth.c"
char Transmit, Receive;
int i;
void main()
{
 ADCON1=0X0F;
 CMCON=0X00;

 TRISB = 0XFF;
 PORTB = 0X00; LATB = 0X00;

 TRISC = 0XFF;
 PORTC = 0X00; LATC = 0X00;

 TRISE = 0X00;
 PORTE = 0X00; LATE = 0X00;

 TRISD = 0X00;
 PORTD = 0X00; LATD = 0X00;

 LATE0_bit = 1;
 LATD0_bit = 1;
 LATD1_bit = 1;

 UART1_Init(9600);
 delay_ms(100);

 while(1)
 {
 if(UART1_Data_Ready() == 1)
 {
 Receive = UART1_Read();
 if(Receive == 'O'&& Button(&PORTC, 2, 1, 1) && LATD0_BIT == 1)
 {
 LATD1_BIT = 0;
 LATD0_BIT = 0;
 Transmit = 'o';
 UART1_Write(Transmit);
 }
 else if(Receive == 'C'&& Button(&PORTC, 0, 1, 1) && LATD0_BIT == 1)
 {
 LATD1_BIT = 1;
 LATD0_BIT = 0;
 Transmit = 'c';
 UART1_Write(Transmit);
 }
 else if(Receive == 'S')
 {
 LATD0_BIT = 1;
 Transmit = 's';
 UART1_Write(Transmit);
 }
 if(LATD0_BIT == 0 && LATD1_bit == 0)
 {
 if(Receive == 'C')
 {
 LATE0_BIT = 1;
 LATD0_bit = 1;
 Transmit = 's';
 UART1_Write(Transmit);
 delay_ms(7000);
 LATD1_BIT = 1;
 Transmit = 'c';
 UART1_Write(Transmit);
 LATD0_BIT = 0;
 }
 }
 if(LATD0_BIT == 0 && LATD1_bit == 1)
 {
 if(Receive == 'O')
 {
 LATE0_BIT = 1;
 LATD0_bit = 1;
 Transmit = 's';
 UART1_Write(Transmit);
 delay_ms(7000);
 LATD1_BIT = 0;
 LATD0_BIT = 0;
 Transmit = 'o';
 UART1_Write(Transmit);
 }
 }
 }
 if(Button(&PORTB, 2, 1, 0))
 {
 while(Button(&PORTB, 2, 1, 0)){}
 LATD0_BIT = 1;
 Transmit = 's';
 UART1_Write(Transmit);
 delay_ms(7000);
 }
 if(Button(&PORTB, 0, 1, 0) && Button(&PORTC, 2, 1, 1) && LATD0_BIT == 1)
 {
 while(Button(&PORTB, 0, 1, 0)){}
 LATD1_BIT = 0;
 LATD0_BIT = 0;
 Transmit = 'o';
 UART1_Write(Transmit);
 }
 while(LATD0_bit == 0)
 {
 LATE0_BIT = 0;
 delay_ms(300);
 LATE0_BIT = 1;
 delay_ms(300);
 if(Button(&PORTB, 0, 1, 0)||Button(&PORTB, 1, 1, 0)||Button(&PORTB, 2, 1, 0)||Button(&PORTC, 0, 1, 0)||Button(&PORTC, 2, 1, 0)||(UART1_Data_Ready() == 1))
 break;
 }
 if(LATD1_bit == 0)
 {
 if(Button(&PORTB, 1, 1, 0))
 {
 LATE0_BIT = 1;
 LATD0_bit = 1;
 Transmit = 's';
 UART1_Write(Transmit);
 delay_ms(7000);
 LATD1_BIT = 1;
 Transmit = 'c';
 UART1_Write(Transmit);
 LATD0_BIT = 0;
 }
 else if(Button(&PORTC, 2, 1, 0))
 {
 LATD0_BIT = 1;
 Transmit = 'w';
 UART1_Write(Transmit);
 delay_ms(7000);
 }
 }
 if(Button(&PORTB, 1, 1, 0) && Button(&PORTC, 0, 1, 1) && LATD0_BIT == 1)
 {
 while(Button(&PORTB, 1, 1, 0)){}
 LATD1_BIT = 1;
 LATD0_BIT = 0;
 Transmit = 'c';
 UART1_Write(Transmit);
 }
 if(LATD1_bit == 1)
 {
 if(Button(&PORTB, 0, 1, 0))
 {
 LATE0_BIT = 1;
 LATD0_bit = 1;
 Transmit = 's';
 UART1_Write(Transmit);
 delay_ms(7000);
 LATD1_BIT = 0;
 LATD0_BIT = 0;
 Transmit = 'o';
 UART1_Write(Transmit);
 }
 else if(Button(&PORTC, 0, 1, 0))
 {
 LATE0_BIT = 1;
 LATD0_BIT = 1;
 Transmit = 'q';
 UART1_Write(Transmit);
 delay_ms(7000);
 }
 }
 }
}
