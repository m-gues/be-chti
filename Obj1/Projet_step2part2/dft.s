	thumb		
	area  moncode, code, readonly

	import TabSin
	import TabCos
	extern partRe
	extern partIm
		
	export dft
		
dft		proc
	
	;sauvegarde du contenu des registres r4 à r6 et lr
	push{r4}
	push{r5}
	push{r6}
	push{r7}
	push{r8}
	push{lr}
	
	
	;les arguments : r0 contient k, r1 contient la table du signal.
	 ldr r2, =TabCos ;r2 contient l'@ de TabCos
	 bl partRe ;r0 contient Re(k)
	 smull r7, r8, r0, r0 ;r7 et r8 contient Re(k) au carré (little-endian)
	 
	 mov r0, r4 ;on remet k dans r0
	 ldr r2, =TabSin ;r2 contient l'@ de TabSin
	 bl partRe;r0 contient Im(k)
	 
	 smlal r7, r8, r0, r0 ;r7 et r8 contiennent M2(k)
	 
	
	; On récupere le résultat
	mov		 r0, r8 ;r6 contient les 32 bits de poids fort comme on est en little endian, on les place dans r0
	
	;restitution du contenu des registres r4 à r6 et lr
	pop{lr}
	pop{r8}
	pop{r7}
	pop{r6}
	pop{r5}
	pop{r4}
	
	
	
	b		fin	
fin
	bx		lr
	endp
	end