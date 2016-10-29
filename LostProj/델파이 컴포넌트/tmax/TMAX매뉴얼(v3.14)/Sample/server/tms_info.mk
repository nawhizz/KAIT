TARGET  = tms_info

INFOLIBDIR = ${INFORMIXDIR}/lib
INFOELIBDIR = ${INFORMIXDIR}/esql
INFOLIBD = ${INFORMIXDIR}/lib/esql
INFOLIBS = -lifsql -lifasf -lifgen -lifos -lifgls -lnsl -lsocket -laio -lm -ldl -lelf /informix/lib/esql/checkapi.o -lifglx -lifxa


TMAXLIBDIR = $(TMAXDIR)/lib64
TMAXLIBS  = -ltms -linfls

CFLAGS = -xarch=v9

$(TARGET):
	$(CC) $(CFLAGS) -o $(TARGET) -L$(TMAXLIBDIR) $(TMAXLIBS) -L$(INFOLIBD) -L$(INFOLIBDIR) -L$(INFOELIBDIR) $(INFOLIBS)
#	mv $(TARGET) $(TMAXDIR)/appbin/.

#
clean:
	-rm -f  core $(TARGET) $(TMAXDIR)/appbin/$(TARGET)

install:
	-cp tms_info $(TMAXDIR)/appbin/am_tms

