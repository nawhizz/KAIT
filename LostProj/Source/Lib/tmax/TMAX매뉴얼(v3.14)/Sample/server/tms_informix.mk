#
INFOLIBDIR = $(INFORMIXDIR)/lib
INFOLIBD = $(INFORMIXDIR)/lib/esql
INFOLIB = -lifsql -lifasf -lifgen -lifos -lifgls -lnsl -lsocket -laio -lm -ldl -lelf /informix/lib/esql/checkapi.o -lifglx -lifxa
TARGET	= tms_informix
APOBJ	= dumy.o
APPDIR	= $(TMAXDIR)/appbin
TMAXLIBD= $(TMAXDIR)/lib64
TMAX_BKAPPBIN= $(TMAXDIR)/bkappbin
#TMAXLIBS  = -ltms -linfs -brtl
TMAXLIBS  = -ltms -linfls
#CFLAGS = -xarch=v9 -o -O -I$(INFORMIXDIR)/incl/esql  -q32
CFLAGS = -xarch=v9 -O -I$(INFORMIXDIR)/incl/esql
all: $(TARGET)
$(TARGET): $(APOBJ)
	$(CC) $(CFLAGS) -L$(TMAXLIBD) -o $(TARGET) -L$(INFOLIBDIR) -L$(INFOLIBD) $(INFOLIB) $(APOBJ) $(TMAXLIBS)
	mv $(TARGET) $(TMAX_BKAPPBIN)
$(APOBJ):
	$(CC) $(CFLAGS) -c dumy.c
#
clean:
	-rm -f *.o core $(TARGET)
