include	$(SVRHOME)/makefile.env

CFLAGS	= \
	-I$(COMMON)/include \
	$(CFOPT) $(CFOPTL)

OBJS	= \
	$(DOBJ)/pinfo.o

all	: echo $(RUNUX)/bin/pinfo

echo	:
	@echo HYPUB/UTILSRC/PINFO$(ECHOLANG)

$(RUNUX)/bin/pinfo	: $(OBJS)
	$(CC) -o $(RUNUX)/bin/pinfo $(LDOPT) $(OBJS)
	strip $(RUNUX)/bin/pinfo

$(DOBJ)/pinfo.o		: pinfo.c
	$(CC) -o $(DOBJ)/pinfo.o $(CFLAGS) -c pinfo.c
