
/**
 * Praktikum 2 - Aufgabe 4
 * 
 * Die Klasse Konto dient für eine Bankapplikation. Sie liefert die Werte über den Kontoinhaber, den Kontostand, sowie den Zinssatz
 * 
 * @author Pascal Brunner 
 * @version 30. September 2017
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
        istNameGueltig(kontoinhaber);
        kontostand = 0;
        zinssatz = 2;
    }
    
    /**
     * Konstruktor zum Konto erzeugen mittels Kontoinhaber und Zinssatz
     */
    public Konto(String kontoinhaber, int zinssatz)
    {
        istNameGueltig(kontoinhaber);
        istZinssatzGueltig(zinssatz);  
        kontostand = 0;
    }
    
    /**
     * Methode zur Überprüfung der Zeichen des Kontoinhabers
     */
    private void istNameGueltig(String kontoinhaber)
    {
        if(kontoinhaber.length() >=3 && kontoinhaber.length() <=20)
        {
            this.kontoinhaber = kontoinhaber;
        }
        else
        {
            this.kontoinhaber = "no name";
            System.out.println("Unzulässige Eingabe, es wurde der Standardwert " + this.kontoinhaber + " eingesetzt; Mindestens drei Zeichen und maximal 20 Zeichen erlaubt");
        }
    }
    
    /**
     * Methode zur Veränderung des Zinssatzes
     */
    public int setZinssatz(int zinssatz)
    {
        istZinssatzGueltig(zinssatz);
        return zinssatz;
    }
    
    /**
     * Methode zur Überprüfung des Zinssatzes
     */
    private void istZinssatzGueltig(int zinssatz)
    {
        if(zinssatz>=0 && zinssatz <=10)
        {
            this.zinssatz = zinssatz;
        }
        else
        {
            zinssatz = 0; 
            System.out.println("Unzulässiger Wert, es wurde der Standardwert " + zinssatz + " eingesetzt; Der Zinssatz muss zwischen 0 und 10 % sein");
        } 
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
        if(istGeldBetragGueltig(betrag) == true)
        {
            kontostand = kontostand + betrag;
        }
        else
        {
            System.out.println("Unzulässige Betrageingabe, der Wert muss zwischen 0 und 10'000 Franken liegen");
        }
    }
    
    /**
     * Methode zum Überprüfung der Geldeinzahlung
     */
    private boolean istGeldBetragGueltig(int betrag)
    {
        if(betrag > 0 && betrag <= 10000)
        {
            return true;
        }
        else
        {
            return false;
        }
    }
    /**
     * Methode zum Geld auszahlen
     */
    public void geldAuszahlen(int betrag)
    {
        if(istGeldBetragGueltig(betrag)==true)
        {
            if(kontostand - betrag >= 0)
            {
            kontostand = kontostand - betrag;
            }
            else
            {
                System.out.println("Die Ausgabe von " + betrag + " ist nicht zulässig. Aktuell sind noch " + kontostand + " Franken auf Ihrem Konto");
            }
        }
        else
        {
            System.out.println("Unzulässige Betrageingabe, der Wert muss zwischen 0 und 10'000 Franken liegen");
        }
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
