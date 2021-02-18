# ITS-Praktikum 3 - Abgabe David Luescher und Pascal Brunner

## Exercise 1
Siehe https://github.zhaw.ch/brunnpa7/ITSec/blob/master/Lab%203/src/Exercise01.java

## Exercise 2
> static BigInteger  probablePrime(int bitLength, Random rnd)    Returns a positive BigInteger that is probably prime, with the specified bitLength

> BigInteger  gcd(BigInteger val) Returns a BigInteger whose value is the greates commond divisor of abs(this) and abs(val)

> public BigInteger mod(BigInteger m) Reutrns a BigInteger whose value is (this mod m). This method differs from remainder in that it always returns a non-negative BigInteger

> BigInteger modPow(BigInteger exponent, BigInteger m)  Returns a BigInteger whose value is (this^exponent mod m)

## Exercise 3
siehe https://github.zhaw.ch/brunnpa7/ITSec/blob/master/Lab%203/src/RSA.java

## Exercise 4
siehe https://github.zhaw.ch/brunnpa7/ITSec/blob/master/Lab%203/src/Main.java

## Exercise 5
siehe https://github.zhaw.ch/brunnpa7/ITSec/blob/master/Lab%203/src/Main.java

## Exercise 6
Hat gut funktioniert

## Exercise 7
Aus der Aufgabenstellung entnehmen wir folgende Informationen:
Sei *e der RSA public key* und *d der dazugehörige private Key*
Anwendung findet dies beim Cipher- /Klartext (Plaintext)
Sei *C der Ciphertext* und *K der Klartext*
Aus der Definition entnehmen wir, dass folgendes gilt:
> C = K^e mod n 
> K = C^e mod n

Daraus foglt:
(K^e mod n)^d mod n, was der Definition aus Cipher und Klartext entspricht

Siehe auch Theorem 5

## Exercise 8
Im vorliegenden Fall könnte Eve (Man-in-the-middle) von einer Replay Attack (oder auch playback attack genannt) gebrauch machen, welche die Eigenschaft besitzt eine Nachricht nochmals zu senden um entsprechend weitere Male (in diesem Fall) das Geld zu erhalten.

## Exercise 9 (Annahme in der Aufgabenstellung ist Aufgabe 8 gemeint)
Man muss sicherstellen, dass die entsprechenden Keys niemals zweimal verwendet werden - sondern zu jedem Zeitpunkt rein zufällig erstellt werden. Sofern etwas nicht wie gewünscht funktionieren sollte, so soll der Key verworfen werden und nicht mehr valid sein.

## Exercise 10
siehe https://github.zhaw.ch/brunnpa7/ITSec/blob/master/Lab%203/src/RSA.java

## Exercise 11
siehe https://github.zhaw.ch/brunnpa7/ITSec/blob/master/Lab%203/src/Main.java

## Exercise 12
See classes `VerifySignedWithPublicKeyFromDavid` and `VerifySignedWithPublicKeyFromPascal` in `src` directory.

## Exercise 13
m muss kleiner sein als der Logrithmus zur Basis e von n. 
Dabei gilt, dass n eine Zahl ist
k repräsentiert die Anzahl Bits, welche benötigt werden um diese Zahl darzustellen.

Wenn wir bspw. die Zahl 5 nehmen, so ist n = 5 und k = 3, da man 5 als 101 in Bits darstellen kann. 
Entsprechend sind alle m zwischen von 0 - 4 mögliche Kandidaten.

Analog ist dies für die sehr grosse Zahl, welche mit bspw. 4056Bits dargestellt werden kann. 

## Exercise 14
Durch das verwenden des Padding-Schemas werden zufällige Bits der (Plain)Nachricht hinzugefügt, bis es die gewünschte Länge erreicht.

## Exercise 15
Verwendung von unterschiedlichen Paddings
Verwendung von eindeutigen KeyPairs für verschiedene Empfänger

## Exercise 16
Unter Betrachtung des Hinweises: What is the gcd of two moduli that do not share a common prime factor, and what is the gcd of two moduli that do share a common prime factor?

Darauf folgt: 
 What is the gcd of two moduli that do not share a common prime factor -> Bei der Primfaktorzerlegung, bei welchem keine gemeinsamen Primzahlen haben, ist einzig die Zahl 1, welche als gcd gelten kann
 what is the gcd of two moduli that do share a common prime factor -> Daraus folgt dann, das der grösste gemeinsame Teiler entsprechend der Primfaktor ist. 
 
## Exercise 17
Hierzu braucht man die Möglichkeit, dass Zahlen Pseudozufällig gewählt werden - in der IT-Security spricht man dabei von Cryptographically secure pseudorandom number generator

