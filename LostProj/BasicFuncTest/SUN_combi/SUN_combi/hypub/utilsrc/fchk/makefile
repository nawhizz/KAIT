include	$(SVRHOME)/makefile.env

CFLAGS	= \
	-I$(COMMON)/include \
	$(CFOPT) $(CFOPTL)

OBJS	= \
	$(DOBJ)/fchk.o

all	: echo $(RUNUX)/bin/fchk

echo	:
	@echo HYPUB/UTILSRC/FCHK$(ECHOLANG)

$(RUNUX)/bin/fchk		: $(OBJS)
	$(CC) -o $(RUNUX)/bin/fchk $(LDOPT) $(OBJS)
	strip $(RUNUX)/bin/fchk

$(DOBJ)/fchk.o			: fchk.c
	$(CC) -o $(DOBJ)/fchk.o $(CFLAGS) -c fchk.c
