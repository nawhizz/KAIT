include	$(SVRHOME)/makefile.env

FNAME	= gpstest

RDIEAP	= $(RUNUX)/bin

LDHYPUB		= $(RUNUX)/lib

IDCOM	= $(COMMON)/include

LGPS	= $(LDHYPUB)/libgps.a

DLIBS	= $(LGPS)

LIBS	= $(LGPS)

CFLAGS	= -I$(IDCOM) $(CFOPT)

FLIST	= \
	cfg	cobol	dataman	dateman	etc	fifo	fileio	keyio \
	main	network	process	ring	shm

ODGPST	= obj

OGPSTS	= $(FLIST:%=$(ODGPST)/%.o)

all	: echo 	$(ODGPST)/$(FNAME)

echo	:
	@echo HYPUB/TESTSRC/$(FNAME)

$(ODGPST)/$(FNAME) : $(OGPSTS) $(DLIBS)
	$(CC) -o $@ $(OGPSTS) $(LIBS)
	strip $@

$(ODGPST)/%.o	: %.c
	$(CC) -o $@ $(CFLAGS)  -c $(*:%=%.c)
