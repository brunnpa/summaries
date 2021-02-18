# ************************************************************
# Fach    BSy
# Autor   M. Thaler
# Version v.fs20
# ************************************************************

CC  = gcc
CF  = -Wall -g
EX  = $(notdir $(shell pwd))
LIB = -lreadline

build:	siShell.o getLine.o
	$(CC) $(CF) siShell.o getLine.o -o $(EX).e $(LIB)

.c.o:
	$(CC) $(CF) -c $<

.cc.o:
	$(CC) $(CF) -c $<

clean:
	rm -f *.o *.e

all:
	@make -s clean
	make 
