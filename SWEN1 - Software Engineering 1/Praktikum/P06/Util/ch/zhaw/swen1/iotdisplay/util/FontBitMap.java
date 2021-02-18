package ch.zhaw.swen1.iotdisplay.util;

/**
 * Provides for a bit map font with all information to render it
 * on a screen. 
 * @author fer
 *
 */
public interface FontBitMap {
	/**
	 * Returns the x distance of 2 letters in pixel
	 * @return
	 */
	int getXInc();
	
	/**
	 * Returns the minimal y distance of 2 letters
	 * @return
	 */
	int getYInc();
	
	/**
	 * Returns true if the bit map information would produce a horizontal
	 * character.   
	 * @return
	 */
	boolean isHorizontal();
	
	/**
	 * Returns how many bits of each int returned by getChar() are valid
	 * @return
	 */
	int getBitWidth();
	
	/**
	 * Returns the bit map for the specified character. Probably all ASCII characters
	 * are supported. 
	 * @param character
	 * @return
	 */
	int[] getChar(int character);
}
