GCC_DIR := /opt/gcc-arm-none-eabi-10.3-2021.10
CC := $(GCC_DIR)/bin/arm-none-eabi-gcc
LD_FILE := Linker/stm_ls.ld

PATH_OUTPUT := ./Output

# Include Files
INC_DIRS += Driver/GPIO/inc \
			Driver/UART/inc
INC_FILES += $(foreach INC_DIRS,$(INC_DIRS),$(wildcard $(INC_DIRS)/*))

# Source Files
SRC_DIRS += Driver/GPIO/src
SRC_FILES += $(foreach SRC_DIRS,$(SRC_DIRS),$(wildcard $(SRC_DIRS)/*))

CHIP=cortex-m4

FLASH_TOOL := /home/hoanganhpham/stm32cubeide/plugins/com.st.stm32cube.ide.mcu.externaltools.cubeprogrammer.linux64_2.2.400.202601091506/tools/bin/STM32_Programmer_CLI

# CC Opt for INC_DIRS
INC_DIRS_OPT = $(foreach INC_DIRS,$(INC_DIRS),-I$(INC_DIRS))
CCFLAGS= -c -mcpu=$(CHIP) -mthumb -std=gnu11 -O0 $(INC_DIRS_OPT)
LDFLAGS= -nostdlib -T $(LD_FILE) -Wl,-Map=$(PATH_OUTPUT)/GPIO.map

.PHONY: build
build: $(PATH_OUTPUT)/GPIO.hex

$(PATH_OUTPUT)/main.o: User/src/main.c
	$(CC) $(CCFLAGS) -o $@ $^
$(PATH_OUTPUT)/GPIO.o: $(SRC_DIRS)/GPIO.c
	$(CC) $(CCFLAGS) -o $@ $^
$(PATH_OUTPUT)/stm32_startup.o: Startup/stm32_startup.c
	$(CC) $(CCFLAGS) -o $@ $^

$(PATH_OUTPUT)/GPIO.elf:$(PATH_OUTPUT)/main.o $(PATH_OUTPUT)/GPIO.o $(PATH_OUTPUT)/stm32_startup.o
	$(CC) $(LDFLAGS) -o $@ $^

$(PATH_OUTPUT)/GPIO.hex: $(PATH_OUTPUT)/GPIO.elf
	$(GCC_DIR)/bin/arm-none-eabi-objcopy -O ihex "$^" "$@"

.PHONY: flash
flash: Output/GPIO.elf
	$(FLASH_TOOL) -c port=SWD -w $< -v -rst

.PHONY: run
run: build flash

clean:
	rm -rf ./Output/*

print-%:
	@echo $($(subst print-,,$@))