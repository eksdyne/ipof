#
# Makefile for 'ipof'.
#
# Type 'make' or 'make ipof' to create the binary.
# Type 'make clean' or 'make clear' to delete all temporaries.
# Type 'make run' to execute the binary.
# Type 'make debug' to debug the binary using gdb(1).
#

# build target specs
CC = cc
CFLAGS = -O2 
OUT_DIR = obj
LIBS =

# first target entry is the target invoked when typing 'make'
default: ipof

install: ipof
	@echo -n 'Installing ipof... '
	@install -C -groot -oroot ipof /usr/local/bin

ipof: $(OUT_DIR)/ipof.c.o
	@mkdir -p $(OUT_DIR)
	@echo -n 'Linking ipof... '
	@$(CC) $(CFLAGS) -o ipof $(OUT_DIR)/ipof.c.o $(LIBS)
	@echo Done.

$(OUT_DIR)/ipof.c.o: ipof.c
	@mkdir -p $(OUT_DIR)
	@echo -n 'Compiling ipof.c... '
	@$(CC) $(CFLAGS) -o $(OUT_DIR)/ipof.c.o -c ipof.c
	@echo Done.

run:
	./ipof 

debug:
	gdb ./ipof

clean:
	@echo -n 'Removing all temporary binaries... '
	@rm -f ipof $(OUT_DIR)/*.o
	@echo Done.

clear:
	@echo -n 'Removing all temporary binaries... '
	@rm -f ipof $(OUT_DIR)/*.o
	@echo Done.

