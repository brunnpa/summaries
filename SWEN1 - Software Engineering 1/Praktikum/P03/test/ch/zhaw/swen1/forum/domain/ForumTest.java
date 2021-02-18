package ch.zhaw.swen1.forum.domain;

import java.time.Clock;
import java.time.Instant;
import java.time.ZoneId;

import org.junit.Before;
import org.junit.Test;

import static org.junit.Assert.*;

/**
 * Combined tests for forum domain logic. Because domain classes are quite simple, 
 * only integration tests have been written. 
  *
 */
public class ForumTest {
	private Forum forum;
	private User user;
	private Instant reference;

	@Before
	public void setUp() throws Exception {
		reference = Instant.ofEpochSecond(1000000); 
		// use a clock which returns always the same time, so testing is easy
		forum = new Forum(Clock.fixed(reference, ZoneId.systemDefault()));
		user = new User("User", new byte[]{0});
		forum.getUsers().add(user);
	}

	@Test
	public void addNewDiscussionTest(){
		//Test if execptions get return
		try{
			forum.addNewDiscussion("",null,"","testName");

			fail("Expected exception");
		} catch(Exception ex){}

		try{
			forum.addNewDiscussion(null,null,"","testName");

			fail("Expected exception");
		} catch(Exception ex){}

		try{
			forum.addNewDiscussion(null,null,"","");

			fail("Expected exception");
		} catch(Exception ex){}

		try{
			forum.addNewDiscussion(null,null,"testTopicName","testName");

			fail("Expected exception");
		} catch(Exception ex){}

		try{
			forum.addNewDiscussion(user.getName(),null,"testTopicName","testName");

			fail("Expected exception");
		} catch(Exception ex){}

		try{
			forum.addNewDiscussion(user.getName(),new byte[]{0},"","");

			fail("Expected exception");
		} catch(Exception ex){}

		try{
			forum.addNewDiscussion(user.getName(),null,"","testName");

			fail("Expected exception");
		} catch(Exception ex){}

		try{
			forum.addNewDiscussion(user.getName(),null,"testTopicName","");

			fail("Expected exception");
		} catch(Exception ex){}

		//Test if new Discussion works
		try{
			Topic topic = new Topic("testTopicName", "Testeintrag");
			forum.getTopics().add(topic);
			forum.addNewDiscussion(user.getName(),new byte[]{0},"testTopicName", "testDiscussionName");
			assertEquals(topic.getDiscussions().size(), 1);
			assertEquals(topic.getDiscussions().get(0).getName(), "testTopicName");
		} catch(Exception ex){
			fail("Expected no exception");
		}
	}

	@Test
	public void getNbrOfContributionsTest(){
		int counter = forum.getNbrOfContributions();
		assertEquals(counter, 0);

		Topic topic = new Topic("testTopicName", "Testeintrag");
		try{
			forum.getTopics().add(topic);
			forum.addNewDiscussion(user.getName(),new byte[]{0},"testTopicName", "testDiscussionName");
		} catch(Exception ex){
			fail("Expected no exception");
		}
		counter = forum.getNbrOfContributions();
		assertEquals(counter, 0);

		topic.getDiscussions().get(0).getContributions().add(new Contribution(("TestContribution"), user, Instant.now()));
		counter = forum.getNbrOfContributions();
		assertEquals(counter, 1);
	}

	 

}