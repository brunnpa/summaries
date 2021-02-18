# ************************************************************
# Fach    BSy
# Autor   M. Thaler
# Version v.fs20
# ************************************************************

CC  = gcc
CF  = -Wall -g
EX  = glTest
LIB = 

build:	glTest.o getLine.o
	$(CC) $(CF) glTest.o getLine.o -o $(EX).e $(LIB)

.c.o:
	$(CC) $(CF) -c $<

.cc.o:
	$(CC) $(CF) -c $<

clean:
	rm -f *.o *.e

all:
	@make -s clean
	make 
