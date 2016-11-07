Feature: Newsroom Archive
As an SEO adviser I would like to have the ability to view posts by year/date so that search engines can index the old posts.
* link below the search bar
* points users to a page of posts categorized by year and month

Background:
	Given I have logged into wordpress as "admin" with the password "JTK17[07E"
	Given I have "news" with the title "Test News Post For Archive" and the slug "test-news-post-for-archive" and the date "2012-04-23 17:05:00" in wordpress
	Given I have "content" with the title "Post Grid Archive Test" and the slug "post-archive-test" in wordpress
	 And the "content" "Post Grid Archive Test" has the "gsdm_content_template_meta_box" "gsdm_content_type" set to "newsroom-grid"
	Given I have "page" with the title "News Archive Test Page" and the slug "news-archive-test-page" in wordpress
     And the "page" "News Archive Test Page" has the page template set to "page-content-wizard.php"
	 And the "page" "News Archive Test Page" has the "gsdm_page_content_repeater_meta_box" "gsdm_content_repeater" set to ""
     And the "page" "News Archive Test Page" has the "content" "Post Grid Archive Test" added to the repeater


@javascript
Scenario: Javascript Navigation Works As Expected
	Given I am on "/news-archive-test-page/"
	When I press "View Archived Posts"
	 And I wait for "1000"
	 And I press "2012"
	 And I wait for "1000"
	 And I prepare to load ajax content
	 And I press "April, 2012"
	 And I wait for ajax content to load
	Then I should see 1 ".main-post-grid li" element
	When I prepare to load ajax content
	 And I press "Show Latest Posts"
	 And I wait for ajax content to load
	Then I should see 8 ".main-post-grid li" elements



	









