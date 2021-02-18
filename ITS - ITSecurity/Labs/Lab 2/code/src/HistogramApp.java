import java.io.BufferedInputStream;
import java.io.FileInputStream;
import java.io.IOException;

import ch.zhaw.init.is.crypto.classic.ByteFrequencyTable;
import ch.zhaw.init.is.crypto.classic.ByteFrequencyTableView;

/**
 * Application for generating and displaying histograms of
 * the byte values in a file. 
 * <p>
 * Usage:<br>
 * <tt>HistogramApp file [slots]</tt>
 * <p>
 * Arguments:<br>
 * <ul>
 * <li>file:   The file the histogram is generated from
 * </ul><p>
 * Options:<br>
 * <ul>
 * <li>slots:  The number of slots. Default is 1. 
 * </ul><p>
 * Slots: If the number of slots is not equal to 1, a 'slotted' analysis is performed.
 * In this case, N histograms are generated, with histogram i (i=1,..,N) including every 
 * N-th byte starting with byte i.
 * <p>
 * Example: Analysis with 2 slots.<br>
 * A file with content <tt>0x00 0x10 0x20 0x30 0x40 0x50 0x60 0x70</tt> results in
 * two histograms where bytes 1, 3, 5, 7 are used to generate the first
 * and bytes 2, 4, 6, 8 to generate the second histogram.  
 *  
 * @author tebe
 */

public class HistogramApp {
	private static String filename;
	private static int slots = 1;
	
	/**
	 * Main method of the application
	 * 
	 * @param args Command line arguments
	 */
	public static void main(String[] args) {
		if(parseCommandLineParameters(args)) {
			try {
				ByteFrequencyTable[] frequencyTable = getFrequencyTables(filename, slots);
				printByteEntropies(frequencyTable);
				ByteFrequencyTableView view = new ByteFrequencyTableView(frequencyTable);
				view.display();
			} catch (IOException e) {
				System.out.println(e.getMessage());
			}			
		} else	{
			usage();
		}
	}

	private static void printByteEntropies(ByteFrequencyTable[] frequencyTable) {
		System.out.println("-- Entropy data --");
		for(int i=0; i<frequencyTable.length; i++) {
			System.out.println("Slot " + i + ": " + frequencyTable[i].getEntropy());
		}
		
	}

	/**
	 * Checks and parses the command line arguments.
	 *  
	 * @param args Command line arguments
	 * @return true, if the arguments could be parsed
	 */
	private static boolean parseCommandLineParameters(String args[])
	{
		if(args.length >= 1 && args.length < 3) {
			filename = args[0];
			if(args.length == 2) {
				try{
					slots = Integer.parseInt(args[1]);
					return true;
				} catch (NumberFormatException e) {
				}
			}
			return true;
		}
		return false;
	}
	
	
	/**
	 * Creates the ByteFrequencyTables of the specified file
	 * 
	 * @param filename The file to be analyzed
	 * @param slots The number of slots

	 * @return The ByteFrequencyTables. One for each slot.
	 *  
	 * @throws IOException
	 */
	private static ByteFrequencyTable[] getFrequencyTables(String filename, int slots) throws IOException {
		ByteFrequencyTable[] frequencyTable = new ByteFrequencyTable[slots];
		for (int i = 0; i < frequencyTable.length; i++) {
			frequencyTable[i] = new ByteFrequencyTable();
		}
		BufferedInputStream inputStream = new BufferedInputStream(new FileInputStream(filename));
		try{
			//TODO: Hier kommt Ihr Code
			int slot = 0;
			int value;
			while ((value = inputStream.read()) != -1) {
				frequencyTable[slot].addByte(value);
				slot = (slot + 1) % slots;
			}

			
			
		} finally {
			if (inputStream != null)
				inputStream.close();
		}
		return frequencyTable;
	}
	
	/**
	 * Prints the usage string.
	 */
	private static void usage() {
		System.out.println("HistogramApp file [slots]");
	}
	

}
