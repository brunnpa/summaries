
/**
 * Mit der Klasse Event können Objekte von Kuenstler und drei Ticketkateogrien erstellt werden
 * 
 * @author Pascal Brunner 
 * @version 07102017
 */
public class Event
{
    private Ticket ticket1;
    private Ticket ticket2;
    private Ticket ticket3;
    private Kuenstler kuenstler;

    /**
     * Konstruktor für Objekte mit Parameter der Klasse Event
     * 
     * @param kuenstlerName Setzt den Namen des Kuenstlers
     * @param kuenstlerGage Setzt die Gage des Kuenstlers
     * @param kategorie1Bezeichnung Setzt die Bezeichnung der Kategorie 1
     * @param kategorie1Preise Setzt den Ticketpreis der Kategorie 1
     * @param kategorie1Total Gibt an wie viele Tickets total in der Kategorie 1 vorhanden sind
     * @param kategorie2Bezeichnung Setzt die Bezeichnung der Kategorie 2
     * @param kategorie2Preise Setzt den Ticketpreis der Kategorie 2
     * @param kategorie2Total Gibt an wie viele Tickets total in der Kategorie 2 vorhanden sind
     * @param kategorie3Bezeichnung Setzt die Bezeichnung der Kategorie 3
     * @param kategorie3Preise Setzt den Ticketpreis der Kategorie 3
     * @param kategorie3Total Gibt an wie viele Tickets total in der Kategorie 3 vorhanden sind
     */
    public Event(String kuenstlerName, int kuenstlerGage, String kategorie1Bezeichnung, int kategorie1Preise, int kategorie1Total, 
                 String kategorie2Bezeichnung, int kategorie2Preise, int kategorie2Total, 
                 String kategorie3Bezeichnung,int kategorie3Preise, int kategorie3Total)
    {
        kuenstler = new Kuenstler(kuenstlerName, kuenstlerGage);
        ticket1 = new Ticket(kategorie1Bezeichnung, kategorie1Preise, kategorie1Total);
        ticket2 = new Ticket(kategorie2Bezeichnung, kategorie2Preise, kategorie2Total);
        ticket3 = new Ticket(kategorie3Bezeichnung, kategorie3Preise, kategorie3Total);
        
    }
    
    /**
     * Erstellen eines Konstruktors ohne Parameter, welche das Objekt mit Default-Werte setzt.
     */
    public Event()
    {
        kuenstler = new Kuenstler();
        ticket1 = new Ticket();
        ticket2 = new Ticket();
        ticket3 = new Ticket();
    }

    /**
     * Methode zum Kaufen von Tickets
     * @param kategorie Dient zur Auswahl der betroffenen Ticketkategorie
     * @param anzahlTickets Gibt die Anzahl an, wie viele Tickets gekauft werden
     */
    public void kaufen(String kategorie, int anzahlTickets)
    {
        if(kategorie == ticket1.getKategorieBezeichnung())
        {
            ticket1.ticketKaufen(anzahlTickets);
        }
        else if(kategorie == ticket2.getKategorieBezeichnung())
        {
            ticket2.ticketKaufen(anzahlTickets);
        }
        else if(kategorie == ticket3.getKategorieBezeichnung())
        {
            ticket3.ticketKaufen(anzahlTickets);
        }
        else
        {
            System.out.println("Es wurde keine Ticketkategorie mit Ihrer Bezeichnung gefunden, achten Sie sich bitte auf die genaue Schreibweise");
            System.out.println("Aktuell verfügbare Ticketkategorien sind:");
            System.out.println(ticket1.getKategorieBezeichnung());
            System.out.println(ticket2.getKategorieBezeichnung());
            System.out.println(ticket3.getKategorieBezeichnung());
        }
    }
    
    /**
     * Mit dieser Methode kann das Objekt ticket1 angepasst werden
     * 
     * @param  bezeichnung    mit dem Parameter bezeichnung kann die Bezeichnung der Kategorie1 gesetzt werden
     * @param  preis          mit dem Parameter preis kann der Preis der Kategorie1 gesetzt werden
     * @param  anzahlTickets  mit dem Parameter anzahlTickets kann die Total verfuegbaren Tickets der Kategorie1 gesetzt werden
     */
    public void setKategorie1(String bezeichnung, int preis, int anzahlTickets)
    {
        ticket1.setTicket(bezeichnung, preis, anzahlTickets);       
    }
    
    /**
     * Mit dieser Methode kann das Objekt ticket2 angepasst werden
     * 
     * @param  bezeichnung    mit dem Parameter bezeichnung kann die Bezeichnung der Kategorie2 gesetzt werden
     * @param  preis          mit dem Parameter preis kann der Preis der Kategorie2 gesetzt werden
     * @param  anzahlTickets  mit dem Parameter anzahlTickets kann die Total verfuegbaren Tickets der Kategorie2 gesetzt werden
     */
    public void setKategorie2(String bezeichnung, int preis, int anzahlTickets)
    {
        ticket2.setTicket(bezeichnung, preis, anzahlTickets);       
    }
    
    /**
     * Mit dieser Methode kann das Objekt ticket3 angepasst werden
     * 
     * @param  bezeichnung    mit dem Parameter bezeichnung kann die Bezeichnung der Kategorie3 gesetzt werden
     * @param  preis          mit dem Parameter preis kann der Preis der Kategorie3 gesetzt werden
     * @param  anzahlTickets  mit dem Parameter anzahlTickets kann die Total verfuegbaren Tickets der Kategorie3 gesetzt werden
     */
    public void setKategorie3(String bezeichnung, int preis, int anzahlTickets)
    {
        ticket3.setTicket(bezeichnung, preis, anzahlTickets);       
    }
    
    /**
     * Mit dieser Methode kann das Objekt kuenstler angepasst werden
     * 
     * @param  bezeichnung    mit dem Parameter bezeichnung kann die Bezeichnung des Kuenstlers gesetzt werden
     * @param  gage           mit dem Parameter gage kann die Gage des Kuenstlers gesetzt werden
     */
    public void setKuenstler(String bezeichnung, int gage)
    {
        kuenstler.setKuenstler(bezeichnung, gage);
    }
    
    /**
     * Methode zur Ausgabe der Informationen zum Event
     */
    public void getEventInformations()
    {
        int gesamteinnahmen = ticket1.berechneEinnahmen() + ticket2.berechneEinnahmen() + ticket3.berechneEinnahmen();
        int gewinn = gesamteinnahmen - kuenstler.getGage();
        System.out.println("Kuenstler: " + kuenstler.getName() + ", Gage: CHF " + kuenstler.getGage());
        System.out.println(ticket1.getKategorieBezeichnung() + ": " + ticket1.getVerfuegbareTickets() + " von " + ticket1.getAnzahlTickets() + 
                            " verfügbar, Einnahmen: CHF " + ticket1.berechneEinnahmen());
        System.out.println(ticket2.getKategorieBezeichnung() + ": " + ticket2.getVerfuegbareTickets() + " von " + ticket2.getAnzahlTickets() + 
                            " verfügbar, Einnahmen: CHF " + ticket2.berechneEinnahmen());
        System.out.println(ticket3.getKategorieBezeichnung() + ": " + ticket3.getVerfuegbareTickets() + " von " + ticket3.getAnzahlTickets() + 
                            " verfügbar, Einnahmen: CHF " + ticket3.berechneEinnahmen());
        System.out.println("Gesamteinnahmen: CHF " + gesamteinnahmen);
        if(gewinn >=0)
        {
            System.out.println("Gewinn: CHF " + gewinn);
        }
        else
            System.out.println("Verlust: CHF " + gewinn);
    }
    
}
