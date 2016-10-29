include	$(SVRHOME)/makefile.env

FNAME	= cmregtst

CFLAGS	= \
	-I$(COMMON)/include \
	$(CFOPT) $(CFOPTL)

HEADER	= \
	$(COMMON)/include/cbuni.h \
	$(COMMON)/include/cmreg.h \
	$(COMMON)/include/gps.h \
 	$(COMMON)/include/stpapi.h

DLIBS	= \
	$(RUNUX)/lib/libcmreg.so \
	$(RUNUX)/lib/libgps.so \
	$(RUNUX)/lib/libstpapi.so

LIBS	= \
	-L$(RUNUX)/lib \
	-lcmreg -lstpapi -lsctl -lpisam -lgps $(LDISAM)

OBJS	= $(DOBJ)/$(FNAME).o

all	: echo $(RUNUX)/cops/run/$(FNAME)

echo	:
	@echo COMMON/TESTSRC/$(FNAME)$(ECHOLANG)

$(RUNUX)/cops/run/$(FNAME)	: $(OBJS) $(DLIBS) 
	$(CC) -o $(RUNUX)/cops/run/$(FNAME) $(LDOPT) $(OBJS) $(LIBS)
	strip $(RUNUX)/cops/run/$(FNAME)

$(DOBJ)/$(FNAME).o		: $(FNAME).c $(HEADER) 
	$(CC) -o $(DOBJ)/$(FNAME).o $(CFLAGS) -c $(FNAME).c
