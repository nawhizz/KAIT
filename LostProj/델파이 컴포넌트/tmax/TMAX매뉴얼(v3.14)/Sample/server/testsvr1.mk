### Base Environment

### For Informix on Linux
INFOINCED = $(INFORMIXDIR)/incl/esql
INFOINCDD = $(INFORMIXDIR)/incl/dmi
INFOLIBD = $(INFORMIXDIR)/lib
INFOLIBED = $(INFORMIXDIR)/lib/esql
INFOLIBSX = -lifsql -lifasf -lifgen -lifos -lifgls -laio -lm -ldl -lelf /informix/lib/esql/checkapi.o -lifglx -lifxa 
INFOLIBSNX = -lifsql -lifasf -lifgen -lifos -lifgls -laio -lm -ldl -lelf /informix/lib/esql/checkapi.o -lifglx

### Tmax
TMAXBINDIR=${TMAXDIR}/bin
TMAXLIBDIR=${TMAXDIR}/lib64
TMAXAPPBIN= $(TMAXDIR)/appbin
SVCTDIR=$(TMAXDIR)/svct
TMAXLIBS= -lsvr -lnsl -lsocket 

### User
CLFUNC = ${SRCPC:.ec=.c}
COBJS = ${SRCPC:.ec=.o}

# CC Environments
# CC=cc
INCDIRS= -I$(TMAXDIR) -I${INFOINCED} -I${INFOINCDD}
LIBDIRS= -L$(TMAXLIBDIR) -L${INFOLIBD} -L${INFOLIBED} 
CFLAGS= -xarch=v9 -O $(INCDIRS) ${LIBDIRS}

SERVER	= testsvr1
SRCPC	= testsvr1.ec

### Tmax Set Env.
OBJS   = $(SVCTOBJ) $(COBJS) 
SVCTOBJ= $(SERVER)_svctab.o
SVCTC  = $(SERVER)_svctab.c

# Exhaustive list of targets to be made
all: $(CLFUNC) $(COBJS) ${SERVER}

# Rule for cleaning out generated files
clean:
	rm -f ${CLFUNC} $(SVCTOBJ) $(COBJS)

# This section contains rules for building servers !

$(SERVER): $(OBJS)
	esql $(CFLAGS) -o $@ $(OBJS) $(INFOLIBSX) $(TMAXLIBS)
	@echo "          *************************************************"
	@echo "          ****** Build XA SERVER $(SERVER) Complete! ******"
	@echo "          *************************************************"
	tmdown -S $@
	cp $@ $(TMAXAPPBIN)
	tmboot -S $@

$(SVCTOBJ):
	touch $(SVCTDIR)/$(SVCTC)
	esql $(CFLAGS) -c $(SVCTDIR)/$(SVCTC)

# Suffix Rules
.SUFFIXES:  .v .V .m .M .ec .c .o

# Rule for creating C bookigrams from embedded SQL bookigrams
.ec.c:
	esql -e $*.ec

# Rule for creating object files from C bookigrams
.c.o:
	esql $(CFLAGS) -c $*.c

