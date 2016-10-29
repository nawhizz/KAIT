include	$(SVRHOME)/makefile.env

CFLAGS	= \
	-I$(COMMON)/include \
	$(CFOPT) $(CFOPTL)

OBJS	= \
	$(DOBJ)/isinfo.o

LIBS	= \
	$(LDISAM)

all	: echo $(RUNUX)/bin/isinfo

echo	:
	@echo HYPUB/UTILSRC/ISINFO$(ECHOLANG)

$(RUNUX)/bin/isinfo		: $(OBJS)
	$(CC) -o $(RUNUX)/bin/isinfo $(LDOPT) $(OBJS) $(LIBS)
	strip $(RUNUX)/bin/isinfo

$(DOBJ)/isinfo.o		: isinfo.c
	$(CC) -o $(DOBJ)/isinfo.o $(CFLAGS) -c isinfo.c
