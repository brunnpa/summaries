package ch.zhaw.its.lab.secretkey;

import java.security.SecureRandom;

public class TotallySecureRandom extends SecureRandom {
    @Override
    public void nextBytes(byte[] bytes) {
        long now = System.currentTimeMillis();

        for (int i = 0; i < bytes.length; i++) {
            bytes[i] = (byte) (now & 0xff);
            now >>= 8;
        }
    }
}
