Feature: Content Shortcode Metabox
As a user I don't want to type shortcodes into the content editor. I want to be able to stop using shortcodes and replace with metaboxes.

Background: 
	Given I have logged into wordpress as "admin" with the password "JTK17[07E"
	Given I have "content" with the title "Test Content Metabox Post 1" and the slug "test-content-metabox-post-1" in wordpress
	 And the "content" "Test Content Metabox Post 1" has the content "Next level Vice freegan swag"
	Given I have "content" with the title "Test Content Metabox Post 2" and the slug "test-content-metabox-post-2" in wordpress
	 And the "content" "Test Content Metabox Post 2" has the content "Gastropub Godard ethical, cray sustainable photo"
	Given I have "content" with the title "Test Content Metabox Post 3" and the slug "test-content-metabox-post-3" in wordpress
	 And the "content" "Test Content Metabox Post 3" has the content "Intelligentsia Shoreditch trust fund"
	Given I have "page" with the title "Test Content Metabox Page" and the slug "test-content-metabox-page" in wordpress
	 And the "page" "Test Content Metabox Page" has the "gsdm_page_content_repeater_meta_box" "gsdm_content_repeater" set to ""
	 
@javascript
Scenario: Create a new repeater page in the admin and add content items in the repeater metabox using both ID and slug
	Given I go to the wordpress "page" post titled "Test Content Metabox Page" to edit it
	 And I select "Content Wizard" from "page_template"
	Then I should see "Content Item"
	When I select "Test Content Metabox Post 1" from the ".gsdm-repeater-item:last-child select" element
	 And I press "Update"
	Then I should see that the "content" "Test Content Metabox Post 1" option from the ".gsdm-repeater-item:last-child select" element is selected
	When I press the ".gsdm-repeater-item:last-child .gsdm-repeater-item-remove" element
	Then I should not see "Content Item:"
	When I press "Update"
	Then I should see that the "Select A Content Item" option from the ".gsdm-repeater-item:last-child select" element is selected
	
Scenario: View the wordpress page in the browser
	Given the "page" "Test Content Metabox Page" has the "gsdm_page_content_repeater_meta_box" "gsdm_content_repeater" set to "test-content-metabox-post-1,test-content-metabox-post-2,test-content-metabox-post-3"
	When I am on "/test-content-metabox-page"
	Then I should see "Next level Vice freegan swag"
	 And I should see "Gastropub Godard ethical, cray sustainable photo"
	 And I should see "Intelligentsia Shoreditch trust fund"
