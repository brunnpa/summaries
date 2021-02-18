package ch.zhaw.init.is.crypto.classic;

import javax.swing.BoxLayout;
import javax.swing.JFrame;
import javax.swing.JPanel;

import org.math.plot.*;

/**
 * This class implements a view of one or multiple {@link ByteFrequencyTable}s.
 * It creates Histogram plots using the jmathplot Library 
 * {@link https://code.google.com/p/jmathplot/}.
 * 
 * @author tebe
 *
 */
public class ByteFrequencyTableView {
	private static final int X_SIZE = 800;
	private static final int Y_SIZE = 600;
	private ByteFrequencyTable[] table;
	
	/**
	 * Constructor to create a view of a single {ByteFrequencyTable}.
	 * @param table The byte frequency table
	 */
	public ByteFrequencyTableView(ByteFrequencyTable table) {
		ByteFrequencyTable[] temp = { table };
		this.table = temp;	
	}

	/**
	 * Constructor to create a view of multiple {ByteFrequencyTable}s.
	 * @param table The byte frequency tables
	 */
	public ByteFrequencyTableView(ByteFrequencyTable[] table) {
		this.table = table;	
	}

	/**
	 * Displays the histogram plot(s). 
	 */
	public void display(){
		JFrame frame = new JFrame("Histogramm view");	
		frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
		JPanel container = new JPanel();
		container.setLayout(new BoxLayout(container, BoxLayout.Y_AXIS));
		int index = 0;
		double[] xAxis = new double[ByteFrequencyTable.BYTE_VALUES];
		for (int i=0; i< xAxis.length; i++){
			xAxis[i] = i;
		}
		for(ByteFrequencyTable t : table) {
			Plot2DPanel plot = new Plot2DPanel();
			plot.getAxis(0).setLegend("Byte");
			plot.getAxis(1).setLegend("# of occurences");
			 double[] convertedData = convertIntToDoubleArray(t.getTable());
			 plot.addBarPlot("Table " + index, xAxis, convertedData);
			 plot.setFixedBounds(0, 0, ByteFrequencyTable.BYTE_VALUES);
			 container.add(plot);
		}
		frame.setContentPane(container);
		frame.setSize(X_SIZE, Y_SIZE);
		frame.setVisible(true);
	}

	private double[] convertIntToDoubleArray(int[] data) {
		 double[] convertedData = new double[data.length];
		 for(int i=0; i<data.length; i++){
		  convertedData[i] = data[i];
		 }
		return convertedData;
	}
}
