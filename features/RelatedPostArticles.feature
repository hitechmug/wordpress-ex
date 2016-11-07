Feature: Related Post Articles
As a user, I would like the ability to view articles related to the post I just read.
* Display a maximum of 3 posts
* Each post will display the title, the excerpt, elapsed time, and a link to the full article
* Below the 3 related articles will be a button that directs users back to the main news page
# Note that this test is not currently reflecting categorization

Background:
	Given I have logged into wordpress as "admin" with the password "JTK17[07E"
	Given I have "post" with the title "Test Related Blog Post 1" and the slug "test-related-blog-post-1" in wordpress
	 And the "post" "Test Related Blog Post 1" has the excerpt "Hunt by meowing loudly at 5am next to human slave food dispenser"
	Given I have "post" with the title "Test Related Blog Post 2" and the slug "test-related-blog-post-2" in wordpress
	 And the "post" "Test Related Blog Post 2" has the excerpt "Jump off balcony, onto stranger's head eat and than sleep on your face"
	Given I have "post" with the title "Test Related Blog Post 3" and the slug "test-related-blog-post-3" in wordpress
	 And the "post" "Test Related Blog Post 3" has the excerpt "Make muffins, for always hungry pooping rainbow while flying in a toasted bread costume"
	Given I have "post" with the title "Test Related Blog Post 4" and the slug "test-related-blog-post-4" in wordpress
	 And the "post" "Test Related Blog Post 4" has the excerpt "Missing until dinner time."
	Given I have "event" with the title "Test Related Event Post 1" and the slug "test-related-event-post-1" in wordpress
	 And the "event" "Test Related Event Post 1" has the excerpt "Buster's in what we like to call a light to no coma."
	Given I have "event" with the title "Test Related Event Post 2" and the slug "test-related-event-post-2" in wordpress
	 And the "event" "Test Related Event Post 2" has the excerpt "Hola, is Rosa still alive? No? Well this is not my day."
	Given I have "event" with the title "Test Related Event Post 3" and the slug "test-related-event-post-3" in wordpress
	 And the "event" "Test Related Event Post 3" has the excerpt "I love all of my children equally. I don't care for Gob."
	Given I have "event" with the title "Test Related Event Post 4" and the slug "test-related-event-post-4" in wordpress
	 And the "event" "Test Related Event Post 4" has the excerpt "I'm tired of trying to find happiness through lies and self-medicating."
	Given I have "news" with the title "Test Related News Post 1" and the slug "test-related-news-post-1" in wordpress
	 And the "news" "Test Related News Post 1" has the excerpt "We have unlimited juice? This party is going to be off the hook."
	Given I have "news" with the title "Test Related News Post 2" and the slug "test-related-news-post-2" in wordpress
	 And the "news" "Test Related News Post 2" has the excerpt "Yeah, you do know how a button works don't you? No, not on clothes."
	Given I have "news" with the title "Test Related News Post 3" and the slug "test-related-news-post-3" in wordpress
	 And the "news" "Test Related News Post 3" has the excerpt "See the driver hooks a function by patching the system call table."
	Given I have "news" with the title "Test Related News Post 4" and the slug "test-related-news-post-4" in wordpress
	 And the "news" "Test Related News Post 4" has the excerpt "An onion sees a swallow as a worried boot."

Scenario: Ability to view blog post related content that is not itself
	Given I am on "/test-related-blog-post-4"
	Then the ".main-post-grid" element should contain "Blog"
	 And the ".main-post-grid" element should not contain "Event"
	 And the ".main-post-grid" element should not contain "News"
	 And the ".main-post-grid" element should contain "Test Related Blog Post 1"
	 And the ".main-post-grid" element should contain "Test Related Blog Post 2"
	 And the ".main-post-grid" element should contain "Test Related Blog Post 3"
	 And the ".main-post-grid" element should not contain "Test Related Blog Post 4"
	When I follow "Read More: Test Related Blog Post 1" 
	Then I should be on "/test-related-blog-post-1/"

Scenario: Ability to view event post related content that is not itself
	Given I am on "/event/test-related-event-post-4"
	Then the ".main-post-grid" element should contain "Event"
	 And the ".main-post-grid" element should not contain "Blog"
	 And the ".main-post-grid" element should not contain "News"
	 And the ".main-post-grid" element should contain "Test Related Event Post 1"
	 And the ".main-post-grid" element should contain "Test Related Event Post 2"
	 And the ".main-post-grid" element should contain "Test Related Event Post 3"
	 And the ".main-post-grid" element should not contain "Test Related Event Post 4"
	When I follow "Read More: Test Related Event Post 1" 
	Then I should be on "/event/test-related-event-post-1/"

Scenario: Ability to view news post related content that is not itself
	Given I am on "/news/test-related-news-post-4"
	Then the ".main-post-grid" element should contain "News"
	 And the ".main-post-grid" element should not contain "Blog"
	 And the ".main-post-grid" element should not contain "Event"
	 And the ".main-post-grid" element should contain "Test Related News Post 1"
	 And the ".main-post-grid" element should contain "Test Related News Post 2"
	 And the ".main-post-grid" element should contain "Test Related News Post 3"
	 And the ".main-post-grid" element should not contain "Test Related News Post 4"
	When I follow "Read More: Test Related News Post 1" 
	Then I should be on "/news/test-related-news-post-1/"


