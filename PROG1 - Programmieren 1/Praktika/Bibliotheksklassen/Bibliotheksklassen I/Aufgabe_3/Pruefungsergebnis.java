/**
 * Diese Klasse verwaltet ein Pruefungsergebnis.
 */
public class Pruefungsergebnis {
  private String student;
  private double note;

  /**
   * Erzeugt ein Pruefungsergebnis.
   * 
   * @param student Name des Studierenden.
   * @param note Note des Studierenden.
   */
  public Pruefungsergebnis(String student, double note) {
    this.student = student;
    this.note = note;
  }

  /**
   * Liefert den Namen des Studierenden.
   * 
   * @return Name des Studierenden.
   */
  public String getStudent() {
    return student;
  }

  /**
   * Liefert die Note.
   * 
   * @return Die Note.
   */
  public double getNote() {
    return note;
  }
}