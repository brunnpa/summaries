package ch.zhaw.swen1.lightingapp.ui.swing;

import java.awt.BorderLayout;
import java.awt.EventQueue;

import javax.swing.JFrame;
import javax.swing.JPanel;
import javax.swing.JSlider;
import javax.swing.border.EmptyBorder;
import javax.swing.event.ChangeEvent;
import javax.swing.event.ChangeListener;

public class SwitchFrame extends JFrame {
	private static final long serialVersionUID = 1L;
	private JPanel contentPane;
	private JSlider slider;

	/**
	 * Launch the application.
	 */
	public static void main(String[] args) {
		EventQueue.invokeLater(new Runnable() {
			public void run() {
				try {
					SwitchFrame frame = new SwitchFrame();
					frame.setVisible(true);
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
		});
	}
	
	/**
	 * Create the frame.
	 */
	public SwitchFrame() {
		setTitle("Home Server");
		setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
		setBounds(100, 100, 400, 100);
		contentPane = new JPanel();
		contentPane.setBorder(new EmptyBorder(5, 5, 5, 5));
		contentPane.setLayout(new BorderLayout(0, 0));
		setContentPane(contentPane);
		
		slider = new JSlider();
		slider.addChangeListener(new ChangeListener() {
			public void stateChanged(ChangeEvent e) {
				do_slider_stateChanged(e);
			}
		});
		slider.setMinorTickSpacing(10);
		slider.setMajorTickSpacing(50);
		slider.setToolTipText("Sets the luminosity immediately");
		slider.setPaintTicks(true);
		slider.setPaintLabels(true);
		slider.setMaximum(200);
		contentPane.add(slider, BorderLayout.CENTER);	
	}

	protected void do_slider_stateChanged(ChangeEvent e) {
	}
}
