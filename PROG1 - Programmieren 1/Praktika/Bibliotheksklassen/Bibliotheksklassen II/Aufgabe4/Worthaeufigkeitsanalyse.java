import java.util.*;

/**
 * Zaehlt die Anzahl Vorkommnisse von Woertern ueber mehrere Zeichenketten.
 * Es lassen sich eine beliebige Anzahl an Zeichenketten uebergeben. Die
 * Statistik wird fortlaufend gefuehrt. Die Wortzaehlung laesst sich jederzeit
 * ausgeben. Die Satzeichen . , ? ! " : ; werden entfernt. Alle Buchstaben
 * werden in Kleinbuchstaben umgewandelt um beispielsweise das Wort 'die'
 * inmitten eines Satzes und das Wort 'Die' am Anfang eines Satzes als gleiches
 * Wort werten zu koennen.
 * 
 * @version 1.0
 * @author David Luescher, Pascal Brunner
 */
public class Worthaeufigkeitsanalyse {
    private String text;
    private HashMap<String, Integer> zaehler;
    
    /**
     * Konstruktor
     */
    public Worthaeufigkeitsanalyse()
    {
        this.text = null;
        zaehler = new HashMap<String, Integer>();
    }
    
    /**
     * Methode zum die Statistik auszugeben
     */
    public void druckeStatistik(String text)
    {
        this.text = text;
        verarbeiteText();
        
        for(HashMap.Entry<String, Integer> entry : zaehler.entrySet())
        {
            System.out.println(entry);
        }
        
    }
    
    /**
     * Methode zum einen Text in einzelne Woerter umzuwandeln
     */
    private void verarbeiteText()
    {
        String[]nurWoerter = text.toLowerCase().split("[.,\"?! :;]+");      
        
        for(int i=0; i<nurWoerter.length; i++) //Ueberpruefungsschlaufe
        {
            if(zaehler.containsKey(nurWoerter[i]))
            {
                //zaehler.get(nurWoerter[i]);
                //zaehler.put(nurWoerter[i], zaehler.get(nurWoerter[i]+1));
                int count = zaehler.get(nurWoerter[i]);
                zaehler.put(nurWoerter[i], ++count);
            }
            else
            {
                zaehler.put(nurWoerter[i],1);
            }
        }
    }
      
}
