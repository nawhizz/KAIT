include	$(SVRHOME)/makefile.env

CFLAGS	= \
	-I$(COMMON)/include \
	$(CFOPT) $(CFOPTL)

OBJS	= \
	$(DOBJ)/fsep.o

all	: echo $(RUNUX)/bin/fsep

echo	:
	@echo HYPUB/UTILSRC/FSEP$(ECHOLANG)

$(RUNUX)/bin/fsep		: $(OBJS)
	$(CC) -o $(RUNUX)/bin/fsep $(LDOPT) $(OBJS)
	strip $(RUNUX)/bin/fsep

$(DOBJ)/fsep.o			: fsep.c
	$(CC) -o $(DOBJ)/fsep.o $(CFLAGS) -c fsep.c
