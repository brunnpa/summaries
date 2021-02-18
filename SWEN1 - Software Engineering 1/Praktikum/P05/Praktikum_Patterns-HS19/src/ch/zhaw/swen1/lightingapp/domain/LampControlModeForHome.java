package ch.zhaw.swen1.lightingapp.domain;

public class LampControlModeForHome implements LampControlMode {
	private int increasePercentage;

	public LampControlModeForHome() {
		this.increasePercentage = 5;
	}

	@Override
	public String toString() {
		return "Wohnung " + increasePercentage + "%";
	}
}
