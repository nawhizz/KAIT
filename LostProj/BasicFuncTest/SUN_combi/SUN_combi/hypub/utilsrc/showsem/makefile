include	$(SVRHOME)/makefile.env

CFLAGS	= \
	-I$(COMMON)/include \
	$(CFOPT) $(CFOPTL)

OBJS	= \
	$(DOBJ)/showsem.o

all	: echo $(RUNUX)/bin/showsem

echo	:
	@echo HYPUB/UTILSRC/SHOWSEM$(ECHOLANG)

$(RUNUX)/bin/showsem		: $(OBJS)
	$(CC) -o $(RUNUX)/bin/showsem $(LDOPT) $(OBJS)
	strip $(RUNUX)/bin/showsem

$(DOBJ)/showsem.o		: showsem.c
	$(CC) -o $(DOBJ)/showsem.o $(CFLAGS) -c showsem.c
