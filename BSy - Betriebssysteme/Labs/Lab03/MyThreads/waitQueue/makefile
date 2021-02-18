# ---------------------------------------------------------------------------
# Makefile fuer MyThreads
# Kurs:	   BSy, M. Thaler, 2012
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

main4:	main4.o  mthread.o dispatcher.o queues.o mlist.o
	$(CMP) main4.o mthread.o dispatcher.o queues.o mlist.o -o $@.e


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
	@if [ -e ../prioQueues/main3.c ]; then cp -u ../prioQueues/main3.c .; fi;
	@if [ -e main3.c ]; then make --no-print-directory main3; fi;
	@make --no-print-directory main4

#-----------------------------------------------------------------------------
