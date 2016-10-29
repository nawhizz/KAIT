include	$(SVRHOME)/makefile.env

CFLAGS	= \
	-I$(COMMON)/include \
	$(CFOPT) $(CFOPTL)

OBJS	= \
	$(DOBJ)/sgrep.o

all	: echo $(RUNUX)/bin/sgrep

echo	:
	@echo HYPUB/UTILSRC/SGREP$(ECHOLANG)

$(RUNUX)/bin/sgrep	: $(OBJS)
	$(CC) -o $(RUNUX)/bin/sgrep $(LDOPT) $(OBJS)
	strip $(RUNUX)/bin/sgrep

$(DOBJ)/sgrep.o		: sgrep.c
	$(CC) -o $(DOBJ)/sgrep.o $(CFLAGS) -c sgrep.c
