# Betriebssysteme Lab 03 - Abgabe David Luescher, Martin Ponbauer und Pascal Brunner

## Aufgabe 1
### Schritt 1
done

### Schritt 2 - mqGetNextThread() implementieren
```
//==============================================================================
// Function:    getNextThread
// Purpose:     returns thread with highest priority in the run queue
//              if there is no thread, return value is NULL

// compares two threads for sorting
int cmp(void *a, void *b)
{
    mthread_t *ta = (mthread_t *)a;
    mthread_t *tb = (mthread_t *)b;

    if (ta->vRuntime < tb->vRuntime)
    {
        return -1;
    }

    if (ta->vRuntime > tb->vRuntime)
    {
        return 1;
    }

    return 0;
}


mthread_t* mqGetNextThread(void) {
    float offset = 0;
    unsigned NThreads = mlGetNumNodes(runQueue); // Umkopieren der Threads aus runQue in die tmpQueue

    while (mlGetNumNodes(runQueue) > 0) {
      mthread_t* tcb = mlDequeue(runQueue);

      tcb->vRuntime = tcb->vRuntime - (VR_DEFAULT / (NThreads -1)) - offset; // gemäss der Aufgabenstellung: "Vor dem sortierten Einfügen, muss die vRuntime aufdatiert werden"
      mlSortIn(tmpQueue, tcb, *cmp); // sortiertes einfügen

    }

    // Zeiger vertauschen der Queues
    mlist_t *tmp = runQueue;
    runQueue = tmpQueue;
    tmpQueue = tmp;

    mthread_t *tcb = mlDequeue(runQueue); //Return-value in Form des Threads
    //gemäss der Aufgabenstellung: "vRuntime dieses Threads muss in der Variablen offset gespeichert werden, dann kann der Thread an den DIspachter zur Einplandung zurückgegeben werden
    if (tcb != NULL && abs(tcb->vRuntime - tcb->vRuntime) < 0.1) {
        offset = tcb->vRuntime; 
    }

    return tcb;
  
}
```

### Schritt 3 - mqAddToQueue() implementieren
```
//==============================================================================
// Function:    add to queue
// Purpose:     initialize queueing system

void mqAddToQueue(mthread_t *tcb, int sleepTime) {
    tprio_t prio = mtGetPrio(tcb);
    mlEnqueue(readyQueue[prio], tcb);
}
``` 

## Aufgabe 2 - CF Scheduler
### Schritt 1 - mqGetNextThread() implementieren
```
//==============================================================================
// Function:    getNextThread
// Purpose:     returns thread with highest priority in the run queue
//              if there is no thread, return value is NULL

mthread_t* mqGetNextThread(void) {
    int offset;

    unsigned NThreads = mlGetNumNodes(runQueue); // Umkopieren der Threads aus runQue in die tmpQueue

    while (mlGetNumNodes(runQueue) > 0) {
      mthread_t* tcb = mlDequeue(runQueue);

      tcb->vRuntime = tcb->vRuntime - (VR_DEFAULT / (NThreads -1)) - offset; // gemäss der Aufgabenstellung: "Vor dem sortierten Einfügen, muss die vRuntime aufdatiert werden"
      mlSortIn(tmpQueue, tcb, *cmp); // sortiertes einfügen

    }

    // Zeiger vertauschen der Queues
    mlist_t *tmp = runQueue;
    runQueue = tmpQueue;
    tmpQueue = tmp;

    mthread_t *tcb = mlDequeue(runQueue); //Return-value in Form des Threads
    //gemäss der Aufgabenstellung: "vRuntime dieses Threads muss in der Variablen offset gespeichert werden, dann kann der Thread an den DIspachter zur Einplandung zurückgegeben werden
    if (tcb != NULL && abs(tcb->vRuntime - tcb->vRuntime) < 0.1) {
        offset = tcb->vRuntime; 
    }

    return tcb;
  
}
```

### Schritt 2 - mqAddToQueue() implementieren
```
//==============================================================================
// Function:    add to queue
// Purpose:     initialize queueing system

void mqAddToQueue(mthread_t *tcb, int sleepTime) {
    tcb->vRuntime += mqGetRuntime() * (mtGetPrio(tcb) + 1); //code aus der Aufgabenstellung, mit der korrekten Priorität (+1)
    mlSortIn(runQueue, tcb, *cmp); //sortiertes Einfügen
}
```

## Aufgab 3 - wait-Queue
### Schritt 1 - 
```
//==============================================================================
// Function:    add to queue
// Purpose:     initialize queueing system

void mqAddToQueue(mthread_t *tcb, int sleepTime) {
    tcb->vRuntime += mqGetRuntime() * (mtGetPrio(tcb) + 1); //code aus der Aufgabenstellung, mit der korrekten Priorität (+1)
    
    // Falls sleepTime vorhanden, Thread in waitQueue eingliedern
    if (sleepTime > 0) {
      tcb->readyTime = mqGetTime() + sleepTime;
      mlEnqueue(waitQueue, tcb);
      return;
    }
    
    mlSortIn(runQueue, tcb, *cmp); //sortiertes Einfügen
}
```

### Schritt 2 - mqGetNextThread()
```
//==============================================================================
// Function:    getNextThread
// Purpose:     returns thread with highest priority in the run queue
//              if there is no thread, return value is NULL

// compares two threads for sorting
int cmp(void *a, void *b)
{
    mthread_t *ta = (mthread_t *)a;
    mthread_t *tb = (mthread_t *)b;

    if (ta->vRuntime < tb->vRuntime)
    {
        return -1;
    }

    if (ta->vRuntime > tb->vRuntime)
    {
        return 1;
    }

    return 0;
}


mthread_t* mqGetNextThread(void) {
    mthread_t* tcb;

    // Solange bereite Threads in waitQueue sind, diese in runQueue rüberschieben
    if (waitQueue != NULL){
        while ((tcb = mlReadFirst(waitQueue)) != NULL && mtGetReadyTime(tcb) <= mqGetTime()){
            mlEnqueue(runQueue, mlDequeue(waitQueue));
        }
    }

    // Threads aus runQueue nach Prio zurückgeben
    mthread_t* thread;
	  for (int i = 0; i < NUM_PRIO_QUEUES; i++){ // NUM_PRIO_QUEUES ist gegeben in COMMONDEFS.h
	    thread = mlDequeue(runQueue);
	    if(thread != NULL) {
        return thread;
      }
	  }

    // runQueue leer, aber Threads in waitQueue am schlafen
    // waitTime schlafen und Methode rekursiv wieder aufrufen
    tcb = mlReadFirst(waitQueue);
    if (thread == NULL && tcb != NULL){
      unsigned int waittime = mtGetReadyTime(tcb) - mqGetTime();
      usleep(waittime);
      return mqGetNextThread();
    }

	  return thread;
}
```

### Schrit 3 - testen
done
