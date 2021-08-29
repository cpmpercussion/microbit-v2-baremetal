  .syntax unified
  

__reset:
  mov r0, #0
  mov r1, #1
  add r0, r0, r1
  b __reset
