package ch.zhaw.swen1.lightingapp.ui.swing;

import java.awt.Color;
import java.awt.Dimension;
import java.awt.Graphics;

import javax.swing.JComponent;

import ch.zhaw.swen1.lightingapp.domain.RGBColorPercentage;


/**
 * Swing component which implements the lamp interface. 
 * Just for simulation purposes. 
 * @author fer
 *
 */
public class JLampComponent extends JComponent {
	private static final long serialVersionUID = 1L;
	private RGBColorPercentage color;

	public JLampComponent(String name) {
		setBackground(Color.BLACK);
		setPreferredSize(new Dimension(32, 32));
		setName(name);
		setColor(RGBColorPercentage.BLACK);
	}

	public void setColor(RGBColorPercentage percentage) {
		this.color = percentage;
		Color color = new Color(percentage.getRed() / 100f, 
				percentage.getGreen() / 100f, 
				percentage.getBlue() / 100f);
		setForeground(color);
		repaint();
	}

	public RGBColorPercentage getColor() {
		return color;
	}	
	
	@Override
	protected void paintComponent(Graphics g) {
		g.setColor(Color.BLACK); 
		g.fillRect(0, 0, getWidth(), getHeight()); 
		g.setColor(getForeground());
		if (getWidth() > 8 && getHeight() > 8){
			g.fillOval(2, 2, getWidth()-4, getHeight()-4);
			g.setColor(Color.WHITE); // something different than BLACK
			g.drawOval(1, 1, getWidth()-2, getHeight()-2); 
		} else {
			g.fillRect(0, 0, getWidth(), getHeight()); 
		}
	}
}
