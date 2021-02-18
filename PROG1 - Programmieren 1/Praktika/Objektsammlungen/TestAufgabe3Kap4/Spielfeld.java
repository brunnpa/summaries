import java.awt.Point;

/**
 * Enthaelt Angaben zum Spielfeld
 */
public class Spielfeld {
  private int hoehe;
  private int breite;
  
  /**
   * Konstruiert ein Spielfeld mit der gegebenen Breite
   * und Hoehe.
   *  
   * @param breite Breite des Spielfelds
   * @param hoehe Hoehe des Spielfelds
   */
  public Spielfeld(int breite, int hoehe){
    this.hoehe = hoehe;
    this.breite = breite;
  }
  
  /**
   * Gibt die Spielfeldhoehe zurueck
   * 
   * @return die Hoehe des Spielfelds
   */
  public int gibHoehe() {
    return hoehe;
  }
  
  /**
   * Gibt die Spielfeldbreite zurueck
   * 
   * @return die Breite des Spielfelds
   */
  public int gibBreite() {
    return breite;
  }
  
  /**
   * Testet, ob ein gegebener Standort innerhalb des Spielfelds ist.
   * 
   * @param p zu pruefender Standort
   * @return true, falls der Standort innerhalb des Spielfelds ist
   */
  public boolean istPunktInSpielfeld(Point p) {
    return p.x >=0 && p.x < breite && p.y >= 0 && p.y < hoehe; 
  }
  
  /**
   * Erzeugt ein Point-Objekt, welches einen zufaelligen 
   * Standort innerhalb des Spielfelds repraesentiert. 
   * 
   * @return zufaelliger Standort innerhalb des Spielfelds
   */
  public Point erzeugeZufallspunktInnerhalb(){    
    int xKoordinate = (int)(Math.random() * this.breite);
    int yKoordinate = (int)(Math.random() * this.hoehe);
    return new Point(xKoordinate, yKoordinate);
  }
}