package ch.zhaw.swen1.iotdisplay.util;

/**
 * Transport independent implementation of the Simple Network Time Protocol.  
 * Refactored Android code. 
 * @author fer
 *
 */
public class SntpProtocoll {
    public static final int NTP_PORT = 123;
    public static final int NTP_PACKET_SIZE = 48;

    private static final int ORIGINATE_TIME_OFFSET = 24;
    private static final int RECEIVE_TIME_OFFSET = 32;
    private static final int TRANSMIT_TIME_OFFSET = 40;

    private static final int NTP_MODE_CLIENT = 3;
    private static final int NTP_VERSION = 3;

    // Number of seconds between Jan 1, 1900 and Jan 1, 1970
    // 70 years plus 17 leap days
    public static final long OFFSET_1900_TO_1970 = ((365L * 70L) + 17L) * 24L * 60L * 60L;
    
    
    
	public SntpProtocoll() {
	}

	/**
	 * Creates a byte array which contains the request to be sent to the SNTP server.  
	 * @param requestTime
	 * @return
	 */
	public static byte[] createRequest(long requestTime){
        byte[] buffer = new byte[NTP_PACKET_SIZE];

        // set mode = 3 (client) and version = 3
        // mode is in low 3 bits of first byte
        // version is in bits 3-5 of first byte
        buffer[0] = NTP_MODE_CLIENT | (NTP_VERSION << 3);
        writeTimeStamp(buffer, TRANSMIT_TIME_OFFSET, requestTime);

        return buffer;
	}
	
	/**
	 * Decodes the reply from a SNTP server. 
	 * @param replyBuffer
	 * @return
	 */
	public static Reply decodeReply(byte[] replyBuffer){
        long originateTime = readTimeStamp(replyBuffer, ORIGINATE_TIME_OFFSET);
        long receiveTime = readTimeStamp(replyBuffer, RECEIVE_TIME_OFFSET);
        long transmitTime = readTimeStamp(replyBuffer, TRANSMIT_TIME_OFFSET);
        return new Reply(originateTime, receiveTime, transmitTime);
	}
		
	/**
	 * Returns the offset of the 
	 * @param clientSendRequestTime time stamp when the client sends the request
	 * @param clientReceiveReplyTime time stamp when the client receives the reply
	 * @return
	 */
	public static long calculateCorrectionOffset(long clientSendRequestTime, 
			long clientReceiveReplyTime, Reply ntpServerReply){
		long serverDelay2 = (ntpServerReply.transmitTime - ntpServerReply.receiveTime) / 2;
		long clientDelay2 = (clientReceiveReplyTime - clientSendRequestTime) / 2;
		long result = clientDelay2 - serverDelay2;
		return result;
	}
	
	
	public static class Reply {
		private long originateTime;
		private long receiveTime;
		private long transmitTime;
		
		public Reply(long originateTime, long receiveTime, long transmitTime) {
			super();
			this.originateTime = originateTime;
			this.receiveTime = receiveTime;
			this.transmitTime = transmitTime;
		}

		public long getOriginateTime() {
			return originateTime;
		}

		public long getReceiveTime() {
			return receiveTime;
		}

		public long getTransmitTime() {
			return transmitTime;
		}
	}
	
    /**
     * Reads an unsigned 32 bit big endian number from the given offset in the buffer.
     */
	public static long read32(byte[] buffer, int offset) {
        byte b0 = buffer[offset];
        byte b1 = buffer[offset+1];
        byte b2 = buffer[offset+2];
        byte b3 = buffer[offset+3];

        // convert signed bytes to unsigned values
        int i0 = ((b0 & 0x80) == 0x80 ? (b0 & 0x7F) + 0x80 : b0);
        int i1 = ((b1 & 0x80) == 0x80 ? (b1 & 0x7F) + 0x80 : b1);
        int i2 = ((b2 & 0x80) == 0x80 ? (b2 & 0x7F) + 0x80 : b2);
        int i3 = ((b3 & 0x80) == 0x80 ? (b3 & 0x7F) + 0x80 : b3);

        return ((long)i0 << 24) + ((long)i1 << 16) + ((long)i2 << 8) + (long)i3;
    }

    /**
     * Reads the NTP time stamp at the given offset in the buffer and returns 
     * it as a system time (milliseconds since January 1, 1970).
     */    
    public static long readTimeStamp(byte[] buffer, int offset) {
        long seconds = read32(buffer, offset);
        long fraction = read32(buffer, offset + 4);
        return ((seconds - OFFSET_1900_TO_1970) * 1000) + ((fraction * 1000L) / 0x100000000L);        
    }

    /**
     * Writes system time (milliseconds since January 1, 1970) as an NTP time stamp 
     * at the given offset in the buffer.
     */    
    public static void writeTimeStamp(byte[] buffer, int offset, long time) {
        long seconds = time / 1000L;
        long milliseconds = time - seconds * 1000L;
        seconds += OFFSET_1900_TO_1970;

        // write seconds in big endian format
        buffer[offset++] = (byte)(seconds >> 24);
        buffer[offset++] = (byte)(seconds >> 16);
        buffer[offset++] = (byte)(seconds >> 8);
        buffer[offset++] = (byte)(seconds >> 0);

        long fraction = milliseconds * 0x100000000L / 1000L;
        // write fraction in big endian format
        buffer[offset++] = (byte)(fraction >> 24);
        buffer[offset++] = (byte)(fraction >> 16);
        buffer[offset++] = (byte)(fraction >> 8);
        // low order bits should be random data
        buffer[offset++] = (byte)(Math.random() * 255.0);
    }
    
}
