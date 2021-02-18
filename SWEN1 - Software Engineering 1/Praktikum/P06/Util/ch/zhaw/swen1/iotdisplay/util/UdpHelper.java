package ch.zhaw.swen1.iotdisplay.util;

import java.io.IOException;
import java.net.DatagramPacket;
import java.net.DatagramSocket;
import java.net.InetAddress;
import java.net.URI;
import java.net.URISyntaxException;
import java.util.Arrays;

import ch.zhaw.swen1.iotdisplay.platform.SocketFactory;

public class UdpHelper {
//	private static long startMillis = 0;

	/**
	 * Sends and receives one UDP socket. 
	 * Refactored Android code. 
	 * @param request
	 * @param targetHost
	 * @param receiveBufferSize
	 * @param timeout
	 * @return
	 * @throws IOException
	 */
	public static byte[] sendAndReceiveUdpPacket(SocketFactory socketFactory, 
			byte[] request, String targetHost,
			int receiveBufferSize, int timeout) throws IOException {

		/* Simulation
		long time = 1418711400000L;
		byte[] buffer = new byte[SntpProtocoll.NTP_PACKET_SIZE];
		SntpProtocoll.writeTimeStamp(buffer, 24, time);
		SntpProtocoll.writeTimeStamp(buffer, 32, time);
		SntpProtocoll.writeTimeStamp(buffer, 40, time);
		return buffer;
		*/

		/*
		if (startMillis == 0) {
			startMillis = System.currentTimeMillis();
		}

		long timeDiff = System.currentTimeMillis() - startMillis;
		if (timeDiff < 5000) {
			System.out.println("Exception thrown");
			throw new IOException("Connection refused");
		}
		long time = LocalDateTime.of(2018, 9, 12, 0, 0).toEpochSecond(ZoneOffset.UTC) * 1000;
		time = time + timeDiff;
//		long time = 1418711400000L;
		byte[] buffer = new byte[SntpProtocoll.NTP_PACKET_SIZE];
		SntpProtocoll.writeTimeStamp(buffer, 24, time);
		SntpProtocoll.writeTimeStamp(buffer, 32, time);
		SntpProtocoll.writeTimeStamp(buffer, 40, time);
		System.out.println("Current time returned : " + time);
		return buffer;
		*/
		
        try (DatagramSocket socket = socketFactory.createDatagramSocket()){
	        socket.setSoTimeout(timeout);
	        URI uri;
			try {
				uri = new URI(targetHost);
			} catch (URISyntaxException e) {
				throw new IOException("Malformed target host", e);
			}
	        InetAddress address = InetAddress.getByName(uri.getHost());
	        DatagramPacket requestPacket = new DatagramPacket(request, request.length, address, uri.getPort());
	
	        socket.send(requestPacket);
	
	        // read the response
	        DatagramPacket response = new DatagramPacket(new byte[receiveBufferSize], receiveBufferSize);
	        socket.receive(response);
	        if (response.getLength() == receiveBufferSize){
	        	return response.getData();
	        }
	        byte[] result = Arrays.copyOf(response.getData(), response.getLength());
			return result;
        }
	}

}
