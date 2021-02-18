#ifndef MLIST_HEADER_FILE
#define MLIST_HEADER_FILE

//******************************************************************************
// File:    mlist.h
// Purpose: header file for mlist (a single linked list with header dummy)
// Author:  M. Thaler, 2012, (based on former work by J. Zeman and M. Thaler)
//******************************************************************************

#include "commondefs.h"
#include "mthread.h"

//------------------------------------------------------------------------------
// list node

typedef struct tnode {
    mthread_t*    tcb;                  // pointer to tcb (thread control block)
    struct tnode* next;                 // pointer to next list element
} tnode_t;

//------------------------------------------------------------------------------
// list header (we use her type tnode_t)

typedef struct mlist {
    unsigned  numNodes;                 // number of list elements
    tnode_t*  head;                     // pointer to header node
    tnode_t*  tail;                     // pointer to tail node
    tnode_t*  iter;                     // pointer for iterartions
} mlist_t;

//------------------------------------------------------------------------------

mlist_t*   mlNewList();                // setup list with dummy header node
void       mlDelList(mlist_t* list);   // delete list including data 

void       mlEnqueue(mlist_t* list, mthread_t* tcb);   // append tcb to list
mthread_t* mlDequeue(mlist_t* list);   // take first element out of ist
                                       // return ptr to tcb or NULL

void mlSortIn(mlist_t* list, mthread_t* tcb, int (*cmp)(void *a, void *b));
                                        // insert tcb sorted according to
                                        // to function int cmp()
                                        // cmp() is expected to return: 
                                        //     value < 0  given  a->v  <   b->v
                                        //     value = 0  given  a->v  ==  b->v
                                        //     value > 0  given  a->v  >   b->v

mthread_t* mlReadFirst(mlist_t* list);  // return ptr to first tcb in list, but
                                        // do not dequeue

unsigned   mlGetNumNodes(mlist_t* list); // return number of elements in list
void       mlSetPtrFirst(mlist_t* list); // set iter pointer to first element
void       mlSetPtrNext(mlist_t*  list); // move iter pointer to next element
mthread_t* mlReadCurrent(mlist_t* list); // return tcb by iter pointer

//******************************************************************************

#endif // MLIST_HEADER_FILE
