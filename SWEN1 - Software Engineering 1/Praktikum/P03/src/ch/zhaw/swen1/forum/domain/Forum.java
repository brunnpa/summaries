package ch.zhaw.swen1.forum.domain;

import java.time.Clock;
import java.time.Instant;
import java.util.ArrayList;
import java.util.List;

/**
 * Represents the whole forum with its list of topics and users
 *
 */
public class Forum {
	private Clock clock;
	private List<User> users = new ArrayList<>();
	private List<Topic> topics = new ArrayList<>();

	public Forum(Clock clock) {
		super();
		this.clock = clock;
	}

	/**
	 * Returns the list of users. Just for tests. 
	 * @return
	 */
	protected List<User> getUsers() {
		return users;
	}
	
	/**
	 * Returns the list of topics. Just for tests. 
	 * @return
	 */
	protected List<Topic> getTopics() {
		return topics;
	}

	/**
	 * Returns the topic with the specified name or null if there is no such topic. 
	 */
	protected Topic getTopicForName(String name){
		for(Topic topic : topics){
			if (topic.getName().equals(name)){
				return topic;
			}
		}
		return null;
	}
	
	protected User getUserForName(String name){
		for(User user : users){
			if (user.getName().equals(name)){
				return user;
			}
		}
		return null;
	}

	// Meine Änderungen
	protected int getNbrOfContributions(){
		int counter = 0;
		List<Topic> topics = getTopics();
		// Iterate through every topic and sum the total number of Contributions in all discussions
		for(Topic topic : getTopics()) {
			counter += topic.getNumberOfDiscussions();
		}
		return counter;
	}

	//meine Änderungen - addNewDiscussion
	protected void addNewDiscussion(String userName, byte[] passwordHash, String topicName, String discussionName) throws Exception {
		if(topicName == null || topicName == "" || discussionName == null || discussionName == ""){
			throw new Exception(); // Parameter, use proper Exception
		}
		User user = getUserForName(userName);
		if(user == null){
			throw new Exception(); // NotFound, use proper Exception
		}
		if(!user.testPassword(passwordHash)){
			throw new Exception(); // NotAuthenticated, use proper Exception
		}
		Topic topic = getTopicForName(topicName);
		if(topic == null){
			throw new Exception(); // NotFound, use proper Exception
		}
		if(topic.existsDiscussion(discussionName)){
			throw new Exception(); // Discussion Exists, use proper Exception
		}
		topic.addDiscussion(discussionName);
	}
}