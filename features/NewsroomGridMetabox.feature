Feature: Newsroom Grid Metabox
As an admin user, I would like the ability to add a grid of blog, news, and events posts to a page so that users can see all of our recent posts.
Show the most recent 12 posts as a grid list. Each post will contain:
- post type (blog, news, or event), 
- the date -- expressed in elapsed time, 
- article title, 
- article excerpt, 
- 'read more' link that directs users to the full article

Background:
	Given I have logged into wordpress as "admin" with the password "JTK17[07E"
	Given I have "news" with the title "Test News First Post Grid Article" and the slug "test-news-first-post-grid" in wordpress
	 And I have "event" with the title "Test Event First Post Grid Article" and the slug "test-event-first-post-grid" in wordpress
	 And I have "post" with the title "Test Blog First Post Grid Article" and the slug "test-blog-first-post-grid" in wordpress
	Given the "news" "Test News First Post Grid Article" has the excerpt "Hunt by meowing loudly at 5am next to human slave food dispenser"
	Given I have "content" with the title "Post Grid Test" and the slug "post-grid-test" in wordpress
	 And the "content" "Post Grid Test" has the "gsdm_content_template_meta_box" "gsdm_content_type" set to "newsroom-grid"
	Given I have "page" with the title "Post Grid Test Page" and the slug "post-grid-test-page" in wordpress
     And the "page" "Post Grid Test Page" has the page template set to "page-content-wizard.php"
	 And the "page" "Post Grid Test Page" has the "gsdm_page_content_repeater_meta_box" "gsdm_content_repeater" set to ""
     And the "page" "Post Grid Test Page" has the "content" "Post Grid Test" added to the repeater

@javascript
Scenario: Search Presents A Result
	Given I have logged out of wordpress
	 And I am on "/post-grid-test-page/"
	 And I wait for "1000"
	 And I prepare to load ajax content
	When I fill in "Search:" with "Test Blog First Post Grid Article"
	 And I manually submit the form
	 And I wait for ajax content to load
	Then I should see 1 ".main-post-grid li" element

@javascript
Scenario: Search Presents 0 Results
	Given I have logged out of wordpress
	 And I am on "/post-grid-test-page/"
	When I fill in "Search:" with "Blah"
	 And I prepare to load ajax content
	 And I manually submit the form
	 And I wait for ajax content to load
	Then I should see "No results found"

@javascript
Scenario: Search Empty String Presents Standard Page
	Given the "content" "Post Grid Test" has the "gsdm_content_newsroom_grid_meta_box" "gsdm_newsroom_grid_features" "0" "gsdm_newsroom_grid_feature_banner" set to "Chase red laser dot."
	 And the "content" "Post Grid Test" has the "gsdm_content_newsroom_grid_meta_box" "gsdm_newsroom_grid_features" "0" "gsdm_newsroom_grid_feature_id" set to the id for "news" "Test News First Post Grid Article"
	 And I have logged out of wordpress
	Given I am on "/post-grid-test-page/"
	 And I prepare to load ajax content
	When I manually submit the form
	 And I wait for ajax content to load
	Then I should see "Chase red laser dot."
	 And I should see "Test News First Post Grid Article"
	 And I should see "Test Event First Post Grid Article"
	 And I should see "Test Blog First Post Grid Article"

@javascript
Scenario: Search Reset Button Resets Results
	Given the "content" "Post Grid Test" has the "gsdm_content_newsroom_grid_meta_box" "gsdm_newsroom_grid_features" "0" "gsdm_newsroom_grid_feature_banner" set to "Chase red laser dot."
	 And the "content" "Post Grid Test" has the "gsdm_content_newsroom_grid_meta_box" "gsdm_newsroom_grid_features" "0" "gsdm_newsroom_grid_feature_id" set to the id for "news" "Test News First Post Grid Article"
	 And I have logged out of wordpress
	Given I am on "/post-grid-test-page/"
	 And I fill in "Search:" with "Blah"
	 And I prepare to load ajax content
	 And I manually submit the form
	 And I wait for ajax content to load
	Then I should see "No results found"
	 And I should see "Reset Results"
	When I prepare to load ajax content
	 And I press "Reset Results"
	 And I wait for ajax content to load
	Then I should see "Chase red laser dot."
	 And I should see "Test News First Post Grid Article"
	 And I should see "Test Event First Post Grid Article"
	 And I should see "Test Blog First Post Grid Article"

Scenario: Post Grid Metabox Text Inputs Saving
	Given I go to the wordpress "content" post titled "Post Grid Test" to edit it
	When I fill in "Banner Headline" with "Meowwwwww."
	 And I fill in "Post ID" with "1289"
	 And I press "Update"
	Then the "Banner Headline" field should contain "Meowwwwww."
	 And the "Post ID" field should contain "1289"

Scenario: Featured Content Appears On Page
	Given the "content" "Post Grid Test" has the "gsdm_content_newsroom_grid_meta_box" "gsdm_newsroom_grid_features" "0" "gsdm_newsroom_grid_feature_banner" set to "Chase red laser dot."
	 And the "content" "Post Grid Test" has the "gsdm_content_newsroom_grid_meta_box" "gsdm_newsroom_grid_features" "0" "gsdm_newsroom_grid_feature_id" set to the id for "news" "Test News First Post Grid Article"
	When I am on "/post-grid-test-page/"
	Then the ".featured-post-grid li:first-child .h2" element should contain "Chase red laser dot."
	 And the ".featured-post-grid li:first-child .h3" element should contain "Test News First Post Grid Article"
	When I follow "Read More: Test News First Post Grid Article" 
	Then I should be on "/news/test-news-first-post-grid/"

@javascript
Scenario: Post With Image Appears On Page
	Given I have uploaded the image "testPattern1.jpg" into the wordpress media library
	 And the "post" "Test Blog First Post Grid Article" has the featured image set to "testPattern1"
	Given I have logged out of wordpress
	 And I am on "/post-grid-test-page/"
	 And I wait for "1000"
	 And I prepare to load ajax content
	When I fill in "Search:" with "Test Blog First Post Grid Article"
	 And I manually submit the form
	 And I wait for ajax content to load
	Then the ".main-post-grid li:first-child .post-details-cta" element should have a css setting "background-image" that "contains" "testPattern1"

Scenario: Featured Content Doesn't Appear In Main Grid
	Given the "content" "Post Grid Test" has the "gsdm_content_newsroom_grid_meta_box" "gsdm_newsroom_grid_features" "0" "gsdm_newsroom_grid_feature_banner" set to "Chase red laser dot."
	 And the "content" "Post Grid Test" has the "gsdm_content_newsroom_grid_meta_box" "gsdm_newsroom_grid_features" "0" "gsdm_newsroom_grid_feature_id" set to the id for "news" "Test News First Post Grid Article"
	When I am on "/post-grid-test-page/"
	Then I should see "Test News First Post Grid Article"
	 And "0" of the ".main-post-grid li .h3" elements should contain "Test News First Post Grid Article"

Scenario: Post Grid Content Appears Correctly On Page 
	Given I am on "/post-grid-test-page"
	 Then I should see "Test News First Post Grid Article"
	  And I should see "Hunt by meowing loudly at 5am next to human slave food dispenser"
	  And I should see "Test Event First Post Grid Article"
	  And I should see "Test Blog First Post Grid Article"
	  And I should see "Blog"
	  And I should see "News"
	  And I should see "Event"
	 When I follow "Read More: Test News First Post Grid Article"
	 Then I should be on "/news/test-news-first-post-grid/"

