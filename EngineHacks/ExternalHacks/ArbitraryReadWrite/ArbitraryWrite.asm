.thumb

ldr r0, =0x30004BC
ldr r1, [r0]
add r0, r0, #4
ldr r2, [r0]
add r0, r0, #4
ldr r3, [r0]
lsl r3, #24
lsr r3, #24
cmp r3, #0
beq Byte
cmp r3, #1
beq Short
Word:
str r2, [r1]
b End
Byte:
lsl r2, #24
lsr r2, #24
strb r2, [r1]
b End
Short:
lsl r2, #16
lsr r2, #16
strh r2, [r1]
End:
bx r14

.align
.pool
