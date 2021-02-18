package ch.zhaw.its.lab.secretkey;

import java.security.SecureRandom;

public class FakeRandom extends SecureRandom {
    public static long data;

    public FakeRandom(long start){
        this.data = start;
    }

    @Override
    public void nextBytes(byte[] bytes) {
        long now = data;

        for (int i = 0; i < bytes.length; i++) {
            bytes[i] = (byte) (now & 0xff);
            now >>= 8;
        }
    }
}