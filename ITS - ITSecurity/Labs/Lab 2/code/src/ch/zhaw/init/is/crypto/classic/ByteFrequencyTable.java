package ch.zhaw.init.is.crypto.classic;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.HashMap;
import java.util.List;
import java.util.Map;


/**
 * This class implements a byte frequency table.
 * 
 * For the different byte values, it counts the number of 
 * times they were added and provides functionality to 
 * retreive the most frequent of them. 
 *   
 * @author tebe
 *
 */
public class ByteFrequencyTable {
	public static final int BYTE_VALUES = 256;
	private int[] frequency = new int[BYTE_VALUES];
	
	/**
	 * Increment the count of the byte with this value by one. 
	 * @param value the byte value
	 */
	public void addByte(int value) {
		frequency[value]++;
	}
	
	/**
	 * Get the most frequent byte(s).
	 * 
	 * @param number number of bytes to be returned 
	 * @return the most frequent byte(s) in descending order 
	 */
	public int[] getMostFrequentBytes(int number) {
		if(number<1 || number>BYTE_VALUES){
			throw new IllegalArgumentException("Number of bytes must be in 1.." + BYTE_VALUES);
		}
		HashMap<Integer, Integer> frequencyLookup; 
		List<Map.Entry<Integer, Integer>> entries;
		
		frequencyLookup = buildByteFrequencyMap();
		entries = getListOfMapEntriesSortedAccordingToValue(frequencyLookup);
		return getMostFrequentBytes(number, entries);
	}
	
	/**
	 * Calculates the entropy (in bits) per byte of this sample byte frequency distribution
	 * @return The entropy (in bits) per byte
	 */
	public double getEntropy(){
		int totalOccurences = 0;
		for(int i=0; i<frequency.length; i++){
			totalOccurences += frequency[i];   
		}
		double sampleProbabilitySum = 0;
		double sampleProbability = 0;
		for(int i=0; i<frequency.length; i++){
			if(frequency[i] > 0){
				sampleProbability = frequency[i]/(double)totalOccurences;
				sampleProbabilitySum += sampleProbability * Math.log(sampleProbability);
			}
		}
		return -1/Math.log(2) * sampleProbabilitySum;
	}
	
	/**
	 * Get the most frequent byte
	 * 
	 * @return the most frequent byte 
	 */
	public int getMostFrequentByte() {
		int[] mostFrequentByte = getMostFrequentBytes(1);
		return mostFrequentByte[0];
	}

	private HashMap<Integer, Integer> buildByteFrequencyMap() {
		HashMap<Integer,Integer> frequencyLookup = new HashMap<Integer, Integer>();
		for(int value=0; value<frequency.length; value++){
			frequencyLookup.put(value, frequency[value]);
		}
		return frequencyLookup;
	}

	private List<Map.Entry<Integer, Integer>> getListOfMapEntriesSortedAccordingToValue(
			HashMap<Integer, Integer> frequencyLookup) {
		List<Map.Entry<Integer, Integer>> entries = new ArrayList<Map.Entry<Integer, Integer>>();
		entries.addAll(frequencyLookup.entrySet());
		Collections.sort(entries, new Comparator<Map.Entry<Integer, Integer>>() {
		  public int compare(
		      Map.Entry<Integer, Integer> entry1, Map.Entry<Integer, Integer> entry2) {
		    return entry2.getValue().compareTo(entry1.getValue());
		  }
		});
		return entries;
	}
	
	private int[] getMostFrequentBytes(int number,
			List<Map.Entry<Integer, Integer>> entries) {
		number = Math.min(entries.size(),  number);
		int[] mostFrequentBytes = new int[number];
		for(int i=0; i<number; i++) {
			mostFrequentBytes[i] = entries.get(i).getKey();
		}
		return mostFrequentBytes;
	}

	int[] getTable(){
		return frequency;
	}
}
