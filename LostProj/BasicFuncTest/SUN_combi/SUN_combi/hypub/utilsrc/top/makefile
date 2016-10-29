include	$(SVRHOME)/makefile.env

CFLAGS	= \
	-I$(COMMON)/include \
	$(CFOPT) $(CFOPTL)

OBJS	= \
	$(DOBJ)/top.o

all	: echo $(RUNUX)/bin/top

echo	:
	@echo HYPUB/UTILSRC/TOP$(ECHOLANG)

$(RUNUX)/bin/top		: $(OBJS)
	$(CC) -o $(RUNUX)/bin/top $(LDOPT) $(OBJS)
	strip $(RUNUX)/bin/top

$(DOBJ)/top.o			: top.c
	$(CC) -o $(DOBJ)/top.o $(CFLAGS) -c top.c
