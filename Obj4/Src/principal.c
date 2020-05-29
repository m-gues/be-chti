#include "gassp72.h"
#include "etat.h"
#define Periode_en_Tck PeriodeSonMicroSec*72 //6552 // T/To vaut 91 u
#define Periode_PWM_en_Tck 720
#define M2TIR 985661

// etat.position=0;

//Demander pour la vérification de la LED

//librairie etat 
type_etat etat;

//fonctions externes
extern int dft(int, vu16*);
extern short Son;
extern int LongueurSon;
extern int PeriodeSonMicroSec;
extern void timer_callback(void);

//Variables globales
vu16 dma_buf[64];
int compt_occurences[6]={0,0,0,0,0,0};
int cible_touchee =0;	


void sys_callback(void)
{	
	// Démarrage DMA pour 64 points
	Start_DMA1(64);
	Wait_On_End_Of_DMA1();
	Stop_DMA1;
	
	//Calcul dft
	int k;
	int tab[64]; //Variable locale pour stocker temporairement le resultat de la dft
	for (k=0;k<64;k++){
		tab[k]=dft(k, &dma_buf[0]);
	}
	
	//Maj du tableau d'occurences
	if (tab[17]>M2TIR) {
		compt_occurences[0]++;
	}
	else compt_occurences[0]=0;
	
	if (tab[18]>M2TIR) {
		compt_occurences[1]++;
	}
	else compt_occurences[1]=0;
	
	if (tab[19]>M2TIR) {
		compt_occurences[2]++;
	}
	else compt_occurences[2]=0;
	
	if (tab[20]>M2TIR) {
		compt_occurences[3]++;
	}
	else compt_occurences[3]=0;
	
	if (tab[23]>M2TIR) {
		compt_occurences[4]++;
	}
	else compt_occurences[4]=0;
	
	if (tab[24]>M2TIR) {
		compt_occurences[5]++;
	}
	else compt_occurences[5]=0;
}


int main(void)
{
	//Sequence d'initialisation
	
	//initialisation de notre son par la variable etat;
etat.taille=LongueurSon;
etat.son=&Son;
etat.Tech_en_Tck = PeriodeSonMicroSec;
etat.position=91;

	
	// activation de la PLL qui multiplie la fréquence du quartz par 9
	CLOCK_Configure();
	// PA2 (ADC voie 2) = entrée analog
	GPIO_Configure(GPIOA, 2, INPUT, ANALOG);
	// PB1 = sortie pour profilage à l'oscillo
	GPIO_Configure(GPIOB, 1, OUTPUT, OUTPUT_PPULL);
	// PB14 = sortie pour LED
	GPIO_Configure(GPIOB, 14, OUTPUT, OUTPUT_PPULL);
	// config port PB0 pour être utilisé par TIM3-CH3
	GPIO_Configure(GPIOB, 0, OUTPUT, ALT_PPULL);
	// config TIM3-CH3 en mode PWM
	etat.resolution = PWM_Init_ff( TIM3, 3, Periode_PWM_en_Tck );
	

	// initialisation du timer 4
	// Periode_en_Tck doit fournir la durée entre interruptions,
	// exprimée en périodes Tck de l'horloge principale du STM32 (72 MHz)
	Timer_1234_Init_ff( TIM4, Periode_en_Tck );	
	// enregistrement de la fonction de traitement de l'interruption timer
	// ici le 2 est la priorité, timer_callback est l'adresse de cette fonction, a créér en asm,
	// cette fonction doit être conforme à l'AAPCS
	Active_IT_Debordement_Timer( TIM4, 2, timer_callback );		
	// activation ADC, sampling time 1us
	Init_TimingADC_ActiveADC_ff( ADC1, 0x31/*Changer la valeur test ici*/); 
	Single_Channel_ADC( ADC1, 2 );
	// Déclenchement ADC par timer2, periode (72MHz/320kHz)ticks
	Init_Conversion_On_Trig_Timer_ff( ADC1, TIM2_CC2, 225 );
	// Config DMA pour utilisation du buffer dma_buf (a créér)
	Init_ADC1_DMA1( 0, &dma_buf[0] );
	// Config Timer, période exprimée en périodes horloge CPU (72 MHz)
	Systick_Period_ff(360000); //5 ms rapportées en ticks à 72 MHz
	// enregistrement de la fonction de traitement de l'interruption timer
	// ici le 3 est la priorité, sys_callback est l'adresse de cette fonction, a créér en C
	Systick_Prio_IT( 3, sys_callback );
	SysTick_On;
	SysTick_Enable_IT;
	
	// lancement des timer
	Run_Timer( TIM4 );
	Run_Timer( TIM3 );		
	
	int score[6]={0,0,0,0,0,0};//Scores associés aux différents pistolets
	int ajout_score[6]={0,0,0,0,0,0}; //Ajouts à faire aux scores définitifs
	
	
while(1)
	{
		//Gestion du score
		for (int i=0; i<6; i++){
				if (compt_occurences[i]>2) {
					etat.position=0;
					cible_touchee=1;
					ajout_score[i]=1;
//				GPIO_Set(GPIOB, 14);
				}
			}
		while (cible_touchee>0){
			cible_touchee=0;
			for (int i=0; i<6; i++){
				if (compt_occurences[i]>2){
					cible_touchee=1;
					ajout_score[i]=1;
				}
			}
		}
//		GPIO_Clear(GPIOB, 14);
		for (int i=0; i<6; i++){
			score[i]+=ajout_score[i];
			ajout_score[i]=0;
		}
	}
}
