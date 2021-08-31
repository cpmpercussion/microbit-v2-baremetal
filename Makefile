all: test.hex

%.o: %.s
	arm-none-eabi-as -mcpu=cortex-m4 -mthumb $< -o $@

%.elf: %.o
	arm-none-eabi-ld -T nrf52833.ld $^ -o $@ -Map $*.map
	arm-none-eabi-size $@

%.hex: %.elf
	arm-none-eabi-objcopy -O ihex $< $@

clean:
	rm -f *.hex *.elf *.bin *.map *.o
