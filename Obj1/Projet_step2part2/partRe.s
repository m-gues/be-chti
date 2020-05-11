	thumb		
	area  moncode, code, readonly
		
	export partRe
		
masque equ 0x3F ; pour faire un modulo 64 
N equ 64
	
partRe proc

	; ici r0 contient k, r1 l'adresse de la table du signal, et r2 l'adresse de la table des cosinus.
	
	mov r12, #0x00 ;on met la variable d'itération à zéro
	mov r4, r0 ; on bouge k dans r4
	mov r0, #0x00 ; on met la valeur qu'on renverra a 0
	
	
loop
	
	mul r5, r4, r12 ;r5=ik
	and r5, #masque ; r5 contient ik modulo 64 
	
	; on recupere les valeurs du signal et du cosinus
	ldrsh 	r5, 	[r2,r5, lsl #0x01] ; r5 contient cos(ik)
	ldrsh 	r6, 	[r1,r12, lsl #0x01] ; r6 contient x(i)
	
	mla r0, r5, r6, r0 ;r0+=x(i)cos(ik) 
	
	;r12 contient la variable d'iteration
	add r12, #1
	cmp r12, #N ; nbe d'itérations
	bne loop
	b	fin
	
fin	
; Point sur le contenu des registres : r0 = valeur de retour, r1 = adresse de la table du signal, r2=adresse de la table des cosinus, r4 = k, le reste est du stockage temporaire


	bx		lr
	endp
	end