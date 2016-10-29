#
TARGET	= $(COMP_TARGET)
APOBJS	= $(TARGET).o
FDLFILE	= demo.f

APPDIR	= $(TMAXDIR)/appbin
TMAXLIBD= $(TMAXDIR)/lib

TMAXLIBS= -lcli -lnsl -lsocket
CFLAGS	= -xarch=v9 -O -I$(TMAXDIR)

#
.SUFFIXES : .c

.c.o: 
	$(CC) $(CFLAGS) -c $<

#
# client compile
#

$(TARGET): $(APOBJS)
	$(CC) $(CFLAGS) -L$(TMAXLIBD) -o $(TARGET) $(APOBJS) $(TMAXLIBS) 

#
clean:
	-rm -f *.o core $(TARGET)
