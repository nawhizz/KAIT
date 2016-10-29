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
include ${BASEINCDIR}/makecomm.inc

SERVER	= df001
SERVICES= ServiceName1,ServiceName2,ServiceName3...

SRCPC	= df001_01.ec 

#Tmax Set Env.
OBJS    = $(SDLOBJ) $(SVCTOBJ) $(COBJS)
SDLDIR = $(BASEINCDIR)
SDLOBJ = ${SDLFILE:.s=_sdl.o}
SDLC   = ${SDLFILE:.s=_sdl.c}
SVCTOBJ = $(SERVER)_svctab.o
SVCTC = $(SERVER)_svctab.c
SDLFILE = demo.s

# Exhaustive list of targets to be made
all: $(CLFUNC) $(COBJS) ${SERVER}

# Rule for cleaning out generated files
clean:
	rm -f ${CLFUNC} $(SDLOBJ) $(SVCTOBJ) $(COBJS) $(SERVER)

# This section contains rules for building servers !

$(SERVER): $(OBJS)
	$(CC) $(CFLAGS) -o $@ $(OBJS) $(NXCONNECT) $(TMAXLIBS)  $(INFOLIBSNX) 
	@echo "          **************************************************"
	@echo "          ****** Build NXA SERVER $(SERVER) Complete! ******"
	@echo "          **************************************************"
	cp ${SERVER} ${TMAXAPPBIN}

$(SVCTOBJ):
	$(CC) -I$(TMAXDIR) -c $(SVCTDIR)/$(SVCTC)

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
