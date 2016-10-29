include	$(SVRHOME)/makefile.env

FNAME	= txlogcon2

CFLAGS	= \
	-I$(COMMON)/include \
	-I$(DLTP)/dblay \
	$(CFOPT)

HEADER	= \
	$(COMMON)/include/cbuni.h \
	$(COMMON)/include/gps.h \
	$(COMMON)/include/pisam.h \
	$(DLTP)/dblay/usid.h

DLIBS	= \
	$(RUNUX)/lib/libdisam.so \
	$(RUNUX)/lib/libgps.so \
	$(RUNUX)/lib/libpisam.so

LIBS	= \
	-lpisam -lgps $(LDISAM)

OBJS	= \
	$(DOBJ)/$(FNAME).o

all	: echo $(RUNUX)/test/$(FNAME)

echo	:
	@echo KSHUTIL/TXLOGCON2

$(RUNUX)/test/$(FNAME)		: $(OBJS) $(DLIBS)
	$(CC) -o $(RUNUX)/test/$(FNAME) $(LDOPT) $(OBJS) $(LIBS)
	strip $(RUNUX)/test/$(FNAME)

$(DOBJ)/$(FNAME).o		: $(FNAME).c $(HEADER)
	$(CC) -o $(DOBJ)/$(FNAME).o $(CFLAGS) -c $(FNAME).c

