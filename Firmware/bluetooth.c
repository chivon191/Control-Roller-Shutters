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
             if(Receive == 'O'&& Button(&PORTC, 2, 1, 1) && LATD0_BIT == 1)  // openok mo
             {
               LATD1_BIT = 0;  //quay thuan
               LATD0_BIT = 0;
               Transmit = 'o';
               UART1_Write(Transmit);
             }
             else if(Receive == 'C'&& Button(&PORTC, 0, 1, 1) && LATD0_BIT == 1)  //closeok mo
             {
                 LATD1_BIT = 1;  //quay nguoc
                 LATD0_BIT = 0;
                 Transmit = 'c';
                 UART1_Write(Transmit);
             }
             else if(Receive == 'S')    //stop
             {
               LATD0_BIT = 1;
               Transmit = 's';
               UART1_Write(Transmit);
             }
             if(LATD0_BIT == 0 && LATD1_bit == 0)   //motor dang mo
             {
               if(Receive == 'C')
               {
                 LATE0_BIT = 1;   //den canh bao
                 LATD0_bit = 1;
                 Transmit = 's';
                 UART1_Write(Transmit);
                 delay_ms(7000);
                 LATD1_BIT = 1;  //quay nguoc
                 Transmit = 'c';
                 UART1_Write(Transmit);
                 LATD0_BIT = 0;
               }
             }
             if(LATD0_BIT == 0 && LATD1_bit == 1)  //motor dang dong
             {
               if(Receive == 'O')
               {
                 LATE0_BIT = 1;
                 LATD0_bit = 1;
                 Transmit = 's';
                 UART1_Write(Transmit);
                 delay_ms(7000);
                 LATD1_BIT = 0;  //dao chieu
                 LATD0_BIT = 0;
                 Transmit = 'o';
                 UART1_Write(Transmit);
               }
             }
          }
            if(Button(&PORTB, 2, 1, 0))    //stop
             {
               while(Button(&PORTB, 2, 1, 0)){}
               LATD0_BIT = 1;
               Transmit = 's';
               UART1_Write(Transmit);
               delay_ms(7000);
             }
             if(Button(&PORTB, 0, 1, 0) && Button(&PORTC, 2, 1, 1) && LATD0_BIT == 1)  //open, openok, motor dung
             {
               while(Button(&PORTB, 0, 1, 0)){}
               LATD1_BIT = 0;    //quay thuan
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
                        break;   // co tac dong tu nut nhan, thoat vong lap
             }
             if(LATD1_bit == 0)  //dang mo
            {
               if(Button(&PORTB, 1, 1, 0)) //close
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
               else if(Button(&PORTC, 2, 1, 0))   //closeok
               {
                  LATD0_BIT = 1;
                  Transmit = 'w';
                  UART1_Write(Transmit);
                  delay_ms(7000);
               }
             }
             if(Button(&PORTB, 1, 1, 0) && Button(&PORTC, 0, 1, 1) && LATD0_BIT == 1)  //close, closeok, motor
             {
                 while(Button(&PORTB, 1, 1, 0)){}
                 LATD1_BIT = 1; //quay nguoc
                 LATD0_BIT = 0;
                 Transmit = 'c';
                 UART1_Write(Transmit);
             }
             if(LATD1_bit == 1) //chieu dong
             {
               if(Button(&PORTB, 0, 1, 0))  //open
               {
                 LATE0_BIT = 1;
                 LATD0_bit = 1;
                 Transmit = 's';
                 UART1_Write(Transmit);   //dung
                 delay_ms(7000);
                 LATD1_BIT = 0;
                 LATD0_BIT = 0;
                 Transmit = 'o';
                 UART1_Write(Transmit);
               }
               else if(Button(&PORTC, 0, 1, 0))  //openok
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