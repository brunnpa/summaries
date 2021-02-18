package ch.zhaw.swen1.iotdisplay.util;

import ch.zhaw.swen1.iotdisplay.platform.RgbIntColor;
import ch.zhaw.swen1.iotdisplay.platform.RgbPixelScreen;

public class RgbPixelScreenHelper {

	private RgbPixelScreenHelper() {
	}

	public static void fillScreenBlack(RgbPixelScreen screen){
		fillRectangle(screen, 0, 0, screen.getWidth(), screen.getHeight(), 
				RgbIntColor.BLACK); 
	}
	
	public static void fillScreen(RgbPixelScreen screen, RgbIntColor color){
		fillRectangle(screen, 0, 0, screen.getWidth(), screen.getHeight(), 
				color); 
	}
	
	public static void fillRectangleBlack(RgbPixelScreen screen, 
			int startX, int startY, int width, int height){
		fillRectangle(screen, startX, startY, width, height, RgbIntColor.BLACK); 
	}
	
	public static void fillRectangle(RgbPixelScreen screen, 
			int startX, int startY, int width, int height, 
			RgbIntColor color){
		for(int y = startY; y < startY + height; y++){
			for (int x = startX; x < startX + width; x++){
				screen.setRgbPixel(x, y, color);  
			}
		}
	}
		
	public static void drawVerticalLine(RgbPixelScreen screen, 
			int startX, int startY, int height, 
			RgbIntColor color){
		for(int y = startY; y < startY + height; y++){
			screen.setRgbPixel(startX, y, color);  
		}
	}
	
	public static void drawVerticalLine(RgbPixelScreen screen, 
			int startX, int startY, int height, 
			int red, int green, int blue){
	}

	public static void drawHorizontalLine(RgbPixelScreen screen, 
			int startX, int startY, int width, 
			RgbIntColor color){
		for (int x = startX; x < startX + width; x++){
			screen.setRgbPixel(x, startY, color);  
		}
	}
			
	public static void drawCross(RgbPixelScreen screen, 
			int startX, int startY, int width, 
			RgbIntColor color){
		int x1 = startX;
		int x2 = startX + width-1;
		int y1 = startY;
		for (int i = 0; i < width; i++){
			screen.setRgbPixel(x1, y1, color);  
			screen.setRgbPixel(x2, y1, color); 
			x1++;
			x2--;
			y1++;
		}
	}
	
	public static void drawOk(RgbPixelScreen screen, 
			int startX, int startY, RgbIntColor color){
		screen.setRgbPixel(startX, startY+1, color);
		screen.setRgbPixel(startX + 1, startY+2, color);
		screen.setRgbPixel(startX + 2, startY+1, color);
		screen.setRgbPixel(startX + 3, startY, color);
	}
	
	/**
	 * Expands the specified rectangle screen content by the specified factor.
	 * @param screen
	 * @param factor
	 */
	public static void expandRect(RgbPixelScreen screen, 
			int width, int height, int factor) {
		for(int y=height-1; y>=0; y--) {
			for(int x=width-1; x>=0; x--) {
				RgbIntColor color = screen.getRgbPixel(x, y);
				int targetX = x * factor;
				int targetY = y * factor;
				for(int yOfs = 0; yOfs < factor; yOfs++) {
					for(int xOfs = 0; xOfs < factor; xOfs++) {
						screen.setRgbPixel(targetX + xOfs, targetY+yOfs, color);
					}
				}
			}
			
		}
	}
	
}
