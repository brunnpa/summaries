import java.io.*;
import java.math.BigInteger;
import java.nio.charset.StandardCharsets;

public class Exercise12Util {

    public static void main(String[] args) throws IOException, BadMessageException, ClassNotFoundException {
        if (args.length == 1 && !args[0].isEmpty()) {
            System.out.println("Input was: '" + args[0] + "'");

            byte[] inputData = args[0].getBytes(StandardCharsets.US_ASCII);

            try (ObjectInputStream publicKeySrc = new ObjectInputStream(new FileInputStream("rsa_public_key_david.pub"));
                 ObjectOutputStream encryptedMsgDest = new ObjectOutputStream(new FileOutputStream("encrypted_msg_david.txt"));
                 ObjectInputStream privateKeySrc = new ObjectInputStream(new FileInputStream("rsa_key_david"));
                 ObjectInputStream encryptedMsgSrc = new ObjectInputStream(new FileInputStream("encrypted_msg_david.txt"));) {

                encrypt(inputData, publicKeySrc, encryptedMsgDest);
                decrypt(privateKeySrc, encryptedMsgSrc);
            } catch (OperationNotSupportedError operationNotSupportedError) {
                operationNotSupportedError.printStackTrace();
            }
        } else {
            System.out.println("No input provided. Please provide an input!\n");
        }
    }

    private static void encrypt(byte[] data, ObjectInputStream publicKeySrc, ObjectOutputStream dest) throws IOException, ClassNotFoundException, BadMessageException {
        BigInteger bigIntegerInput = new BigInteger(data);
        RSA rsa = new RSA(publicKeySrc);
        BigInteger encryptedValue = rsa.encrypt(bigIntegerInput);
        dest.writeObject(encryptedValue);
    }

    private static void decrypt(ObjectInputStream privateKeySrc, ObjectInputStream msgSrc) throws IOException, ClassNotFoundException, BadMessageException, OperationNotSupportedError {
        RSA rsa = new RSA(privateKeySrc);
        BigInteger encryptedMsg = (BigInteger) msgSrc.readObject();
        BigInteger decryptedBigInt = rsa.decrypt(encryptedMsg);
        String decryptedMsg = new String(decryptedBigInt.toByteArray(), "ASCII");
        System.out.println("Decrypted Text: '" + decryptedMsg + "'");
    }
}
