import java.util.ArrayList;

/**
 * Bietet Funktionalitaeten zum Speichern von Pruefungsergebnissen von einer
 * Vielzahl von Studenten. Aus den gespeicherten Ergebnissen lassen sich
 * personalisierte Antworttext generieren.
 */
public class Pruefungsverwaltung {
    private ArrayList<Pruefungsergebnis> pruefungsresultat;
    private Pruefungsergebnis ergebnis;
    boolean bestanden;

    public Pruefungsverwaltung()
    {
        pruefungsresultat = new ArrayList<Pruefungsergebnis>();
    }

    /**
     * Speichert ein Pruefungsergebnis.
     * 
     * @param ergebnis Das Pruefungsergebnis.
     */
    public void speichereErgebnis(Pruefungsergebnis ergebnis) {
        // TODO Implementieren gemaess Aufgabenstellung
        pruefungsresultat.add(ergebnis);
    }

    /**
     * Gibt pro gespeichert Ergebnis einen Text auf die Konsole aus.
     * Je nachdem ob der Kandidate die Pruefung bestanden (>= 4.0) oder nicht
     * bestanden (< 4.0) hat, wird ein Text in folgendem Format ausgegeben:
     * 
     * Sie haben an der Pruefung eine 3.0 erzielt und 
     * sind somit durchgefallen!
     * 
     * Herzliche Gratulation Max Muster! Sie haben an der Pruefung eine 4.5
     * erzielt und somit bestanden!
     */
    public void druckeAntworttexte() {
        // TODO Implementieren gemaess Aufgabenstellung
        for(Pruefungsergebnis ergebnis : pruefungsresultat)
        {
            pruefungBestanden(ergebnis.getNote());
            if(bestanden)
            {
                System.out.println("Herzliche Gratulation " + ergebnis.getStudent() + " ! Sie haben an der Pruefung eine " 
                + rundeAufHalbeNote(ergebnis.getNote()));
                System.out.println("erzielt und somit bestanden");
            }
            else
            {
                System.out.println("Sie haben an der Pruefung eine " + rundeAufHalbeNote(ergebnis.getNote()) + " erzielt und");
                System.out.println("sind somit durchgefallen!");
            }
        }
        
    }

    private double rundeAufHalbeNote(double note) {
        return Math.round(note * 2) / 2.0;
    }
    
    /**
     * Methode zur Ueberpruefung ob die Pruefung bestanden (>=4.0) ist oder nicht(<4.0).
     * 
     * @param note Die erzielte Note
     * @return ob die Pruefung bestanden ist
     */
    private boolean pruefungBestanden(double note)
    {
        if(note >= 4.0)
        {
            bestanden = true;
            return bestanden;
        }
        else
        {
            bestanden = false;
            return bestanden;
        }
    }
}
