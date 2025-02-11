.thumb

ldr r0, =0x30004BC
ldr r1, [r0]
add r0, r0, #4
ldr r2, [r0]
cmp r2, #0
beq Byte
cmp r2, #1
beq Short
Word:
ldr r3, [r1]
b End
Short:
ldrh r3, [r1]
b End
Byte:
ldrb r3, [r1]
End:
add r0, #0x28
str r3, [r0]
bx r14

.align
.pool
