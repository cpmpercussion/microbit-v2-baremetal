all: test.hex

%.o: %.s
	arm-none-eabi-as -mcpu=cortex-m4 -mthumb $< -o $@

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
