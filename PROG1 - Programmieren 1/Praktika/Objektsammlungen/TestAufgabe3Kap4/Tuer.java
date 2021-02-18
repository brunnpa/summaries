import java.awt.Point;

/**
 * Repraesentiert eine Tuer.
 */
public class Tuer {
  private Point aktuellerOrt;

  /**
   * Konstruiert eine Tuer mit Standort
   * bei den angegebenen Koordinaten. 
   * 
   * @param x x-Koordinate der Tuer
   * @param y y-Koordinate der Tuer
   */
  public Tuer(int x, int y) {
    aktuellerOrt = new Point(x, y);
  }

  /**
   * Prueft, ob die Tuer am bezeichneten Standort ist
   * 
   * @param standort
   * @return wahr, falls die Tuer am bezeichneten Standort ist
   */
  public boolean istAufPunkt(Point standort) {
    return aktuellerOrt.equals(standort);
  }
}