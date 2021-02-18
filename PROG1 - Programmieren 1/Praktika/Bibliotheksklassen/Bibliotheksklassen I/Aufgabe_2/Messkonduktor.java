import java.util.Arrays;
import java.util.Random;
/**
 * Mit dem Messkonduktor kann die Zeit fuer das Erzeugen und Sortieren einer
 * vorgegebenen Anzahl Zusfallszahlen gemessen werden. Die Anzahl Zufallszahlen
 * ist konfigurierbar. 
 */
public class Messkonduktor {
  private int anzahlZufallszahlen;
  
  /**
   * Erstellt einen Messkonduktor.
   * 
   * @param anzahlZufallszahlen Anzahl Zufallszahlen pro Messung.
   */
  public Messkonduktor(int anzahlZufallszahlen) {
    this.anzahlZufallszahlen = anzahlZufallszahlen;
  }
  
  /**
   * Fuehrt eine Anzahl Messungen durch. Die Anzahl ist bestimmt durch die
   * Laenge des uebergeben Arrays. Eine einzelne Messung besteht aus dem
   * Generieren und Sortieren der Zufallszahlen.
   * 
   * @param messResultate Der Array fuer die Messresultate.
   * @return Messresultate mit Zeitdauer in ms.
   */
  public int[] messungenDurchfuehren(int[] messResultate) {
    for (int i = 0; i < messResultate.length; i++) {
      messResultate[i] = einzelneMessungDurchfuehren();
    }
    return messResultate;
  }
  
  private int einzelneMessungDurchfuehren() {
    long zeitVorher = System.currentTimeMillis();
    int[] zufallszahlen = zufallszahlenGenerieren();
    Arrays.sort(zufallszahlen);
    long zeitDanach = System.currentTimeMillis();
    int zeitdauerInMs = (int) (zeitDanach - zeitVorher);
    return zeitdauerInMs;
  }
  
  private int[] zufallszahlenGenerieren() {
    int[] zufallszahlen = new int[anzahlZufallszahlen];
    Random zufallszahlenGenerator = new Random();
    for (int i = 0; i < anzahlZufallszahlen; i++) {
      zufallszahlen[i] = zufallszahlenGenerator.nextInt(100000);
    }
    return zufallszahlen;
  }
  
  public int setAnzahlZufallszahlen(int anzahlZufallszahlen){
      this.anzahlZufallszahlen = anzahlZufallszahlen;
      return anzahlZufallszahlen;
    }
}