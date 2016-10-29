include	$(SVRHOME)/makefile.env

CFLAGS	= \
	-I$(COMMON)/include \
	$(CFOPT) $(CFOPTL)

HEADER	= \
	$(COMMON)/include/sockcomm.h

STATIC_OBJS	= \
	$(SDOBJ)/sockcomm.o	$(SDOBJ)/l_socksethyerrno.o

DYNAMIC_OBJS	= \
	$(DDOBJ)/sockcomm.o	$(DDOBJ)/l_socksethyerrno.o

all	: echo $(RUNUX)/lib/libsockcomm.a \
		$(RUNUX)/lib/libsockcomm.$(MAKESLN)

echo		:
	@echo	HYPUB/LIBSRC/SOCKCOMM$(ECHOLANG)

$(RUNUX)/lib/libsockcomm.a	: $(STATIC_OBJS)
	ar vcr $(RUNUX)/lib/libsockcomm.a $(STATIC_OBJS)

$(RUNUX)/lib/libsockcomm.$(MAKESLN)	: $(DYNAMIC_OBJS)
	$(GENSL) -o $(RUNUX)/lib/libsockcomm.$(MAKESLN) $(MAKESL) $(DYNAMIC_OBJS)

$(SDOBJ)/sockcomm.o	: sockcomm.c $(HEADER)
	$(CC) -o $(SDOBJ)/sockcomm.o $(CFLAGS) -c sockcomm.c

$(SDOBJ)/l_socksethyerrno.o	: l_socksethyerrno.c $(HEADER)
	$(CC) -o $(SDOBJ)/l_socksethyerrno.o $(CFLAGS) -c l_socksethyerrno.c

$(DDOBJ)/sockcomm.o	: sockcomm.c $(HEADER)
	$(CC) -o $(DDOBJ)/sockcomm.o $(MAKESLO) $(CFLAGS) -c sockcomm.c

$(DDOBJ)/l_socksethyerrno.o	: l_socksethyerrno.c $(HEADER)
	$(CC) -o $(DDOBJ)/l_socksethyerrno.o $(MAKESLO) $(CFLAGS) -c l_socksethyerrno.c

