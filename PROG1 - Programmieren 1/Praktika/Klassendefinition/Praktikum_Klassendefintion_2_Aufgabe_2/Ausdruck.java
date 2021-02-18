

public class Ausdruck {

  public void ausgeben() {
    int int1 = 1, int2 = 2, int3 = 3;
    double double1 = 3.0, double2 = 4.0;
    boolean boolean1 = true;

    System.out.println(int1 + int2 + int3--);
    System.out.println(int3);
    System.out.println(--int3);

    int3 = 3;
    System.out.println(int1 + int2 * int3);
    System.out.println((int1 + int2) * int3);

    System.out.println(int1 / int2 + ", " + int3 / int2);
    System.out.println(int1 / double1 + ", " + double2 / int3);
    System.out.println(int1 / 4 + ", " + int1 / 4.0);

    System.out.println (int2 / int3 * double1);
    System.out.println (int2 / (int3 * double1));

    System.out.println(9 % 4 + ", " + 9.0 % 4);

    System.out.println("Ein Hund hat " + 2 + 2 + " Beine");
    System.out.println("Ein Hund hat " + (2 + 2) + " Beine");
    System.out.println("Zwei Hunde haben " + 2 * 4 + " Beine");

    System.out.println(int1 == int2);
    System.out.println(int1 == int3 / int2);

    System.out.println((int3 <= 3) && (double2 <= 2.999999));
    System.out.println((int3 < 3) || !(double2 <= 2.999999));
    System.out.println((int3 <= 3) && !(double2 <= 2.999999));

    System.out.println(boolean1 = 7 > 6);
    System.out.println(/*int3 = int1 + int2 == 3*/"Kompilierfehler");
    System.out.println((int3 = int2 - int1) == 1);

    System.out.println(3 * 1000000);
    System.out.println(3 * 10000000);
    System.out.println(3 * 100000000);
    System.out.println(3 * 1000000000);
    System.out.println(3 * 1000000000L);
    System.out.println(3 * 1000000000d);
  }

  public static void main(String[] args) {
    (new Ausdruck()).ausgeben();
  }

}
