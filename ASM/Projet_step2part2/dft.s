	thumb		
	area  moncode, code, readonly

	import TabSin
	import TabCos
		
	export dft
		
dft		proc
	;on recup l'argument
	
	;mettre l'@ de TabSin et TabCos
	ldr 	r1, =TabSin ;on met @ de TabSin
	ldr 	r2, =TabCos ; on met l'@ de TabCos
	
	; on ajoute position et on recup la valeur
	ldrsh 	r3, 	[r1,r0, lsl #0x01] ; r3 contient la valeur de sin
	ldrsh 	r12, 	[r2,r0, lsl #0x01] ; r4 contient la valeur de cos
	
	mul 	r3,r3
	mul 	r12,r12

	add 	r3,r12
	
	; On récupere le résultat
	mov		 r0, r3
	b		fin
	
fin
	bx		lr
	endp
	end