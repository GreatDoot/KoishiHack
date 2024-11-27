.thumb

.set FogLevelAddress, 0x3005268
.set MemorySlot0, 0x300004B8

.global ReadFogModeLevel
.type ReadFogModeLevel, %function
ReadFogModeLevel:

ldr r0, =FogLevelAddress
ldrb r1, [r0]
mov r2, #5
lsl r1, r2
lsr r1, r2

ldr r0, =MemorySlot0
mov r2, #0xC
lsl r2, #2
str r1, [r0, r2]
bx lr

.global WriteFogModeLevel
.type WriteFogModeLevel, %function
WriteFogModeLevel:

ldr r0, =MemorySlot0
mov r1, #1
lsl r1, #2
ldr r1, [r0, r1]

mov r0, #7
cmp r0, r1 @do nothing if input is greater than 7
bgt WriteFogModeLevel.End

ldr r0, =FogLevelAddress
ldrb r2, [r0] @r2 is the last 8 flags (0x125-0x12C)

mov r3, #3 @00000111b
lsr r2, r3
lsl r2, r3
@wipe the last 3 bits to set them with the orr from s1's input

@orr to set the last 3 bits
orr r1, r2
strb r1, [r0] @restore flag values
WriteFogModeLevel.End:
bx lr