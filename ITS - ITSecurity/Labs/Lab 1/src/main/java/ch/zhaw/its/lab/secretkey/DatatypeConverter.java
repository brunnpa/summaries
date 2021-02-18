package ch.zhaw.its.lab.secretkey;

import java.io.IOException;

public class DatatypeConverter {
    private static void encodeNybble(StringBuilder sb, int n) {
        final String hexDigits = "0123456789abcdef";
        if (n < 0 || n > hexDigits.length()) {
            throw new IllegalStateException("can't happen: hex digit " + n);
        }

        sb.append(hexDigits.charAt(n));
    }

    private static byte decodeNybble(char c) {
        switch (c) {
            case '0': return 0x00;
            case '1': return 0x01;
            case '2': return 0x02;
            case '3': return 0x03;
            case '4': return 0x04;
            case '5': return 0x05;
            case '6': return 0x06;
            case '7': return 0x07;
            case '8': return 0x08;
            case '9': return 0x09;
            case 'a': return 0x0a;
            case 'b': return 0x0b;
            case 'c': return 0x0c;
            case 'd': return 0x0d;
            case 'e': return 0x0e;
            case 'f': return 0x0f;
            default: throw new IllegalArgumentException("character '" + c + "' is not a hex digit");
        }
    }

    public static String printHexBinary(byte[] encoded) {
        StringBuilder sb = new StringBuilder(2*encoded.length);

        for (byte c : encoded) {
            encodeNybble(sb, (c >> 4) & 0x0f);
            encodeNybble(sb, (c >> 0) & 0x0f);
        }

        return sb.toString();
    }

    public static byte[] parseHexBinary(String rawKey) throws IOException {
        if (rawKey.length() % 2 != 0) {
            throw new IOException("hex key spec has odd number of characters");
        }

        byte[] key = new byte[rawKey.length()/2];

        int charPos = 0;
        for (int i = 0; i < key.length; i++) {
            key[i] |= decodeNybble(rawKey.charAt(charPos++)) << 4;
            key[i] |= decodeNybble(rawKey.charAt(charPos++)) << 0;
        }
        return key;
    }
}
