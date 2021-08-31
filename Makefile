all: test.elf

%.o: %.s
	arm-none-eabi-gcc -nostdlib -nostartfiles -mcpu=cortex-m4 -mthumb -Wall -Werror -g -o $@ -c $<

%.elf: %.o
	arm-none-eabi-ld -T nRF52833.ld $^ -o $@ -Map $*.map
	arm-none-eabi-size $@

%.hex: %.elf
	arm-none-eabi-objcopy -O ihex $< $@

.PHONY: upload
upload:
	openocd -f interface/cmsis-dap.cfg -f target/nrf52.cfg -c "program test.hex verify reset exit"

clean:
	rm -f *.hex *.elf *.bin *.map *.o
