Feature: Recent Post Carousel
As an admin user, I would like the ability to display recent posts at the bottom of every page
* Display the most recent 5 blog posts
* Show title, excerpt, and a link to view the full post
* Display in carousel format

Background:
	Given I have logged into wordpress as "admin" with the password "JTK17[07E"
	Given I have "post" with the title "Test Post Carousel 1" and the slug "test-post-carousel-1" in wordpress
	 And the "post" "Test Post Carousel 1" has the excerpt "They were lost without the saltant traffic that composed their temper."
	Given I have "post" with the title "Test Post Carousel 2" and the slug "test-post-carousel-2" in wordpress
	 And the "post" "Test Post Carousel 2" has the excerpt "The unstamped trial reveals itself as a taillike sauce to those who look."
	Given I have "post" with the title "Test Post Carousel 3" and the slug "test-post-carousel-3" in wordpress
	 And the "post" "Test Post Carousel 3" has the excerpt "The transmissions could be said to resemble conferred elbows."
	Given I have "post" with the title "Test Post Carousel 4" and the slug "test-post-carousel-4" in wordpress
	 And the "post" "Test Post Carousel 4" has the excerpt "This could be, or perhaps a turdine cocktails bolt comes with it the thought that the addorsed ruth is a cotton."
	Given I have "post" with the title "Test Post Carousel 5" and the slug "test-post-carousel-5" in wordpress
	 And the "post" "Test Post Carousel 5" has the excerpt "Some assert that a softdrink of the hardboard is assumed to be a stemless pajama."
	Given I have "post" with the title "Test Post Carousel 6" and the slug "test-post-carousel-6" in wordpress
	 And the "post" "Test Post Carousel 6" has the excerpt "Some posit the headstrong calculus to be less than strongish."

Scenario: List of 5 elements displays on page
	Given I am on "/test-post-carousel-1"
	Then I should see 5 "#blog-recent-posts > ul > li" elements

@javascript
Scenario: Display presents as a carousel and autoplays
	Given I am on "/test-post-carousel-1"
	Then I should see "Test Post Carousel 6"
	 #And I should not see "Test Post Carousel 5" #Note that the blog items show up in the related items as well
	When I wait for "6000"
	Then I should see "Test Post Carousel 5"
	 #And I should not see "Test Post Carousel 6" #Note that the blog items show up in the related items as well

@javascript
Scenario: Carousel navigation displays expected tweets
	Given I am on "/test-post-carousel-1"
	When I press "View Slide 5" 
	 And I wait for "1000"
	Then I should see "Test Post Carousel 2"

