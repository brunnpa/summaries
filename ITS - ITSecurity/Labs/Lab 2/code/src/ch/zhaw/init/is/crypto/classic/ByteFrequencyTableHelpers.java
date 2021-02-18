package ch.zhaw.init.is.crypto.classic;

import java.io.DataInputStream;
import java.io.IOException;

/**
 * This class implements some helper methods related to 
 * the construction of {ByteFrequencyTable}s.
 *   
 * @author tebe
 *
 */
public class ByteFrequencyTableHelpers {
	/**
	 * Creates the {@link ByteFrequencyTable}s of the input data for the
	 * different key bytes. The resulting array has keylength 
	 * entries with one table per key byte.
	 * 
	 * @param keylength
	 *            The length of the key in bytes
	 * @param inputStream 
	 *            The data  
	 * @return The byte frequency tables
	 * @throws IOException
	 */
	public static ByteFrequencyTable[] getFrequencyTableForKeyLength(int keylength,
			DataInputStream inputStream) throws IOException {
		ByteFrequencyTable[] frequencyTable = new ByteFrequencyTable[keylength];
		try{

			for (int i = 0; i < frequencyTable.length; i++) {
				frequencyTable[i] = new ByteFrequencyTable();
			}
			int value = 0;
			int keyIndex = 0;
			while ((value = inputStream.read()) != -1) {
				frequencyTable[keyIndex].addByte(value);
				keyIndex = (keyIndex + 1) % keylength;
			}
		} finally {
			if (inputStream != null)
				inputStream.close();
		}
		return frequencyTable;
	}
}
