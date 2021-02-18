package ch.zhaw.swen1.lightingapp.domain;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

import ch.zhaw.swen1.lightingapp.ui.swing.JLampComponent;
import ch.zhaw.swen1.lightingapp.ui.swing.JRotarySwitchComponent;

/**
 * Basic implementation of lamp control. The CRUD methods for lamps and
 * switches are omitted. 
 * @author fer
 *
 */
public class LampControl {
	private List<JLampComponent> lampList;
	private List<JRotarySwitchComponent> rotarySwitchList;
	private Map<JRotarySwitchComponent, List<JLampComponent>> lampsForRotarySwitch;
	private Map<JRotarySwitchComponent, LampControlMode> controlModeForRotarySwitch; 
	private Set<LampControlMode> availableControlModes;

	public LampControl() {
		lampList = new ArrayList<>();
		rotarySwitchList = new ArrayList<>();
		lampsForRotarySwitch = new HashMap<>();
		controlModeForRotarySwitch = new HashMap<>();
		availableControlModes = new HashSet<>();
	}

	public void addLamp(JLampComponent lamp) {
		lampList.add(lamp); 
	}

	public void addLampControlMode(LampControlMode controlMode) {
		availableControlModes.add(controlMode);
	}
	
	/**
	 * Adds a new rotary switch together with the lamps it controls. 
	 * @param rotarySwitch
	 * @param lamps
	 */
	public void addRotarySwitch(JRotarySwitchComponent rotarySwitch, List<JLampComponent> lamps) {
		rotarySwitch.setLampControl(this); 
		rotarySwitchList.add(rotarySwitch);		
		lampsForRotarySwitch.put(rotarySwitch, lamps);
	}

	public void setControlModeForSwitch(JRotarySwitchComponent rotarySwitch, LampControlMode controlMode){
		controlModeForRotarySwitch.put(rotarySwitch, controlMode);
	}

	public Set<LampControlMode> getAvailableControlModes() {
		return availableControlModes;
	}

	public void buttonPressed(JRotarySwitchComponent rotarySwitch) {	
		List<JLampComponent> lamps = lampsForRotarySwitch.get(rotarySwitch);
		if (lamps != null && lamps.size() > 0) {
			RGBColorPercentage firstLampColor = lamps.get(0).getColor();
			RGBColorPercentage newColor;
			if (firstLampColor.equals(RGBColorPercentage.BLACK)) {
				newColor = RGBColorPercentage.WHITE;
			} else {
				newColor = RGBColorPercentage.BLACK;
			}
			lamps.forEach((lamp)->lamp.setColor(newColor)); 
		}
	}

	public void rotationChanged(JRotarySwitchComponent rotarySwitch, int i) {
	}
}
