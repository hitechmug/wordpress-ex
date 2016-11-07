Feature: Page Grid Metabox
As an admin user I would like to create a grid of buttons on the page that link to featured pages. 
I would like to enter custom headers, images, and paths for each of the buttons. 
I would like to be able to sort those grid items.
I would like to be able to pull content from news/events/blog posts directly from their page content.

Background:
	Given I have logged into wordpress as "admin" with the password "JTK17[07E"
	 And I have uploaded the image "testPattern1.jpg" into the wordpress media library
	Given I have "content" with the title "Page Grid Test" and the slug "page-grid-test" in wordpress
	 And the "content" "Page Grid Test" has the "gsdm_content_page_grid_meta_box" "gsdm_page_grid_repeater" set to ""
	 And the "content" "Page Grid Test" has the "gsdm_content_page_grid_meta_box" "gsdm_page_grid_results_button" set to ""
	 And the "content" "Page Grid Test" has the "gsdm_content_template_meta_box" "gsdm_content_type" set to "page-grid"
	 And the "content" "Page Grid Test" has the "gsdm_content_section_header_meta_box" "gsdm_section_header_line_1" set to "Section"
	 And the "content" "Page Grid Test" has the "gsdm_content_section_header_meta_box" "gsdm_section_header_line_2" set to "Header"
	Given I have "page" with the title "Test Work Page" and the slug "test-work-page" in wordpress
	 And the "client_filters" taxonomy has the tag "client1"
	 And the "page" "Test Work Page" has the taxonomy "client_filters" set to "client1"
	Given I have "news" with the title "Test News Post Page Grid" and the slug "test-news-post-page-grid" in wordpress
	Given I have "page" with the title "Page Grid Test Page" and the slug "page-grid-test-page" in wordpress
     And the "page" "Page Grid Test Page" has the page template set to "page-content-wizard.php"
	 And the "page" "Page Grid Test Page" has the "gsdm_page_content_repeater_meta_box" "gsdm_content_repeater" set to ""
     And the "page" "Page Grid Test Page" has the "content" "Page Grid Test" added to the repeater

@javascript
Scenario: Page Grid Metabox Image Button
      Given I go to the wordpress "content" post titled "Page Grid Test" to edit it
       And I select "Page Grid" from "gsdm_content_type"
       When I press "Add A Grid Item"
	    And I press the ".gsdm-page-grid-item:last-child .gsdm-meta-accordion-closer" element
	    And I press the ".gsdm-page-grid-item:last-child .gsdm-meta-choose-item.meta-image.button" element
	   Then I should see the wordpress choose image dialog

@javascript
Scenario: Page Grid Metabox Text Inputs Saving
      Given I go to the wordpress "content" post titled "Page Grid Test" to edit it
	   And I fill in "gsdm_page_grid_posts_per_page" with "2"
	   And I check "Add Custom Button At End Of Results:"
      When I press "Add A Grid Item"
	   And I fill in the ".gsdm-page-grid-item:last-child .gsdm-meta-item-title" element with "Item 1"
	   And I press the ".gsdm-page-grid-item:last-child .gsdm-meta-accordion-closer" element
	   And I select "Home Page" from the ".gsdm-page-grid-item:last-child .gsdm-meta-grid-page-id" element
	   And I fill in the ".gsdm-page-grid-item:last-child .gsdm-meta-grid-page-url" element with "http://www.google.com"
       And I press "Update"
	Then the "gsdm_page_grid_posts_per_page" field should contain "2"
	 And the "Add Custom Button At End Of Results:" checkbox should be checked
	When I press the ".gsdm-page-grid-item:last-child .gsdm-meta-accordion-closer" element
    Then the ".gsdm-page-grid-item:last-child .gsdm-meta-item-title" element should have the attribute "value" that contains "Item 1"
     And I should see that the "page" "Home Page" option from the ".gsdm-page-grid-item:last-child .gsdm-meta-grid-page-id" element is selected 
	 And the ".gsdm-page-grid-item:last-child .gsdm-meta-grid-page-url" element should have the attribute "value" that contains "http://www.google.com"
    When I press the ".gsdm-page-grid-item:last-child .gsdm-repeater-item-remove" element
	 And I uncheck "Add Custom Button At End Of Results:"
    Then I should not see "Item 1"
    When I press "Update"
    Then I should not see "Item 1"
	And the "Add Custom Button At End Of Results:" checkbox should not be checked

@javascript
Scenario: Page Grid Content Appears Correctly On Page 
	Given the "content" "Page Grid Test" has the page grid repeater item titled "Repeater 1" and the image "testPattern1" and the id for "page" "Test Work Page" 
	 And the "content" "Page Grid Test" has the page grid repeater item titled "Repeater 2" and the image "testPattern2" and the id for "news" "Test News Post Page Grid"
	 And the "content" "Page Grid Test" has the page grid repeater item titled "Repeater 3" and the image "testPattern1" and the id for "page" "Test Work Page"
	 And the "content" "Page Grid Test" has the page grid repeater item titled "Repeater 4" and the image "testPattern2" and the id for "page" "Test Work Page" 
	 And the "content" "Page Grid Test" has the "gsdm_content_page_grid_meta_box" "gsdm_page_grid_posts_per_page" set to "2"
	 And the "content" "Page Grid Test" has the "gsdm_content_page_grid_meta_box" "gsdm_page_grid_results_button" set to ""
	When I am on "/page-grid-test-page"
	 And I wait for "1000"
	Then I should see "Section"
	 And I should see "Header"
	Then the ".page-grid-item-1 > a" element should have a css setting "background-image" that "contains" "testPattern1"
	 And I should see "Repeater 1"
	Then the ".page-grid-item-2 > a" element should have a css setting "background-image" that "contains" "testPattern2"
	 And I should see "News"
	 And I should see "Read More"
	 And I should see "Test News Post Page Grid"
	Then I should not see "Repeater 3"
	 And I should not see "Repeater 4"
	When I "mouseOver" the element ".page-grid-item-1" and wait for "1000"
	Then I should see "client1"
	When I press "View More"
	 And I wait for "500"
	Then I should see "Repeater 3"
	 And I should see "Repeater 4"
	 And I should not see "Go To Newsroom"
	 And I should not see "Go To Work"
	When I follow "View client1: Repeater 1"
	 And I wait for "1000"
	Then I should be on "/test-work-page/"

@javascript
Scenario: Page Grid Content Appears Correctly With External URL 
	Given the "content" "Page Grid Test" has the page grid repeater item titled "Repeater 1" and the image "testPattern1" and the url "https://www.linkedin.com/" 	 
	When I am on "/page-grid-test-page"
	 And I wait for "1000"
	Then I should see "Repeater 1"
	When I follow "View: Repeater 1"
	 And I switch tabs
	Then I should be on "https://www.linkedin.com/"

@javascript
Scenario: Button At End Of Results Displays 
	Given the "content" "Page Grid Test" has the page grid repeater item titled "Repeater 1" and the image "testPattern1" and the id for "page" "Test Work Page" 
	 And the "content" "Page Grid Test" has the page grid repeater item titled "Repeater 2" and the image "testPattern2" and the id for "news" "Test News Post Page Grid"
	 And the "content" "Page Grid Test" has the "gsdm_content_page_grid_meta_box" "gsdm_page_grid_posts_per_page" set to "2"
	 And the "content" "Page Grid Test" has the "gsdm_content_page_grid_meta_box" "gsdm_page_grid_results_button" set to "on"
	When I am on "/page-grid-test-page"
	 And I wait for "1000"
	Then I should see "Go To Newsroom"
	 And I should see "Go To Work"

