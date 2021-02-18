//******************************************************************************
// File:    mlist.c
// Purpose: implementation mlist (a single linked list with header dummy)
// Author:  M. Thaler, 2012, (based on former work by J. Zeman and M. Thaler)
// Version: v.fs20
//******************************************************************************

#include <stdio.h>
#include <stdlib.h>

#include "commondefs.h"
#include "mthread.h"
#include "mlist.h"

//******************************************************************************
// macro to allocate new tnode_t

#define mlNewTNode() (tnode_t *)malloc(sizeof(tnode_t))

mlist_t* mlNewList() {
    mlist_t* newList = (mlist_t *)malloc(sizeof(mlist_t));
    tnode_t* dummyNode = (tnode_t *)malloc(sizeof(tnode_t));
    dummyNode->tcb = NULL;
    dummyNode->next = NULL;

    newList->head = dummyNode;
    newList->iter = NULL;
    newList->tail = dummyNode;
    newList->numNodes = 0;

    return newList;
}

void mlDelList(mlist_t* list) {
    while(list->head != list->tail){
        mthread_t *th = mlDequeue(list);
        mtDelThread(th);
    }
    free(list->head);
    free(list);
}

void mlEnqueue(mlist_t* list, mthread_t* tcb) {
    tnode_t* newNode = (tnode_t *)malloc(sizeof(tnode_t));
    newNode->tcb = tcb;
    newNode->next = NULL;

    list->tail->next = newNode;
    list->tail = newNode;
    list->numNodes++;
}

mthread_t* mlDequeue(mlist_t* list) {
    tnode_t* next = list->head->next;
    mthread_t* thread = NULL;

    if(!next) {
        thread = NULL;
    } else {
        thread = next->tcb;
        free(list->head);
        next->tcb = NULL;
        list->head = next;
        list->numNodes--;
    }

    return thread;
}

void mlSortIn(mlist_t* list, mthread_t* tcb, int (*cmp)(void *a, void *b)) {
    tnode_t* old = list->head;
    tnode_t* current = list->head->next;

    if(current == NULL){
        mlEnqueue(list, tcb);
        return;
    }

    while(current) {
        int result = cmp(current->tcb, tcb);

        if(current->next) {
            if(result > 0) {
                tnode_t* new_node = (tnode_t *)malloc(sizeof(tnode_t));
                new_node->tcb = tcb;

                old->next = new_node;
                new_node->next = current;
                list->numNodes++;

                return;
            } else if(result == 0) {
                tnode_t* new_node = (tnode_t *)malloc(sizeof(tnode_t));
                new_node->tcb = tcb;

                tnode_t* old_next = current->next;
                current->next = new_node;
                new_node->next = old_next;
                list->numNodes++;
                return;
            }
            old = current;
            current = current->next;
        } else {
            if(result > 0) {
                tnode_t* new_node = (tnode_t *)malloc(sizeof(tnode_t));
                new_node->tcb = tcb;

                old->next = new_node;
                new_node->next = current;
                list->numNodes++;
            } else {
                mlEnqueue(list, tcb);
            }
            return;
        }
    }
}

mthread_t* mlReadFirst(mlist_t* list) {
    tnode_t* next = list->head->next;
    if(next == NULL) {
        return NULL;
    }

    return next->tcb;
}

unsigned mlGetNumNodes(mlist_t* list) {
    return list->numNodes;
}

void mlSetPtrFirst(mlist_t* list) {
    tnode_t* next = list->head->next;
    if(next == NULL) {
        return;
    }
    list->iter = next;
}

void mlSetPtrNext(mlist_t*  list) {
    if(list->iter == NULL) {
        return;
    }
    tnode_t* next = list->iter->next;
    list->iter = next;
}

mthread_t* mlReadCurrent(mlist_t* list) {
    if(list->iter == NULL) {
        return NULL;
    }
    return list->iter->tcb;
}