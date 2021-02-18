import java.awt.Point;
import java.util.Scanner;
import java.util.ArrayList;
import java.util.HashMap;

/**
 * Spielklasse des Spiels Snake.
 *
 * Ziel dieses Spiels ist es alle Goldstuecke einzusammeln und 
 * die Tuer zu erreichen, ohne sich selber zu beissen oder in 
 * die Spielfeldbegrenzung reinzukriechen. 
 */
public class SnakeSpiel {
    private Schlange schlange;
    private Tuer tuer;
    private Spielfeld spielfeld;
    private ArrayList<Point> goldStuecke;
    private ArrayList<Integer> wert;
    private boolean spielLaeuft = true;
    private int anzahlGoldstuecke = 10;

    /**
     * Konstruktor ohne Parameter mit Defaultwert 10
     */
    public SnakeSpiel()
    {
        anzahlGoldstuecke = 10;
    }
    
    /**
     * Konstruktor mit Parameter 
     * @param anzahlGoldstuecke gibt die Anzahl der Goldstuecke auf dem Spielfeld an
     */
    
    public SnakeSpiel(int anzahlGoldstuecke)
    {
        setAnzahlGoldstuecke(anzahlGoldstuecke);
    }
    
    /**
     * Startet das Spiel.
     */
    public void spielen() {
        spielInitialisieren();
        while (spielLaeuft) {
            zeichneSpielfeld();
            ueberpruefeSpielstatus();
            fuehreSpielzugAus();
        }   
    }
    
    /**
     * Main-Methode
     */
    public static void main(String[] args) {
        new SnakeSpiel().spielen();
    }
    
    /**
     * Initialisiert das Spiel
     */
    private void spielInitialisieren() {
        tuer = new Tuer(0, 5);
        spielfeld = new Spielfeld(40, 10);
        goldStuecke = new ArrayList<Point>();
        wert = new ArrayList<Integer>();
        for (int counter = 0; counter < anzahlGoldstuecke; counter++)
        {
            Point neuerPunktFuerGoldstueck = spielfeld.erzeugeZufallspunktInnerhalb();
            goldStuecke.add(new Point(neuerPunktFuerGoldstueck));
            Integer wertDefinierenFuerGoldstueck = zufallsWert();
            wert.add(new Integer(wertDefinierenFuerGoldstueck));
            HashMap<Point, Integer> map = new HashMap<Point, Integer>();
        }   
        schlange = new Schlange(30, 2);
    }
    
    /**
     * Methode um die Anzahl Goldstuecke auf dem Spielfeld zu bestimmen
     * @param anzahl Anzahl Goldstuecke auf dem Spielfeld
     */
      public void setAnzahlGoldstuecke(int anzahl)
    {
        anzahlGoldstuecke = anzahl;
    }
    
    /**
     * Methode um das Spielfeld zu zeichnen
     */
        private void zeichneSpielfeld() {
        char ausgabeZeichen;
        for (int y = 0; y < spielfeld.gibHoehe(); y++) {
            for (int x = 0; x < spielfeld.gibBreite(); x++) {
                Point punkt = new Point(x, y);
                ausgabeZeichen = '.';
                if (schlange.istAufPunkt(punkt)) {
                    ausgabeZeichen = '@';
                } else if (istEinGoldstueckAufPunkt(punkt)) {
                    ausgabeZeichen = '$';
                } else if (tuer.istAufPunkt(punkt)) {
                    ausgabeZeichen = '#';
                } 
                if(schlange.istKopfAufPunkt(punkt)) {
                    ausgabeZeichen = 'S';         
                }
                System.out.print(ausgabeZeichen);
            }
            System.out.println();
        }
    }

    /**
     * Methode zur Ueberpruefung ob ein Goldstueck auf einem Punkt liegt
     * @return ob das Goldstueck auf dem Punkt liegt
     */
     private boolean istEinGoldstueckAufPunkt(Point punkt) 
    {
    return !(goldStuecke.isEmpty()) && goldStuecke.contains(punkt);
    }
    
    /**
     * Methode zur Ueberpruefung des Spielstatus
     */
    private void ueberpruefeSpielstatus() 
    {
        if (istEinGoldstueckAufPunkt(schlange.gibPosition())) {
            goldStuecke = null;
            schlange.wachsen();
            System.out.println("Goldstueck eingesammelt.");
        }
        if (istVerloren()){ 
            System.out.println("Verloren!");
            spielLaeuft = false;
        }
        if (istGewonnen()){
            System.out.println("Gewonnen!");
            spielLaeuft = false;
        }
    }

    /**
     * Methode zur Ueberpruefung ob das Spiel gewonnen ist
     * @return istGewonnen
     */
    private boolean istGewonnen() 
    {
        return goldStuecke == null && 
        tuer.istAufPunkt(schlange.gibPosition());
    }

    /**
     * Methode zur Ueberprufung ob das Spiel verloren ist
     * @return istVerloren
     */
    private boolean istVerloren() 
    {
        return schlange.istKopfAufKoerper() || 
        !spielfeld.istPunktInSpielfeld(schlange.gibPosition());
    }
    
    /**
     * Methode zur Spielzugausfuehrung
     */
    private void fuehreSpielzugAus() 
    {
        char eingabe = liesZeichenVonTastatur();
        schlange.bewege(eingabe);
    }
    
    /**
     * Methode zum Auslesen der Zeichen aus der Tastatur
     * @return Der Wert der Konsolen eingabe
     */
    private char liesZeichenVonTastatur() 
    {
        Scanner scanner = new Scanner(System.in);
        char konsolenEingabe = scanner.next().charAt(0);
        return konsolenEingabe;
    }
    
    /**
     * Methode zur Berechnung eines Zufallwertes
     * @return Der Zufallswert
     */
    private int zufallsWert()
    {
        int wert = (int)(Math.random()*5+1);
        return wert;
    }
}