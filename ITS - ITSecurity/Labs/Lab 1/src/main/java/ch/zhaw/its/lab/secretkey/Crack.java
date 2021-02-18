package ch.zhaw.its.lab.secretkey;

import javax.crypto.*;
import javax.crypto.spec.IvParameterSpec;
import java.io.*;
import java.util.HashMap;

import static ch.zhaw.its.lab.secretkey.DatatypeConverter.printHexBinary;



// Initialisierungsvektor ist beschissen gewählt -> Timestamp und die 16 Bits
public class Crack {
    public static final String KALGORITHM = "AES";
    public static final String CALGORITHM = KALGORITHM + "/CBC/PKCS5Padding";

    // Calculate the entropy of given input
    public static double getEntropy(byte[] input) {
        HashMap<Byte, Integer> entropyTable = new HashMap<Byte, Integer>();

        for (byte b : input) {
            if (entropyTable.containsKey(b)) {
                entropyTable.put(b, entropyTable.get(b) + 1);
            } else {
                entropyTable.put(b, 1);
            }
        }

        // Build the sum
        int totalBytes = 0;
        for (int value : entropyTable.values()) {
            totalBytes += value;
        }

        double totalEntropy = 0d;
        HashMap<Byte, Double> probabilityTable = new HashMap<Byte, Double>();

        // Compute entropy
        for (byte entry : entropyTable.keySet()) {
            double probability = (double) entropyTable.get(entry) / (double) totalBytes;
            totalEntropy += probability * Log2(1d / probability);
            probabilityTable.put(entry, probability);
        }
        return totalEntropy;
    }

    /**
     *
     * @param input a plaintext as a byte array
     * @return True, if the given text as byte is most likely plaintext. Else return false.
     */
    public static boolean isPlaintext(byte[] input) {
        return getEntropy(input) < 7d;
    }

    // Tries to find the key to a given encoded file
    public static void crack(byte[] input) {
        // Create a fake random at a probable point in time this file was generated
        FakeRandom rng = new FakeRandom(findApproxCreationTime(new ByteArrayInputStream(input)));

        // Turn back time as long until we found the key
        do {
            try {
                // Generate key
                KeyGenerator keyGen = KeyGenerator.getInstance(KALGORITHM);
                keyGen.init(128, rng);
                SecretKey key = keyGen.generateKey();

                // Try to decode the file with given key
                System.err.println("Trying key: " + printHexBinary(key.getEncoded()));
                byte[] decrypted = decrypt(input, key);
                if (decrypted != null && isPlaintext(decrypted)) {
                    System.err.println("Success with key: " + printHexBinary(key.getEncoded()));
                    return;
                }
            } catch (Exception e) {
                // do nothing
            } finally {
                // Key was not correct, go back a millisecond
                rng.data--;
            }
        } while (true);
    }

    // Find the approximate time the file was encoded
    private static long findApproxCreationTime(InputStream is) {
        try {
            byte[] bytes = new byte[16];
            bytes = is.readNBytes(16);

            StringBuilder s = new StringBuilder();
            for (int i = bytes.length - 1; i >= 0; --i) {
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
            return Long.parseLong(s.toString(), 2) + 1000;
        } catch (Exception e) {
            System.err.println("Failed to locate the time this key was created");
            System.exit(1);
        }
        return 0;
    }

    // Decrypt method from source code
    private static byte[] decrypt(byte[] input, SecretKey key) {
        try {
            Cipher cipher = Cipher.getInstance(CALGORITHM);
            InputStream is = new ByteArrayInputStream(input);
            OutputStream os = new ByteArrayOutputStream();
            IvParameterSpec ivParameterSpec = readIv(is, cipher);
            cipher.init(Cipher.DECRYPT_MODE, key, ivParameterSpec);
            crypt(is, os, cipher);

            // TODO: Adapt file path if needed for your machine
            try (OutputStream outputStream = new FileOutputStream("C:\\Users\\david\\git\\ITSec\\lab01\\mystery-solved")) {
                ((ByteArrayOutputStream) os).writeTo(outputStream);
            }

            return ((ByteArrayOutputStream) os).toByteArray();
        } catch (Exception error) {
            return null;
        }
    }

    // crypt method from source code
    private static void crypt(InputStream is, OutputStream os, Cipher cipher) throws IOException, BadPaddingException, IllegalBlockSizeException {
        boolean more = true;
        byte[] input = new byte[cipher.getBlockSize()];

        while (more) {
            int inBytes = is.read(input);

            if (inBytes > 0) {
                os.write(cipher.update(input, 0, inBytes));
            } else {
                more = false;
            }
        }
        os.write(cipher.doFinal());
    }

    // readIv method from source code
    private static IvParameterSpec readIv(InputStream is, Cipher cipher) throws IOException {
        byte[] rawIv = new byte[cipher.getBlockSize()];
        int inBytes = is.read(rawIv);

        if (inBytes != cipher.getBlockSize()) {
            throw new IOException("can't read IV from file");
        }

        return new IvParameterSpec(rawIv);
    }

    private static double Log2(double input) {
        return Math.log10(input) / Math.log10(2);
    }
}