#include "gassp72.h"
#include "etat.h"
#define Periode_en_Tck PeriodeSonMicroSec*72; //6552 // T/To vaut 91 u
#define Periode_PWM_en_Tck 720; 

extern short Son;
extern int LongueurSon;
extern int PeriodeSonMicroSec;

void timer_callback(void);

type_etat etat;


int main(void)
{
	//initialisation de notre son par la variable etat;
etat.taille=LongueurSon;
etat.son=&Son;
etat.Tech_en_Tck = PeriodeSonMicroSec;
	// activation de la PLL qui multiplie la fréquence du quartz par 9
CLOCK_Configure();
	// config port PB0 pour être utilisé par TIM3-CH3
GPIO_Configure(GPIOB, 0, OUTPUT, ALT_PPULL);
// config TIM3-CH3 en mode PWM
etat.resolution = PWM_Init_ff( TIM3, 3, Periode_PWM_en_Tck );
	
	while	(1)
		{
	}
}
