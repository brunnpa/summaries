# IT-Security Lab 6 - Abgabe Gruppe 21 - David Lüscher, Pascal Brunner
Nachfolgend werden die Lösungen inkl. Printscreen (sofern sinnvoll) aufgelistet, welche relevant für die Praktikumspunkt gemäss Aufgabenstellung sind

## Setup und Kontrolle
![alt text](https://github.zhaw.ch/brunnpa7/ITSec/blob/master/Lab%206/img/DeviceNummern.png "DeviceNummern-Kontrolle")
![alt text](https://github.zhaw.ch/brunnpa7/ITSec/blob/master/Lab%206/img/TestSetUp.png "Test Setup")

## Teil 1

### Aufgabe 1
```sh
nmap -v -Pn -sT -p1-100 dmz
```
![alt text](https://github.zhaw.ch/brunnpa7/ITSec/blob/master/Lab%206/img/T1A1.png "Aufgabe1")

offen: Zugriff auf diesen Port wird zugelassen
geschlossen: Verbindung zu diesem Port wird durch die Firewall blockiert
gefiltert: Die Firewall gibt keine Antwort an den Sender zurück und se läuft somit in ein Timeout (drop-Action)

### Aufgabe 2
![alt text](https://github.zhaw.ch/brunnpa7/ITSec/blob/master/Lab%206/img/T1A2.png "Aufgabe2")

Das Pingen geht nicht mehr aufgrund der drop-Action verwirft es die Pakete und gibt keine Rückmeldung. Entsprechend erscheint beim Ping "unreachable". Das Verhalten des nmap-Scan ist noch identisch, da myforward noch nicht angepasst wurde

### Aufgabe 3
![alt text](https://github.zhaw.ch/brunnpa7/ITSec/blob/master/Lab%206/img/T1A3.png "Aufgabe3")
Nun werden sämtliche 100 gesetzte Ports auf gefiltert gesetzt. Dies aufgrund der Anpassung von myforward auf drop.

## Teil 2

### Aufgabe 9
nd-neighbor-advert: Geht es um die IP Auflösung von IPv4 nach IPv6 und, dass sich die Router sporadisch im Netzwerk melden
nd-neighbor-solicit: Alle Router im Netz werden aufgefordert alle 
echo-request: Wird explizit pro Netz für jede Anforderung gesetzt
echo-Reply: wird explizit pro Netz für jede Antwort gesetzt

### Praktikumspunkt
#### nmap von internal nach dmz
```
nmap -v -Pn -sT -p1-100 dmz
```
-> SSH wird als offen angezeigt
![alt text](https://github.zhaw.ch/brunnpa7/ITSec/blob/master/Lab%206/img/T4dmz-to-int.png "Praktikumspunkt")

#### nmap von dmz nach internal
```
nmap -v -Pn -sT -p1-100 int
```
-> SSH wird nicht angezeigt
![alt text](https://github.zhaw.ch/brunnpa7/ITSec/blob/master/Lab%206/img/T4int-to-dmz.png "Praktikumspunkt")

## Teil 6

### Praktiumspunkt
Wie in der obigen Abbildung gewünscht erreichen wir vom external aus, den DMZ mittels SSH oder FTP (beides funktioniert, sowohl als ipv4, wie auch ipv6)
Vergleichen wir das mit dem nmap ext aus der vorherigen Aufgabe so sehen wir das die Ports 7, 9, und 13 nicht mehr aufgelistet werden
#### IPv4
![alt text](https://github.zhaw.ch/brunnpa7/ITSec/blob/master/Lab%206/img/T6nmap-ext-to-dmz.png "Praktikumspunkt")
#### IPv6
![alt text](https://github.zhaw.ch/brunnpa7/ITSec/blob/master/Lab%206/img/T6nmap-ext-to-dmz-IPv6.png "Praktikumspunkt")

### Aufgabe 17
Insofern deckt es meine Erwartung, dass nur http explzit aufgelistet wird. Jedoch habe ich erwartet, dass es als "open" deklariert wird. Jedoch sehen wir hier, dass es als "closed" aufgelistet wird
![alt text](https://github.zhaw.ch/brunnpa7/ITSec/blob/master/Lab%206/img/T6A17.png "Aufgabe17")

### Praktikumspunkt
![alt text](https://github.zhaw.ch/brunnpa7/ITSec/blob/master/Lab%206/img/Traceroute.png "Praktikumspunkt")

## Teil 7
![alt text](https://github.zhaw.ch/brunnpa7/ITSec/blob/master/Lab%206/img/Netstate.png "Praktikumspunkt")

## Teil 8 
angepasstes Firewall-Skript siehe hier: https://github.zhaw.ch/brunnpa7/ITSec/blob/master/Lab%206/DavidLuescherPascalBrunnerFirewallskript.txt
