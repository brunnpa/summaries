package ch.zhaw.swen1.iotdisplay.examples;

import java.io.IOException;
import java.util.Map;

import ch.zhaw.swen1.iotdisplay.main.IotDisplayMain;
import ch.zhaw.swen1.iotdisplay.platform.Executable;
import ch.zhaw.swen1.iotdisplay.platform.Platform;
import ch.zhaw.swen1.iotdisplay.platform.RgbIntColor;
import ch.zhaw.swen1.iotdisplay.platform.RgbPixelScreen;
import ch.zhaw.swen1.iotdisplay.util.RgbPixelScreenHelper;

public class PraktikumIoTDisplay implements Executable {
	private int delayCounter;
	private int currentDelayCounter;
	protected Platform platform;
	private int currentRectangleSize;
	private RgbIntColor[] colors = new RgbIntColor[]{
				new RgbIntColor(31, 0, 0), // 31 is maximum value for one color component 
				new RgbIntColor( 0,31, 0), // 31 is maximum value for one color component 
				new RgbIntColor( 0, 0,31)  // 31 is maximum value for one color component 
			};
	private int currentColorIndex = 0;

	public PraktikumIoTDisplay(int delayCounter) {
		this.delayCounter = delayCounter;
	}

	public PraktikumIoTDisplay() {
		this.delayCounter = 4;
	}

	@Override
	public String toString() {
		return "Praktikum IoT Display Example";
	}

	@Override
	public void start(Platform platform, Map<String, Object> configuration) {
		this.platform = platform;
		platform.setTimer4HzEventListener(this::handleTimer4HzEvent);
		platform.setButtonEventListener("Main", this::changeColor);
		// buttons with attached listener are rendered differently
		platform.setButtonEventListener("Red", this::setColorToRed);
	}

	protected void changeColor(Object sender){
		currentColorIndex = (currentColorIndex + 1) % colors.length;
	}
	
	protected void setColorToRed(Object sender){
		currentColorIndex = 0;
	}
	
	protected void handleTimer4HzEvent(Object sender) throws Exception {
		int displaySizeInPixel = platform.getDisplay().getWidth(); // assuming square
		if (currentDelayCounter > 0){
			currentDelayCounter--;
			return;
		}
		currentDelayCounter = delayCounter;
		try (RgbPixelScreen screen = getScreen()){
			RgbIntColor color = colors[currentColorIndex];
			RgbPixelScreenHelper.fillScreenBlack(screen);
			int positionLeftUpperCorder = (displaySizeInPixel - currentRectangleSize) / 2;
			int positionRightLowerCorder = displaySizeInPixel - positionLeftUpperCorder - 1;
			RgbPixelScreenHelper.drawHorizontalLine(screen, 
					positionLeftUpperCorder, positionLeftUpperCorder, 
					currentRectangleSize, color);
			RgbPixelScreenHelper.drawHorizontalLine(screen, 
					positionLeftUpperCorder, positionRightLowerCorder, 
					currentRectangleSize, color);
			RgbPixelScreenHelper.drawVerticalLine(screen, 
					positionLeftUpperCorder, positionLeftUpperCorder, 
					currentRectangleSize, color);
			RgbPixelScreenHelper.drawVerticalLine(screen, 
					positionRightLowerCorder, positionLeftUpperCorder, 
					currentRectangleSize, color);
			currentRectangleSize = currentRectangleSize + 2;
			if (currentRectangleSize > displaySizeInPixel) {
				currentRectangleSize = 0;
			}
		}
	}

	private RgbPixelScreen getScreen() {
		return platform.getDisplay().getScreen();
	}
	
	@Override
	public void close() throws IOException {
		// no sockets have been opened, therefore nothing to close here. 
	}
	
	public static void main(String[] args){
		IotDisplayMain.startExecutableInSimulation(new PraktikumIoTDisplay()); 
	}

}
