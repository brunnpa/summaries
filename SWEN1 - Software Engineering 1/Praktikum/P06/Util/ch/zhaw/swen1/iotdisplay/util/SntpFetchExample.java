package ch.zhaw.swen1.iotdisplay.util;

import java.io.IOException;
import java.time.Instant;
import java.time.LocalDateTime;
import java.time.ZoneId;

import ch.zhaw.swen1.iotdisplay.platform.SocketFactory;
import ch.zhaw.swen1.iotdisplay.util.SntpProtocoll.Reply;

/**
 * Example code for fetching the current date/time from an SNTP server
 * @author fer
 *
 */
public class SntpFetchExample {
	private static final String defaultUrl = "//0.ch.pool.ntp.org:123";

	public static LocalDateTime fetchCurrentTime(SocketFactory socketFactory) throws IOException {
		// prepare request
		byte[] request = SntpProtocoll.createRequest(0);
		// send request and read reply
		byte[] replyBuffer = UdpHelper.sendAndReceiveUdpPacket(socketFactory,
				request, defaultUrl, SntpProtocoll.NTP_PACKET_SIZE, 1000);
		// decode reply
		Reply reply = SntpProtocoll.decodeReply(replyBuffer);
		// extract current time from reply
		Instant instant = Instant.ofEpochMilli(reply.getTransmitTime());
		// construct a local date time with the default ZoneId
		LocalDateTime currentTime = LocalDateTime.ofInstant(instant, ZoneId.systemDefault());
		
		return currentTime;
	}
}
