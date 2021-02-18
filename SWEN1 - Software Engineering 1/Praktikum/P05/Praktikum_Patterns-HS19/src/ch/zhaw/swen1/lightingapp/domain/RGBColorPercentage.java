package ch.zhaw.swen1.lightingapp.domain;

/**
 * Color information in percentage. 
 * @author fer
 *
 */
public class RGBColorPercentage {
	private int red;
	private int green;
	private int blue;

	public RGBColorPercentage(RGBColorPercentage original) {
		this(original.getRed(), original.getGreen(), original.getBlue());
	}

	public RGBColorPercentage(int red, int green, int blue) {
		super();
		this.red = red;
		this.green = green;
		this.blue = blue;
	}

	@Override
	public String toString() {
		return "RGBColorPercentage [red=" + red + ", green=" + green + ", blue=" + blue + "]";
	}

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + blue;
		result = prime * result + green;
		result = prime * result + red;
		return result;
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		RGBColorPercentage other = (RGBColorPercentage) obj;
		if (blue != other.blue)
			return false;
		if (green != other.green)
			return false;
		if (red != other.red)
			return false;
		return true;
	}

	public RGBColorPercentage increaseBrightness(int percentIncrement){
		RGBColorPercentage result = new RGBColorPercentage(this);
		result.increaseBrightnessInternal(percentIncrement);
		return result;
	}
		
	private void increaseBrightnessInternal(int percentIncrement){
		red = increaseComponent(red, percentIncrement);
		green = increaseComponent(green, percentIncrement);
		blue = increaseComponent(blue, percentIncrement);
	}
	
	protected static int increaseComponent(int oldValue, int percentIncrement){
		if (percentIncrement > 0){
			return Math.min(oldValue + percentIncrement, 100);
		} else {
			return Math.max(oldValue + percentIncrement, 0);
		}
	}
	
	public boolean isPercentageBelow(RGBColorPercentage level){
	    return getRed() < level.getRed() &&
			getGreen() < level.getGreen() &&
			getBlue() < level.getBlue();
	}
	
	public int getRed() {
		return red;
	}

	public int getGreen() {
		return green;
	}

	public int getBlue() {
		return blue;
	}

	public static final RGBColorPercentage WHITE = new RGBColorPercentage(100, 100, 100); 
	public static final RGBColorPercentage BLACK = new RGBColorPercentage(0, 0, 0); 
}
