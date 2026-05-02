PATH_OUTPUT := ./Output

# Include Files
INC_DIRS += Driver/$(MODULE)/inc \
			User/inc
INC_FILES += $(foreach INC_DIRS,$(INC_DIRS),$(wildcard $(INC_DIRS)/*))

# Source Files
SRC_DIRS += Driver/$(MODULE)/src \
			User/src \
			Startup