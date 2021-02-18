package ch.zhaw.its.lab.secretkey;

import javax.crypto.KeyGenerator;
import javax.crypto.SecretKey;
import java.util.Arrays;
import java.util.Date;

public class TestCurrentTimeMillis {

    public static final String KALGORITHM = "AES";
    public static final String CALGORITHM = KALGORITHM + "/CBC/PKCS5Padding";

    public static void main(String[] args) {
        long now = System.currentTimeMillis();

        System.out.println(now);
        System.out.println(Long.toBinaryString(now));
        System.out.println("0000000" + Long.toBinaryString(now));
        System.out.println(Long.toBinaryString(now).length());
        Date date = new Date(1539605991296l);
        System.out.println(date);

        byte[] bytes = new byte[6];

        for (int i = 0; i < 6; i++) {
            bytes[i] = (byte) (now & 0xff);
            now >>= 8;
        }

        StringBuilder s = new StringBuilder();
        for (int i = bytes.length-1; i >= 0; --i) {
            StringBuilder ts = new StringBuilder(Integer.toBinaryString(bytes[i]));
            if (ts.length() == 8)
                s.append(ts);
            else if (ts.length() < 8) {
                for (int j = 8 - ts.length(); j > 0; --j) {
                    ts.insert(0, "0");
                }
                s.append(ts);
            } else {
                ts = new StringBuilder(ts.substring(ts.length() - 8, ts.length()));
                s.append(ts);
            }
        }

        System.out.println(s);
        System.out.println(Long.parseLong(s.toString(), 2));

        try {
            KeyGenerator keyGen = KeyGenerator.getInstance(KALGORITHM);
            keyGen.init(128, new TotallySecureRandom());
            SecretKey key = keyGen.generateKey();
            System.out.println(key.getEncoded());
            System.out.println(Arrays.toString(key.getEncoded()));
            key = keyGen.generateKey();
            System.out.println(key.getEncoded());
            System.out.println(Arrays.toString(key.getEncoded()));
            key = keyGen.generateKey();
            System.out.println(key.getEncoded());
            System.out.println(Arrays.toString(key.getEncoded()));
        } catch (Exception e) {
            System.out.println(e.getMessage());
        }
    }
}
