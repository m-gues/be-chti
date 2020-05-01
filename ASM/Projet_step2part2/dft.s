	thumb		
	area  moncode, code, readonly

	import TabSin
	import TabCos
	extern partRe
	extern partIm
		
	export dft
		
dft		proc
	
	;sauvegarde du contenu des registres r4 à r6
	push{r4}
	push{r5}
	push{r6}
	
	
	;les arguments : r0 contient k, r1 contient la table du signal.
	 ldr r2, =TabCos ;r2 contient l'@ de TabCos
	 bl partRe
	 mov r5, r0 ;r5 contient Re(k)
	 smull r5, r6, r5, r5 ;r5 et r6 contient Re(k) au carré (little-endian)
	 
	 mov r0, r4 ;on remet k dans r0
	 ldr r2, =TabSin ;r2 contient l'@ de TabSin
	 bl partRe;r0 contient Im(k)
	 
	 smlal r5, r6, r0, r0 ;r5 et r6 contiennent M2(k)
	 
	
	; On récupere le résultat
	mov		 r0, r6 ;r6 contient les 32 bits de poids fort comme on est en little endian, on les place dans r0
	
	;restitution du contenu des registres r4 à r6
	pop{r6}
	pop{r5}
	pop{r4}
	
	
	
	b		fin	
fin
	bx		lr
	endp
	end