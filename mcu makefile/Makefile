GCC_DIR := /opt/gcc-arm-none-eabi-10.3-2021.10
CC := $(GCC_DIR)/bin/arm-none-eabi-gcc
LD_FILE := Linker/stm_ls.ld

# Versatile module changing
MODULE := GPIO
PATH_OUTPUT := ./Output

# Include Files
INC_DIRS += Driver/$(MODULE)/inc \
			User/inc
INC_FILES += $(foreach INC_DIRS,$(INC_DIRS),$(wildcard $(INC_DIRS)/*))

# Source Files
SRC_DIRS += Driver/$(MODULE)/src \
			User/src \
			Startup
SRC_FILES += $(foreach SRC_DIRS,$(SRC_DIRS),$(wildcard $(SRC_DIRS)/*))

CHIP=cortex-m4

FLASH_TOOL := /home/hoanganhpham/stm32cubeide/plugins/com.st.stm32cube.ide.mcu.externaltools.cubeprogrammer.linux64_2.2.400.202601091506/tools/bin/STM32_Programmer_CLI

# Object Files
OBJ_FILES := $(notdir $(SRC_FILES))
OBJ_FILES := $(subst .c,.o,$(OBJ_FILES))
PATH_OBJS := $(foreach OBJ_FILES,$(OBJ_FILES),$(PATH_OUTPUT)/$(OBJ_FILES))

# CC Opt for INC_DIRS
INC_DIRS_OPT = $(foreach INC_DIRS,$(INC_DIRS),-I$(INC_DIRS))
CCFLAGS= -c -mcpu=$(CHIP) -mthumb -std=gnu11 -O0 $(INC_DIRS_OPT)
LDFLAGS= -nostdlib -T $(LD_FILE) -Wl,-Map=$(PATH_OUTPUT)/$(MODULE).map

vpath %.c $(SRC_DIRS)

.PHONY: build
build: $(PATH_OUTPUT)/$(MODULE).hex

%.o:%.c
	$(CC) $(CCFLAGS) -o $(PATH_OUTPUT)/$@ $^

$(PATH_OUTPUT)/$(MODULE).elf: $(OBJ_FILES)
	$(CC) $(LDFLAGS) -o $@ $(PATH_OBJS)

$(PATH_OUTPUT)/$(MODULE).hex: $(PATH_OUTPUT)/$(MODULE).elf
	$(GCC_DIR)/bin/arm-none-eabi-objcopy -O ihex "$^" "$@"

.PHONY: flash
flash: Output/$(MODULE).elf
	$(FLASH_TOOL) -c port=SWD -w $< -v -rst

.PHONY: run
run: build flash

clean:
	rm -rf ./Output/*

print-%:
	@echo $($(subst print-,,$@))