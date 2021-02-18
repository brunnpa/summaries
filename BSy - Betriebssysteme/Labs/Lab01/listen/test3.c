//******************************************************************************
// File:    test1.c
// Purpose: unit test for single linked list
// Author:  M. Thaler, 2012
//          tha, 5/19: mlSortIn() with callback function
// Version: v.fs20
//******************************************************************************
// Testing
//
//
//******************************************************************************

#include <stdio.h>
//#include <assert.h>
#include <stdlib.h>
#include <time.h>

#include "commondefs.h"
#include "mlist.h"
#include "mthread.h"

//******************************************************************************
// prototype of local functions

void beginTest(const char *str);
void endTest(void);

void testListConistency(mlist_t *list);

void shuffleIntArray(int *ar, int size);

int compareReadyTimes(void *a, void *b);

#define assert(X) {}

//******************************************************************************

int main(void){

    mthread_t*   th;
    tnode_t*     tn;
    unsigned int tid, utmp;
    int          count;

    mlist_t*   queue1 = NULL;

    // #1 new, empty list ------------------------------------------------------

    beginTest("initialization of queue");

    queue1 = mlNewList();                       // allocate new queue

    assert(queue1 != NULL);                     // queue exists
    assert(mlGetNumNodes(queue1) == 0);         // queue is empty
    assert(queue1->head == queue1->tail);       // head == tail
    assert(queue1->iter == NULL);               // iter == NULL
    endTest();

    // #2 enqueue 4 threads ----------------------------------------------------

    beginTest("enqueue threads and list consistency");

    count = 4;
    tid   = 0;
    for (unsigned int j = 0; j < count; j++) {
          th = mtNewThread(tid++, 1, 10);
          mlEnqueue(queue1, th);
    }

    assert(queue1                != NULL);      // queue exists
    assert(queue1->head != queue1->tail);       // head != tail
    assert(queue1->head->tcb == NULL);          // tcb ptr -> NULL @ head

    tn = queue1->head->next;
    for (unsigned int j = 0; j < count; j++) {  // check for list consistency
        th = tn->tcb;
        assert(th->tID == j);                   // list in correct order
        if (j == count - 1) {
            assert(tn == queue1->tail);
            assert(tn->next == NULL);
        }
        tn = tn->next;
    }

    endTest();

    // #3 dequeue 4 threads ----------------------------------------------------

    beginTest("dequeue 4 threads");

    count = 4;
    
    for (unsigned int j = 0; j < count; j++) {
        th = mlDequeue(queue1);
        assert(th->tID == j);                   // 
        assert(queue1->head->tcb == NULL);      // tcb ptr -> NULL @ head
        mtDelThread(th);                        // free thread control block
    }

    assert(queue1->head == queue1->tail);       // head == tail
    th = mlDequeue(queue1);                     // dequeue on empty list
    assert(th == NULL);                         //

    mlDelList(queue1);                          // check if ok
    queue1 = NULL;

    endTest();


    // #4 auxilary functions on new and empty list -----------------------------

    beginTest("auxilary functions on new & empty list");

    queue1 = mlNewList();                       // allocate new queue

    assert(queue1 != NULL);                     // queue exists
    assert(mlGetNumNodes(queue1) == 0);         // queue is empty
    assert(queue1->head == queue1->tail);       // head == tail
    assert(queue1->iter == NULL);               // iter == NULL

    assert(mlReadFirst(queue1)   == NULL);      // no entries
    assert(mlReadCurrent(queue1) == NULL);      // current initialized
    mlSetPtrNext(queue1);                       // cannot forward iter on empty
    assert(mlReadCurrent(queue1) == NULL);      // list

    endTest();

    // #5 auxilary functions on new list ---------------------------------------

    beginTest("auxilary functions");

    count = 10;
    tid   = 100;
    for (unsigned int j = 0; j < count; j++) {
          th = mtNewThread(tid++, 1, 10);
          mlEnqueue(queue1, th);
    }

    th = mlReadFirst(queue1);                   // first entry tID
    assert(th != NULL);                         //   not NULL
    assert(th->tID == 100);                     //   first entry

    assert(mlReadCurrent(queue1) == NULL);      // not yet set
    mlSetPtrFirst(queue1);                      // set iteration pointer
    th = mlReadCurrent(queue1);                 // read current threadd
    assert(th != NULL);                         //   not NULL
    assert(th->tID == 100);                     //   first entry

    mlSetPtrFirst(queue1);                      // set iteration pointer
    for (unsigned int j = 0; j < count; j++) {
        th = mlReadCurrent(queue1);             // read current threadd
        assert(th != NULL);                     //   not NULL
        assert(th->tID == j+100);               //   expected entry
        if (j == count - 1)                     // last node == tail node
            assert(queue1->iter==queue1->tail); 
        mlSetPtrNext(queue1);                   // next node
    }

    assert(queue1->iter == NULL);               // iter must be NULL 
    th = mlReadCurrent(queue1);                 // get correct value
    assert(th == NULL);

    mlSetPtrNext(queue1);                       // next at end of list
    assert(th == NULL);

    mlDelList(queue1);                          // delete list
    queue1 = NULL;

    endTest();

    // #6 add four threads -----------------------------------------------------

    beginTest("enqueue and dequeue");

    queue1 = mlNewList();                       // allocate new queue

    count = 4;
    tid   = 0;
    for (unsigned int j = 0; j < count; j++) {
          th = mtNewThread(tid++, 1, 10);
          mlEnqueue(queue1, th);
    }

    assert(queue1                != NULL);      // queue exists
    assert(mlGetNumNodes(queue1) == count);     // queue is not empty
    assert(queue1->head != queue1->tail);       // head == tail
    assert(queue1->head->tcb == NULL);          // tcb ptr -> NULL @ head

    mlSetPtrFirst(queue1);                      // set iteration pointer
    for (unsigned int j = 0; j < count; j++) {               // check for list consistency
        th = mlReadCurrent(queue1);
        assert(th->tID == j);                   // list in correct order
        if (j == count - 1)
            assert(queue1->iter == queue1->tail);
        mlSetPtrNext(queue1);
    }
    assert(mlReadCurrent(queue1) == NULL);      // end of list

    th = mlDequeue(queue1);
    mtDelThread(th);

    th = mlDequeue(queue1);
    assert(th->tID == 1);                       // threads 0 and 1 dequeued
    mtDelThread(th);
    

    while ((th = mlDequeue(queue1)) != NULL)
        mtDelThread(th);

    assert(mlGetNumNodes(queue1) == 0);         // queue is empty

    mlSetPtrFirst(queue1);                      // empty list
    th = mlReadCurrent(queue1);
    assert(th == NULL);

    mlSetPtrNext(queue1);
    assert(mlReadCurrent(queue1) == NULL);      // cannot iterate empty list

    assert(queue1->head->tcb == NULL);          // NULL tcb entry @ head

    assert(mlDequeue(queue1) == NULL);          // dequeue from empty list

    mlDelList(queue1);                          // delete list
    queue1 = NULL;

    endTest();

    // #7 enqueue sorted to empyt list -----------------------------------------
    
    beginTest("enqueue sorted into empty list");

    queue1 = mlNewList();                       // allocate new queue

    assert(mlGetNumNodes(queue1) == 0);         // queue is empty 
    mlSetPtrFirst(queue1);
    assert(mlReadCurrent(queue1) == NULL);

    tid = 0;
    th = mtNewThread(tid++, 1, 10);
    mlSortIn(queue1, th, compareReadyTimes);

    assert(mlGetNumNodes(queue1) == 1);         // queue is not empty
    mlSetPtrFirst(queue1);
    assert(mlReadCurrent(queue1) != NULL);      

    th = mtNewThread(tid++, 1, 20);             // add at end
    mlSortIn(queue1, th, compareReadyTimes);
    assert(mlGetNumNodes(queue1) == 2);         // queue is not empty

    mlSetPtrFirst(queue1);                      // path from head -> tail
    mlSetPtrNext(queue1);
    assert(queue1->iter == queue1->tail);
    mlSetPtrNext(queue1);
    assert(mlReadCurrent(queue1) == NULL);

    th = mtNewThread(tid++, 1, 5);              // add as first  
    mlSortIn(queue1, th, compareReadyTimes);
    assert(mlGetNumNodes(queue1) == 3);         // queue is not empty
    th = mtNewThread(tid++, 1, 15);             // add as first  
    mlSortIn(queue1, th, compareReadyTimes);
    assert(mlGetNumNodes(queue1) == 4);         // queue is not empty
    

    mlSetPtrFirst(queue1);                      // path from head -> tail
    mlSetPtrNext(queue1);
    mlSetPtrNext(queue1);
    mlSetPtrNext(queue1);
    assert(queue1->iter == queue1->tail);
    mlSetPtrNext(queue1);
    assert(mlReadCurrent(queue1) == NULL);

    th = mtNewThread(tid++, 1, 25);             // add at end
    mlSortIn(queue1, th, compareReadyTimes);

    th = mtNewThread(tid++, 1, 30);             // add at end
    mlSortIn(queue1, th, compareReadyTimes);

    mlSetPtrFirst(queue1);                      // check sort order 
    count = 6;
    utmp  = 5;
    for (unsigned int j = 0; j < count; j++) {
        th = mlReadCurrent(queue1);
        assert(mtGetReadyTime(th) == utmp);
        utmp += 5;
        mlSetPtrNext(queue1);
    }
    assert(mlReadCurrent(queue1) == NULL);
    assert(mlGetNumNodes(queue1) == count);     // number of entries

    endTest();

    // #8 dequeue first --------------------------------------------------------

    beginTest("dequeue and dummy node handling");

    tn = queue1->head->next;
    th = mlDequeue(queue1);
    mtDelThread(th);
    assert(tn == queue1->head);                 // dequeued tnode_t -> new head?

    count--;
    assert(mlGetNumNodes(queue1) == count);     // number of entries

    mlSetPtrFirst(queue1);                      // path from head -> tail
    mlSetPtrNext(queue1);
    mlSetPtrNext(queue1);
    mlSetPtrNext(queue1);
    mlSetPtrNext(queue1);
    assert(queue1->iter == queue1->tail);
    mlSetPtrNext(queue1);
    assert(mlReadCurrent(queue1) == NULL);

    endTest();

    // #9 dequeue next thread and add threads sorted ---------------------------

    beginTest("add sorted and enque");

    th = mlDequeue(queue1);
    mtDelThread(th);
    count--;

    mlSortIn(queue1,  mtNewThread(tid++, 1,  3), compareReadyTimes);   count++;
    testListConistency(queue1);

    mlSortIn(queue1,  mtNewThread(tid++, 1, 70), compareReadyTimes);   count++;
    testListConistency(queue1);

    mlSortIn(queue1,  mtNewThread(tid++, 1, 21), compareReadyTimes);   count++;
    testListConistency(queue1);

    mlEnqueue(queue1, mtNewThread(tid++, 1, 80));   count++;
    testListConistency(queue1);

    assert(mlGetNumNodes(queue1) == count);     // number of entries

    mlSetPtrFirst(queue1);                      // path from head -> tail
    for (unsigned int j = 0; j < count-1; j++)
        mlSetPtrNext(queue1);
    assert(queue1->iter == queue1->tail);
    mlSetPtrNext(queue1);
    assert(mlReadCurrent(queue1) == NULL);

    mlSetPtrFirst(queue1);                      // check sort order
    th = mlReadCurrent(queue1);
    utmp = mtGetReadyTime(th);
    mlSetPtrNext(queue1);
    for (unsigned int j = 1; j < count; j++) {
        th = mlReadCurrent(queue1);
        assert(mtGetReadyTime(th) >= utmp);
        utmp = mtGetReadyTime(th);
        mlSetPtrNext(queue1);
    }

    endTest();

    // #10 now dequeue all threads ---------------------------------------------

    beginTest("empty whole list");

    tn = queue1->head->next;
    for (unsigned int j = 0; j < count; j++) {
        th = mlDequeue(queue1);
        assert(tn == queue1->head);             // dequeued tnode_t = new head ?
        assert(tn->tcb == NULL);                // tcb ptr = NULL ?
        tn = queue1->head->next;
        mtDelThread(th);
    }
    assert(mlGetNumNodes(queue1) == 0);         // no entries
    assert(queue1->head->tcb == NULL);          // NULL tcb entry @ head
    assert(queue1->head == queue1->tail);       // head == tail

    mlSetPtrFirst(queue1); 
    mlSetPtrNext(queue1);
    assert(mlReadCurrent(queue1) == NULL);
 

    mlDelList(queue1);                          // cleanup queue

    endTest();

    // #11 check a large list --------------------------------------------------

    beginTest("test large list");
    count = 1000;
    int rt;
    int *iar = (int *)malloc(count*sizeof(int));
    assert(iar != NULL);

    mlist_t* queue2 = mlNewList();              // new list

    for (unsigned int j = 0; j < count; j++)
        iar[j] = j+1;
    shuffleIntArray(&iar[0], count);
    for (unsigned int j = 0; j < count; j++) {
        mlSortIn(queue2,  mtNewThread(j+1, 1,  iar[j]), compareReadyTimes);
        testListConistency(queue2); 
    }
    free(iar);

    mlSetPtrFirst(queue2);
    for (unsigned int j = 1; j <= count; j++) {
        th = mlReadCurrent(queue2);
        rt = mtGetReadyTime(th);
        assert( rt == j);
        rt++;                                   // -> no compilation warning
        mlSetPtrNext(queue2);
    }
    mlDelList(queue2);
    queue2 = NULL;
    endTest();
    exit(0);
}


//******************************************************************************

void beginTest(const char *str) {
}

void endTest(void){
}

//******************************************************************************

void testListConistency(mlist_t *list) {
    mlSetPtrFirst(list);   
    while ((mlReadCurrent(list) != NULL) && (list->iter != list->tail))
        mlSetPtrNext(list);
    assert(list->iter == list->tail);
    mlSetPtrNext(list);
    assert(mlReadCurrent(list) == NULL);
}

//******************************************************************************

void shuffleIntArray(int *ar, int size) {
    int j, k, tmp;
    double dran;
    srand((unsigned int)time(NULL));
    // shuffle according to Knuth to avoid sorted lists
    for (j = size-1; j >= 0; j--) {
        dran = (double)rand() / (double)(RAND_MAX);
        k = (int)(j*dran);
        tmp   = ar[j];
        ar[j] = ar[k];
        ar[k] = tmp;
    }
}

//******************************************************************************

int compareReadyTimes(void *a, void *b) {
    int ia, ib;
    ia = ((mthread_t *)a)->readyTime;
    ib = ((mthread_t *)b)->readyTime;
    return (ia >= ib);
}

//******************************************************************************
