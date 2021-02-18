# IT-Security Lab 04 - Abgabe David Lüscher, Pascal Brunner 

Wir haben die Passwort-Hashes der Gruppe 29 verwendet

## Alice's Passwort -> /fontanA8
Das gesuchte Passwort ist: /fontanA8 
### Anpassungen im john.conf
```
#Rule for Alice -> Wir verwenden die bestehende Regel von Uppercase the last letter of pure alphabetic words (fred -> freD) und haben die Zahl am Schluss und das Sonderzeichen vorne ergänzt durch eine Auswahl von Möglichkeiten
-c <+ >2 !?A l M r Q c r $[0-9] ^[+"*%&/()=?{}!.<>]
```
### Eingabe im Terminal
```
john --wordlist=/usr/share/wordlists/metasploit/password.lst --rules /root/Desktop/alice_netntlmv2
```
![alt text](https://github.zhaw.ch/brunnpa7/ITSec/blob/master/Lab%204/img/TerminalAlice.png "Alice")

## Bob's Passwort -> .SKDq
Das gesuchte Passwort ist: .SKDq
### Anpassungen im John.conf
```
[Incremental:ASCIIBob]
File = $JOHN/ascii.chr
MinLen = 4
MaxLen = 4
CharCount = 95
```
### Eingabe im Terminal
```
john --incremental=ASCIIBob /root/Desktop/bob_netntlmv2
```
![alt text](https://github.zhaw.ch/brunnpa7/ITSec/blob/master/Lab%204/img/TerminalBob.png "Bob")

## Carol's Passwort -> KI7dn7wbssS
Das gesuchte Passwort ist: KI7dn7wbssS
### Anpassungen im John.conf

keine, da die RainbowTables verwendet werden

### Eingabe im Terminal
#### Schritt 1
```
rcracki_mt -h 1d689323c30bb9b8 /root/rainbowtables/halflmchall*
```
Wobei 1d689323c30bb9b8 die ersten 8 Bytes sind

Daraus folgt das (Teil)Passwort: KI7DN7W
![alt text](https://github.zhaw.ch/brunnpa7/ITSec/blob/master/Lab%204/img/TerminalCarol_Rainbow-Tables.png "Carol 1")

### Schritt 2
```
netntlm.pl --seed KI7DN7W --file /root/Desktop/carol_netntlm
```
Wobei das Passwort: KI7DN7WBSSS herauskommt, dies ist jedoch noch nicht das finale, da alles gross geschrieben ist
![alt text](https://github.zhaw.ch/brunnpa7/ITSec/blob/master/Lab%204/img/TerminalCarol_Teil2_1.png "Carol 2.1")
![alt text](https://github.zhaw.ch/brunnpa7/ITSec/blob/master/Lab%204/img/TerminalCarol_Teil2_2.png "Carol 2.2")

### Schritt 3
```
netntlm.pl --file /root/Desktop/carol_netntlm
```
Nun erhält man das vollständige Passwort unter der Berücksichtigung der Gross-/Kleinschrift
![alt text](https://github.zhaw.ch/brunnpa7/ITSec/blob/master/Lab%204/img/TerminalCarol_Teil3.png "Carol 3")

## Dave's Passwort -> /D66AB+A4F
Das gesuchte Passwort ist: /D66AB+A4F

Bei diesem Passwort können wir die Rainbow-Tables nicht verwenden, da es zum einen keinen Eintrag dazu gibt und zum anderen funktioniert dies nicht mit den Sonderzeichen.

Aus diesem Grund gehen wir im Folgenden den Weg in der incrementellen Berechnung der 7 ersten Zeichen. Hierfür braucht es eine Anpassung im John.conf
### Anpassungen John.conf
```
[Incremental:DaveRule]
File = $JOHN/digits.chr
Extra = ABCDEF+/.
MinLen = 7
MaxLen = 7
CharCount = 19
```

### Eingabe Terminal
#### Schritt 1
```
john --format=nethalflm --incremental=DaveRule /root/Desktop/dave_netntlm
```
Daraus erhalten wir dann folgendes Teilpasswort: /D66AB+
![alt text](https://github.zhaw.ch/brunnpa7/ITSec/blob/master/Lab%204/img/TerminalDave_Teil1.png "Dave 1")

### Schritt 2
```
netntlm.pl --seed /D66AB+ --file /root/Desktop/dave_netntlm
```
Daraus erhalten wir folgendes Passwort: /D66AB+A4F
Da wir im vorliegenden Fall wissen, dass es sich einzig um Grossbuchstaben handeln kann, wissen wir auch, dass es sich um das gewünschte Passwort handelt. Um die Aufgabe zu überprüfen, führen wir noch Schritt 3 aus.
![alt text](https://github.zhaw.ch/brunnpa7/ITSec/blob/master/Lab%204/img/TerminalDave_Teil2_1.png "Dave 2.1")
![alt text](https://github.zhaw.ch/brunnpa7/ITSec/blob/master/Lab%204/img/TerminalDave_Teil2_2.png "Dave 2.2")

### Schritt 3
```
netntlm.pl --file /root/Desktop/dave_netntlm
```
--> Das Passwort stimmt überein
![alt text](https://github.zhaw.ch/brunnpa7/ITSec/blob/master/Lab%204/img/TerminalDave_Teil3.png "Dave 3")
