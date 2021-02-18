# *************************************************************
# Fach    BSy
# Autor   M. Thaler
# Stand   11/2014
# Version v.fs20
# *************************************************************

CMP=		gcc
CMPFLAGS=       -Wall
LDFLAGS=
EXENAME=	ProcA3.e
FNAME=		ProcA3
EXENAMC=	ChildProcA3.e
FNAMC=		ChildProcA3
LIBNAME=
LIBNAME=

compile:	$(EXENAME) $(EXENAMC)

$(EXENAME):	$(FNAME).o
		$(CMP)  $(FNAME).o $(LIBNAME) $(LDFLAGS) -o $@

$(EXENAMC):	$(FNAMC).o
		$(CMP)  $(FNAMC).o $(LIBNAME) $(LDFLAGS) -o $@
	
.c.o:
		$(CMP) -c $(CMPFLAGS) $<
	
.cc.o:
		$(CMP) -c $(CMPFLAGS) $<
	
clean:
		rm -f *.o $(EXENAME) $(EXENAMC)

all:
		@make clean
		@make
