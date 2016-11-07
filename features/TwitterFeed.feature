Feature: Twitter Feed
As an admin user, I would like the ability to add a list of recent tweets posted by @gsdmjobs to the jobs page.
* Maximum 5 tweets
* Display the elapsed time with the tweet
* Include a button below the list of tweets that allows users to follow @gsdmjobs.

Background:
	Given I have logged into wordpress as "admin" with the password "JTK17[07E"
	Given I have "content" with the title "Test Twitter Feed" and the slug "test-twitter-feed" in wordpress
	 And the "content" "Test Twitter Feed" has the "gsdm_content_template_meta_box" "gsdm_content_type" set to "twitter-feed"
	 And the "content" "Test Twitter Feed" has the "gsdm_content_section_header_meta_box" "gsdm_section_header_line_1" set to "Section"
	 And the "content" "Test Twitter Feed" has the "gsdm_content_section_header_meta_box" "gsdm_section_header_line_2" set to "Header"
	Given I have "page" with the title "Test Twitter Feed Page" and the slug "test-twitter-feed-page" in wordpress
	 And the "page" "Test Twitter Feed Page" has the page template set to "page-content-wizard.php"
	 And the "page" "Test Twitter Feed Page" has the "gsdm_page_content_repeater_meta_box" "gsdm_content_repeater" set to ""
     And the "page" "Test Twitter Feed Page" has the "content" "Test Twitter Feed" added to the repeater

Scenario: Metabox Saves Data
	Given I go to the wordpress "content" post titled "Test Twitter Feed" to edit it
	When I fill in "gsdm_twitter_username" with "GSDMJobs"
	 And I fill in "gsdm_twitter_display_name" with "GSDM Jobs"
	 And I press "Update"
	Then the "gsdm_twitter_username" field should contain "GSDMJobs"
	 And the "gsdm_twitter_display_name" field should contain "GSDM Jobs"

Scenario: View Section Header on the Page
	Given I am on "/test-twitter-feed-page?fake_twitter=1"
	Then I should see "Section"
	 And I should see "Header"

Scenario: List of 5 elements displays on page
	Given I am on "/test-twitter-feed-page?fake_twitter=1"
	Then I should see 5 "#test-twitter-feed > ul > li" elements

Scenario: Custom Meta Displays On Screen
	Given the "content" "Test Twitter Feed" has the "gsdm_content_twitter_feed_meta_box" "gsdm_twitter_username" set to "GSDMJobs"
	 And the "content" "Test Twitter Feed" has the "gsdm_content_twitter_feed_meta_box" "gsdm_twitter_display_name" set to "GSD&M Jobs"
	Given I am on "/test-twitter-feed-page?fake_twitter=1&count=0" 
	Then I should see "GSD&M Jobs"
	 And I should see "Follow @GSDMJobs"

Scenario: 0 tweets doesn't bomb
	Given the "content" "Test Twitter Feed" has the "gsdm_content_twitter_feed_meta_box" "gsdm_twitter_username" set to "GSDM"
	 And the "content" "Test Twitter Feed" has the "gsdm_content_twitter_feed_meta_box" "gsdm_twitter_display_name" set to "GSD&M Jobs"
	Given I am on "/test-twitter-feed-page?fake_twitter=1&count=0"
	Then I should see "GSD&M Jobs"
	 And I should not see "30 women taking Austin"
	 And I should see "Follow @GSDM"
	When I follow "Follow @GSDM"
	Then I should be on "https://twitter.com/intent/follow?screen_name=gsdm"

Scenario: Entities are encoded
	Given I am on "/test-twitter-feed-page?fake_twitter=1"
	When I follow "@MyABJ"
	Then I should be on "https://twitter.com/MyABJ"

Scenario: Button below tweets allows users to follow @gsdmjobs
	Given I am on "/test-twitter-feed-page?fake_twitter=1"
	When I follow "Follow @GSDM"
	Then I should be on "https://twitter.com/intent/follow?screen_name=gsdm"

@javascript
Scenario: Display presents as a carousel and autoplays
	Given I am on "/test-twitter-feed-page?fake_twitter=1"
	When I press "View Slide 1"
	 And I wait for "1000"
	Then I should see "30 women taking Austin"
	 And I should not see "panel proposals and we need your vote!"
	When I wait for "6000"
	Then I should see "panel proposals and we need your vote!"
	 And I should not see "30 women taking Austin"

@javascript
Scenario: Carousel navigation displays expected tweets
	Given I am on "/test-twitter-feed-page?fake_twitter=1"
	When I press "View Slide 3"
	 And I wait for "1000"
	Then I should see "by lack of ideas"

