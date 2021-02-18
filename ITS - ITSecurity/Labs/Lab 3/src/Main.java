import java.io.*;
import java.math.BigInteger;
import java.nio.charset.StandardCharsets;

public class Main {

    private static final String PRIVATE_PUBLIC_KEY = "private_public.key";
    private static final String PUBLIC_KEY = "public.key";
    private static final String ENCRYPTED = "encrypted.cipher";
    private static final String SIGNED = "signed.cipher";

    // clean up for exercise 4 and 12
    // String resources for public key
    private static final String RSA_KEY_DAVID_PUB = "rsa_key_david.pub";
    private static final String RSA_KEY_PASCAL_PUB = "rsa_key_pascal.pub";
    // String resources for private keys
    private static final String RSA_KEY_DAVID = "rsa_key_david";
    private static final String RSA_KEY_PASCAL = "rsa_key_pascal";
    // String resources for encrypted messages
    private static final String ENCRYPTED_MESSAGE_DAVID = "encrypted_msg_david";
    private static final String ENCRYPTED_MESSAGE_PASCAL = "encrypted_msg_pascal";
    // String resources for signed encrypted messages
    private static final String SIGNED_ENCRYPTED_MESSAGE_DAVID = "encrypted_msg_DAVID_signed.txt";
    private static final String SIGNED_ENCRYPTED_MESSAGE_PASCAL = "encrypted_msg_PASCAL_signed.txt";


    private static final boolean GENERATE_NEW_KEYS = true;
    private static final boolean ENCRYPT = true;
    private static final boolean DECRYPT = true;
    private static final boolean SIGN = true;
    private static final boolean VERIFY = true;

    // set the boolean for execute the different exercises
    public static void main(String[] args) {
        exercise_1();

        //Exercise 4
        if (GENERATE_NEW_KEYS) {
            exercise_4();
        }
        //Exercise 5 - Encryption
        if (ENCRYPT) {
            exercise_5_encrypt();
        }
        //Exercise 5 - Decryption
        if (DECRYPT) {
            exercise_5_decrypt();
        }
        //Exercise 11 - Sign
        if (SIGN) {
            exercise_11_sign();
        }
        //Exercise 11 - Verify
        if (VERIFY) {
            exercise_11_verify();
        }
    }


    public static void exercise_1() {
        System.out.println("exercise 1:");
        Exercise01 ex1 = new Exercise01();
        ex1.calculation();
    }


    public static void exercise_4() {
        System.out.println("exercise 4: writing private and public key files.\n");
        RSA rsa = new RSA();

        // TODO: Depending on which key-pair you want to generate, set the constants accordingly (either ending on _PASCAL or _DAVID)
        // TODO: As a convention we use p=1015/q=1033 for the generation of the key-pair for "_DAVID". The key-pair for "_PASCAL" uses P=1012/q=1033 to ensure that we work with two different key-pairs for exercise 12
        File privatePublicKeyFile = new File(RSA_KEY_DAVID);
        File publicKeyFile = new File(RSA_KEY_DAVID_PUB);

        try {
            rsa.save(new ObjectOutputStream(new FileOutputStream(privatePublicKeyFile)));
            rsa.savePublic(new ObjectOutputStream(new FileOutputStream(publicKeyFile)));
        } catch (IOException | OperationNotSupportedError e) {
            e.printStackTrace();
        }
    }

    public static void exercise_5_encrypt() {
        System.out.println("exercise 5: enter plain text you want to encrypt");

        try (ObjectInputStream is = new ObjectInputStream(new FileInputStream(new File(RSA_KEY_DAVID_PUB)));
             ObjectOutputStream encryptedOs = new ObjectOutputStream(new FileOutputStream(new File(ENCRYPTED_MESSAGE_DAVID)))) {

            BufferedReader plainReader = new BufferedReader(new InputStreamReader(System.in));
            String plain = plainReader.readLine();
            System.out.println("your plain text:\t\t" + plain);

            RSA rsa = new RSA(is);
            BigInteger encrypted = rsa.encrypt(new BigInteger(plain.getBytes(StandardCharsets.US_ASCII)));
            System.out.println("your encrypted text:\t" + encrypted);

            encryptedOs.writeObject(encrypted);
        } catch (IOException | ClassNotFoundException | BadMessageException e) {
            e.printStackTrace();
        }
    }

    public static void exercise_5_decrypt() {
        try (ObjectInputStream is = new ObjectInputStream(new FileInputStream(new File(RSA_KEY_DAVID)));
             ObjectInputStream encryptedIs = new ObjectInputStream(new FileInputStream(new File(ENCRYPTED_MESSAGE_DAVID)))) {
            RSA rsa = new RSA(is);

            BigInteger encrypted = (BigInteger) encryptedIs.readObject();

            String decrypt = new String(rsa.decrypt(encrypted).toByteArray());
            System.out.println("your decrypted text:\t" + decrypt + "\n");

        } catch (IOException | ClassNotFoundException | BadMessageException | OperationNotSupportedError e) {
            e.printStackTrace();
        }
    }

    public static void exercise_11_sign() {
        System.out.println("exercise 11: enter plain text you want to sign");

        try (ObjectInputStream is = new ObjectInputStream(new FileInputStream(new File(RSA_KEY_DAVID)));
             ObjectOutputStream signedOs = new ObjectOutputStream(new FileOutputStream(new File(SIGNED_ENCRYPTED_MESSAGE_DAVID)))) {

            BufferedReader plainReader = new BufferedReader(new InputStreamReader(System.in));
            String plain = plainReader.readLine();
            System.out.println("your plain text:\t\t\t\t\t" + plain);

            RSA rsa = new RSA(is);
            BigInteger plainMessage = new BigInteger(plain.getBytes(StandardCharsets.US_ASCII));
            BigInteger signed = rsa.sign(plainMessage);
            System.out.println("your signed text:\t\t\t\t\t" + signed);

            signedOs.writeObject(signed);
            signedOs.writeObject(plainMessage);
        } catch (IOException | ClassNotFoundException | BadMessageException | OperationNotSupportedError e) {
            e.printStackTrace();
        }
    }

    public static void exercise_11_verify() {
        try (ObjectInputStream is = new ObjectInputStream(new FileInputStream(new File(RSA_KEY_DAVID_PUB)));
             ObjectInputStream signedIs = new ObjectInputStream(new FileInputStream(new File(SIGNED_ENCRYPTED_MESSAGE_DAVID)))) {
            RSA rsa = new RSA(is);

            BigInteger signed = (BigInteger) signedIs.readObject();
            BigInteger plain = (BigInteger) signedIs.readObject();

            boolean isVerified = rsa.verify(plain, signed);
            System.out.println("your signed message was verified:\t" + isVerified);

        } catch (IOException | ClassNotFoundException | BadMessageException e) {
            e.printStackTrace();
        }
    }
}