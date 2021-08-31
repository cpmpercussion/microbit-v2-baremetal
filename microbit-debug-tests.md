# How to run assembly code on a BBC micro:bit v2

The [BBC micro:bit](https://microbit.org/) is a neat microcontroller board aimed as a pocket-sized educational computer for kids. 

It features an attractive design with two user-addressable buttons, a
display which is a 5x5 LED array, a speaker, a microphone, a motion
sensor, Bluetooth, and various other cool things. Behind the scenes,
it has a nice ARM Cortex-M4 processor from NNordic Semiconductor, the
[nRF52833](https://www.nordicsemi.com/products/nrf52833).

Kids program it in a browser using block-based coding or MicroPython,
but I'm interested in using it to teach [computer organisation and
program execution](https://cs.anu.edu.au/courses/comp2300) to
undergraduate computing students. To do this, I need to be able run
and debug ARM assembly code directly on the board.

For teaching this course, we use a fairly well-scaffolded ecosystem of
starter projects and a VSCode extension[^1], but just to remember how to
do it, here's the steps for running and debugging some bare-metal
assembly on a v2 microbit with a minimal working example.

## Setup

You'll need a toolchain to 

## Write some assembly

Here's a simple assembly program that will add two numbers

```
```

## Make

1. build with `arm-none-eabi-as`
2. link to make an `elf`
3. `objcopy` to make the `.hex` file
4. `cp program.hex /media/charles/MICROBIT/`

Program should be running!

## Upload to the board

`openocd -f interface/cmsis-dap.cfg -f target/nrf52.cfg -c "program test.hex verify reset exit"`

## Debug

1. start openocd: `openocd -f interface/cmsis-dap.cfg -f target/nrf52.cfg`
2. start GDB: `gdb-multiarch test.elf`

Now we have can type commands into GDB's shell.

- first: connect GDB to OpenOCD: `target remote :3333`

Now the program is running, GDB will tell you something like:
```
Remote debugging using :3333
0x00000022 in loop ()
```
So the board is running the program, the program counter is at `0x00000022` and we're in under the label `loop`.

Now we can issue a few GDB commands to see what's going on. Just to get started:

- hit `Ctrl-C` to halt the program.
- type `p $r1` to see the current value of `r1` - it should be 1 as the program sets it to 1 and never changes it. 
- type `p $r0` to see the current value of `r0` - it should be some integer (maybe even a big negative number), the program increments `r0` over and over and it will eventually overflow.
- to step the program forward type `nexti` which moves forward by one instruction
- after moving forward a few instructions, you can check on `r0` (`p $r0`) to see if it's been incremented as we would expect.
- to set your program going continuously, type `continue` (you can halt it again with `Ctrl-C`)

## Conclusions

This is obviously a _very basic_ test, but it's nice to see things working without the benefit of big integrated development systems. Now we know how to make artisanal, hand-crafted, assembly programs run on a micro:bit and we can prove that they work!

## Interesting Links

- nRF52833 [Product Specification](https://infocenter.nordicsemi.com/index.jsp?topic=%2Fstruct_nrf52%2Fstruct%2Fnrf52833.html)
- Micro:bit v2 [Pin Map](https://tech.microbit.org/hardware/schematic/#v2-pinmap)
- Micro:bit v2 [Schematic](https://github.com/microbit-foundation/microbit-v2-hardware/blob/main/V2/MicroBit_V2.0.0_S_schematic.PDF)
- Linker file from [CODAL project](https://github.com/lancaster-university/codal-microbit-v2/blob/6e880bc3d10df1a585bb9046ee4ab02bdcab1f34/ld/nrf52833.ld)
- M Spivey's [linker file](https://github.com/Spivoxity/baremetal-v2/blob/master/x09-pureasm/nRF52833.ld)

[^1] Have a look at the [course
website](https://cs.anu.edu.au/courses/comp2300) although this
currently (2021) refers to the previous ARM microcontroller board that
we used: the STM32L476 Discovery Board, a neat little board which is
sadly no longer in production!
