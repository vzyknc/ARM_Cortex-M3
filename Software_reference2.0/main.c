
#define AHB_LED_BASE 0x50000000
#define AHB_BUTTON 0x51000000

void delay(unsigned int x)
{
		unsigned int i,j;
	for(i=x;i>0;i--)
		for(j=200;j>0;j--);
}

void mode0()
{
	*(unsigned int*) AHB_LED_BASE = 0xff;
}	

void mode1()
{
	unsigned char cnt = 0;
	*(unsigned int*) AHB_LED_BASE = 0x01;
	delay(2000);
	for(;cnt<=7;cnt++)
	{
		*(unsigned int*) AHB_LED_BASE = *(unsigned int*) AHB_LED_BASE << 1 ;
		delay(2000);
	}
	cnt = 0;
}

void mode2()
{
	unsigned char cnt = 0;
	*(unsigned int*) AHB_LED_BASE = 0x80;
	delay(2000);
	for(;cnt<=7;cnt++)
	{
		*(unsigned int*) AHB_LED_BASE = *(unsigned int*) AHB_LED_BASE >> 1 ;
		delay(2000);
	}
	cnt = 0;
}

void mode3()
{
		delay(2500);
	*(unsigned int*) AHB_LED_BASE = 0x00;
		delay(2500);
		*(unsigned int*) AHB_LED_BASE = 0xff;
}

int main(void)
{
    unsigned char  i = 0;
    while(1)
{
    if(*(unsigned int*) AHB_BUTTON == 0x00)
		{
			mode0();
		}
		else if(*(unsigned int*) AHB_BUTTON == 0x01)	
		{	
			mode1();
    }
		else if(*(unsigned int*) AHB_BUTTON == 0x02)
		{
			mode2();
		}
		else if(*(unsigned int*) AHB_BUTTON == 0x03)
		{
			mode3();
		}
		else *(unsigned int*) AHB_LED_BASE = 0x00;
}
}
