/**
 * Exercise 03
 */

import java.io.IOException;
import java.io.ObjectInputStream;
import java.io.ObjectOutputStream;
import java.math.BigInteger;
import java.security.SecureRandom;

public class RSA{

    private boolean readPossible = true;
    private BigInteger n;
    private BigInteger publicKey_e; // for encryption (public key)
    private BigInteger privateKey_d; // for decryption (private/secret key)

    //Generates random RSA key pair
    public RSA(){
        //Reads public key or keypair from input stream
        // Choose two big prime-numbers for p and q
        BigInteger p = new BigInteger(1015, 100, new SecureRandom());
        BigInteger q = new BigInteger(1033, 100, new SecureRandom());

        n = p.multiply(q);
        BigInteger phi_n = p.subtract(BigInteger.ONE).multiply(q.subtract(BigInteger.ONE));
        publicKey_e = BigInteger.valueOf(3);
        while(publicKey_e.gcd(phi_n).compareTo(BigInteger.ONE) != 0){
            publicKey_e = publicKey_e.nextProbablePrime();
        }

        privateKey_d = publicKey_e.modInverse(phi_n);
        assert publicKey_e.multiply(privateKey_d).mod(phi_n).compareTo(BigInteger.ONE) == 0;
    }

    //Reads public key or key pair from input stream
    public RSA(ObjectInputStream is) throws IOException, ClassNotFoundException{
        n = (BigInteger) is.readObject();
        publicKey_e = (BigInteger) is.readObject();

        try{
            privateKey_d = (BigInteger) is.readObject();
            if(privateKey_d == null){
                readPossible = false;
            }
        } catch (IOException e){
            readPossible = false;
        }

    }

    public BigInteger encrypt(BigInteger plain) throws BadMessageException {
        if(plain.compareTo(BigInteger.ONE) < 0 && plain.compareTo(n.subtract(BigInteger.ONE)) > 0) {
            throw new BadMessageException("plain is not between 1 and (n-1)");
        }

        return plain.modPow(publicKey_e, n);
    }

    public BigInteger decrypt(BigInteger cipher) throws BadMessageException, OperationNotSupportedError {
        if(!readPossible){
            throw new OperationNotSupportedError("It is not possible to read private key, this operation is not supported");
        }
        if(cipher.compareTo(BigInteger.ONE) < 0 && cipher.compareTo(n.subtract(BigInteger.ONE)) > 0) {
            throw new BadMessageException("The cipher is not between 1 and (n-1)");
        }

        return cipher.modPow(privateKey_d, n);

    }

    public void save(ObjectOutputStream os) throws IOException, OperationNotSupportedError{
        if(!readPossible) {
            throw new OperationNotSupportedError("It is not possible to read private key, this operation is not supported");
        }

        savePublic(os);
        os.writeObject(privateKey_d);
    }

    public void savePublic(ObjectOutputStream os) throws IOException{
        os.writeObject(n);
        os.writeObject(publicKey_e);
    }

    public BigInteger sign(BigInteger message) throws BadMessageException, OperationNotSupportedError {
        return decrypt(message);
    }

    public boolean verify(BigInteger message, BigInteger signature) throws BadMessageException {
        return encrypt(signature).compareTo(message) == 0;
    }
}
