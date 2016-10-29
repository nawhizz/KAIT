include	$(SVRHOME)/makefile.env

CFLAGS	= \
	-I$(COMMON)/include \
	$(CFOPT) $(CFOPTL)

OBJS	= \
	$(DOBJ)/fstr.o

all	: echo $(RUNUX)/bin/fstr

echo	:
	@echo HYPUB/UTILSRC/FSTR$(ECHOLANG)

$(RUNUX)/bin/fstr		: $(OBJS)
	$(CC) -o $(RUNUX)/bin/fstr $(LDOPT) $(OBJS)
	strip $(RUNUX)/bin/fstr

$(DOBJ)/fstr.o			: fstr.c
	$(CC) -o $(DOBJ)/fstr.o $(CFLAGS) -c fstr.c
