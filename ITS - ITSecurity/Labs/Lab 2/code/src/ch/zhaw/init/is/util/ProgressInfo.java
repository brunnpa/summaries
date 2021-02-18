package ch.zhaw.init.is.util;

public interface ProgressInfo {

	/**
	 * @return The current progress as absolute number (e.g. tasks => number of tasks processed until now )
	 */
	double getProgressAbsolute();

	/**
	 * @return The current progress in percent
	 */
	double getProgressInPercent();

	/**
	 * @return The unit of the absolute measurement (e.g., tasks)
	 */
	String getUnit();
	
}
