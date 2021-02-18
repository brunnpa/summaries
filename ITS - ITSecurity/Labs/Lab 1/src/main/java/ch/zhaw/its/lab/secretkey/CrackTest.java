package ch.zhaw.its.lab.secretkey;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;

public class CrackTest {
    public static void main(String[] args) throws IOException {
        // TODO: Change file path if needed for your machine
        File mystery = new File("C:\\Users\\david\\git\\ITSec\\lab01\\mystery");
        Crack.crack(Files.readAllBytes(mystery.toPath()));
    }
}
