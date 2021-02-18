
/**
 * Aufgabe 4
 * 
 * Die Klasse Konto dient für eine Bankapplikation. Sie liefert die Werte über den Kontoinhaber, den Kontostand, sowie den Zinssatz
 * 
 * @author Pascal Brunner 
 * @version 19. September 2017
 */
public class Konto
{
    private String kontoinhaber;
    private int kontostand;
    private int zinssatz;
    
    /**
     * Konstruktor zum Konto erzeugen mittels Kontoinhaber
     */
    public Konto(String kontoinhaber)
    {
        this.kontoinhaber = kontoinhaber;
        kontostand = 0;
        zinssatz = 2;
    }
    
    /**
     * Konstruktor zum Konto erzeugen mittels Kontoinhaber und Zinssatz
     */
    public Konto(String kontoinhaber, int zinssatz)
    {
        this.kontoinhaber = kontoinhaber;
        this.zinssatz = zinssatz;
        kontostand = 0;
    }
    
    /**
     * Methode zur Veränderung des Zinssatzes
     */
    public int setZinssatz(int zinssatz)
    {
        this.zinssatz = zinssatz;
        return zinssatz;
    }
    
    /**
     * Methode zum Abfrage des Zinssatzes
     */
    public int getZinssatz()
    {
        System.out.println("Der Zinssatz ist " + zinssatz);
        return zinssatz;
    }
    
    /**
     * Methode zum Geld einzahlen
     */
    public void geldEinzahlen(int betrag)
    {
        kontostand = kontostand + betrag;
    }
    
    /**
     * Methode zum Geld auszahlen
     */
    public void geldAuszahlen(int betrag)
    {
        kontostand = kontostand - betrag;
    }
    
    /**
     * Methode zur Abfrage des Jahreszinses
     */
    public int getJahreszins()
    {
        int betragJahreszins;
        betragJahreszins = (kontostand / 100 * zinssatz);
        return betragJahreszins;
    }
    
    /**
     * Methode zur Abfrage der Kontoinformationen
     */
    public void kontoInformationen()
    {
        System.out.println("Informationen zum Konto:");
        System.out.println("Kontoinhaber: " + kontoinhaber);
        System.out.println("Kontostand: CHF " + kontostand);
        System.out.println("Zinssatz: " + zinssatz +"%");
    }
}
