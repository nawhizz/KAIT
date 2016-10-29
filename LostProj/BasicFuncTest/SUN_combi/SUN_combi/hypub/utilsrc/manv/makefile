include	$(SVRHOME)/makefile.env

CFLAGS	= \
	-I$(COMMON)/include \
	$(CFOPT) $(CFOPTL)

OBJS	= \
	$(DOBJ)/manv.o

all	: echo $(RUNUX)/bin/manv

echo	:
	@echo HYPUB/UTILSRC/MANV$(ECHOLANG)

$(RUNUX)/bin/manv	: $(OBJS)
	$(CC) -o $(RUNUX)/bin/manv $(LDOPT) $(OBJS)
	strip $(RUNUX)/bin/manv

$(DOBJ)/manv.o		: manv.c
	$(CC) -o $(DOBJ)/manv.o $(CFLAGS) -c manv.c
