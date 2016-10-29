include	$(SVRHOME)/makefile.env

FNAME	= dsml2tst

CFLAGS	= \
	-I$(COMMON)/include \
	$(CFOPT)

HEADER	= \
	$(COMMON)/include/cbuni.h \
	$(COMMON)/include/dsml.h \
	$(COMMON)/include/gps.h

DLIBS	= \
	$(RUNUX)/lib/libdsml.a \
	$(RUNUX)/lib/libpisam.a \
	$(RUNUX)/lib/libgps.a \
	$(RUNUX)/lib/libdisam.a

LIBS	= $(DLIBS)

OBJS	= $(DOBJ)/$(FNAME).o

all	: echo $(RUNUX)/bin/$(FNAME)

echo	:
	@echo HYPUB/TESTSRC/$(FNAME)

$(RUNUX)/bin/$(FNAME) : $(OBJS) $(DLIBS)
	$(CC) -o $(RUNUX)/bin/$(FNAME) $(LDOPT) $(OBJS) $(LIBS)
	strip $(RUNUX)/bin/$(FNAME)

$(DOBJ)/$(FNAME).o	: $(FNAME).c $(HEADER)
	$(CC) -o $(DOBJ)/$(FNAME).o $(CFLAGS)  -c $(FNAME).c
