.thumb

EventMenuCommandEffect:
	push {r14}
	
	@ r1 is command 6C
	@ command 6C + 0x3C is command index
	
	mov  r0, #0x3C
	ldrb r0, [r1, r0]
	
	ldr r1, =0x0800D1F8 @ SetEventSlotC
	mov r14, r1
    .short 0xF800

	mov r0, #0x17
	
	pop {r1}
	bx r1
	