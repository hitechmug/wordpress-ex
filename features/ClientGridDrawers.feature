Feature: Client Grid Drawer
As an admin user, I would like the ability to add a logo grid to the page so that, when the logo is clicked, it displays more details about the brand.

Background:
	Given I have logged into wordpress as "admin" with the password "JTK17[07E"
	Given I have "client" with the title "Test Client Logo1" and the slug "test-client-logo1" in wordpress
	 And I have uploaded the image "testPattern1.jpg" into the wordpress media library
	 And I have uploaded the image "testPattern2.jpg" into the wordpress media library
	 And the "client" "Test Client Logo1" has the "gsdm_client_video_meta_box" "gsdm_video_id" set to ""
	 And I have uploaded the image "employee-photo.png" into the wordpress media library
	 And the "attachment" titled "testPattern1" is attached as "gsdm_client_logos_meta_box" meta to the "client" titled "Test Client Logo1" as "gsdm_display_logo"
	 And the "attachment" titled "testPattern2" is attached as "gsdm_client_logos_meta_box" meta to the "client" titled "Test Client Logo1" as "gsdm_hover_logo"
	 And the "attachment" titled "employee-photo" is attached as "gsdm_client_infographic_meta_box" meta to the "client" titled "Test Client Logo1" as "gsdm_infographic_image"
	 And the "client" "Test Client Logo1" has the content "It's good to yell at people and tell people that you're from Tennesee, so that way you'll be safe."
	Given I have "client" with the title "Test Client Logo2" and the slug "test-client-logo2" in wordpress
	 And the "attachment" titled "testPattern1" is attached as "gsdm_client_logos_meta_box" meta to the "client" titled "Test Client Logo2" as "gsdm_display_logo"
	 And the "attachment" titled "testPattern2" is attached as "gsdm_client_logos_meta_box" meta to the "client" titled "Test Client Logo2" as "gsdm_hover_logo"
	 And the "client" "Test Client Logo2" has the content "Listen to the silence. And when the silence is deafening, you're in the center of your own universe."
	Given I have "content" with the title "Test Client Grid Content" and the slug "test-client-grid-content" in wordpress
	 And the "content" "Test Client Grid Content" has the "gsdm_content_template_meta_box" "gsdm_content_type" set to "client-grid"
	 And the "content" "Test Client Grid Content" has the "gsdm_content_client_grid_meta_box" "gsdm_client_grid_show_drawer" set to "on"
	Given I have "page" with the title "Test Client Grid Page" and the slug "test-client-grid" in wordpress
	 And the "page" "Test Client Grid Page" has the page template set to "page-content-wizard.php"
	 And the "page" "Test Client Grid Page" has the "gsdm_page_content_repeater_meta_box" "gsdm_content_repeater" set to ""
	 And the "page" "Test Client Grid Page" has the "content" "Test Client Grid Content" added to the repeater

@javascript
Scenario: Drawer is not active when checkbox is not checked
	Given I go to the wordpress "content" post titled "Test Client Grid Content" to edit it
	 And I uncheck "gsdm_client_grid_show_drawer"
	 And I press "Update"
	When I am on "/test-client-grid-content"
	Then I should not see an ".client-drawer" element 

@javascript
Scenario: Infographic upload image button 
	Given I go to the wordpress "client" post titled "Test Client Logo1" to edit it
	 Then I should see "Infographic"
	When I press "Choose Image"
	Then I should see the wordpress choose image dialog

Scenario: Video metabox saves
	Given I go to the wordpress "client" post titled "Test Client Logo1" to edit it
	 And I fill in "gsdm_video_id" with "123456"
	When I press "Update"
	Then the "gsdm_video_id" field should contain "123456"

@javascript
Scenario: Drawer displays expected content
	Given I am on "/test-client-grid"
	When I press "Test Client Logo1"
	 And I wait for "1000"
	Then I should see "It's good to yell at people and tell people that you're from Tennesee, so that way you'll be safe."
	 And the ".item-test-client-logo1 .client-drawer-infographic .infographic-image" element should have the attribute "style" that contains "employee-photo" 

@javascript
Scenario: Test (logo click opening drawer) and (close button closing drawer)
	When I am on "/test-client-grid"
	 And I press "Test Client Logo2"
	 And I wait for "1000"
	Then I should see "Listen to the silence. And when the silence is deafening, you're in the center of your own universe."
	When I press "close - Test Client Logo2"
	 And I wait for "1000"
	Then I should not see "Listen to the silence. And when the silence is deafening, you're in the center of your own universe."

@javascript
Scenario: Test (logo click opening drawer) and (same logo click closing drawer)
	When I am on "/test-client-grid"	
	 And I press "Test Client Logo1"
	 And I wait for "1000"
	Then I should see "It's good to yell at people and tell people that you're from Tennesee, so that way you'll be safe."
	When I press "Test Client Logo1"
	 And I wait for "1000"
	Then I should not see "It's good to yell at people and tell people that you're from Tennesee, so that way you'll be safe."

@javascript
Scenario: Test (logo click opening drawer) and (different logo click closing drawer)
	When I am on "/test-client-grid"	
	 And I press "Test Client Logo1"
	 And I wait for "1000"
	Then I should see "It's good to yell at people and tell people that you're from Tennesee, so that way you'll be safe."
	When I press "Test Client Logo2"
	 And I wait for "1000"
	Then I should not see "It's good to yell at people and tell people that you're from Tennesee, so that way you'll be safe."
	 And I should see "Listen to the silence. And when the silence is deafening, you're in the center of your own universe."

@javascript
Scenario: Unique Path For Client Logo Displays Open Drawer
	When I am on "/test-client-grid/#Test-Client-Logo1"
	 And I wait for "1000"
	Then I should see "good to yell at people and tell people"
	 And I should not see "Listen to the silence."

