.thumb

.set WriteAndVerifySramFast, 0x080D184C+1
.set ReadSramFastAddr, 0x030067A0 @ Dereference func from here

/*
    both existing functions have args as such:
    arg r0: source address
    arg r1: target address
    arg r2: size of data

    this write function has args:
    arg r0: target address (SRAM)
    arg r1: size
    so needs to get source address (RAM)

    this read function has args:
    arg r0: source address (SRAM)
    arg r1: size
    so needs to get target address (RAM)
*/

.global EMS_WriteRunModifiers
.type EMS_WriteRunModifiers, %function

.global EMS_ReadRunModifiers
.type EMS_ReadRunModifiers, %function

EMS_WriteRunModifiers:
push {r14}
mov r2, r1
mov r1, r0
ldr r0, =RunModifiersRam_Link
ldr r0, [r0]
ldr r3, =WriteAndVerifySramFast
mov r14, r3
.short 0xF800
pop {r0}
bx r0

EMS_ReadRunModifiers:
push {r14}
mov r2, r1
ldr r1, =RunModifiersRam_Link
ldr r1, [r1]
ldr r3, =ReadSramFastAddr
ldr r3, [r3]
mov r14, r3
.short 0xF800
pop {r0}
bx r0

.align
