include	$(SVRHOME)/makefile.env

CFLAGS	= \
	-I$(COMMON)/include \
	$(CFOPT) $(CFOPTL)

OBJS	= \
	$(DOBJ)/dwc.o

LIBS	=

all	: echo $(RUNUX)/bin/dwc

echo	:
	@echo HYPUB/UTILSRC/DWC$(ECHOLANG)

$(RUNUX)/bin/dwc		: $(OBJS)
	$(CC) -o $(RUNUX)/bin/dwc $(LDOPT) $(OBJS) $(LIBS)
	strip $(RUNUX)/bin/dwc

$(DOBJ)/dwc.o		: dwc.c
	$(CC) -o $(DOBJ)/dwc.o $(CFLAGS) -c dwc.c
