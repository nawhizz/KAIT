include	$(SVRHOME)/makefile.env

CFLAGS	= \
	-I$(COMMON)/include \
	$(CFOPT) $(CFOPTL)

OBJS	= \
	$(DOBJ)/socktst.o

LIBS	= \
	$(LSOCK)

all	: echo $(RUNUX)/bin/socktst

echo	:
	@echo HYPUB/UTILSRC/SOCKTST$(ECHOLANG)

$(RUNUX)/bin/socktst		: $(OBJS)
	$(CC) -o $(RUNUX)/bin/socktst $(LDOPT) $(OBJS) $(LIBS)
	strip $(RUNUX)/bin/socktst

$(DOBJ)/socktst.o		: socktst.c
	$(CC) -o $(DOBJ)/socktst.o $(CFLAGS) -c socktst.c
