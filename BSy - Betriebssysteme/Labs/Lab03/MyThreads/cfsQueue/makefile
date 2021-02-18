# ---------------------------------------------------------------------------
# Makefile fuer MyThreads
# Kurs:	   BSy, M. Thaler, 2012, 5/2019
# File:	   makefile 
# Version: v.fs20
# ---------------------------------------------------------------------------

#macros

CFL = -Wall -g 
CMP = gcc -std=gnu99 $(CFL)


main1:	main1.o  mthread.o dispatcher.o queues.o mlist.o
	$(CMP) main1.o mthread.o dispatcher.o queues.o mlist.o -o $@.e

main2:	main2.o  mthread.o dispatcher.o queues.o mlist.o
	$(CMP) main2.o mthread.o dispatcher.o queues.o mlist.o -o $@.e

main3:	main3.o  mthread.o dispatcher.o queues.o mlist.o
	$(CMP) main3.o mthread.o dispatcher.o queues.o mlist.o -o $@.e

.c.o:
	$(CMP) -c $<

.cc.o:
	$(CMP) -c $<

clean:		
	rm -f *.o main*.e
	echo "directory cleaned"

all:
	@make --no-print-directory clean
	@make --no-print-directory main1
	@make --no-print-directory main2
	@make --no-print-directory main3

#-----------------------------------------------------------------------------
