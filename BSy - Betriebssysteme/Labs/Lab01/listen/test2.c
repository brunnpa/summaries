//******************************************************************************
// File:    test2.c
// Purpose: test for single linked list
// Author:  M. Thaler, 2012, (based on former work by J. Zeman and M. Thaler)
//          tha, 5/19: mlSortIn() with callback function
// Version: v.fs20
//******************************************************************************

#include <stdio.h>
#include <stdlib.h>
#include <assert.h>

#include "commondefs.h"
#include "mlist.h"
#include "mthread.h"

//******************************************************************************
// prototypes of local functions

void printList(mlist_t* list, const char *str);
void beginTest(const char *str);

int compareReadyTimes(void *a, void *b) {
    int ia, ib;
    ia = ((mthread_t *)a)->readyTime;
    ib = ((mthread_t *)b)->readyTime;
    return (ia >= ib);
}

//******************************************************************************

int main(int argc, char *args[]){

    unsigned int tid = 0, i;
    mthread_t* th;
    mlist_t* queue1 = mlNewList();
    mlist_t* queue2 = mlNewList();
    mlist_t* queue3 = mlNewList();

 
    // print empty queues ------------------------------------------------------

    beginTest("creating empyt queues");
    printf("\n");
    queue1 = mlNewList();
    queue2 = mlNewList();
    queue3 = mlNewList();

    printList(queue1, "queue1 -> empty");
    printList(queue2, "queue2 -> empty");
    printList(queue3, "queue3 -> empty");

    // set up queues -----------------------------------------------------------

    beginTest("make fifo queue and sort queue\n");
    tid = 0;
    int count = 8;

    for (i = 0; i < count; i++) {
        mlEnqueue(queue1,  mtNewThread(tid++, rand()%6 + 1,  rand()%6 + 1));        
    }

    for (i = 0; i < count; i++) {
        th = mlDequeue(queue1);
        mlSortIn(queue2, th, compareReadyTimes);    // -> sorted queue
        mlEnqueue(queue3, th);                      // -> fifo queue 
    }

    mlDelList(queue1);
    mlDelList(queue2);

    // Durch das löschen der Queue 1 und 2, wird die Referenz von der queue3 ebenfalls gelöscht -> dadurch zeigt es auf Random-Memory
    printList(queue3, "queue3 -> fifo queue");
    
    if (argc > 1) {
        mlDelList(queue3);
    }

    exit(0);
}

//******************************************************************************

void printList(mlist_t* list, const char *str) {
    mthread_t* p;
    printf("--> printing %s, total %d elements\n", str, mlGetNumNodes(list));
    mlSetPtrFirst(list);
    while((p = mlReadCurrent(list)) != NULL) {
        printf("  > node tid = %8d, ready time = %2d\n", p->tID, p->readyTime);
        mlSetPtrNext(list);
    }
    printf("\n");
}

//******************************************************************************

void beginTest(const char *str) {
    printf("\n*************************************************************\n");
    if (str != NULL)
        printf("check: %s\n", str);
}


//******************************************************************************


