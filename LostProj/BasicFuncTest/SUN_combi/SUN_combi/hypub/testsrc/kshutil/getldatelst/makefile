include	$(SVRHOME)/makefile.env

CFLAGS	= \
	$(CFOPT) $(CFOPTL)

HEADER	= 

DLIBS	= \

LIBS	= \

OBJS	= $(DOBJ)/getldatelst.o 

all	: echo $(RUNUX)/bin/getldatelst

echo	:
	@echo KSHUTIL/GETLDATELST

$(RUNUX)/bin/getldatelst	: $(OBJS) $(DLIBS)
	$(CC) -o $(RUNUX)/bin/getldatelst $(LDOPT) $(OBJS) $(LIBS)
	strip $(RUNUX)/bin/getldatelst

$(DOBJ)/getldatelst.o		: getldatelst.c $(HEADER) 
	$(CC) -o $(DOBJ)/getldatelst.o $(CFLAGS) -c getldatelst.c

