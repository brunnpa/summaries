/**
 * Die Klasse Nummernanzeige repräsentiert Darstellungen von
 * digitalen Werten, die von null bis zu einem vorgegebenen Limit
 * reichen können. Das Limit wird definiert, wenn eine Nummernanzeige
 * erzeugt wird. Die darstellbaren Werte reichen von null bis Limit-1.
 * Wenn beispielsweise eine Nummernanzeige für die Sekunden einer
 * digitalen Uhr verwendet werden soll, würde man ihr Limit auf 60
 * setzen, damit die dargestellten Werte von 0 bis 59 reichen.
 * Wenn der Wert einer Nummernanzeige erhöht wird, wird bei Erreichen
 * des Limits der Wert automatisch auf null zurückgesetzt.
 * 
 * @author Michael Kölling und David J. Barnes
 * @version 31.07.2011
 */
public class Nummernanzeige
{
  private int limit;
  private int wert;

  /**
   * Konstruktor für Exemplare der Klasse Nummernanzeige.
   * Setzt das Limit, bei dem die Anzeige zurückgesetzt wird.
   */
  public Nummernanzeige(int anzeigeLimit)
  {
    limit = anzeigeLimit;
    wert = 0;
  }

  /**
   * Liefere den aktuellen Wert als int.
   */
  public int gibWert()
  {
    return wert;
  }

  /**
   * Liefere den Anzeigewert, also den Wert dieser Anzeige als
   * einen String mit zwei Ziffern. Wenn der Wert der Anzeige
   * kleiner als zehn ist, wird die Anzeige mit einer führenden
   * null eingerückt.
   */
  public String gibAnzeigewert()
  {
    if(wert < 10) {
      return "0" + wert;
    }
    else {
      return "" + wert;
    }
  }

  /**
   * Setze den Wert der Anzeige auf den angegebenen 'ersatzwert'.
   * Wenn der angegebene Wert unter null oder über dem Limit liegt,
   * tue nichts.
   */
  public void setzeWert(int ersatzwert)
  {
    if((ersatzwert >= 0) && (ersatzwert < limit)) {
      wert = ersatzwert;
    }
  }

  /**
   * Erhöhe den Wert um eins. Wenn das Limit erreicht ist, setze
   * den Wert wieder auf null.
   */
  public void erhoehen()
  {
    wert = (wert + 1) % limit;
  }
}
