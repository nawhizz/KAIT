# makefile

TARGET  = agenttest     
APOBJS	= $(TARGET).o
SDLFILE = demo.s 

LIBS	= -lsvr -lnsl -lsocket
OBJS	= $(APOBJS) $(SDLOBJ) $(SVCTOBJ)
SDLOBJ	= ${SDLFILE:.s=_sdl.o}
SDLC	= ${SDLFILE:.s=_sdl.c}
SVCTOBJ = $(TARGET)_svctab.o

CFLAGS	= -O  -I$(INFORMIXDIR)/incl/esql -I$(TMAXDIR)

APPDIR	= $(TMAXDIR)/appbin
SVCTDIR	= $(TMAXDIR)/svct
LIBDIR	= $(TMAXDIR)/lib
INFLIBD	= $(INFORMIXDIR)/lib/esql
INFLIBDD = $(INFORMIXDIR)/lib
INFLIBS = -lifsql -lifasf -lifgen -lifos -lifgls -lnsl -lsocket -laio -lm -ldl -lelf /userdir/informix/lib/esql/checkapi.o -lifglx  -lifxa

#
.SUFFIXES : .c
.c.o:
	$(CC) $(CFLAGS) -c $<

#
# Server compile
#

$(TARGET): $(OBJS)
	cc -L$(LIBDIR) -L$(INFLIBD) -L$(INFLIBDD) -o $(TARGET) $(OBJS) $(LIBS) $(INFLIBS)
	mv $(TARGET) $(APPDIR)/.

$(APOBJS): $(TARGET).ec
	esql -e $(TARGET).ec
$(SVCTOBJ):
	cc $(CFLAGS) -c $(SVCTDIR)/$(TARGET)_svctab.c
$(SDLOBJ):
	$(TMAXDIR)/bin/sdlc -i ../sdl/$(SDLFILE)
	cc $(CFLAGS) -c ../sdl/$(SDLC)
 
#
clean:
	-rm -f *.o core $(TARGET) $(TARGET)_svctab.c
