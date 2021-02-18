package praktikum_10;

import Server.CommandExecutor;

public class SortServer implements CommandExecutor {
    private static final String DELIMITER = " ";
    private static final int MIN_RANGE = 0;
    private static final int MAX_RANGE = 1000000;

    @Override
    public String execute(String command) throws Exception {
        String[] split = command.split(DELIMITER);
        SortMethod sortMethod = SortMethod.valueOf(split[0]);
        int numberOfElements = Integer.parseInt(split[1]);

        if (sortMethod == null) {
            throw new IllegalArgumentException("No sorting method was provided");
        }

        int[] data = generateExecuteInputData(numberOfElements, MIN_RANGE, MAX_RANGE);
        long end, start = System.currentTimeMillis();
        int count = 0;

        int[] tmp = new int[data.length];

        do {
            System.arraycopy(data, 0, tmp, 0, data.length);
            switch (sortMethod) {
                case BUBBLE_SORT:
                    bubbleSort(tmp);
                    break;
                case INSERTION_SORT:
                    insertionSort(tmp);
                    break;
                case SELECTION_SORT:
                    selectionSort(tmp);
                    break;
            }
            count++;
            end = System.currentTimeMillis();
        } while (end - start < 1000);

        double time = (double) (end - start) / count;
        boolean sorted = checkSorted(tmp);
        return String.format("method=%s time=%f sorted=%b\n", sortMethod.toString(), time, sorted);
    }

    private void bubbleSort(int[] data) {
        for (int i = data.length - 1; i > 0; i--) {
            boolean noSwap = true;
            for (int j = 0; j < i; j++) {
                if (data[j] > data[j + 1]) {
                    swap(data, j, j + 1);
                    noSwap = false;
                }
            }
            if (noSwap) {
                break;
            }
        }
    }

    private void selectionSort(int[] data) {
        for (int i = 0; i < data.length; i++) {
            int min = i;
            for (int j = i + 1; j < data.length; j++) {
                if (data[j] < data[min]) min = j;
            }
            if (min != i) {
                swap(data, min, i);
            }
        }
    }

    private void insertionSort(int[] data) {
        for (int k = 1; k < data.length; k++) {
            if (data[k] < data[k - 1]) {
                int x = data[k];
                int i;
                for (i = k; ((i > 0) && (data[i - 1] > x)); i--)
                    data[i] = data[i - 1];
                data[i] = x;
            }
        }
    }

    private void swap(int[] a, int i, int j) {
        int h = a[i];
        a[i] = a[j];
        a[j] = h;
    }

    private boolean checkSorted(int[] input) {
        for (int i = 0; i < input.length - 1; i++) {
            if (input[i] > input[i + 1]) {
                return false;
            }
        }
        return true;
    }

    private static int[] generateExecuteInputData(int numberOfElements, int min, int max) {
        int[] data = new int[numberOfElements];

        for (int i = 0; i < numberOfElements; i++) {
            data[i] = (int) (Math.random() * ((max - min) + 1)) + min;
        }
        return data;
    }

    public static void main(String... args) throws Exception {
        SortServer sortServer = new SortServer();
        String sortWithBubbleSort10k = SortMethod.BUBBLE_SORT + DELIMITER + 10000;
        String sortWithInsertionSort10k = SortMethod.INSERTION_SORT + DELIMITER + 10000;
        String sortWithSelectionSort10k = SortMethod.SELECTION_SORT + DELIMITER + 10000;
        String sortWithBubbleSort20k = SortMethod.BUBBLE_SORT + DELIMITER + 20000;
        String sortWithInsertionSort20k = SortMethod.INSERTION_SORT + DELIMITER + 20000;
        String sortWithSelectionSort20k = SortMethod.SELECTION_SORT + DELIMITER + 20000;
        String sortWithBubbleSort40k = SortMethod.BUBBLE_SORT + DELIMITER + 40000;
        String sortWithInsertionSort40k = SortMethod.INSERTION_SORT + DELIMITER + 40000;
        String sortWithSelectionSort40k = SortMethod.SELECTION_SORT + DELIMITER + 40000;
        String sortWithBubbleSort100k = SortMethod.BUBBLE_SORT + DELIMITER + 100000;
        String sortWithInsertionSort100k = SortMethod.INSERTION_SORT + DELIMITER + 100000;
        String sortWithSelectionSort100k = SortMethod.SELECTION_SORT + DELIMITER + 100000;


        String resultBubbleSort10k = sortServer.execute(sortWithBubbleSort10k);
        System.out.println(resultBubbleSort10k);
        String resultBubbleSort20k = sortServer.execute(sortWithBubbleSort20k);
        System.out.println(resultBubbleSort20k);
        String resultBubbleSort40k = sortServer.execute(sortWithBubbleSort40k);
        System.out.println(resultBubbleSort40k);
        String resultBubbleSort100k = sortServer.execute(sortWithBubbleSort100k);
        System.out.println(resultBubbleSort100k);

        String resultInsertionSort10k = sortServer.execute(sortWithInsertionSort10k);
        System.out.println(resultInsertionSort10k);
        String resultInsertionSort20k = sortServer.execute(sortWithInsertionSort20k);
        System.out.println(resultInsertionSort20k);
        String resultInsertionSort40k = sortServer.execute(sortWithInsertionSort40k);
        System.out.println(resultInsertionSort40k);
        String resultInsertionSort100k = sortServer.execute(sortWithInsertionSort100k);
        System.out.println(resultInsertionSort100k);


        String resultSelectionSort10k = sortServer.execute(sortWithSelectionSort10k);
        System.out.println(resultSelectionSort10k);
        String resultSelectionSort20k = sortServer.execute(sortWithSelectionSort20k);
        System.out.println(resultSelectionSort20k);
        String resultSelectionSort40k = sortServer.execute(sortWithSelectionSort40k);
        System.out.println(resultSelectionSort40k);
        String resultSelectionSort100k = sortServer.execute(sortWithSelectionSort100k);
        System.out.println(resultSelectionSort100k);

    }
}
