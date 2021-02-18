
/**
 * Die Klasse Auto soll für die Verwaltung einen Autohändler sein, damit dieser seine Fahrzeuge verwalten kann. Es besitzt die Datenfelder Marke,
 * Typ, Hubraum, turboMotor, sowie lagerbestand. 
 *
 * 
 * @author (Pascal Brunner) 
 * 
 */
public class Auto
{
    private String marke;
    private String typ;
    private double hubraum;
    private boolean turboMotor;
    private int lagerbestand;

    /**
     * Konstruktor für Objekte der Klasse Auto. Die Strings Marke und Typ werden auf die Zeichenlänger überprüft (Min. 3 und Max. 10 Zeichen).
     * Das Datenfeld Hubraum hat einen Min.- und Max.-Wert von 0.5 bis 8.0
     */
    public Auto(String marke, String typ, double hubraum, boolean turboMotor)
    {
        if(marke.length() > 2 && marke.length() < 11)
        {
            this.marke = marke; 
        }
        else
        {
            this.marke = "___";
            System.out.println("Ungültige Eingabe - Die Bezeichnung der Marke muss zwischen drei und zehn Zeichen haben");
        }
        
        if(typ.length() > 2 && typ.length() < 11)
        {
            this.typ = typ;
        }
        else
        {
            this.typ = "___";
            System.out.println("Ungültige Eingabe, automatisch gesetzter Wert ist ___ - Die Bezeichnung der Typ muss zwischen drei und zehn Zeichen haben");
        }
        
        if(hubraum >= 0.5 && hubraum <= 8.0)
        {
            this.hubraum = hubraum;
        }
        else
        {
            this.hubraum = 0;
            System.out.println("Ungültige Eingabe, automatisch gesetzter Wert ist 0 - Der Wert des Hubraums muss zwischen 0.5 und 8 sein");
        }
        this.turboMotor = turboMotor;
        lagerbestand = 0;
    }
    
    /**
     * Setter-Methode zum Aendern des Markennames inkl. Ueberpruefung der Eingabegrenze (Min. 3 & Max. 10) 
     */
    public String setMarke(String markeEingeben)
    {
        if(markeEingeben.length() > 2 && markeEingeben.length() < 11)
        {
            this.marke = markeEingeben;
        }
        else
        {
            System.out.println("Ungültige Eingabe, die alte Marke wird belassen - Die Bezeichnung der Marke muss zwischen drei und zehn Zeichen haben");
        }
        return marke;
    }
    
    /**
     * Setter-Methode zum Aendern des Typs inkl. Ueberpruefung der Eingabegrenze (Min. 3 & Max. 10) 
     */
    public String setTyp(String typEingeben)
    {
        if(typEingeben.length() > 2 && typEingeben.length() < 11)
        {
            this.typ = typEingeben;
        }
        else
        {
            System.out.println("Ungültige Eingabe, der alte Typ wird belassen - Die Bezeichnung des Typs muss zwischen drei und zehn Zeichen sein");
        }
        return typ;
    }
    
    /**
     * Setter-Methode zum Aendern des Hubraumes inkl. Ueberpruefung der Eingabegrenze (Min. 0.5 & Max. 8.0) 
     */
    public double setHubraum(double hubraumEingeben)
    {
        if(hubraumEingeben >= 0.5 && hubraumEingeben <= 8.0)
        {
            this.hubraum = hubraumEingeben;
        }
        else
        {
            System.out.println("Ungültige Eingabe, der alte Wert des Hubraumes wird belassen - Der Wert des Hubraums muss zwischen 0.5 und 8 sein");
        }
        return hubraum;
    }
    
    /**
     * Methode zum Aendern des boolean ob ein Turbo vorhanden ist oder nicht
     */
    public boolean setTurboMotor(boolean turboEingabe)
    {
        turboMotor = turboEingabe;
        return turboMotor;
    }
    
    /**
     * Setter-Methode zum Aendern des Lagerbestandes inkl. Ueberpruefung der Eingabegrenze (maximaler Änderungswert +/- 10) 
     */
    public int setLagerbestand(int lagerAenderungen)
    {
        int alterLagerbestand = lagerbestand;
        
        if(lagerAenderungen >=-10 && lagerAenderungen <= 10)
        {
            if (lagerbestand - lagerAenderungen >= 0)
            {
                lagerbestand = (lagerbestand - lagerAenderungen);
                System.out.println("Alter Lagerbestand: " + alterLagerbestand);
                System.out.println("neuer Lagerbestand: " + lagerbestand);
            }
            else
            {
                System.out.println("Der Lagerbestand darf nicht unter 0 sein.");
            }
        }
        else
        {
            System.out.println("Der Maximalwert der Änderung darf +/- 10 sein.");
        }
        
        return lagerbestand;
    }
    
    /**
     * Getter-Methode zum Abfragen der Informationen zum Auto 
     */
    public void getInformation()
    {
        
        if(turboMotor == true)
        {
            System.out.println(marke + " " + typ + ", " + hubraum + " Liter " + "turbo");
            System.out.println(marke.substring(0, 3) + "-" + typ.substring(0, 3) + "-" + hubraum + "t");
        }
        else
        {
            System.out.println(marke + " " + typ + ", " + hubraum + " Liter");
            System.out.println(marke.substring(0, 3) + "-" + typ.substring(0, 3) + "-" + hubraum);
        }
            System.out.println("Lagerbestand: " + lagerbestand);
    }
}