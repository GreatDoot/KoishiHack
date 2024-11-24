.thumb

@another ditto banger of a creation

@goal: make x unit be buffed when equipping y weapon
@in this specific case it is blade wolf using a steel blade

@r0 = attacker, r1 = defender
push {r4-r5}

mov r4, r0
mov r5, r1

@get the current unit's ID
ldr r0, [r4] @+0x00 is pointer to char data
ldrb r0, [r0, #0x04] @+0x04 of char data is unit ID
mov r1, #0x01 @char id
cmp r0, r1
bne End

@if it's the correct unit, check if it's the correct item
mov r2, #0x4A
ldrb r0, [r4, r2] @item + uses before battle is a short at +0x4A but item is the byte at +0x4A
mov r1, #0x01 @item id
cmp r0, r1
bne End

@apply bonuses
@hit +40
mov r3, #40
mov r1, #0x60
ldrh r2, [r4, r1]
add r2, r2, r3
strh r2, [r4, r1]

@str +3
mov r3, #3
mov r1, #0x5A
ldrh r2, [r4, r1]
add r2, r2, r3
strh r2, [r4, r1]

@def +5
mov r3, #5
mov r1, #0x5C
ldrh r2, [r4, r1]
add r2, r2, r3
strh r2, [r4, r1]

End:
pop {r4-r5}
bx lr

.align
.ltorg