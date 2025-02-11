.thumb

push {r14}

ldr r0, =0x800D1C8 // DeleteEventEngines
mov r14, r0
.short 0xF800

ldr r0, =0x800D07C // CallEvent (Creates new event engine if none exist)
mov r14, r0
ldr r0, =0x30004BC // Memory Slot 1
ldr r0, [r0] // Load Event to "jump to" in r0
mov r1, #0
.short 0xF800

pop {r15}

.ltorg
.align
