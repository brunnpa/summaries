
/**
 * Beschreiben Sie hier die Klasse Parkhaus.
 * 
 * @author (Ihr Name) 
 * @version (eine Versionsnummer oder ein Datum)
 */
public class Parkhaus
{
    // Instanzvariablen - ersetzen Sie das folgende Beispiel mit Ihren Variablen
    private Stockwerk stockwerk1;
    private Stockwerk stockwerk2;
    private Stockwerk stockwerk3;

    /**
     * Konstruktor für Objekte der Klasse Parkhaus
     */
    public Parkhaus(int plaetzeStockwerk1, int plaetzeStockwerk2, int plaetzeStockwerk3)
    {
        stockwerk1 = new Stockwerk("1. Stock", plaetzeStockwerk1);
        stockwerk2 = new Stockwerk("2. Stock", plaetzeStockwerk2);
        stockwerk3 = new Stockwerk("3. Stock", plaetzeStockwerk3);
        
    }

    /**
     * Ein Beispiel einer Methode - ersetzen Sie diesen Kommentar mit Ihrem eigenen
     * 
     * @param  y    ein Beispielparameter für eine Methode
     * @return        die Summe aus x und y
     */
    
}
