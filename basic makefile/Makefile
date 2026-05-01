PROJ_NAME := sum
OBJ_FILES = out/main.o 
OBJ_FILES += out/$(PROJ_NAME).o # use += adding var

.PHONY: all
all: build

out/main.o:src/main.c
	@mkdir -p out
	@gcc -c -I./inc src/main.c -o out/main.o

out/$(PROJ_NAME).o:src/$(PROJ_NAME).c
	@mkdir -p out
	@gcc -c -I./inc src/$(PROJ_NAME).c -o out/$(PROJ_NAME).o
	@echo "Build Done!"

.PHONY: build
build:$(OBJ_FILES)
	@gcc $(OBJ_FILES) -o out/main

.PHONY: run
run:
	./out/main

.PHONY: clean
clean:
	@rm -rf out
	@echo "Clear all output files!"

print-%:
	@echo $($(subst print-,,$@))