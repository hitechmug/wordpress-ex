Feature: Newsroom Pagination
As an admin user, I would like users to have the ability to view more than the default 12 articles in the results 
so that they can view all relevant data related to their search.

Background:
	Given I have logged into wordpress as "admin" with the password "JTK17[07E"
	Given I have "news" with the title "Test News Post Pagination 1" and the slug "test-news-post-pagination-1" in wordpress
	 And I have "event" with the title "Test Event Post Pagination 1" and the slug "test-event-post-pagination-1" in wordpress
	 And I have "post" with the title "Test Blog Post Pagination 1" and the slug "test-blog-post-pagination-1" in wordpress
	 And I have "news" with the title "Test News Post Pagination 2" and the slug "test-news-post-pagination-2" in wordpress
	 And I have "event" with the title "Test Event Post Pagination 2" and the slug "test-event-post-pagination-2" in wordpress
	 And I have "post" with the title "Test Blog Post Pagination 2" and the slug "test-blog-post-pagination-2" in wordpress
	 And I have "news" with the title "Test News Post Pagination 3" and the slug "test-news-post-pagination-3" in wordpress
	 And I have "event" with the title "Test Event Post Pagination 3" and the slug "test-event-post-pagination-3" in wordpress
	 And I have "post" with the title "Test Blog Post Pagination 3" and the slug "test-blog-post-pagination-3" in wordpress
	 And I have "news" with the title "Test News Post Pagination 4" and the slug "test-news-post-pagination-4" in wordpress
	 And I have "event" with the title "Test Event Post Pagination 4" and the slug "test-event-post-pagination-4" in wordpress
	 And I have "post" with the title "Test Blog Post Pagination 4" and the slug "test-blog-post-pagination-4" in wordpress
	 And I have "news" with the title "Test News Post Pagination 5" and the slug "test-news-post-pagination-5" in wordpress
	 And I have "event" with the title "Test Event Post Pagination 5" and the slug "test-event-post-pagination-5" in wordpress
	 And I have "post" with the title "Test Blog Post Pagination 5" and the slug "test-blog-post-pagination-5" in wordpress
	Given I have "content" with the title "News Pagination Test" and the slug "news-pagination-test" in wordpress
	 And the "content" "News Pagination Test" has the "gsdm_content_template_meta_box" "gsdm_content_type" set to "newsroom-grid"
	Given I have "page" with the title "News Pagination Test Page" and the slug "news-pagination-test-page" in wordpress
     And the "page" "News Pagination Test Page" has the page template set to "page-content-wizard.php"
	 And the "page" "News Pagination Test Page" has the "gsdm_page_content_repeater_meta_box" "gsdm_content_repeater" set to ""
     And the "page" "News Pagination Test Page" has the "content" "News Pagination Test" added to the repeater

@javascript
Scenario: Results Have Less Than 12 Articles, No Pagination Button Present
	Given I have logged out of wordpress
	 And I am on "/news-pagination-test-page/"
	 And I wait for "1000"
	When I fill in "Search:" with "news post pagination"
	 And I prepare to load ajax content
	 And I manually submit the form
	 And I wait for ajax content to load
	Then I should see 5 ".main-post-grid li" elements
	 And the "button.load-more" element is not visible

@javascript
Scenario: Results Have More Than 12 Articles, Pagination Works As Expected
	Given I have logged out of wordpress
	 And I am on "/news-pagination-test-page/"
	 And I wait for "1000"
	 And I have maximized the browser window
	When I fill in "Search:" with "pagination"
	 And I prepare to load ajax content
	 And I manually submit the form
	 And I wait for ajax content to load
	 And I wait for "1000"
	Then I should see 12 ".main-post-grid li" elements
	 And I should see "More News"
	 And I should see "Test Blog Post Pagination 5"
	 And I should not see "Test Blog Post Pagination 1"
	When I scroll to the "button.load-more" element
	 And I wait for "1000"
	 And I press "More News"
	 And I wait for ajax to load more than "12" ".main-post-grid li" elements
	Then I should see 15 ".main-post-grid li" elements
	 And I should see "Test Blog Post Pagination 1"
	 And the "button.load-more" element is not visible


	









