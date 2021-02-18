package ch.zhaw.its.lab.secretkey;

import java.io.CharArrayReader;
import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.util.*;

public class EntropyCalculator {

    private static Collection<String> paths = new ArrayList<>();

    private static Map<Character, Integer> charProbabilities = new HashMap<>();

    public static void main(String[] args) {
        // TODO: Change file paths to your specific file paths on your machine
        args = new String[]{"C:\\Users\\david\\git\\ITSec\\lab01\\src\\main\\java\\ch\\zhaw\\its\\lab\\secretkey\\FileEncrypter.java",
                "C:\\Users\\david\\git\\ITSec\\lab01\\mystery"};

        paths.addAll(Arrays.asList(args));

        for (String path : paths) {
            try {
                File file = new File(path);
                String content = new String(Files.readAllBytes(file.toPath()));
                System.out.println(file.getName() + ": " + calculateEntropy(content));
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
    }

    private static double calculateEntropy(String content) {
        double entropy = 0.0;

        for (int i = 0; i < content.length(); i++) {
            if (!charProbabilities.containsKey(content.charAt(i))) {
                charProbabilities.put(content.charAt(i), 1);
            } else {
                charProbabilities.put(content.charAt(i), 1 + charProbabilities.get(content.charAt(i)));
            }
        }

        for (Map.Entry<Character, Integer> entry : charProbabilities.entrySet()) {
            double p = 1.0 * entry.getValue() / content.length();
            entropy -= p * Log2.log2(p);
        }
        return entropy;
    }

    private static boolean whiteSpaceCheck(byte[] content) {
        String contentString = Arrays.toString(content);
        double numWhiteSpace = 0;

        for (int i = 0; i < contentString.length(); ++i)
            if (contentString.charAt(i) == ' ')
                ++numWhiteSpace;

        return numWhiteSpace / contentString.length() > 0.1;
    }

    private static boolean letterFrequencyCheck(byte[] content) {
        String contentString = Arrays.toString(content).replaceAll("\\s+", "");
        Map<Character, Integer> charMap = new HashMap<>();

        for (int i = 0; i < contentString.length(); ++i) {
            Character c = contentString.charAt(i);

            if (charMap.containsKey(c)) {
                charMap.put(c, charMap.get(c) + 1);
            } else {
                charMap.put(c, 1);
            }
        }
        return false;
    }
}