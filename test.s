  .thumb
  .syntax unified
  .global __reset
  
  .section .vectors
  @@ Vector table at address 0
  .word __stack               @ Initial stack pointer
  .word __reset               @ Reset vector
  @@ Rest of the vectors are unused
  
  .text
  .thumb_func
__reset:
  mov r0, #0
  mov r1, #1
loop:
  add r0, r0, r1  
  nop
  b loop
