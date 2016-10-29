include	$(SVRHOME)/makefile.env

CFLAGS	= \
	-I$(COMMON)/include \
	$(CFOPT) $(CFOPTL)

OBJS	= \
	$(DOBJ)/isutil.o

LIBS	= \
	$(LDISAM)

all	: echo $(RUNUX)/bin/isutil

echo	:
	@echo HYPUB/UTILSRC/ISUTIL$(ECHOLANG)

$(RUNUX)/bin/isutil		: $(OBJS)
	$(CC) -o $(RUNUX)/bin/isutil $(LDOPT) $(OBJS) $(LIBS)
	strip $(RUNUX)/bin/isutil

$(DOBJ)/isutil.o		: isutil.c
	$(CC) -o $(DOBJ)/isutil.o $(CFLAGS) -c isutil.c
