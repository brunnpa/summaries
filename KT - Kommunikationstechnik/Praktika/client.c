/*
---------------------------------------------------------------------------
 Program:   client

 Zweck:     Erstellt eine Verbindung zu einem Server und zeigt die 
            vom Server gesendeten Daten an.
 
 Syntax:    client [ server [port] ]
 
               server - IP-Adresse des Servers
               port   - Protokoll-Port-Nummer des Servers
 
 Anmerkung: Beide Parameter sind fakultativ.  
            - Falls "server" fehlt, wird "LocalHost" angenommen
            - Falls "port" fehlt, wird der Default-Wert
              "DefaultPortNumber" verwendet.

 --------------------------------------------------------------------------
 */

#include <sys/types.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <arpa/inet.h>
#include <netdb.h>
#include <unistd.h>
#include <stdlib.h>
#include <stdio.h>
#include <string.h>

/* Konstanten definieren                                                 */
   const char DefaultPortNumber[] = "8080";    /* Default-Protokoll-Port, wurde angepasst. ehemals: 4711 */
   const char LocalHost[] = "localhost";       /* Default-Server-Name    */

/* Macro um eine beliebige Datenstruktur (mittels Nullen) zu löschen     */
#define ClearMemory(s) memset((char*)&(s), 0, sizeof(s))

/* Prozedur zur Fehlerabfrage und Behandlung                             */
void ExitOnError(int Status, char* Text) {
   if (Status < 0) {
      fprintf(stderr, "%s: %s\n", Text, gai_strerror(Status)); 
      exit(1);
   }
}
        
int main(int ArgumentCount, char* ArgumentValue[]) {

   typedef struct sockaddr* SockAddrPtr; /* Pointer auf sockaddr         */

   const char*      ServerName;          /* Temp.Pointer auf Servernamen */
   struct addrinfo  Hints;
   struct addrinfo* SrvInfo;		    /* Resultat von getaddrinfo     */   
   int              CommunicationSocket; /* Socket(-Descriptor)          */
   const char*      PortNumber;	   
   char             Buffer[1000];        /* Daten-Buffer                 */
   int              Status;              /* Status-Zwischenspeicher      */
   int              CharsReceived;       /* Anzahl empfangener Zeichen   */


   /*
      1. Parameter der Kommandozeile verarbeiten:

   Falls eine Server-Adresse angegeben wurde, soll diese verwendet werden,
   sonst der Default-Wert (Konstante "LocalHost").
   */

   GET / http/1.0\nAccept: */*\nUser-Agent: client_www\n\n

   if (ArgumentCount > 1) {           /* Falls Server-Argument angegeben */
      ServerName = ArgumentValue[1];
   } else {
      ServerName = LocalHost;
   }


   /*
   2. Parameter der Kommandozeile verarbeiten:

   Falls eine Port-Nummer angegeben wurde, soll diese für das Protokoll
   verwendet werden, sonst der Default-Wert (Konstante DefaultPortNumber).
   */

   if (ArgumentCount > 2) {            /* Falls Port-Parameter angegeben */
      PortNumber = ArgumentValue[2];   
   } else {
      PortNumber = DefaultPortNumber;               /* Default verwenden */
   }

   /* Adressinformationen bereitstellen */
   ClearMemory(Hints);
   Hints.ai_family = AF_INET;       // Nur IPv4 
   Hints.ai_socktype = SOCK_STREAM; // TCP Stream Sockets
   Hints.ai_flags = AI_PASSIVE;     // Irgend eine der eigenene Adressen
   Status = getaddrinfo(ServerName, PortNumber, &Hints, &SrvInfo);
   ExitOnError(Status, "getaddrinfo fehlgeschlagen");

   /* Socket für Verbindungsaufbau und Datentransfer erzeugen            */
   CommunicationSocket = socket(PF_INET, SOCK_STREAM, 0);
   ExitOnError(CommunicationSocket, "socket fehlgeschlagen");

   /* Verbindung zum Server und Dienst erstellen                         */
   Status=connect(CommunicationSocket, SrvInfo->ai_addr, SrvInfo->ai_addrlen);
   ExitOnError(Status, "connect fehlgeschlagen");

   freeaddrinfo(SrvInfo);                 // Wird nicht mehr gebraucht

   /* Wiederholt Daten vom Server lesen und am Bildschirm anzeigen       */
   CharsReceived = recv(CommunicationSocket, Buffer, sizeof(Buffer), 0);
   while (CharsReceived > 0) {
      Buffer[CharsReceived] = 0;
      fprintf(stdout,"%s", Buffer);
      CharsReceived = recv(CommunicationSocket, Buffer, sizeof(Buffer), 0);
   }

   /* Close the socket                                                   */
   close(CommunicationSocket);
   ExitOnError(Status, "close fehlgeschlagen");

   /* Programm mit positivem Status beenden */
   exit(0);
}

