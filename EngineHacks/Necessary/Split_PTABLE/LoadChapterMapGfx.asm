.thumb

.global LoadChapterMapGfx
.type LoadChapterMapGfx, %function

.equ origin, 0x0801990C

.equ Decompress_6008000, 0x06008000
.equ Decompress_600C000, 0x0600C000

.equ bl_GetChapterDefinition, . + 0x08034618 - origin
.equ bl_Decompress, . + 0x08012F50 - origin
.equ bl_CopyToPaletteBuffer, . + 0x08000DB8 - origin


		LoadChapterMapGfx:
		push	{r4-r6,r14}
		mov		r4, r0
		
		@Check map object type
		ldr		r5, =Object_PTABLE
		bl		bl_GetChapterDefinition
		mov		r6, r0
		ldrb	r0, [r6,#4]
		lsl		r0, #2
		ldr		r0, [r5,r0]
		ldr		r1, =Decompress_6008000
		bl		bl_Decompress
		
		@I'm not sure what this is for (or what table it should load with split ptable)
		ldrb	r0, [r6,#5]
		lsl		r0, #2
		ldr		r0, [r5,r0]
		cmp		r0, #0
		beq		GetMapPalette
		
			ldr		r1, =Decompress_600C000
			bl		bl_Decompress
			
		GetMapPalette:
		ldrb	r0, [r6,#6]
		lsl		r0, #2
		ldr		r1, =Palette_PTABLE
		ldr		r0, [r1,r0]
		mov		r2, #0xA0
		lsl		r2, #1
		mov		r1, #0xC0
		bl		bl_CopyToPaletteBuffer
		
		pop		{r4-r6}
		pop		{r0}
		bx		r0
		
		.align
		.ltorg

