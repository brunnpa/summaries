/******************************************************************************
* File:		TimeDaemonDefs.h
* Aufgabe:	Data Definitions for TimeDaemon
* Autor:	M. Thaler
* Datum:	Rev. 11/2014
* Version:  v.fs20
******************************************************************************/

#ifndef TIME_DAEMON_DEFS
#define TIME_DAEMON_DEFS

#define HOST_NAM_LEN 32

#define TIME_PORT 65534

#define REQUEST_STRING  "requestTimeFromServer"

// data structure receiving from time daemon

typedef struct {
	int	 hours;
	int	 minutes;
	int  seconds;
	int	 day;
	int	 month;
	int  year;
    char servername[HOST_NAM_LEN];
} TimeData, *TimeDataPtr;

#endif

//*****************************************************************************
