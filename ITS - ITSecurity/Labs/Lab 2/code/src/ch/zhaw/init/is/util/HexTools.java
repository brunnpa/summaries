package ch.zhaw.init.is.util;

/**
 * This class contains methods related to conversion and
 * processing of data to and from hexadecimal system
 *  
 * @author tebe
 *
 */
public class HexTools {
	
	/**
	 * Converts the numbers in the integer array to their
	 * hexadecimal representation and returns them as a 
	 * sequence of numbers separated by a space.
	 * @param array The input data
	 * @return the array as string of space separated hex values 
	 */
	public static String intArrayToHexString(int[] array) {
		String result = "";
		for (int i = 0; i < array.length; i++) {
			result += Integer.toHexString(array[i]) + " ";
		}
		return result;
	}
}
