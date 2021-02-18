# Author  M. Thaler, InIT/ZHAW
# Version v.fs20

CMP=		gcc
CMPFLAGS=       -Wall
LDFLAGS=
EXENAME1=	ProcA11_1.e
FNAM1=		ProcA11_1.o workerUtils.o
LIBNAME=	

Compile:	$(EXENAME1) $(EXENAME2)

$(EXENAME1):	$(FNAM1)
		$(CMP)  $(CMPFLAGS) $(FNAM1) $(LIBNAME) $(LDFLAGS) -o $@

.c.o:
		$(CMP) -c $(CMPFLAGS) $< 

.cc.o:
		$(CMP) -c $(CMPFLAGS) $< 

clean:
		rm -f *.o $(EXENAME1) $(EXENAME2)

all:
		@make clean &> /dev/null
		@make

