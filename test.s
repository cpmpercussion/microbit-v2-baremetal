    .syntax unified
    .global __reset

    .section .vectors
    .word __stack
    .word __reset

    .text
    .type __reset, %function
__reset:
    mov r0, #0
    mov r1, #1
loop:
    add r0, r0, r1
    nop
    b loop
    .size __reset, .-__reset