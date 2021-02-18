
/**
 * Die Klasse Kuenstler kann von der Klasse Event verwendet werden. In der Klasse Kuenstler kann ein Objekt Kuenstler mit Gage erzeugt werden.
 * 
 * @author Pascal Brunner
 * @version 07102017
 */
public class Kuenstler
{
    private String kuenstlerName;
    private int gage;

    /**
     * Konstruktor für mit Parameter Objekte der Klasse Kuenstler
     * @param KuenstlerName Der Name des Kuenstlers
     * @param gage Die Gage des Kuenstlers    
     */
    public Kuenstler(String kuenstlerName, int gage)
    {
       this.kuenstlerName = kuenstlerName;
       this.gage = gage;
    }
    
    /**
     * Konstruktor ohne Parameter mit Defaultwerten
     * @param KuenstlerName Der Name des Kuenstlers
     * @param gage Die Gage des Kuenstlers    
     */
    public Kuenstler()
    {
        kuenstlerName = "__";
        gage = 0;
    }
    
    /**
     * Setzt einen Namen und Gage für den Kuenstler
     * 
     * @param kuenstlerName Der Namen des Kuenstlers
     * @param gage Die Gage des Kuenstlers
     */
    public void setKuenstler(String kuenstlerName, int gage)
    {
       this.kuenstlerName = kuenstlerName;
       this.gage = gage;
    }
    
    /**
     * Liefert die Gage des Kuenstlers
     * @return Liefert die Gage
     */
    public int getGage()
    {
        return gage;
    }
    
    /**
     * Liefert den Namen des Kuenstlers 
     * @return liefert den Namen des Kuenstlers
     */
    public String getName()
    {
        return kuenstlerName;
    }
    
    
}
