public class Parkplatz{
    private static int nummern = 1;
    private final int parkplatznummer;
    
    public Parkplatz(){
        parkplatznummer = nummern++;
    }
}