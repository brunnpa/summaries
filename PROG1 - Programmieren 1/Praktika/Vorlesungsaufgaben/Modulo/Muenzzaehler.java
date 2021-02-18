
/**
 * Beschreiben Sie hier die Klasse Muenzzaehler.
 * 
 * @author (Ihr Name) 
 * @version (eine Versionsnummer oder ein Datum)
 */
public class Muenzzaehler
{
    // Instanzvariablen - ersetzen Sie das folgende Beispiel mit Ihren Variablen
    private int restbetrag;
    private int betrag;

    /**
     * Konstruktor für Objekte der Klasse Muenzzaehler
     */
    public Muenzzaehler()
    {
        
    }

    
    public int zaehler(int betrag)
    {
        int anzahlfuenfer = 0;
        int anzahlzweier = 0;
        int anzahleiner = 0;
        int anzahlfuenfziger = 0;
        int anzahlzwanziger = 0;
        int anzahlzehner = 0;
        int anzahlfuenferli = 0;
        
        anzahlfuenfer = betrag % 500;
        anzahlzweier = anzahlfuenfer % 200;
        anzahleiner = anzahlzweier % 100;
        anzahlfuenfziger = anzahleiner % 50;
        anzahlzwanziger = anzahlfuenfziger % 20;
        anzahlzehner = anzahlzwanziger % 10;
        anzahlfuenferli = anzahlzehner % 5;
        
        System.out.println("Anzahl 5er" + anzahlfuenfer);
        System.out.println("Anzahl 2er" + anzahlzweier);
        System.out.println("Anzahl 2er" + anzahleiner);
        System.out.println("Anzahl 2er" + anzahlfuenfziger);
        System.out.println("Anzahl 2er" + anzahlzweier);
        System.out.println("Anzahl 2er" + anzahlzweier);
    }
}
