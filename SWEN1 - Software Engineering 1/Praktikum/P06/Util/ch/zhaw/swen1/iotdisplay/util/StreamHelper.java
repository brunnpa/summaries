package ch.zhaw.swen1.iotdisplay.util;

import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.InputStream;

/**
 * Provides helper methods for handling input and output streams
 * @author fer
 *
 */
public class StreamHelper {

	private StreamHelper() {
	}

	/**
	 * Copies the provided input stream into a byte array, wraps it into a ByteArrayInputStream
	 * and returns it. 
	 * @param in
	 * @return
	 * @throws IOException
	 */
	public static ByteArrayInputStream copyInputStreamIntoByteArrayInputStream(InputStream in)
	throws IOException{
    	ByteArrayOutputStream out = new ByteArrayOutputStream();
    	byte[] buffer = new byte[1024];
		int len = in.read(buffer);
    	while (len != -1) {
    	    out.write(buffer, 0, len);
    	    len = in.read(buffer);
    	}	        	
    	return new ByteArrayInputStream(out.toByteArray()) ;
	}
	
}
