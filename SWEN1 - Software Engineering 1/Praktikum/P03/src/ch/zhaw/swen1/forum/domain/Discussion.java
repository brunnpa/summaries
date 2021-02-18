package ch.zhaw.swen1.forum.domain;

 	
import java.util.ArrayList;
import java.util.List;

/**
 * A discussion inside a topic of a form. 
 *
 */
public class Discussion {
	private String name;
	private List<Contribution> contributions = new ArrayList<Contribution>();

	public Discussion(String name) {
		super();
		this.name = name;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public List<Contribution> getContributions() {
		return contributions;
	}

	//meine Änderungen
	public int getNumberofContribution(){
		return getContributions().size();
	}
	 

}