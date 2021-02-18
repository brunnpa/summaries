import java.util.stream.*;

/**
 * Die Klasse MessApp steuert einen Messablauf, um die Performance des
 * Zufallszahlengenerators zu messen.
 */
public class MessApp {
  private Messkonduktor messkonduktor;
  private int[][] messung;
  
  /**
   * Fuehrt eine Messung durch.
   */
  public void messen() {
    initialisieren();
    analyseDurchfuehren();
    berechneUndDruckeMittelwerteMessreihe();
    berechneUndDruckeMittelwerteMessung();
  }
  
  private void initialisieren() {
    // Objektsammlung und Messkonduktor erzeugen
    messung = new int[10][20];
    messkonduktor = new Messkonduktor(400000);
  }
  
  private void analyseDurchfuehren() {
    // TODO Benutzen Sie 'messkonduktor' um die Messungen
    // durchzufuehren und in der Objektsammlung zu speichern.
    for(int index=0; index<messung.length;index++){
          messung[index]= messkonduktor.messungenDurchfuehren(messung[index]);
    }
  }
  
  private void berechneUndDruckeMittelwerteMessreihe() {
    // TODO Implementieren Sie die Methode.
    System.out.println("Messreihen:");
    System.out.println();
    for(int i = 0; i<messung.length; i++)
    {
        int mittelwertMessreihe = (IntStream.of(messung[i]).sum())/20;        
        System.out.println("Der Mittelwert der Messreihe " + i + " ist: " + mittelwertMessreihe);
    }
    // for(int i = 0; i<messung.length; i++)
    // {
        // int mittelwertMessreihe = (mittelwertMessreihe + messung[i]);   // Weshalb gibt es bei "messung[i]" eine Fehlermeldung?   
        // System.out.println("Der Mittelwert der Messreihe " + i + " ist: " + mittelwertMessreihe);
    // }
    System.out.println();
  }
  
  private void berechneUndDruckeMittelwerteMessung() {
    // TODO Implementieren Sie die Methode.
    System.out.println("Messungen:");
    for(int i = 0; i < messung[0].length; i++) //guter Versuch
    {
        int mittelwertMessung = 0;
        for(int j = 0; j < messung.length; j++)
        {
            //System.out.print(messung[j][i] + " "); //addieren ausdruck der messergebnisse
            
            mittelwertMessung = (mittelwertMessung + messung[j][i]);
            
            
        }
        System.out.print("Der Mittelwert der Messungen " + i + " ist: " + (mittelwertMessung/10) + " ");
        System.out.println(); //neue spalte
    }
  }
 
}