	thumb
	area moncode, code, readonly
	export timer_callback
		
GPIOB_BSRR	equ	0x40010C10	; Bit Set/Reset register

;fonction principale
timer_callback proc
	mov r1, r12
	cbz r1, mise_a_1
	cbnz r1, mise_a_0

; mise a 1 de PB1
mise_a_1
	ldr	r3, =GPIOB_BSRR
	mov	r1, #0x00000002
	str	r1, [r3]
	mov r12, #1
	b fin
	;
mise_a_0
; mise a zero de PB1
	ldr	r3, =GPIOB_BSRR
	mov	r1, #0x00020000
	str	r1, [r3]
	mov r12, #0
	b fin
	;
fin	
	bx lr
	endp
	end
			
; N.B. le registre BSRR est write-only, on ne peut pas le relire