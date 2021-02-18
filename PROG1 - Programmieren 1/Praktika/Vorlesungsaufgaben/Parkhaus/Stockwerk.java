
/**
 * Beschreiben Sie hier die Klasse Stockwerk.
 * 
 * @author (Ihr Name) 
 * @version (eine Versionsnummer oder ein Datum)
 */
public class Stockwerk
{
    // Instanzvariablen - ersetzen Sie das folgende Beispiel mit Ihren Variablen
    private String stockwerkname;
    private int anzahlParkplaetze;
    private int parkplaetzeBesetzt;

    /**
     * Konstruktor für Objekte der Klasse Stockwerk
     */
    public Stockwerk(String stockwerkname, int anzahlParkplaetze)
    {
        this.stockwerkname = stockwerkname;
        this.anzahlParkplaetze = anzahlParkplaetze;
        parkplaetzeBesetzt = 0;
    }
    
    public int parkplatzBesetzen()
    {
        parkplaetzeBesetzt = anzahlParkplaetze - 1;
        return parkplaetzeBesetzt;
    }
    
    public int parkplatzFreigeben()
    {
        parkplaetzeBesetzt = anzahlParkplaetze + 1;
        return parkplaetzeBesetzt;
    }
    
    
    /**
     * Ein Beispiel einer Methode - ersetzen Sie diesen Kommentar mit Ihrem eigenen
     * 
     * @param  y    ein Beispielparameter für eine Methode
     * @return        die Summe aus x und y
     */
    public void ausgeben()
    {
        System.out.println(stockwerkname + ": " +  (anzahlParkplaetze - parkplaetzeBesetzt) + " von" + anzahlParkplaetze + " frei");
    }
}
