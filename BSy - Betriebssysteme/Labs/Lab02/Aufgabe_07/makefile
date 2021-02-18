# *************************************************************
# Fach    BSy
# Autor   M. Thaler
# Stand   11/2014
# Version v.fs20
# *************************************************************

CMP=		gcc
CMPFLAGS=	-Wall
LDFLAGS=
EXENAMES=	aaaa.e
FNAME=		ProcA7
LIBNAME=

$(EXENAMES):	$(FNAME).o
		$(CMP)  $(FNAME).o $(LIBNAME) $(LDFLAGS) -o $@

.c.o:
		$(CMP) -c $(CMPFLAGS) $<

.cc.o:
		$(CMP) -c $(CMPFLAGS) $<

clean:
		rm -f *.o $(EXENAMES)

all:
		@make clean
		@make

