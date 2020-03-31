	thumb		
	area  moncode, code, readonly
		
	export partRe
		
partRe proc
	;on recup l'argument
	; ici r0 contient k, r1 l'adresse de la table du signal, et r2 l'adresse de la table des cosinus. On les empile pour pouvoir r�utiliser les registres.
	push {r0}
	push {r1}
	push {r2}
	
	mov r12, #0x00 ;on met la variable d'it�ration � z�ro
	b loop
	push {r12} ; on met un z�ro tout en haut de la pile : c'est cette valeur qui sera incr�ment�e � la fin de chaque it�ration
	
	
loop

	; on d�pile la valeur de retour et les arguments
	pop {r0} ;valeur de retour
	pop {r1} ;table des cosinus
	pop {r2} ;table du signal
	pop {r3} ;k
	
	;on r�empile imm�diatement les arguments sans les modifier
	push {r3} ;k
	push {r2} ;signal
	push {r1} ;cosinus

	
	mul r3, r12 ;r3=ik
	
	; on ajoute position et on recup la valeur
	ldrsh 	r1, 	[r1,r3, lsl #0x01] ; r1 contient cos(ik)
	ldrsh 	r2, 	[r2,r12, lsl #0x01] ; r2 contient x(i)
	
	mul r1, r2 ;r1=x(i)cos(ik)
	add r0, r1 ;on ajoute r1 � la valeur de retour
	push {r0} ;on empile la valeur de retour
	
	
	;r12 contient la variable d'iteration
	add r12, #1
	cmp r12, #64 ; nbe d'it�rations
	bne loop
	b	fin
	
fin	
	bx		lr
	endp
	end