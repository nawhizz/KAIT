include	$(SVRHOME)/makefile.env

CFLAGS	= \
	-I$(COMMON)/include \
	$(CFOPT) $(CFOPTL)

OBJS	= \
	$(DOBJ)/fcom.o

all	: echo $(RUNUX)/bin/fcom

echo	:
	@echo HYPUB/UTILSRC/FCOM$(ECHOLANG)

$(RUNUX)/bin/fcom		: $(OBJS)
	$(CC) -o $(RUNUX)/bin/fcom $(LDOPT) $(OBJS)
	strip $(RUNUX)/bin/fcom

$(DOBJ)/fcom.o			: fcom.c
	$(CC) -o $(DOBJ)/fcom.o $(CFLAGS) -c fcom.c
