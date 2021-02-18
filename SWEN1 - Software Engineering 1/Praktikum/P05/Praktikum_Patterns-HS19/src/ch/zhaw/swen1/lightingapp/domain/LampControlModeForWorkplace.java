package ch.zhaw.swen1.lightingapp.domain;

public class LampControlModeForWorkplace implements LampControlMode {
	private int increasePercentage;

	public LampControlModeForWorkplace() {
		this.increasePercentage = 10;
	}

	@Override
	public String toString() {
		return "Arbeitsplatz " + increasePercentage + "%";
	}
}
