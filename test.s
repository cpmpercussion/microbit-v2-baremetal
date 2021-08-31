    .thumb
    .syntax unified
        .global __reset

    .section .vectors
    .word __stack
    .word __reset

    .text
    .thumb_func
__reset:
    mov r0, #0
    mov r1, #1
loop:
    add r0, r0, r1
    nop
    b loop
