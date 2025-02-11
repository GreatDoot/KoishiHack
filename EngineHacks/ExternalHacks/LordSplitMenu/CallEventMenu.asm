.thumb

CallEventMenu:
	push {r4, r14} 
	
	@ Saving argument from r0 to r4 (The Event Engine 6C)
	mov r4, r0
	
	ldr r1, =0x0804E884 @ ClearBG0BG1
	mov r14, r1
	.short 0xF800

	ldr  r2, =#0x03003080 @ pLCDControlBuffer
	ldrb r0, [r2, #1] 
	
	mov r1, #1
	orr r0, r1 @ enable bg0 display
	
	mov r1, #2
	orr r0, r1 @ enable bg1 display
	
	mov r1, #4
	orr r0, r1 @ enable bg2 display
	
	mov r1, #8
	orr r0, r1 @ enable bg3 display
	
	mov r1, #0x10
	orr r0, r1 @ enable obj display
	
	strb r0, [r2, #1] 
	
	@ Setting up relevant graphics (Setting up text font and loading UI frame graphics)
	
	mov r0, #0
	ldr r1, =0x08003D38 @ SetFont | Arguments: r0 = Font Struct (0 for default)
	mov r14, r1
	.short 0xF800

	ldr r1, =0x080043A8 @ SetupFontForUI
	mov r14, r1
	.short 0xF800

	ldr r1, =0x0804EB68 @ LoadNewUIGraphics
	mov r14, r1
	.short 0xF800

	@ Calling the actual lord split menu 6C, with the event engine as parent

    @ read menu def pointer from slot 1
	
	ldr r0, =0x30004BC @ MemorySlot1
	ldr r0, [r0]
	
	mov r1, r4
	ldr r2, =0x0804EBC8  @ NewMenu_DefaultChild | Arguments: r0 = Menu Def, r1 = Parent
	mov r14, r2
	.short 0xF800

	pop {r4} 
	
	pop {r0} 
	bx r0 

.ltorg
.align
