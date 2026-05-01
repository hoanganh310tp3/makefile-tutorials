GCC_DIR := /opt/gcc-arm-none-eabi-10.3-2021.10
CC := $(GCC_DIR)/bin/arm-none-eabi-gcc
LD_FILE := Linker/stm_ls.ld
INC_DIR := Driver/GPIO/inc

CHIP=cortex-m4
FLASH_TOOL := /home/hoanganhpham/stm32cubeide/plugins/com.st.stm32cube.ide.mcu.externaltools.cubeprogrammer.linux64_2.2.400.202601091506/tools/bin/STM32_Programmer_CLI

CCFLAGS= -c -mcpu=$(CHIP) -mthumb -std=gnu11 -O0 -I$(INC_DIR)
LDFLAGS= -nostdlib -T $(LD_FILE) -Wl,-Map=Output/GPIO.map

.PHONY: build
build: Output/GPIO.hex

Output/main.o: User/src/main.c
	$(CC) $(CCFLAGS) -o Output/main.o User/src/main.c
Output/GPIO.o: Driver/GPIO/src/GPIO.c
	$(CC) $(CCFLAGS) -o Output/GPIO.o Driver/GPIO/src/GPIO.c
Output/stm32_startup.o: Startup/stm32_startup.c
	$(CC) $(CCFLAGS) -o Output/stm32_startup.o Startup/stm32_startup.c

Output/GPIO.elf:Output/main.o Output/GPIO.o Output/stm32_startup.o
	$(CC) $(LDFLAGS) -o Output/GPIO.elf Output/main.o Output/GPIO.o Output/stm32_startup.o

Output/GPIO.hex: Output/GPIO.elf
	$(GCC_DIR)/bin/arm-none-eabi-objcopy -O ihex Output/GPIO.elf Output/GPIO.hex

.PHONY: flash
flash: Output/GPIO.elf
	$(FLASH_TOOL) -c port=SWD -w $< -v -rst

.PHONY: run
run: build flash

clean:
	rm -rf ./Output/*