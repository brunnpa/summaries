
public class Auto2 {
	private String marke;
	private String typ;
	private double hubraum;
	private boolean turbo;
	private int lagerbestand;
	
	public Auto2 (String marke, String typ, double hubraum, boolean hatTurbo){
		zeichenUeberpruefung(marke);
		this.marke = marke;
		zeichenUeberpruefung(typ);
		this.typ = typ; 
		wertUeberpruefung(hubraum);
		this.hubraum = hubraum;
		lagerbestand = 0;
		turbo = hatTurbo;
	}
	
	private String zeichenUeberpruefung (String zuUeberpruefenderWert) {
		if(zuUeberpruefenderWert.length() >= 3 && zuUeberpruefenderWert.length() <= 10) {
			return zuUeberpruefenderWert;
		}
		else {
			zuUeberpruefenderWert = "___";
			System.out.println("Ungueltiger Wert, bitte zwischen 3 und 10 Zeichen eingeben. Auf Defaulwert ___ gesetzt");
			return zuUeberpruefenderWert;
		}
	}
	
	private double wertUeberpruefung (double zuUeberpruefenderWert) {
		if(zuUeberpruefenderWert >= 0.5 && zuUeberpruefenderWert <= 8.0) {
			return zuUeberpruefenderWert;
		}
		else {
			zuUeberpruefenderWert = 0.0;
			System.out.println("Ungueltiger Wert, bitte zwischen 0.5 und 8 angeben. Auf Defaultwert 0 gesetzt");
			return zuUeberpruefenderWert;
		}
	}
	
	
	public void setTyp(String typ) {
		if(zeichenUeberpruefung(typ) != "___") {
			this.typ = typ;}
	}

	public void setMarke (String marke) {
		if(zeichenUeberpruefung(marke) != "___") {
			this.marke = marke; 
		}
	}
	
	public void setHubraum(double hubraum) {
		if(wertUeberpruefung(hubraum) != 0.0) {
			this.hubraum = hubraum;
		}
	}
	
	public void setLagerbestand(int betragsAenderung) {
		int alterLagerbestand = lagerbestand; 
		if(betragsAenderung >=-10 && betragsAenderung <= 0) {
			if((lagerbestand - betragsAenderung)>= 0) {
				this.lagerbestand = lagerbestand - betragsAenderung;
				System.out.println("alter Lagerbestand: " + alterLagerbestand);
				System.out.println("neuer Lagerbestand: " + this.lagerbestand);
			}	
		} else if(betragsAenderung >= 0 && betragsAenderung <=10){
			this.lagerbestand = lagerbestand + betragsAenderung;
			System.out.println("alter Lagerbestand: " + alterLagerbestand);
			System.out.println("neuer Lagerbestand: " + this.lagerbestand);
		}
	}
	
	public void getInformations() {
		System.out.println(marke + " " + typ + " " + hubraum + " Liter" + hatTurboFuerString());
		System.out.println("Code: " + marke.substring(0, 3) + "-" + typ.substring(0, 3) + hatTurboFuerStringAbk());
		System.out.println("Lagerbestand: " + lagerbestand);
	}
	
	private String hatTurboFuerStringAbk() {
		if(turbo) {
			return "-t";
		}
		return "";
	}
	
	private String hatTurboFuerString() {
		if(turbo) {
			return " Turbo";
		}
		return "";
	}
}
