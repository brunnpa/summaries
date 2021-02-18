//******************************************************************************
// File:    test1.c
// Purpose: unit test for single linked list
// Author:  M. Thaler, 2012
//          tha, 2/19: test #31 adapted
//          tha, 5/19: test 11.1 fifo policy for sort, 11.2 (previous 11)
//                     mlSortIn() with callback function
// Version: v.fs20
//******************************************************************************
// Testing
//
//
//******************************************************************************

#include <stdio.h>
#include <assert.h>
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

int compareReadyTime(void *a, void *b);
int compareCheckTime(void *a, void *b);

//******************************************************************************

int main(int argc, char *argv[]){

    mthread_t*   th;
    tnode_t*     tn;
    unsigned int tid, j, count, utmp;

    mlist_t* queue1 = NULL;

    // #1 new, empty list ------------------------------------------------------

    beginTest("initialization of queue");

    queue1 = mlNewList();                       // allocate new queue

    assert(queue1                != NULL);      // queue exists
    assert(mlGetNumNodes(queue1) == 0);         // queue is empty
    assert(queue1->head == queue1->tail);       // head == tail
    assert(queue1->iter == NULL);               // iter == NULL
    endTest();

    // #2 enqueue 4 threads ----------------------------------------------------

    beginTest("enqueue threads and list consistency");

    count = 4;
    tid   = 0;
    for (j = 0; j < count; j++) {
          th = mtNewThread(tid++, 1, 10);
          mlEnqueue(queue1, th);
    }

    assert(queue1                != NULL);      // queue exists
    assert(queue1->head != queue1->tail);       // head != tail
    assert(queue1->head->tcb == NULL);          // tcb ptr -> NULL @ head

    tn = queue1->head->next;
    for (j = 0; j < count; j++) {               // check for list consistency
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
    
    for (j = 0; j < count; j++) {
        th = mlDequeue(queue1);
        assert(th->tID == j);                   // 
        assert(queue1->head->tcb == NULL);      // tcb ptr -> NULL @ head
        mtDelThread(th);
    }

    assert(queue1->head == queue1->tail);       // head == tail
    th = mlDequeue(queue1);                     // dequeue on empty list
    assert(th == NULL);                         //

    mlDelList(queue1);                          // check if ok
    queue1 = NULL;

    endTest();

    // #31 check if dummy freed ------------------------------------------------
    //   !!! this test is kind of risky, since we assume, that we get exactly 
    //       the same memory back we just released
    //   !!! this test might pass, even if the dummy node is not freed

    beginTest("check if dummy node is released by free()");

    queue1 = mlNewList();                       // allocate new queue
    mlEnqueue(queue1, mtNewThread(1, 1, 1));
    th = mlDequeue(queue1);
    mtDelThread(th);

    tn = queue1->head;
    tn->next = NULL;
    tn->tcb  = NULL;
    mlDelList(queue1);                          // tn => now dangling pointer

    queue1->head = (tnode_t *)malloc(sizeof(tnode_t));
    queue1 = (mlist_t *)malloc(sizeof(mlist_t));

    assert((tn->next != NULL)||(tn->tcb != NULL));

    free(queue1->head);
    free(queue1);

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
    for (j = 0; j < count; j++) {
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
    for (j = 0; j < count; j++) {
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
    for (j = 0; j < count; j++) {
          th = mtNewThread(tid++, 1, 10);
          mlEnqueue(queue1, th);
    }

    assert(queue1                != NULL);      // queue exists
    assert(mlGetNumNodes(queue1) == count);     // queue is not empty
    assert(queue1->head != queue1->tail);       // head == tail
    assert(queue1->head->tcb == NULL);          // tcb ptr -> NULL @ head

    mlSetPtrFirst(queue1);                      // set iteration pointer
    for (j = 0; j < count; j++) {               // check for list consistency
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
    mlSortIn(queue1, th, compareReadyTime);

    assert(mlGetNumNodes(queue1) == 1);         // queue is not empty
    mlSetPtrFirst(queue1);
    assert(mlReadCurrent(queue1) != NULL);      

    th = mtNewThread(tid++, 1, 20);             // add at end
    mlSortIn(queue1, th, compareReadyTime);
    assert(mlGetNumNodes(queue1) == 2);         // queue is not empty

    mlSetPtrFirst(queue1);                      // path from head -> tail
    mlSetPtrNext(queue1);
    assert(queue1->iter == queue1->tail);
    mlSetPtrNext(queue1);
    assert(mlReadCurrent(queue1) == NULL);

    th = mtNewThread(tid++, 1, 5);              // add as first  
    mlSortIn(queue1, th, compareReadyTime);
    assert(mlGetNumNodes(queue1) == 3);         // queue is not empty
    th = mtNewThread(tid++, 1, 15);             // add as first  
    mlSortIn(queue1, th, compareReadyTime);
    assert(mlGetNumNodes(queue1) == 4);         // queue is not empty
    

    mlSetPtrFirst(queue1);                      // path from head -> tail
    mlSetPtrNext(queue1);
    mlSetPtrNext(queue1);
    mlSetPtrNext(queue1);
    assert(queue1->iter == queue1->tail);
    mlSetPtrNext(queue1);
    assert(mlReadCurrent(queue1) == NULL);

    th = mtNewThread(tid++, 1, 25);             // add at end
    mlSortIn(queue1, th, compareReadyTime);

    th = mtNewThread(tid++, 1, 30);             // add at end
    mlSortIn(queue1, th, compareReadyTime);

    mlSetPtrFirst(queue1);                      // check sort order 
    count = 6;
    utmp  = 5;
    for (j = 0; j < count; j++) {
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

    mlSortIn(queue1,  mtNewThread(tid++, 1,  3), compareReadyTime);   count++;
    testListConistency(queue1);

    mlSortIn(queue1,  mtNewThread(tid++, 1, 70), compareReadyTime);   count++;
    testListConistency(queue1);

    mlSortIn(queue1,  mtNewThread(tid++, 1, 21), compareReadyTime);   count++;
    testListConistency(queue1);

    mlEnqueue(queue1, mtNewThread(tid++, 1, 80));   count++;
    testListConistency(queue1);

    assert(mlGetNumNodes(queue1) == count);     // number of entries

    mlSetPtrFirst(queue1);                      // path from head -> tail
    for (j = 0; j < count-1; j++)
        mlSetPtrNext(queue1);
    assert(queue1->iter == queue1->tail);
    mlSetPtrNext(queue1);
    assert(mlReadCurrent(queue1) == NULL);

    mlSetPtrFirst(queue1);                      // check sort order
    th = mlReadCurrent(queue1);
    utmp = mtGetReadyTime(th);
    mlSetPtrNext(queue1);
    for (j = 1; j < count; j++) {
        th = mlReadCurrent(queue1);
        assert(mtGetReadyTime(th) >= utmp);
        utmp = mtGetReadyTime(th);
        mlSetPtrNext(queue1);
    }

    endTest();

    // #10 now dequeue all threads ---------------------------------------------

    beginTest("empty whole list");

    tn = queue1->head->next;
    for (j = 0; j < count; j++) {
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

    // #11.1 check if sort is stable -------------------------------------------

    beginTest("check for stable sort -> fifo policy");

    count = 32;
    queue1 = mlNewList(); 
    for (j = 0; j < count; j++) {
        mlSortIn(queue1,  mtNewThread(j,   1, j), compareReadyTime);
    }
    for (j = 2*count-1; j >= count; j--) {
        mlSortIn(queue1,  mtNewThread(j, 2, j-count), compareReadyTime);
    }

    int errCount;
    j = errCount = utmp = 0;
    while ((th = mlDequeue(queue1)) != NULL) {
        utmp = j/2;
        tid = utmp;
        if (j%2) tid += count;
        if ((th->tID != tid) && (th->tPrio != utmp))
            errCount++;
        mtDelThread(th);
        j++;
    }

    assert(errCount == 0);         // no entries
    mlDelList(queue1);                          // cleanup queue

    endTest();

    // #11.2 check a large list ------------------------------------------------

    beginTest("test large list");
    count = 1000;
    int rt;
    int *iar = (int *)malloc(count*sizeof(int));
    assert(iar != NULL);

    mlist_t* queue2 = mlNewList();              // new list

    for (j = 0; j < count; j++)
        iar[j] = j+1;
    shuffleIntArray(&iar[0], count);
    for (j = 0; j < count; j++) {
        mlSortIn(queue2,  mtNewThread(j+1, 1,  iar[j]), compareReadyTime);
        testListConistency(queue2); 
    }
    free(iar);

    mlSetPtrFirst(queue2);
    for (j = 1; j <= count; j++) {
        th = mlReadCurrent(queue2);
        rt = mtGetReadyTime(th);
        assert( rt == j);
        mlSetPtrNext(queue2);
    }
    mlDelList(queue2);
    queue2 = NULL;
    endTest();

    // #11.3 check a large list ------------------------------------------------

    beginTest("test if callback is used");
    count = 5;
    int tim = 1;

    queue2 = mlNewList();              // new list

    for (j = 0; j < count; j++) {
        mlSortIn(queue2,  mtNewThread(j, 1,  tim++), compareCheckTime);
        testListConistency(queue2); 
    }

    tim--;
    mlSetPtrFirst(queue2);
    for (j = 0; j < count; j++) {
        th = mlReadCurrent(queue2);
        rt = mtGetReadyTime(th);
        assert( rt == tim);
        tim--;
        mlSetPtrNext(queue2);
    }
    mlDelList(queue2);
    queue2 = NULL;
    endTest();

    // #12 random test ---------------------------------------------------------

    beginTest("random test");
    long int rnd1, rnd2;
    tid   = 0;
    count = (64*1024);
    time_t t1, t2;
    srandom(5379);
   
    queue1 = mlNewList();                       // new list 

    for (j = 0; j < 100; j++) {
        rnd1 = (int)random(); 
        rnd2 = (int)random();
        mlSortIn(queue1,  mtNewThread(tid++, rnd1,  rnd2), compareReadyTime);
    }

    t1 = 0;
    t2 = time(NULL);
    for (j = 0; j < count; j++) {
        rnd1 = (int)random();
        if (rnd1 > RAND_MAX/2) {
            th = mlDequeue(queue1);
            mtDelThread(th);
        }
        else {
            rnd2 = (int)random();
            mlSortIn(queue1,  mtNewThread(tid++, rnd1,  rnd2), compareReadyTime);
        }
        testListConistency(queue1); 
        rnd1 = (int)random();
        rnd2 = RAND_MAX/4 + RAND_MAX/2;
        if ((rnd1 < rnd2) && (rnd1 > RAND_MAX/2)) {
            mlEnqueue(queue1,  mtNewThread(tid++, rnd1,  rnd2));
            testListConistency(queue1);
        }
        t1 = time(NULL);
        if (t1 > t2) {
            t2 = t1;
            printf(".");
            fflush(stdout);
        }
    }
    printf("\n");
    mlDelList(queue1);

    endTest();


    exit(EXIT_SUCCESS);
}


//******************************************************************************

void beginTest(const char *str) {
    printf("\n*************************************************************\n");
    if (str != NULL)
        printf("check: %s\n", str);
}


void endTest(void){
    printf("-> passed\n");
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
// call back function for sortIn

int compareReadyTime(void *a, void *b) {
    int ta = ((mthread_t *)a)->readyTime;
    int tb = ((mthread_t *)b)->readyTime;
    return (ta - tb);
}

int compareCheckTime(void *a, void *b) {
    int ta = ((mthread_t *)a)->readyTime;
    int tb = ((mthread_t *)b)->readyTime;
    return (tb - ta);
}

//******************************************************************************
