include	$(SVRHOME)/makefile.env

CFLAGS	= \
	-I$(COMMON)/include \
	$(CFOPT) $(CFOPTL)

OBJS	= \
	$(DOBJ)/mann.o

all	: echo $(RUNUX)/bin/mann

echo	:
	@echo HYPUB/UTILSRC/MANN$(ECHOLANG)

$(RUNUX)/bin/mann	: $(OBJS)
	$(CC) -o $(RUNUX)/bin/mann $(LDOPT) $(OBJS)
	strip $(RUNUX)/bin/mann

$(DOBJ)/mann.o		: mann.c
	$(CC) -o $(DOBJ)/mann.o $(CFLAGS) -c mann.c
