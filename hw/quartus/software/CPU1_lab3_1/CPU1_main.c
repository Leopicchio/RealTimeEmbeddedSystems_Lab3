#include <stdio.h>
#include "includes.h"
#include "altera_avalon_pio_regs.h"
#include "altera_avalon_timer_regs.h"
#include "altera_avalon_mutex_regs.h"
#include <altera_avalon_mutex.h>
#include "altera_avalon_mailbox_simple.h"
#include "altera_avalon_mailbox_simple_regs.h"
#include "system.h"
#include "sys/alt_irq.h"


/* Definition of Task Stacks */
#define   TASK_STACKSIZE       512
OS_STK    task_leds_stack[TASK_STACKSIZE];

#define TASK_LEDS_PRIORITY				2


#define CPU		1


#define COUNTER_PERIOD		10						// milliseconds
#define COUNTER_INCREMENT	-1



#define CLOCK_FREQUENCY		50000000 					// Hertz
#define CLOCK_PERIOD		0.00002						// milliseconds


#define IRESETVAL  0
//Change the values if your register map is different than here
#define ICOUNTER   0
#define IRZ        1
#define ISTART     2
#define ISTOP      3
#define IIRQEN     4
#define ICLREOT    5
#define RESETVAL   0XFF000000
//Counter starts counting from this value
#define IRQENVAL   1
#define IRQDISVAL  0
#define CLREOTVAL  1
#define ARBITVAL   0X0000FFFF
//Arbitrary writedata value used for addresses 1,2,3
#define SPECIFIC_COUNTER_0_BASE CUSTOM_COUNTER_0_BASE



unsigned long milliseconds = 0;
char time_elapsed = 0;	// a flag raised every time COUNTER_PERIOD has elapsed
alt_mutex_dev* mutex;

alt_u32* message[2];
int timeout     = 1000000;
altera_avalon_mailbox_dev* mailbox;

long read_timer(long base_address);
void timer_interrupt();

void rx_cb (void* message) {
	alt_u32* data;
	data = message;
	if (message!= NULL) {
		printf("Message received");
	} else {
	  printf("Incomplete receive");
	}
}

void test_counter()
	{  IOWR(SPECIFIC_COUNTER_0_BASE, IRESETVAL, RESETVAL);
	//Reset value is loaded
	IOWR(SPECIFIC_COUNTER_0_BASE, IRZ, ARBITVAL);
	//Reset activated to load the counter with the reset value
	printf("iCounter after reset= %x\n",IORD(SPECIFIC_COUNTER_0_BASE, ICOUNTER));
	//Check that counter is loaded with the reset value
	IOWR(SPECIFIC_COUNTER_0_BASE, ISTART, ARBITVAL);
	//Start the counter
	printf("iCounter after start= %x\n",IORD(SPECIFIC_COUNTER_0_BASE, ICOUNTER));
	//Read a value from the running counter
	IOWR(SPECIFIC_COUNTER_0_BASE, ISTOP, ARBITVAL);
	printf("iCounter after stop1= %x\n",IORD(SPECIFIC_COUNTER_0_BASE, ICOUNTER));
	printf("iCounter after stop2= %x\n",IORD(SPECIFIC_COUNTER_0_BASE, ICOUNTER));
	//Two consecutive reads to test that the counter is stopped. They should give    the same result
	IOWR(SPECIFIC_COUNTER_0_BASE, ISTART, ARBITVAL);
	//Restart the counter
	printf("iCounter after restart1= %x\n",IORD(SPECIFIC_COUNTER_0_BASE,ICOUNTER));
	printf("iCounter after restart2= %x\n",IORD(SPECIFIC_COUNTER_0_BASE,ICOUNTER));
	//Two consecutive reads to test that the counter is stopped. They should give different results
	IOWR(SPECIFIC_COUNTER_0_BASE, ISTOP, ARBITVAL);
}





void task_leds(void* pdata)
{
	unsigned long counter = 0, data = 1, blink = 0;
	while (1)
	{
		if (time_elapsed == 1)
		{
			//printf("CPU 1 %d\n", counter++);
			time_elapsed = 0;

			altera_avalon_mutex_lock( mutex, 1 );	// acquire the mutex, setting the value to three

			counter = IORD_ALTERA_AVALON_PIO_DATA(PIO_0_BASE);
			IOWR_ALTERA_AVALON_PIO_DATA(PIO_0_BASE, counter + COUNTER_INCREMENT);

			altera_avalon_mutex_unlock( mutex );	 // release the lock
		}
	}
}


int main(void)
{
	// setup the parallel port to control the LEDs
	IOWR_ALTERA_AVALON_PIO_DIRECTION(PIO_0_BASE, 0xFFFFFFFF);	// sets pins as output

	// timer setup
	IOWR_ALTERA_AVALON_TIMER_CONTROL(CPU_1_0_TIMER_0_BASE, 0b0111);	// start timer, continuous mode on, interrupts active

	// register the Isr to respond to a timer overflow
	alt_ic_isr_register(CPU_1_0_TIMER_0_IRQ_INTERRUPT_CONTROLLER_ID, CPU_1_0_TIMER_0_IRQ, timer_interrupt, NULL, NULL);

	/* get the mutex device handle */
	mutex = altera_avalon_mutex_open("/dev/mutex_0");

	test_counter();

//		while(1)
//		{
//	mailbox = altera_avalon_mailbox_open("/dev/mailbox_simple_0", NULL, rx_cb);
//			if (!mailbox){
//				printf ("FAIL: Unable to open mailbox_simple");
//				return 1;
//			}
//		/* For interrupt disable system */
//		altera_avalon_mailbox_retrieve_poll (mailbox,message, timeout);
//
//		if (message == NULL){
//		printf("Receive Error");}
//		else{
//		printf("Message received with Command 0x%x and Message 0x%x\n", message[0], message[1]);}
//		altera_avalon_mailbox_close (mailbox);
//		}



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

	IOWR_ALTERA_AVALON_TIMER_STATUS(CPU_1_0_TIMER_0_BASE, 0x0000); 	// acknowledge interrupt
}





