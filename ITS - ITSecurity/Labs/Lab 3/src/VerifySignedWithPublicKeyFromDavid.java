import java.io.FileInputStream;
import java.io.IOException;
import java.io.ObjectInputStream;
import java.math.BigInteger;

public class VerifySignedWithPublicKeyFromDavid {

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


    public static void main(String[] args) throws BadMessageException, IOException, ClassNotFoundException {

        String publicKeySrc = RSA_KEY_DAVID_PUB;

        String messageSrc = SIGNED_ENCRYPTED_MESSAGE_DAVID;

        verify(publicKeySrc, messageSrc);
        modifyThenVerify(publicKeySrc, messageSrc);
    }

    private static void verify(String publicKeySrc, String encodedMsgSrc) throws IOException, ClassNotFoundException {
        try (ObjectInputStream publicKeyObjectOutputStream = new ObjectInputStream(new FileInputStream(publicKeySrc));
             ObjectInputStream msgObjectInputStream = new ObjectInputStream(new FileInputStream(encodedMsgSrc))) {

            BigInteger encryptedMsg = (BigInteger) msgObjectInputStream.readObject();
            BigInteger signature = (BigInteger) msgObjectInputStream.readObject();

            RSA rsaPublic = new RSA(publicKeyObjectOutputStream);
            boolean signatureVerified = rsaPublic.verify(encryptedMsg, signature);

            if (signatureVerified) {
                System.out.println("Signature of NON-MODIFIED " + encodedMsgSrc + " successfully verified");
            } else {
                System.out.println("Signature of NON-MODIFIED " + encodedMsgSrc + " could not be verified");
            }
        } catch (BadMessageException e) {
            e.printStackTrace();
        }
    }

    private static void modifyThenVerify(String publicKeySrc, String encodedMsgSrc) throws IOException, ClassNotFoundException {
        try (ObjectInputStream publicKeyObjectOutputStream = new ObjectInputStream(new FileInputStream(publicKeySrc));
             ObjectInputStream msgObjectInputStream = new ObjectInputStream(new FileInputStream(encodedMsgSrc))) {

            BigInteger encryptedMsg = (BigInteger) msgObjectInputStream.readObject();
            BigInteger signature = (BigInteger) msgObjectInputStream.readObject();

            encryptedMsg = encryptedMsg.add(BigInteger.ONE);

            RSA rsaPublic = new RSA(publicKeyObjectOutputStream);
            boolean signatureVerified = rsaPublic.verify(encryptedMsg, signature);

            if (signatureVerified) {
                System.out.println("Signature on pre-hashed plain-text: Signature of MODIFIED " + encodedMsgSrc + " successfully verified");
            } else {
                System.out.println("Signature on pre-hashed plain-text: Signature of MODIFIED " + encodedMsgSrc + " could not be verified");
            }
        } catch (BadMessageException e) {
            e.printStackTrace();
        }
    }
}