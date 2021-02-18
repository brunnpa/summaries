package ch.zhaw.init.is.util;

import java.util.TimerTask;

/**
 * This class implements a simple TimerTask printing the
 * current progress of a task. 
 * 
 * @author tebe
 *
 */
 public class ProgressTask extends TimerTask {
	private ProgressInfo cracker;
	private double lastTotalTrials;
	private long lastTimestamp;

	public ProgressTask(ProgressInfo cracker) {
		this.cracker = cracker;
		lastTimestamp = System.currentTimeMillis();
	}

	public void run() {
		double current = cracker.getProgressAbsolute();
		double diff = current - lastTotalTrials;
		long diffTime = System.currentTimeMillis() - lastTimestamp;
		System.out.println(diff / (diffTime/1000)  + " " + cracker.getUnit() + "/s (Completed: " + cracker.getProgressInPercent() + "%)");
		lastTotalTrials = current;
		lastTimestamp = diffTime + lastTimestamp;
	}
}
