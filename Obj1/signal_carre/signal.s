	thumb
		
	area madata, data, readwrite
	export switch_val
		
switch_val dcd 0
		
		
	area moncode, code, readonly
	export timer_callback
		
GPIOB_BSRR	equ	0x40010C10	; Bit Set/Reset register

;fonction principale
timer_callback proc
	ldr r2, =switch_val
	ldr r1, [r2]
	cbz r1, mise_a_1
	cbnz r1, mise_a_0

; mise a 1 de PB1
mise_a_1
	ldr	r3, =GPIOB_BSRR
	mov	r1, #0x00000002
	str	r1, [r3]
	mov r1, #1
	str r1, [r2]
	b fin
	;
mise_a_0
; mise a zero de PB1
	ldr	r3, =GPIOB_BSRR
	mov	r1, #0x00020000
	str	r1, [r3]
	mov r1, #0
	str r1, [r2]
	b fin
	;
fin	
	bx lr
	endp
	end
			
; N.B. le registre BSRR est write-only, on ne peut pas le relire