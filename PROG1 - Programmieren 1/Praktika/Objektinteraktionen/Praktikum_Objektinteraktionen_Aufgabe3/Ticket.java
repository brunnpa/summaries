
/**
 * Die Klasse Ticket kann von der Klasse Event verwendet werden. 
 * In der Klasse Ticket kann Objekt Ticket mit Kategorie, Preis, totale und verfügbare Ticket erzeugt werden
 * 
 * @author Pascal Brunner
 * @version 07102017
 */
public class Ticket
{
    private String bezeichnungKategorie;
    private int ticketpreis;
    private int totaleTickets;
    private int verfuegbareTickets;

    /**
     * Konstruktor für Objekte mit Parameter der Klasse Ticket
     * Setzt den Wert verfuegbareTickets auf den Wert der totalenTickets
     * @param bezeichnungKategorie
     * @param ticketpreis
     * @param totaleTickets
     */
    public Ticket(String bezeichnungKategorie, int ticketpreis, int totaleTickets)
    {
        this.bezeichnungKategorie = bezeichnungKategorie;
        this.ticketpreis = ticketpreis;
        this.totaleTickets = totaleTickets;
        verfuegbareTickets = totaleTickets;
    }
    
    /**
     * Konstruktor für Objekte ohne Parameter der Klasse Ticket mit Defaultwerte
     */
    public Ticket ()
    {
        bezeichnungKategorie = "___";
        ticketpreis = 0;
        totaleTickets = 0;
        verfuegbareTickets = 0;
    }

    /**
     * Methode zum Setzten der Ticketdetails
     * 
     * @param bezeichnungKategorie Bezeichnung der Kategorie
     * @param ticketpreis Preis des Tickets
     * @param totaleTickets Anzahl der totalen Anzahl der Tickets
     */
    public void setTicket(String bezeichnungKategorie, int ticketpreis, int totaleTickets)
    {
        this.bezeichnungKategorie = bezeichnungKategorie;
        this.ticketpreis = ticketpreis;
        this.totaleTickets = totaleTickets;
    }
    
    /**
     * Methode zum Ticket kaufen
     * @param anzahlTickets Anzahl der gewünschten Tickets
     * 
     * @return kaufpreis liefert den Wert des Kaufpreises
     */
    // Fragen an den Lehrer: Ist hier ein return Wert notwendig? Meine Gedanken sind, dass man dann mit dem Kaufpreis weitergearbeitet werden kann.
    public int ticketKaufen(int anzahlTickets)
    {
        int kaufpreis = 0; 
        
        if(verfuegbareTickets - anzahlTickets >= 0 && anzahlTickets >= 1)
        {
            verfuegbareTickets = verfuegbareTickets - anzahlTickets;
            kaufpreis = anzahlTickets * ticketpreis;
            System.out.println(anzahlTickets + "Tickets à " + ticketpreis + "pro Ticket. Gesamtpreis: CHF " + kaufpreis);
        }
        else
        {
            System.out.println("Kauf konnte nicht abgeschlossen werden, es sind nur noch " + verfuegbareTickets + " verfügbar");
        }
        return kaufpreis;
    }

    /**
     * Liefert Anzahl der Tickets
     * 
     * @return Liefert die Anzahl der Tickets
     */
    public int getAnzahlTickets()
    {
        return totaleTickets;
    }
    
    /**
     * Liefert Anzahl der verfuegbaren Tickets
     * 
     * @return Liefert die Anzahl der verfuegbaren Tickets
     */
    public int getVerfuegbareTickets()
    {
        return verfuegbareTickets;
    }
    
    /**
     * Berechnet die Einnahme des Tickets
     * 
     * @return Die Einnahme des Tickets
     */
    public int berechneEinnahmen()
    {
        int einnahme = (totaleTickets - verfuegbareTickets)*ticketpreis;
        return einnahme;
    }
    
    /**
     * Liefert den Namen der Kategorie
     * 
     * @return Liefert den Namen der Kategorie
     */
    public String getKategorieBezeichnung()
    {
        return bezeichnungKategorie;
    }
}
