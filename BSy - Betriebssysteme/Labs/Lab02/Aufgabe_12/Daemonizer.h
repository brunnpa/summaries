/*********************************************************************
* File:		Daemonizer.h
* Aufgabe:	einen Daemon-Prozess erzeugen
* Autor:	M. Thaler
* Datum:	Rev. 11/2014
* Version:  v.fs20
*********************************************************************/

#ifndef DAEMONIZER_H
#define DAEMONIZER_H

int Daemonizer(void Daemon(void *), void *data, 
               const char *LockFile, const char *LogFile, const char *LivDir);

#endif

//------------------------------------------------------------------------
