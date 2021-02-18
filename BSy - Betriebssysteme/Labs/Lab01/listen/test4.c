//******************************************************************************
// File:    test4.c
// Purpose: unit test for single linked list
// Author:  M. Thaler, 2012, 
//          tha, 2017: adapted -> time limit on sort inrceasing
//          tha, 5/19: mlSortIn() with callback function
// Version: v.fs20
//******************************************************************************

#include <stdio.h>
#include <stdlib.h>
#include <assert.h>
#include <stdlib.h>
#include <time.h>

#include "commondefs.h"
#include "mlist.h"
#include "mthread.h"

//******************************************************************************
#define N (4*1024*1024)
//******************************************************************************
// prototypes of local functions

void beginTest(const char *str);
void endTest(void);
void shuffleIntArray(int *ar, int size);
int  compareReadyTimes(void *a, void *b);

//******************************************************************************

int main(void) {

    int        tid;
    int*       array;
    int        num = N;
    mthread_t* th;
    mlist_t*   queue = mlNewList();

    // -------------------------------------------------------------------------
    // enqueue N threads

    beginTest("large queue");

    tid = 0;
    for (int i = 0; i < N; i++) {
        th = mtNewThread(tid++, HIGH, 10);
        mlEnqueue(queue, th);
    }
    assert(mlGetNumNodes(queue) == N);
    th = mtNewThread(tid++, HIGH, 20);
    mlSortIn(queue, th, compareReadyTimes);
    th = mlDequeue(queue);
    mtDelThread(th);

    // dequeue N threads
    for (int i = 0; i < N; i++) {
        th = mlDequeue(queue);
        mtDelThread(th);
    }   
    assert(mlGetNumNodes(queue) == 0);

    endTest();

    // -------------------------------------------------------------------------
    // enqueue N threads sorted with increasing key

    beginTest("put sort in increasing order");

    int k = 0;

    time_t t1, dt = 0, ct = 0;
    t1 = time(NULL);
    while ((dt < 20) && (k < N)) {
        th = mtNewThread(tid++, HIGH, k++);
        mlSortIn(queue, th, compareReadyTimes);
        dt = time(NULL) - t1;
        if (dt > ct) {
            printf(".");
            fflush(stdout);
            ct = dt;
        }
    }
    if (ct > 0)
        printf("\n");
    assert(mlGetNumNodes(queue) == k);

    if (k < N)
        printf("-> time limit reached\n");
    num = k;

    // dequeue N threads
    for (int i = 0; i < num; i++) {
        th = mlDequeue(queue);
        mtDelThread(th);
    }
    assert(mlGetNumNodes(queue) == 0);

    endTest();

    // -------------------------------------------------------------------------
    // enqueue N threads sorted i decreasing

    beginTest("put sort in decreasing order");

    for (int i = 0; i < N; i++) {
        th = mtNewThread(tid++, HIGH, N-1-i);
        mlSortIn(queue, th, compareReadyTimes);
    }
    assert(mlGetNumNodes(queue) == N);

    // dequeue N threads
    for (int i = 0; i < N; i++) {
        th = mlDequeue(queue);
        mtDelThread(th);
    }
    assert(mlGetNumNodes(queue) == 0);

    endTest();

    // -------------------------------------------------------------------------
    // enqueue N threads sorted all i shuffled

    beginTest("put sort all i shuffled");

    array = (int *)malloc(N * sizeof(int));
    assert(array != NULL);

    int nN = (num < N/100) ? num : N/100;
        
    for (int i = 0; i < nN; i++)
        array[i] = i;
    shuffleIntArray(array, nN);

    for (int i = 0; i < nN; i++) {
        th = mtNewThread(tid++, HIGH, array[i]);
        mlSortIn(queue, th, compareReadyTimes);
    }
    // we do not need it anymore: before assert -> memory leak
    free(array);

    assert(mlGetNumNodes(queue) == nN);

    // dequeue N threads
    for (int i = 0; i < N; i++) {
        th = mlDequeue(queue);
        mtDelThread(th);
    }
    assert(mlGetNumNodes(queue) == 0);

    endTest();

    mlDelList(queue);

    exit(0);

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

void shuffleIntArray(int *ar, int size) {
    int j, k, tmp;
    double dran;
    srand(5555u);
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
    int ia = mtGetReadyTime((mthread_t *)a);
    int ib = mtGetReadyTime((mthread_t *)b);
    return (ia >= ib);
}

//******************************************************************************

