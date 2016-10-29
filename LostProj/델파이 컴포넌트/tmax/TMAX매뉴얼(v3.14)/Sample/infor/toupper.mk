TARGET	= toupper
APOBJS	= $(TARGET).o

APPDIR	= $(TMAXDIR)/appbin
TMAXLIBD= $(TMAXDIR)/lib
NSDLOBJ = $(TMAXDIR)/lib/sdl.o

TMAXLIBS= -lcli -lnsl -lsocket

### For Tmax on Uinx
TMAXINCDIR = $(TMAXDIR)/usrinc

### For Informix on Unix
INFOINCED = $(INFORMIXDIR)/incl/esql
INFOINCDD = $(INFORMIXDIR)/incl/dmi
INFOLIBD  = $(INFORMIXDIR)/lib
INFOLIBED = $(INFORMIXDIR)/lib/esql
INFOLIBSNX = -lifsql -lifasf -lifgen -lifos -lifgls -laio -lm -ldl -lelf /informix/lib/esql/checkapi.o -lifglx
# -lifxa    XA모드 사용시 추가


INCDIRS= -I$(TMAXDIR) -I$(TMAXINCDIR) -I${INFOINCED} -I${INFOINCDD} -I$(NSDLOBJ) 
LIBDIRS= -L$(TMAXLIBD) -L$(INFOLIBD) -L$(INFOLIBED)
CFLAGS = -xarch=v9 -O $(INCDIRS) $(LIBDIRS)

$(TARGET): $(APOBJS)
	$(CC) $(CFLAGS) $(INCDIRS) $(LIBDIRS) -o $(TARGET) $(APOBJS) $(APSOURCE) $(TMAXLIBS) $(INFOLIBSNX)

# Suffix Rules
.SUFFIXES:      .v .V .m .M .ec .c .o

.ec.c:
	esql -e $*.ec

.c.o: 
	$(CC) $(CFLAGS) -c $*.c

clean:
	-rm -f *.o core $(TARGET)
