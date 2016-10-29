#
TARGET	= tms_ora
APOBJ	= dumy.o

APPDIR	= $(TMAXDIR)/appbin
TMAXLIBD= $(TMAXDIR)/lib64
ORALIBD = ${ORACLE_HOME}/lib

ORALIBS = -lclntsh `cat /oracle/app/oracle8/product/817/lib/sysliblist` -ldl -lm
TMAXLIBS  = -ltms -loras
#TMAXLIBS  = -ltmsdbg -loras

CFLAGS = -xarch=v9 -O

$(TARGET): $(APOBJ)
	$(CC) $(CFLAGS) -L$(TMAXLIBD) -L$(ORALIBD) -o $(TARGET) $(APOBJ) $(ORALIBS) $(TMAXLIBS)
	mv $(TARGET) $(APPDIR)/.

$(APOBJ):
	$(CC) $(CFLAGS) -c dumy.c

#
clean:
	-rm -f *.o core $(TARGET)
