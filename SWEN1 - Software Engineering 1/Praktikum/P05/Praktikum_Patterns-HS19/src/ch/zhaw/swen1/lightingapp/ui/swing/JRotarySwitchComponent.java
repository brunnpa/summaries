package ch.zhaw.swen1.lightingapp.ui.swing;

import java.awt.event.ActionEvent;

import javax.swing.BoxLayout;
import javax.swing.JButton;
import javax.swing.JPanel;

import ch.zhaw.swen1.lightingapp.domain.LampControl;

public class JRotarySwitchComponent extends JPanel {
	private static final long serialVersionUID = 1L;
	private LampControl lampControl;
	private JButton pressButton;
	private JButton incrementButton;
	private JButton decrementButton;

	public JRotarySwitchComponent(String name) {
		setName(name);
		pressButton = new JButton("S");
		pressButton.addActionListener(this::pressAction);
		incrementButton = new JButton("+");
		incrementButton.addActionListener(this::incrementAction);
		decrementButton = new JButton("-");		
		decrementButton.addActionListener(this::decrementAction);
		setLayout(new BoxLayout(this, BoxLayout.LINE_AXIS));		
		add(pressButton);
		add(decrementButton);
		add(incrementButton);
	}
	
	public LampControl getLampControl() {
		return lampControl;
	}

	public void setLampControl(LampControl lampControl) {
		this.lampControl = lampControl;
	}

	protected void pressAction(ActionEvent event){
        if (lampControl != null){
        	lampControl.buttonPressed(this);
		}
	}

	protected void incrementAction(ActionEvent event){
        if (lampControl != null){
        	lampControl.rotationChanged(this, 1);
		}
	}
	
	protected void decrementAction(ActionEvent event){
		if (lampControl != null){
			lampControl.rotationChanged(this, -1);
		}
	}

}
