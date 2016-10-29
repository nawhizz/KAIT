include	$(SVRHOME)/makefile.env

FNAME	= pisamtst

RDIEAP	= $(RUNUX)/bin

LDHYPUB	= $(RUNUX)/lib

IDCOM	= $(COMMON)/include

LPISAM	= $(LDHYPUB)/libpisam.a

DLIBS	=

LIBS	= \
	-L$(RUNUX)/lib \
	-lgps -lpisam \
	$(LDISAM)

CFLAGS	= -I$(IDCOM) $(CFOPT)

FLIST	= \
	main		TPI_OPEN	TPI_KEYLENGTH	TPI_READ	TPI_WRITE

OBJ	= obj

OTPISAM	= $(FLIST:%=$(OBJ)/%.o)

all	: echo 	$(RDIEAP)/$(FNAME)

echo	:
	@echo HYPUB/TESTSRC/$(FNAME)

$(RDIEAP)/$(FNAME) : $(OTPISAM) $(DLIBS)
	$(CC) -o $@ $(OTPISAM) $(LIBS)
	strip $@

$(OBJ)/%.o	: %.c
	$(CC) -o $@ $(CFLAGS)  -c $(*:%=%.c)
