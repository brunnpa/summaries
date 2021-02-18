package ch.zhaw.swen1.iotdisplay.util;

import ch.zhaw.swen1.iotdisplay.platform.RgbIntColor;
import ch.zhaw.swen1.iotdisplay.platform.RgbPixelScreen;

public class FontHelper {
	public static void drawText(String text, 
			FontBitMap font, 
			int x, int y, RgbPixelScreen screen, 
			RgbIntColor color){
		for(int i = 0; i < text.length(); i++){
			int character = text.charAt(i);
			int[] characterBitMap = font.getChar(character);
			if (font.isHorizontal()){
				FontHelper.drawCharacterHorizontal(characterBitMap, font.getBitWidth(), 
						x, y, screen, color);				
			} else {
				FontHelper.drawCharacterVertical(characterBitMap, font.getBitWidth(), 
						x, y, screen, color);
			}
			x = x + font.getXInc();
		}
	}
		
	public static void drawCharacterVertical(int[] characterBitMap, 
			int bitWidth,  
			int x, int y, RgbPixelScreen target, 
			RgbIntColor color){
		for(int fontIndex = 0; fontIndex < characterBitMap.length; fontIndex++){
			drawPixelColumn(characterBitMap[fontIndex], bitWidth, x, y, target, color);
			x++;
		}
	}
	
	public static void drawPixelColumn(int pixelBits, int bitWidth, 
			int x, int y, RgbPixelScreen target, 
			RgbIntColor color){
		for(int i = 0; i < bitWidth; i++){
			int mask = 1 << i;
			boolean on = (pixelBits & mask) > 0;
			if (on){
				target.setRgbPixel(x, y, color);
			}
			y++;
		}
	}
	
	public static void drawCharacterHorizontal(int[] characterBitMap, 
			int bitWidth,  
			int x, int y, RgbPixelScreen target, 
			RgbIntColor color){
		for(int fontIndex = 0; fontIndex < characterBitMap.length; fontIndex++){
			drawPixelLine(characterBitMap[fontIndex], bitWidth, x, y, target, color);
			y++;
		}
	}
	
	public static void drawPixelLine(int pixelBits, int bitWidth, 
			int x, int y, RgbPixelScreen target, 
			RgbIntColor color){
		for(int i = 0; i < bitWidth; i++){
			int mask = 1 << i;
			boolean on = (pixelBits & mask) > 0;
			if (on){
				if (x >= 0 && x < target.getWidth() && y >= 0 && y < target.getHeight()) {
					target.setRgbPixel(x, y, color);
				}
			}
			x++;
		}
	}
	
}
