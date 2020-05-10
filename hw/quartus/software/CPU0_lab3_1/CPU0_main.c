#include <stdio.h>
#include "includes.h"
#include "altera_avalon_pio_regs.h"
#include "altera_avalon_timer_regs.h"
#include "altera_avalon_mutex_regs.h"
#include <altera_avalon_mutex.h>
#include "sys/alt_irq.h"


/* Definition of Task Stacks */
#define   TASK_STACKSIZE       512
OS_STK    task_leds_stack[TASK_STACKSIZE];

#define TASK_LEDS_PRIORITY				2


#define CPU		0


#define COUNTER_PERIOD		20						// milliseconds
#define COUNTER_INCREMENT	1


#define TICK_PER_MICROSEC	50.0					// clock cycles per microsecond
#define CLOCK_FREQUENCY		50000000.0 				// Hertz
#define CLOCK_PERIOD		0.00002					// milliseconds

unsigned long milliseconds = 0;
char time_elapsed = 0;	// a flag raised every time COUNTER_PERIOD has elapsed
alt_mutex_dev* mutex;

long read_timer(long base_address);
void timer_interrupt();

void task_leds(void* pdata)
{
	unsigned long counter = 0, data = 1, timer_start, timer_end;
	while (1)
	{
		if (time_elapsed == 1)
		{

			time_elapsed = 0;

			timer_start = read_timer(CPU_0_0_TIMER_0_BASE);
			/*altera_avalon_mutex_lock( mutex, 1 );	// acquire the mutex, setting the value to three

			counter = IORD_ALTERA_AVALON_PIO_DATA(PIO_0_BASE);
			IOWR_ALTERA_AVALON_PIO_DATA(PIO_0_BASE, counter + COUNTER_INCREMENT);

			altera_avalon_mutex_unlock( mutex );	 // release the lock*/
			timer_end = read_timer(CPU_0_0_TIMER_0_BASE);

			printf("Timer reading overhead: %f us\n", (timer_start - timer_end)/TICK_PER_MICROSEC);
		}
	}
}


int main(void)
{
	// setup the parallel port to control the LEDs
	IOWR_ALTERA_AVALON_PIO_DIRECTION(PIO_0_BASE, 0xFFFFFFFF);	// sets pins as output

	// timer setup
	IOWR_ALTERA_AVALON_TIMER_CONTROL(CPU_0_0_TIMER_0_BASE, 0b0111);	// start timer, continuous mode on, interrupts active

	// register the Isr to respond to a timer overflow
	alt_ic_isr_register(CPU_0_0_TIMER_0_IRQ_INTERRUPT_CONTROLLER_ID, CPU_0_0_TIMER_0_IRQ, timer_interrupt, NULL, NULL);

	/* get the mutex device handle */
	mutex = altera_avalon_mutex_open("/dev/mutex_0");



	// creates the task which displays the counter value on the LEDs
	OSTaskCreateExt(task_leds,
                  NULL,
                  (void *)&task_leds_stack[TASK_STACKSIZE-1],
				  TASK_LEDS_PRIORITY,
				  TASK_LEDS_PRIORITY,
				  task_leds_stack,
                  TASK_STACKSIZE,
                  NULL,
                  0);
              
               
  OSStart();
  return 0;
}



// Timer Isr: every 1 ms updates the counter
void timer_interrupt()
{
	if (milliseconds < COUNTER_PERIOD)
		milliseconds++;
	else
	{
		milliseconds = 0;
		time_elapsed = 1;
	}

	IOWR_ALTERA_AVALON_TIMER_STATUS(CPU_0_0_TIMER_0_BASE, 0x0000); 	// acknowledge interrupt
}



// a function to read the value of the timer (to avoid writing this stuff every time)
long read_timer(long base_address)
{
	 long timer_LSB, timer_MSB;
	 IOWR_ALTERA_AVALON_TIMER_SNAPL(base_address, 0x00);	// necessary to update SNPL and SNAPH registers
	 timer_LSB = IORD_ALTERA_AVALON_TIMER_SNAPL(base_address);
	 timer_MSB = IORD_ALTERA_AVALON_TIMER_SNAPH(base_address);

	 return timer_LSB + (timer_MSB<<16);
}



