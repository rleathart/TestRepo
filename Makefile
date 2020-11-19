ifeq ($(OS),Windows_NT)
	CC := clang
	BINEXT := .exe
	SHELL = powershell.exe
endif

PROGNAME := HelloWorld
PROGNAME := $(addsuffix $(BINEXT), $(PROGNAME))

SRC := $(wildcard *.c)
SRC += $(wildcard src/*.c)

OBJ := $(SRC:.c=.o)

$(PROGNAME): $(OBJ)
	$(CC) $(OBJ) -o $(PROGNAME)

run: $(PROGNAME)
	./$(PROGNAME)

ifeq ($(OS),Windows_NT)
clean:
	Get-ChildItem -Recurse -File *.o | Remove-Item -Force
Clean: clean
	Get-ChildItem -File $(PROGNAME) | Remove-Item -Force
else
clean:
	$(RM) *.o
Clean: clean
	$(RM) $(PROGNAME)
endif

.PHONY: clean Clean run
