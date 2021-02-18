# Abgabe Betriebssysteme Lab 05 - Martin Ponbauer, David Lüscher, Pascal Brunner

## 2.2.1 Aufgaben - Mutex

### a)
Wir erhalten unterschiedliche Werte. Dabei wird jeweils die 'diff' angeben. Wobei die diff = c - s1 - s2 ist.
Erhalten wir hier != 0, dann weisst darauf hin dass der Thread unterbrochen wurde -> Die Datenstruktur wird nicht gelocked (Kaffeemaschine und Costumer-Thread), der Thread kann unterbrochen werden und die Differenz ergibt nicht 0

### b)
Anschliessend sehen wir entsprechend 
working
working
...
working

Wir haben es gelocked bevor es  in die if-Anweisung gesprungen ist und danach wieder unlocked.
Dasselbe Ergebnis hatten wir bei 10 Customers

### c)
Nein man könnte nicht darauf verzichten, da es immer noch Synchronisations-Probleme gäbe

### d)
Dies ist stark abhängig vom eingesetzten Scheduler.


## 2.3.1 Aufgabe - BasicSequence

### a)
#### Schritt 1: Prozesse (Threads) der Problemstellung identifizieren
Kaffeeautomat, Kunde [A, B, C, D]

#### Schritt 2: Ausführungsschritte der einzelnen Prozesse (Threads) ermitteln
Kaffee-Maschine | Kunde A
 --------------- | -------
meldet sich, wenn sie ready ist | wartet bis an der Reihe ist
wartet auf Geld | Geld einwerfen
gibt Kaffee | wartet auf Kaffee
wartet auf Freigabe | gibt Automat frei

#### Schritt 3: Synchronisationsbedingungen ermitteln
![alt text](https://github.zhaw.ch/brunnpa7/BSY/blob/master/Lab05/img/2.jpg "Skizze")

#### Schritt 4: Benötigte Semaphore definieren
ist am Zug = myTurn
Münze = coin
Kaffee = coffee
fertig = ready
```
myTurn = sem_open(MYTURN_SEMAPHOR, O_CREAT, 0700, 1); checkSem(myTurn);
coin   = sem_open(COIN_SEMAPHOR,   O_CREAT, 0700, 0); checkSem(coin);
coffee = sem_open(COFFEE_SEMAPHOR, O_CREAT, 0700, 0); checkSem(coffee);
ready  = sem_open(READY_SEMAPHOR,  O_CREAT, 0700, 0); checkSem(ready);
``` 
#### Schritt 5: Prozesse mit Semaphoroperationen ergänzen
Kaffee-Maschine | Kunde A | Kunde B | Kunde C | Kunde D
 --------------- | ------- | ------- | ------- | -------
ready(0) | wait(myturn) (wartet bis myturn = 1 und setzt myturn = 0)| wait for myturn | wait for myturn | wait for myturn
set ready(1) | wait for ready(1) | wait for myturn | wait for myturn | wait for myturn
wait for coin(1) | coin(1) | wait for myturn | wait for myturn | wait for myturn
coffee(1) | wait for coffee(1) | wait for myturn | wait for myturn | wait for myturn
set ready(0) | post(myturn) (setzt myturn = 1)| wait for myturn | wait for myturn | wait for myturn

#### Schritt 6: Implementation
Nachfolgend

### b)
ist im Code abgebildet

### c)
Nicht in jedem Fall

## 2.4.1 Aufgabe - AdvancedSequence
siehe Code

## 3.2 - Banking

### 3.2.1 Aufgabe 1
#### a)
```
Running 1 threads
Balance of accounts is: 1006995400
Balance of accounts is: 1006995400 ... correct
Run time 1.61s

Running 2 threads
Balance of accounts is: 1006995400
Balance of accounts is: 1006954858 ... not correct
Run time 1.62s

Running 4 threads
Balance of accounts is: 1006995400
Balance of accounts is: 1006914777 ... not correct
Run time 1.60s
``` 
Die Aktionen abheben und einzahlen sind nicht gelocked, aus diesem Grund können mehrere Threads auf die Kontos zugreifen

#### b)
```
Running 1 threads
Balance of accounts is: 1006995400
Balance of accounts is: 1006995400 ... correct
Run time 2.36s

Running 2 threads
Balance of accounts is: 1006995400
Balance of accounts is: 1006995400 ... correct
Run time 2.31s

Running 4 threads
Balance of accounts is: 1006995400
Balance of accounts is: 1006995400 ... correct
Run time 2.83s
``` 
Da wir im vorliegenden Fall nur die einzelnen Accounts locken wollten, haben wir uns für acntLock entschieden.

### 3.2.2 Aufgabe 2
#### a)
```
Running 1 threads
Balance of accounts is: 1006995400
Balance of accounts is: 1006995400 ... correct
Run time 4.25s

Running 2 threads
Balance of accounts is: 1006995400
Balance of accounts is: 1006995400 ... correct
Run time 6.21s

Running 4 threads
Balance of accounts is: 1006995400
Balance of accounts is: 1006995400 ... correct
Run time 7.38s
```
Im Vergleich zur vorherigen Aufgabe hat es mehr als doppelt solange gedauert. Aus diesem Grund empfehlen wir die Variante der vorherigen Aufgabe.

#### b)
Unser Kollege wollte uns wohl reinlegen, da es einen Deadlock produzieren würde :-)

### 3.2.3 Aufgabe 3
#### a)
In den vorherigen Varianten kann es zu inkonsistenten Zuständen in einer Bank kommen.
1. Konto A von Bank A -> Überweisung -> Konto B von Bank A
1. Konto A hebt Geld ab, bevor Überweisung zu Konto B erfolgt ist (ist möglich, da nicht komplette Filiale gelocked)
1. Thread wird unterbrochen
1. Bilanz ist nicht korrekt

#### b)
Nun kommt branchLock zum Einsatz

#### c)
```
Running 1 threads
Balance of accounts is: 1006995400
Balance of accounts is: 1006995400 ... correct
Run time 1.00s

You do comply with the IBC rules 


Running 2 threads
Balance of accounts is: 1006995400
Balance of accounts is: 1006995400 ... correct
Run time 2.02s

You do comply with the IBC rules 


Running 4 threads
Balance of accounts is: 1006995400
Balance of accounts is: 1006995400 ... correct
Run time 2.52s

You do comply with the IBC rules 
``` 
![alt text](https://github.zhaw.ch/brunnpa7/BSY/blob/master/Lab05/img/Testing.png "Testing")
Der Test durchläuft grün! 

Diese Variante ist minimal langsamer als der erste Versuch, jedoch deutlich schneller als die anderen.
