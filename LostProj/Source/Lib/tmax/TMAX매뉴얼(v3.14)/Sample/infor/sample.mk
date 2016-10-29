#
# File ID : ServerNameNX.mk ( ServerName.mk )
# 
# Spec    : build Non-XA Server
#
# Modify  :
#

#
# SERVER = Server name
# SERVICES =  Service name ; 추가적으로 comma(,)로 구분
# SRCPC =  *.ec name       ; 추가적으로 blank로 구분 
#

SERVER	= svr2
SERVICES= TOUPPER,TOLOWER

SRCPC	= toupper.ec tolower.ec

#Tmax Set Env.
TMAXBINDIR = ${TMAXDIR}/bin
TMAXLIBDIR = ${TMAXDIR}/lib
TMAXINCDIR = ${TMAXDIR}/usrinc
TMAXAPPBIN = $(TMAXDIR)/appbin
#SVCTDIR    = $(TMAXDIR)/svct
SDLDIR     = ${TMAXDIR}/sdl
#OBJS    = $(SDLOBJ) $(SVCTOBJ) $(COBJS)
OBJS    = $(SDLOBJ) $(COBJS)
SDLOBJ = ${SDLFILE:.s=_sdl.o}
SDLC   = ${SDLFILE:.s=_sdl.c}
#SVCTOBJ = $(SERVER)_svctab.o
#SVCTC = $(SERVER)_svctab.c
SDLFILE = tmax.s
TMAXLIBS  = -lsvr -lsocket -lnsl

### For Informix on Unix
INFOINCED = $(INFORMIXDIR)/incl/esql
INFOINCDD = $(INFORMIXDIR)/incl/dmi
INFOLIBD  = $(INFORMIXDIR)/lib
INFOLIBED = $(INFORMIXDIR)/lib/esql
INFOLIBSX = -lifsql -lifasf -lifgen -lifos -lifgls -lnsl -lsocket -laio \
        -lm -ldl -lelf /userdir/informix/lib/esql/checkapi.o -lifglx 
# -lifxa    XA모드 사용시 추가

# CC Environments
# CC=cc
INCDIRS= -I$(TMAXDIR) -I$(TMAXINCDIR) -I${INFOINCED} -I${INFOINCDD} \
        -I$(SDLDIR) -I$(TMAXDIR)/fdl
LIBDIRS= -L$(TMAXLIBDIR) -L${INFOLIBD} -L${INFOLIBED}
CFLAGS = -O $(INCDIRS) ${LIBDIRS}
PCFLAGS= include=$(TMAXDIR)

# Exhaustive list of targets to be made
all: $(CLFUNC) $(COBJS) ${SERVER}

# Rule for cleaning out generated files
clean:
#	rm -f ${CLFUNC} $(SDLOBJ) $(SVCTOBJ) $(COBJS) $(SERVER)
	rm -f ${CLFUNC} $(SDLOBJ) $(COBJS) $(SERVER)

# This section contains rules for building servers !

$(SERVER): $(OBJS)
	$(CC) $(CFLAGS) -o $@ $(OBJS) $(NXCONNECT) $(TMAXLIBS)  $(INFOLIBSNX) 
	@echo "          **************************************************"
	@echo "          ****** Build NXA SERVER $(SERVER) Complete! ******"
	@echo "          **************************************************"
	cp ${SERVER} ${TMAXAPPBIN}

#$(SVCTOBJ):
#	$(CC) -I$(TMAXDIR) -c $(SVCTDIR)/$(SVCTC)

$(SDLOBJ):
	$(TMAXDIR)/bin/sdlc -i $(SDLDIR)/$(SDLFILE)
	$(CC) $(CFLAGS) -c $(SDLDIR)/$(SDLC)

# Suffix Rules
.SUFFIXES:	.v .V .m .M .ec .c .o

# Rule for creating C bookigrams from embedded SQL bookigrams
.ec.c:
	esql -e $*.ec

# Rule for creating object files from C bookigrams
.c.o:
	$(CC) $(CFLAGS) -c $*.c
