package ch.zhaw.its.lab.secretkey;

import javax.crypto.*;
import javax.crypto.spec.IvParameterSpec;
import javax.crypto.spec.SecretKeySpec;
import java.io.*;
import java.security.InvalidAlgorithmParameterException;
import java.security.InvalidKeyException;
import java.security.NoSuchAlgorithmException;

public class FileEncrypter {
    public static final String KALGORITHM = "AES";
    public static final String CALGORITHM = KALGORITHM + "/CBC/PKCS5Padding";
    private String inFile;
    private String outFile;

    public FileEncrypter(String inFile, String outFile) {
        this.inFile = inFile;
        this.outFile = outFile;
    }

    public void crypt(InputStream is, OutputStream os, Cipher cipher) throws IOException, BadPaddingException, IllegalBlockSizeException {
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

    public void encrypt() throws IOException, NoSuchPaddingException, NoSuchAlgorithmException, InvalidKeyException,
            InvalidAlgorithmParameterException, BadPaddingException, IllegalBlockSizeException {
        KeyGenerator keyGen = KeyGenerator.getInstance(KALGORITHM);
        keyGen.init(128, new TotallySecureRandom());
        SecretKey key = keyGen.generateKey();

        Cipher cipher = Cipher.getInstance(CALGORITHM);

        byte[] rawIv = new byte[cipher.getBlockSize()];
        new TotallySecureRandom().nextBytes(rawIv);
        IvParameterSpec iv = new IvParameterSpec(rawIv);

        cipher.init(Cipher.ENCRYPT_MODE, key, iv);

        try (InputStream is = new FileInputStream(inFile);
             OutputStream os = new FileOutputStream(outFile)) {
            writeIv(os, iv);
            crypt(is, os, cipher);
        }
    }

    public IvParameterSpec readIv(InputStream is, Cipher cipher) throws IOException {
        byte[] rawIv = new byte[cipher.getBlockSize()];
        int inBytes = is.read(rawIv);

        if (inBytes != cipher.getBlockSize()) {
            throw new IOException("can't read IV from file");
        }

        return new IvParameterSpec(rawIv);
    }

    public void writeIv(OutputStream os, IvParameterSpec iv) throws IOException {
        os.write(iv.getIV());
    }

    public void decrypt(byte[] rawKey) throws NoSuchPaddingException, NoSuchAlgorithmException, IOException,
            BadPaddingException, IllegalBlockSizeException, InvalidAlgorithmParameterException, InvalidKeyException {
        SecretKey key = new SecretKeySpec(rawKey, 0, rawKey.length, KALGORITHM);
        Cipher cipher = Cipher.getInstance(CALGORITHM);

        try (InputStream is = new FileInputStream(inFile);
             OutputStream os = new FileOutputStream(outFile)) {
            IvParameterSpec ivParameterSpec = readIv(is, cipher);

            cipher.init(Cipher.DECRYPT_MODE, key, ivParameterSpec);
            crypt(is, os, cipher);
        }
    }
}
