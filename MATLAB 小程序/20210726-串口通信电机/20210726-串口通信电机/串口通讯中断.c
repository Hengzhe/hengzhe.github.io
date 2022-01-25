
#include<reg52.h>                    

void InitUART  (void)
{
    EA=1;

    SCON  = 0x50;		        // SCON: 模式 1, 8-bit UART, 使能接收  
	TMOD &=0x0F;
    TMOD |= 0x20;               // TMOD: timer 1, mode 2, 8-bit 重装
    TH1   = 0xF3;               // TH1:  重装值 9600 波特率 晶振 11.0592MHz  
	TL1=TH1;
    TR1   = 1;  
    PCON=0x80;                
}                       

void main (void)
{

InitUART();

ES=1;
//SEND();

while (1);                       

}


void UART_SER (void) interrupt 4 //串行中断服务程序
{
    unsigned char Temp;          //定义临时变量 
   
                       //判断是接收中断产生
	  //RI=0;                      //标志位清零
	  Temp=SBUF;                    //把值输出到P1口，用于观察
	  RI=0;
	  P1=Temp;
	  SBUF=Temp;		  
      while(TI==0);                        //如果是发送标志位，清零
      TI=0;
} 


