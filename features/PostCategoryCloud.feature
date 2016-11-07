Feature: Post Category Cloud
As a user, I would like the ability to see all of the categories the article is categorized in
* Display a list of all the related categories.
* Link to search results of all those categories.

Background:
	Given I have logged into wordpress as "admin" with the password "JTK17[07E"
	 And I have "post" with the title "Test Blog Post" and the slug "test-blog-post" in wordpress
	 And I have "event" with the title "Test Event Post" and the slug "test-event-post" in wordpress
	 And I have "news" with the title "Test News Post" and the slug "test-news-post" in wordpress
	Given the "category" taxonomy has the tag "testCategory1"
	 And the "category" taxonomy has the tag "testCategory2"
	Given the "post" "Test Blog Post" has the taxonomy "category" set to "testCategory1"
	 And the "event" "Test Event Post" has the taxonomy "category" set to "testCategory1"
	 And the "news" "Test News Post" has the taxonomy "category" set to "testCategory1"
	Given I have "content" with the title "Post Grid Test" and the slug "post-grid-test" in wordpress
	 And the "content" "Post Grid Test" has the "gsdm_content_template_meta_box" "gsdm_content_type" set to "newsroom-grid"
	Given I have "page" with the title "Newsroom" and the slug "newsroom" in wordpress
	 And the "page" "Newsroom" has the page template set to "page-content-wizard.php"
	 And the "page" "Newsroom" has the "gsdm_page_content_repeater_meta_box" "gsdm_content_repeater" set to ""
     And the "page" "Newsroom" has the "content" "Post Grid Test" added to the repeater

Scenario: View category cloud within blog posts and click  link
	Given I am on "/test-blog-post"
	Then I should see "testCategory1"
	When I follow "testCategory1"
	Then I should see 3 ".main-post-grid > li" elements

Scenario: View category cloud within event post and click link
	Given I am on "/news/test-news-post"
	Then I should see "testCategory1"
	When I follow "testCategory1"
	Then I should see 3 ".main-post-grid > li" elements

Scenario: View category cloud within news post and click link
	Given I am on "/event/test-event-post"
	Then I should see "testCategory1"
	When I follow "testCategory1"
	Then I should see 3 ".main-post-grid > li" elements

Scenario: Handle multiple category selections
	Given the "post" "Test Blog Post" has the term "testCategory2" added to the taxonomy "category"
	Given I am on "/test-blog-post"
	Then I should see "testCategory1"
	 And I should see "testCategory2"
	When I follow "testCategory2"
	Then I should see 1 ".main-post-grid > li" elements

Scenario: Display 0 results when no posts are in that category
	Given I am on "/newsroom/?categories=1234"
	Then I should see "No results found."






