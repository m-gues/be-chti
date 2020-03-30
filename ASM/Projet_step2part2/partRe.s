	thumb		
	area  moncode, code, readonly

	import TabCos
	import TabSig
		
	export partRe
		
partRe proc
	;on recup l'argument
	
	mov r12, #0x00
	b loop
	push {r12} ; on met un zéro tout en haut de la pile : c'est cette valeur qui sera incrémentée à la fin de chaque itération
	
loop

	;mettre l'@ de la valeur du signal et de Tabcos
	ldr 	r2, =TabSig ;on met @ de TabSin
	ldr 	r1, =TabCos ; on met l'@ de TabCos
	
	mul r3, r12, r0 ;r3=ik
	
	; on ajoute position et on recup la valeur
	ldrsh 	r1, 	[r1,r3, lsl #0x01] ; r1 contient cos(ik)
	ldrsh 	r2, 	[r2,r12, lsl #0x01] ; r2 contient x(i)
	
	mul r1, r2
	pop {r3}
	add r3, r1
	push {r3}
	
	
	;r12 contient la variable d'iteration
	add r12, #1
	cmp r12, #64 ; nbe d'itérations
	bne loop
	b	fin
	
fin	
	; On récupere le résultat
	mov		 r0, r3
	bx		lr
	endp
	end