#include <stdint.h>
#define AHB_LED_BASE	0x50000000
#define LED  *(unsigned int *)AHB_LED_BASE
void delay_ms(int t)
{
	int i=12000;
	 while(t--)
	 {
   for(;i>=0;i--);
	 }
}
int main(void)
{
    //static uint32_t i = 0;
    // while(1){
    //    i++;
    //}
	  while(1)
		{
	    LED = 0x55;
			delay_ms(300);
			LED=~LED;
		}
}

