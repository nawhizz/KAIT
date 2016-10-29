include	$(SVRHOME)/makefile.env

CFLAGS	= \
	-I$(COMMON)/include \
	$(CFOPT) $(CFOPTL)

OBJS	= \
	$(DOBJ)/dgrep.o

all	: echo $(RUNUX)/bin/dgrep

echo	:
	@echo HYPUB/UTILSRC/DGREP$(ECHOLANG)

$(RUNUX)/bin/dgrep	: $(OBJS)
	$(CC) -o $(RUNUX)/bin/dgrep $(LDOPT) $(OBJS)
	strip $(RUNUX)/bin/dgrep

$(DOBJ)/dgrep.o	: dgrep.c
	$(CC) -o $(DOBJ)/dgrep.o $(CFLAGS) -c dgrep.c
