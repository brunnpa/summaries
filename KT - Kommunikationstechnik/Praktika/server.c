/*
---------------------------------------------------------------------------

 Program:   server

 Zweck:     Erzeugt einen Socket und führt wiederholt aus:
              1) Warte auf eine Verbindung von einem Client
              2) Sende eine Meldung an den Client
              3) Beende die Verbindung

 Syntax:    server [ port ]
                port  - Protokoll-Port

 Anmerkung: Die Angabe von "port" ist fakultativ. Falls nicht angegeben,
            wird der Default-Wert "DefaultPortNumber" verwendet.

---------------------------------------------------------------------------
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
const char* DefaultPortNumber = "8080";  /* Default-Protokoll-Port, angepasst. ehemals 4711       */
const int QueueLength = 10;              /* Laenge der Request Queue     */

/* Macro um eine beliebige Datenstruktur (mittels Nullen) zu löschen     */
#define ClearMemory(s) memset((char*)&(s),0,sizeof(s))

/* Prozedur zur Fehlerabfrage und Behandlung                             */
void ExitOnError(int Status, char* Text) {
   if (Status < 0) {
      fprintf(stderr, "%s: %s\n", Text, gai_strerror(Status));
      exit(1);
   }
} 

int main(int ArgumentCount, char* ArgumentValue[]) {

   typedef struct sockaddr* SockAddrPtr; /* Pointer auf sockaddr         */

   /* Struktur für Server-Adresse und Pointer für Parameter-Übergabe     */
   struct addrinfo hints;
   struct addrinfo* servinfo;

   /* Struktur für Client-Adresse und Pointer für Parameter-Übergabe     */
   struct sockaddr_in ClientAddr;
   const  SockAddrPtr ClientAddrPtr = (SockAddrPtr)&ClientAddr;

   int              ListeningSocket;   /* Socket für Verbindungsaufbau   */
   int              ConnectedSocket;   /* Socket für Datenübertragung    */
   const char*      PortNumber;        /* Protokoll-Port-Nummer          */
   unsigned         AddrLen;           /* Laenge der Adresse             */
   char             Buffer[1000];      /* Daten-Buffer                   */
   int              Status;            /* Status-Zwischenspeicher        */
   int              Visits;            /* bisherige Anzahl Verbindungen  */

   /*
   Kommandozeile verarbeiten:

   Falls eine Port-Nummer angegeben wurde, soll diese für das Protokoll
   verwendet werden, sonst der Default-Wert (Konstante DefaultPortNumber).
   */

   if (ArgumentCount > 1) {              /* Falls Port angegeben          */
      PortNumber = ArgumentValue[1];     
   } else {
      PortNumber = DefaultPortNumber;    /* Default verwenden             */
   }

   /* Gewünschte Eigenschaften des Sockets angeben                        */ 
   ClearMemory(hints);
   hints.ai_family = AF_INET;       // nur IPv4 
   hints.ai_socktype = SOCK_STREAM; // TCP Stream Sockets
   hints.ai_flags = AI_PASSIVE;     // eigene IP-Adresse verwenden
   Status = getaddrinfo(NULL, PortNumber, &hints, &servinfo);
   ExitOnError(Status, "getaddrinfo fehlgeschlagen");

   /* Socket für Verbindungsaufbau erzeugen                               */
   ListeningSocket = socket(servinfo->ai_family, servinfo->ai_socktype, 
			    servinfo->ai_protocol);
   ExitOnError(ListeningSocket, "socket fehlgeschlagen");

   /* Dem Socket die lokale Adresse und Port-Nummer zuordnen               */
   Status = bind(ListeningSocket,  servinfo->ai_addr, servinfo->ai_addrlen);
   ExitOnError(Status, "bind fehlgeschlagen");

   freeaddrinfo(servinfo); // Wird nicht mehr benötigtip

   /* Socket in passiv Modus versetzen und Warteschlagengrösse festlegen  */   
   Status = listen(ListeningSocket, QueueLength);
   ExitOnError(Status, "listen fehlgeschlagen");

   Visits = 0; /* Noch keine Verbindungen */
   printf("Server wartet an Port %s auf die erste Verbindung\n", PortNumber);

   while (1) { /* Server Loop */

      AddrLen = sizeof(ClientAddr);     /* ... wird von accept verändert   */

   /* Auf Client-Verbindung (connect) warten                               */
      ConnectedSocket = accept(ListeningSocket, ClientAddrPtr, &AddrLen);
      ExitOnError(ConnectedSocket, "accept fehlgeschlagen");

      Visits++;
      printf("%d. Verbindung von %s, Port %d\n", Visits, 
             inet_ntoa(ClientAddr.sin_addr), ClientAddr.sin_port);

   /* Daten-Buffer aufbereiten                                             */
      sprintf(Buffer,"Dies ist die %d. Verbindung.\n",Visits);

   /* Daten-Buffer senden                                                  */
      Status = send(ConnectedSocket, Buffer, strlen(Buffer), 0);
      ExitOnError(Status, "send fehlgeschlagen");

   /* Client-Verbindung beenden                                            */
      Status = close(ConnectedSocket);
      ExitOnError(Status, "close fehlgeschlagen");

   } /* Server Loop */
}
