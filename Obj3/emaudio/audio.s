	thumb
		
	area moncode, code, readonly
		
	export timer_callback
		
GPIOB_BSRR	equ	0x40010C10	; Bit Set/Reset register
TIM3_CCR3	equ	0x4000043C	; adresse registre PWM
	
	 export timer_callback
	 include etat.inc
	 import etat
	 import LongueurSon 
	 import PeriodeSonMicroSec
	 import Son
	 
	
timer_callback proc
	
	push 	{r4-r6}
	ldr 	r0, =etat 		; ro=@etat
	ldr 	r1,[r0, #E_POS]	; r1=position
	ldr		r2,[r0, #E_TAI] ; r2=taille
	cmp 	r1,r2
	bpl		boucle ;if position >= taille on entre dans la boucle
	b 		fin		; sinon on vas dans fin 
	;début de boucle
boucle	
	ldr 	r3,[r0, #E_SON] ;r3= @Son
	ldrsh 	r4,[r3,r1,lsl #0x01]    ;r4=échantillon 
	
	add 	r4,#0x8000 ; ajout de la composante continue
	
	; Mise à l'échelle à faire
	;multiplier par un facteur échelle
	;division par 2^16
	ldr 	r5,[r0, #E_RES]
	mul		r4, r5 ; multiplie par la résolution 
	mov 	r5, #0xFFFF
	udiv	r4,	r5 ; division par 2^16
	
	
	;sortie ech vers pwm
	ldr 	r5,=TIM3_CCR3 ; on place l'@ de la sortie PWM 
	str 	r4,[r5]
	;position ++
	add 	r1,#0x1
	str 	r1,[r0, #E_POS]
	
fin 
	mov 	r6,#0x0000		;
	str		r6,[r0, #E_POS]	;On mets la position à zéro 
	
		;sortie ech vers pwm
	ldr 	r5,=TIM3_CCR3 ; on place l'@ de la sortie PWM 
	str 	r4,[r5]
	
	pop 	{r4,r5}
	bx 		 lr
	endp 
	end
	