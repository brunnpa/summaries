import java.awt.Point;
import java.util.Scanner;
import java.util.ArrayList;

/**
 * Beschreiben Sie hier die Klasse Goldstueck.
 * 
 * @author (Ihr Name) 
 * @version (eine Versionsnummer oder ein Datum)
 */
public class Goldstueck
{
    // Instanzvariablen - ersetzen Sie das folgende Beispiel mit Ihren Variablen
    private int wert;

    /**
     * Konstruktor für Objekte der Klasse Goldstueck
     */
    public Goldstueck()
    {
        zufallsWert();
    }

    /**
     * Ein Beispiel einer Methode - ersetzen Sie diesen Kommentar mit Ihrem eigenen
     * 
     * @param  y    ein Beispielparameter für eine Methode
     * @return        die Summe aus x und y
     */
    public int zufallsWert()
    {
        wert = (int)(Math.random()*5+1);
        return wert;
    }
    
    public int getWert()
    {
        return wert;
    }
        
}
