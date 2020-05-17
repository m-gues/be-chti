	thumb
		
	area moncode, code, readonly
	export timer_callback
		
GPIOB_BSRR	equ	0x40010C10	; Bit Set/Reset register
TIM3_CCR3	equ	0x4000043C	; adresse registre PWM
	
	 import LongueurSon 
	 import PeriodeSonMicroSec
	 import Son
	 
	
timer_callback proc
	
	push 	{r4}
	ldr 	r0, =etat 		; ro=@etat
	ldr 	r1,[r0, #E_POS]	; r1=position
	ldr		r2,[r0, #E_TAL] ; r2=taille
	cmp 	r1,r2
	bmi 	fin ;if position >taille on vas a la partie fin
	;début de boucle
	
	ldr 	r3,[r0, #E_SON] ;r3= @Son
	ldrsh 	r4,[r3,r1]    ;r4=échantillon 
	
	add 	r4,#0x8000 ; ajout de la composante continue
	
	; Mise à l'échelle à faire
	;multiplier par un facteur échelle
	;division par 2^16
	
	;sortie ech vers pwm
	
	;position ++
	add 	r1,#0x1
	str 	r1,[r0, #E_POS]
	
fin 

	pop 	{r4}
	bx 		 lr
	endp 
	end
	