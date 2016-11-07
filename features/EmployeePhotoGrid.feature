Feature: Employee Photo Grid
As an admin user, I would like to be able to add a grid of employee photos to the website. 
As an admin user, I would like the ability to include animated photos when users hover over the image so that we can add some interest and personality to the employee photo display.
As the CMS manager, I would like for ONLY users with administrator-level access to be able to make modifications to the employee photos, client filters, and instagram username/ability to contribute to the feed.

Background:
	Given I have logged into wordpress as "admin" with the password "JTK17[07E"
	 And I have uploaded the image "employee-photo.png" into the wordpress media library	 
	Given the "contributor" user "user1" with the password "testuser1" exists
	 And the "subscriber" user "user2" with the password "testuser2" exists
	 And the "author" user "user3" with the password "testuser3" exists
	 And the "editor" user "user4" with the password "testuser4" exists
	 And the "contributor" user "user5" with the password "testuser5" exists
	 And the "contributor" user "user6" with the password "testuser6" exists
	 Given the "gsdm_employee_headshot" metadata for the user "user1" is not set
	 And the "gsdm_employee_headshot" metadata for the user "user2" is not set
	 And the "gsdm_employee_headshot" metadata for the user "user3" is not set
	 And the "gsdm_employee_headshot" metadata for the user "user4" is not set
	 And the "gsdm_employee_headshot" metadata for the user "user5" is not set
	 And the "gsdm_employee_headshot" metadata for the user "user6" is not set
	 And the "gsdm_employee_headshot" metadata for the user "admin" is not set
	Given the "gsdm_employee_photo_static" metadata for the user "user1" is not set
	 And the "gsdm_employee_photo_static" metadata for the user "user2" is not set
	 And the "gsdm_employee_photo_static" metadata for the user "user3" is not set
	 And the "gsdm_employee_photo_static" metadata for the user "user4" is not set
	 And the "gsdm_employee_photo_static" metadata for the user "user5" is not set
	 And the "gsdm_employee_photo_static" metadata for the user "user6" is not set
	 And the "gsdm_employee_photo_static" metadata for the user "admin" is not set
	Given the "gsdm_employee_photo_animated" metadata for the user "user1" is not set
	 And the "gsdm_employee_photo_animated" metadata for the user "user2" is not set
	 And the "gsdm_employee_photo_animated" metadata for the user "user3" is not set
	 And the "gsdm_employee_photo_animated" metadata for the user "user4" is not set
	 And the "gsdm_employee_photo_animated" metadata for the user "user5" is not set
	 And the "gsdm_employee_photo_animated" metadata for the user "user6" is not set
	 And the "gsdm_employee_photo_animated" metadata for the user "admin" is not set
	Given the "gsdm_user_filter_homepage" metadata for the user "user1" is set to ""
	 And the "gsdm_user_filter_homepage" metadata for the user "user2" is set to ""
	 And the "gsdm_user_filter_homepage" metadata for the user "user3" is set to ""
	 And the "gsdm_user_filter_homepage" metadata for the user "user4" is set to ""
	 And the "gsdm_user_filter_homepage" metadata for the user "user5" is set to ""
	 And the "gsdm_user_filter_homepage" metadata for the user "user6" is set to ""
	 And the "gsdm_user_filter_homepage" metadata for the user "admin" is set to ""
	Given I have "content" with the title "Employee Grid Test" and the slug "employee-grid-test" in wordpress
	 And the "content" "Employee Grid Test" has the "gsdm_content_template_meta_box" "gsdm_content_type" set to "employee-grid"
	 And the "content" "Employee Grid Test" has the "gsdm_content_section_header_meta_box" "gsdm_section_header_line_1" set to "Section"
	 And the "content" "Employee Grid Test" has the "gsdm_content_section_header_meta_box" "gsdm_section_header_line_2" set to "Header"
	Given I have "page" with the title "Employee Grid Test Page" and the slug "employee-grid-test-page" in wordpress
     And the "page" "Employee Grid Test Page" has the page template set to "page-content-wizard.php"
	 And the "page" "Employee Grid Test Page" has the "gsdm_page_content_repeater_meta_box" "gsdm_content_repeater" set to ""
     And the "page" "Employee Grid Test Page" has the "content" "Employee Grid Test" added to the repeater
	   	 
Scenario: Contributor cannot see Employee Photo Image or Employee Headshot Buttons
	Given I have logged out of wordpress
	 And I have logged into wordpress as "user1" with the password "testuser1"
	 And I am on "/wp-admin/profile.php"	 
	 Then I should not see "Employee Headshot"
	 And I should not see "Employee Photos"
	 And I should not see "Client Categories"
	 And I should not see "Instagram Username"

Scenario: Subscriber cannot see Employee Photo Image or Employee Headshot Buttons
	Given I have logged out of wordpress
	 And I have logged into wordpress as "user2" with the password "testuser2"
	 And I am on "/wp-admin/profile.php"	 
	 Then I should not see "Employee Headshot"
	 And I should not see "Employee Photos"
	 And I should not see "Client Categories"
	 And I should not see "Instagram Username"

Scenario: Author cannot see Employee Photo Image or Employee Headshot Buttons
	Given I have logged out of wordpress
	 And I have logged into wordpress as "user3" with the password "testuser3"
	 And I am on "/wp-admin/profile.php"	 
	 Then I should not see "Employee Headshot"
	 And I should not see "Employee Photos"
	 And I should not see "Client Categories"
	 And I should not see "Instagram Username"

Scenario: Editor cannot see Employee Photo Image or Employee Headshot Buttons
	Given I have logged out of wordpress
	 And I have logged into wordpress as "user4" with the password "testuser4"
	 And I am on "/wp-admin/profile.php"	 
	 Then I should not see "Employee Headshot"
	 And I should not see "Employee Photos"
	 And I should not see "Edit Client Categories"
	 And I should not see "Instagram Username"

@javascript
Scenario: Employee Headshot Photo Image Button
	Given I am on "/wp-admin/users.php"
	 And I follow "user1"
	Then I should see "Employee Headshot"
	When I press "Choose Headshot Photo"
	Then I should see the wordpress choose image dialog

@javascript
Scenario: Static Employee Photo Image Button
	Given I am on "/wp-admin/users.php"
	 And I follow "user1"
	Then I should see "Employee Photos"
	When I press "Choose Static Employee Photo"
	Then I should see the wordpress choose image dialog

@javascript
Scenario: Animated Employee Photo Image Button
	Given I am on "/wp-admin/users.php"
	 And I follow "user1"
	Then I should see "Employee Photos"
	When I press "Choose Animated Employee Photo"
	Then I should see the wordpress choose image dialog

@javascript
Scenario: Employee Headshot Image Removing
	Given the user "user1" has the image "employee-headshot" added to the "gsdm_employee_headshot" metadata
	 And I have uploaded the image "employee-headshot.jpg" into the wordpress media library
	 And I am on "/wp-admin/users.php"
	 And I follow "user1"
	Then I should see "Remove Image"
	When I press "Remove Headshot Photo"
	 And I press "Update"
	Then I should not see "Remove Headshot Image"

@javascript
Scenario: Employee Static Photo Image Removing
	Given the user "user1" has the image "employee-photo" added to the "gsdm_employee_photo_static" metadata
	 And I am on "/wp-admin/users.php"
	 And I follow "user1"
	Then I should see "Remove Image"
	When I press "Remove Static Employee Photo"
	 And I press "Update"
	Then I should not see "Remove Image"

@javascript
Scenario: Employee Animated Photo Image Removing
	Given the user "user1" has the image "employee-photo" added to the "gsdm_employee_photo_animated" metadata
	 And I am on "/wp-admin/users.php"
	 And I follow "user1"
	Then I should see "Remove Image"
	When I press "Remove Animated Employee Photo"
	 And I press "Update"
	Then I should not see "Remove Image"

Scenario: User Profile Homepage Category Selection
	Given I am on "/wp-admin/users.php"
	 And I follow "user1"
	When I check "gsdm_user_filter_homepage"	
	 And I press "Update"
	Then the checkbox "gsdm_user_filter_homepage" should be checked
	When I uncheck "gsdm_user_filter_homepage"
	 And I press "Update"
	Then the checkbox "gsdm_user_filter_homepage" should be unchecked

Scenario: Content Homepage Filter Selection
	Given I go to the wordpress "content" post titled "Employee Grid Test" to edit it
	When I select "homepage" from "gsdm_employee_grid_filter" 
	 And I press "Update"
	Then I should see that the "homepage" option from "gsdm_employee_grid_filter" is selected

Scenario: Section Header Writes To Page
	Given I am on "/employee-grid-test-page"
	Then I should see "Section"
	 And I should see "Header"

Scenario: View 0 Generic Users In The Grid
	Given I am on "/employee-grid-test-page"
	Then I should see 0 ".employee-grid li" elements

@javascript
Scenario: View 4 Generic Users In The Grid
	Given the user "user1" has the image "employee-photo" added to the "gsdm_employee_photo_static" metadata
	Given the user "user2" has the image "employee-photo" added to the "gsdm_employee_photo_static" metadata
	Given the user "user3" has the image "employee-photo" added to the "gsdm_employee_photo_static" metadata
	Given the user "user4" has the image "employee-photo" added to the "gsdm_employee_photo_static" metadata
	Given I am on "/employee-grid-test-page"
	 And I maximize the browser window size
	Then I should see 4 ".employee-grid li" elements

@javascript
Scenario: View 5 Generic Users In The Grid
	Given the user "user1" has the image "employee-photo" added to the "gsdm_employee_photo_static" metadata
	Given the user "user2" has the image "employee-photo" added to the "gsdm_employee_photo_static" metadata
	Given the user "user3" has the image "employee-photo" added to the "gsdm_employee_photo_static" metadata
	Given the user "user4" has the image "employee-photo" added to the "gsdm_employee_photo_static" metadata
	Given the user "user5" has the image "employee-photo" added to the "gsdm_employee_photo_static" metadata
	Given I am on "/employee-grid-test-page"
	 And I maximize the browser window size
	Then I should see 5 ".employee-grid li" elements

@javascript
Scenario: View 4 Homepage Users In The Grid
	Given the user "user1" has the image "employee-photo" added to the "gsdm_employee_photo_static" metadata
	 And the "gsdm_user_filter_homepage" metadata for the user "user1" is set to "on"
	Given the user "user2" has the image "employee-photo" added to the "gsdm_employee_photo_static" metadata
	 And the "gsdm_user_filter_homepage" metadata for the user "user2" is set to "on"
	Given the user "user3" has the image "employee-photo" added to the "gsdm_employee_photo_static" metadata
	 And the "gsdm_user_filter_homepage" metadata for the user "user3" is set to "on"
	Given the user "user4" has the image "employee-photo" added to the "gsdm_employee_photo_static" metadata
	 And the "gsdm_user_filter_homepage" metadata for the user "user4" is set to "on"
	Given the "content" "Employee Grid Test" has the "gsdm_content_employee_grid_meta_box" "gsdm_employee_grid_filter" set to "homepage"
	Given I am on "/employee-grid-test-page"
	 And I maximize the browser window size
	Then I should see 4 ".employee-grid li" elements

@javascript
Scenario: View 4 Homepage Users and 1 Generic User In The Grid
	Given the user "user1" has the image "employee-photo" added to the "gsdm_employee_photo_static" metadata
	Given the user "user2" has the image "employee-photo" added to the "gsdm_employee_photo_static" metadata
	 And the "gsdm_user_filter_homepage" metadata for the user "user2" is set to "on"
	Given the user "user3" has the image "employee-photo" added to the "gsdm_employee_photo_static" metadata
	 And the "gsdm_user_filter_homepage" metadata for the user "user3" is set to "on"
	Given the user "user4" has the image "employee-photo" added to the "gsdm_employee_photo_static" metadata
	 And the "gsdm_user_filter_homepage" metadata for the user "user4" is set to "on"
	Given the user "user5" has the image "employee-photo" added to the "gsdm_employee_photo_static" metadata
	 And the "gsdm_user_filter_homepage" metadata for the user "user5" is set to "on"
	Given the "content" "Employee Grid Test" has the "gsdm_content_employee_grid_meta_box" "gsdm_employee_grid_filter" set to "homepage"
	Given I am on "/employee-grid-test-page"
	And I maximize the browser window size
	Then I should see 5 ".employee-grid li" elements
	 And the ".employee-grid li.grid-item-5 img" element should have the attribute "alt" that contains "user1"

@javascript
Scenario: View 5 Homepage Users and 0 Generic Users In The Grid
	Given the user "user1" has the image "employee-photo" added to the "gsdm_employee_photo_static" metadata
	Given the user "user2" has the image "employee-photo" added to the "gsdm_employee_photo_static" metadata
	 And the "gsdm_user_filter_homepage" metadata for the user "user2" is set to "on"
	Given the user "user3" has the image "employee-photo" added to the "gsdm_employee_photo_static" metadata
	 And the "gsdm_user_filter_homepage" metadata for the user "user3" is set to "on"
	Given the user "user4" has the image "employee-photo" added to the "gsdm_employee_photo_static" metadata
	 And the "gsdm_user_filter_homepage" metadata for the user "user4" is set to "on"
	Given the user "user5" has the image "employee-photo" added to the "gsdm_employee_photo_static" metadata
	 And the "gsdm_user_filter_homepage" metadata for the user "user5" is set to "on"
	Given the user "user6" has the image "employee-photo" added to the "gsdm_employee_photo_static" metadata
	 And the "gsdm_user_filter_homepage" metadata for the user "user6" is set to "on"
	Given the "content" "Employee Grid Test" has the "gsdm_content_employee_grid_meta_box" "gsdm_employee_grid_filter" set to "homepage"
	Given I am on "/employee-grid-test-page"
	When I maximize the browser window size
	Then I should see 5 ".employee-grid li" elements
	 And I should see 0 ".employee-grid li.user1" elements


