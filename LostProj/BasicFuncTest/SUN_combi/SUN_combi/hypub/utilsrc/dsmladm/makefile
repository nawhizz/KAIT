include	$(SVRHOME)/makefile.env

CFLAGS	= \
	-I$(COMMON)/include \
	$(CFOPT) $(CFOPTL)

HEADER	= \
	$(COMMON)/include/dsml.h \
	$(COMMON)/include/pisam.h \
	$(COMMON)/include/gps.h

DLIBS	= \
	$(RUNUX)/lib/libdsml.a \
	$(RUNUX)/lib/libpisam.a \
	$(RUNUX)/lib/libgps.a

LIBS	= \
	$(RUNUX)/lib/libdsml.a \
	$(RUNUX)/lib/libpisam.a \
	$(RUNUX)/lib/libgps.a \
	$(LDISAM)

OBJS	= \
	$(DOBJ)/dsmladm.o

all	: echo $(RUNUX)/bin/dsmladm

echo	:
	@echo HYPUB/UTILSRC/DSMLADM$(ECHOLANG)

$(RUNUX)/bin/dsmladm	: $(OBJS) $(DLIBS)
	$(CC) -o $(RUNUX)/bin/dsmladm $(LDOPT) $(OBJS) $(LIBS)
	strip $(RUNUX)/bin/dsmladm

$(DOBJ)/dsmladm.o		: dsmladm.c $(HEADER)
	$(CC) -o $(DOBJ)/dsmladm.o $(CFLAGS) -c dsmladm.c
