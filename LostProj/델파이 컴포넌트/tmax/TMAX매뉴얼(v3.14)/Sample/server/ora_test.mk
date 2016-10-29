# Server Pro*C makefile

CFLAGS  = -xarch=v9 -O -I$(ORAINCLDIR) -g

ORAINCLDIR=$(ORACLE_HOME)/precomp/public
ORALIBD = ${ORACLE_HOME}/lib
ORALIBS = -lclntsh `cat /oracle/app/oracle8/product/817/lib64/sysliblist` -ldl -lm

#PROC
PROFLAGS = 

.SUFFIXES:  .pc .c .o

.pc.c:
	proc $(PROFLAGS) iname=$*.pc

.c.o:
	$(CC) $(CFLAGS) -c $*.c

.pc.o:
	proc $(PROFLAGS) iname=$*.pc
	$(CC) $(CFLAGS) -c $*.c

#
# server compile
#

ora_test:ora_test.o
	$(CC) $(CFLAGS) -L$(ORALIBD) -o ora_test ora_test.o $(ORALIBS)

clean:
	-rm -f *.o core $(OBJS) $(COBJS) $(OBJS).lis

