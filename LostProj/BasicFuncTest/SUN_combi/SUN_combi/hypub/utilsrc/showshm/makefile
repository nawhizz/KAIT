include	$(SVRHOME)/makefile.env

CFLAGS	= \
	-I$(COMMON)/include \
	$(CFOPT) $(CFOPTL)

OBJS	= \
	$(DOBJ)/showshm.o

all	: echo $(RUNUX)/bin/showshm

echo	:
	@echo HYPUB/UTILSRC/SHOWSHM$(ECHOLANG)

$(RUNUX)/bin/showshm	: $(OBJS)
	$(CC) -o $(RUNUX)/bin/showshm $(LDOPT) $(OBJS)
	strip $(RUNUX)/bin/showshm

$(DOBJ)/showshm.o	: showshm.c
	$(CC) -o $(DOBJ)/showshm.o $(CFLAGS) -c showshm.c
