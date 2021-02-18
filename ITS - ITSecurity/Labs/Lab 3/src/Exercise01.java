/**
 * ----OUTPUT----
 *
 * w = 128 	 w(b) = 1766
 * w = 256 	 w(b) = 9427
 * w = 384 	 w(b) = 25816
 * w = 512 	 w(b) = 53311
 */

public class Exercise01 {
    //Number of required Bits of Security
    private static int[] w = {128, 256, 384, 512};

    public static void main(String[] args) {
    calculation();

    }

    public static void calculation() {
        for (int i : w) {
            int b = 1;
            while (calculateW(b) < Math.pow(2, i)) {
                b++;
            }

            System.out.println(String.format("w = %d \t w(b) = %d", i, b));
        }

    }

    private static double calculateW(int b) {
        return Math.exp(1.92 * Math.pow(b, 1.0 / 3.0) * Math.pow(Math.log(b), 2.0 / 3.0));
    }
}


