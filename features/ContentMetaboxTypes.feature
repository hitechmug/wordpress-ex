Feature: Content Metabox Types
As an admin user I would like to only see the relevant type of meta box corresponding to the post type so that I enter content correctly.

Background: 
	Given I have logged into wordpress as "admin" with the password "JTK17[07E"
	Given I have "content" with the title "Test Content Types" and the slug "test-content-types" in wordpress
	 And the "content" "Test Content Types" has the "gsdm_content_template_meta_box" "gsdm_content_type" set to "text"
	 And the "content" "Test Content Types" has the "gsdm_content_template_meta_box" "gsdm_content_remove_formatting" set to ""
	 And the "content" "Test Content Types" has the "gsdm_content_template_meta_box" "gsdm_content_color_invert" set to ""
	Given I have "page" with the title "Test Content Types" and the slug "test-content-types-page" in wordpress
	 And the "page" "Test Content Types" has the page template set to "page-content-wizard.php"
	 And the "page" "Test Content Types" has the "gsdm_page_content_repeater_meta_box" "gsdm_content_repeater" set to ""
	 And the "page" "Test Content Types" has the "content" "Test Content Types" added to the repeater

@javascript
Scenario: Correct meta boxes display for image
	Given I am on "/wp-admin/post-new.php?post_type=content"
	When I select "image" from "gsdm_content_type"
	Then I should see a "#gsdm_content_image_meta_box" element
	 And I should see "Image" in the "#gsdm_content_image_meta_box h3>span" element
	 And the "#postdivrich" element is visible
	 But the "#gsdm_content_video_meta_box" element is not visible

@javascript
Scenario: Correct meta boxes display for video
	Given I am on "/wp-admin/post-new.php?post_type=content"
	When I select "video" from "gsdm_content_type"
	Then I should see a "#gsdm_content_video_meta_box" element
	 And the "#postdivrich" element is visible

@javascript	
Scenario: Correct meta boxes display for text
	Given I am on "/wp-admin/post-new.php?post_type=content"
	When I select "text" from "gsdm_content_type"
	Then I should see a "#postdivrich" element
	 But the "#gsdm_content_image_meta_box" element is not visible
	 And the "#gsdm_content_video_meta_box" element is not visible

Scenario: Checkbox Testing: Remove Formatting Saving
	Given I go to the wordpress "content" post titled "Test Content Types" to edit it
	When I check "gsdm_content_remove_formatting"
	 And I press "Update"
	Then the checkbox "gsdm_content_remove_formatting" should be checked
	When I uncheck "gsdm_content_remove_formatting"
	 And I press "Update"
	Then the checkbox "gsdm_content_remove_formatting" should not be checked

Scenario: Checkbox Testing: Invert Color Scheme Saving
	Given I go to the wordpress "content" post titled "Test Content Types" to edit it
	When I check "gsdm_content_color_invert"
	 And I press "Update"
	Then the checkbox "gsdm_content_color_invert" should be checked
	When I uncheck "gsdm_content_color_invert"
	 And I press "Update"
	Then the checkbox "gsdm_content_color_invert" should not be checked

@javascript
Scenario: Site Displays Text Content With Inverted Colors
	Given the "content" "Test Content Types" has the "gsdm_content_template_meta_box" "gsdm_content_color_invert" set to "on"
	When I am on "/test-content-types-page"
	Then the ".content-text:last-child > .content-text-body" element should have the attribute "class" that contains "inverted"

Scenario: Site Displays Text Content With Formatting Removed
	Given the "content" "Test Content Types" has the "gsdm_content_template_meta_box" "gsdm_content_remove_formatting" set to "on"
	When I am on "/test-content-types-page"
	Then I should see 0 ".content-text:last-child > .content-text-body" elements
