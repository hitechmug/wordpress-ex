Feature: Employee Photo Grid Client Filter
As an admin user, I would like to be able to add a grid of employee photos to the website. 

Background:
	Given I have logged into wordpress as "admin" with the password "JTK17[07E"
	 And I have uploaded the image "employee-photo.png" into the wordpress media library
	Given the "client_filters" taxonomy has the tag "client1"
	 And the "client_filters" taxonomy has the tag "client2"
	Given the "contributor" user "user1" with the password "testuser1" exists
	 And the "contributor" user "user2" with the password "testuser2" exists
	 And the "contributor" user "user3" with the password "testuser3" exists
	 And the "contributor" user "user4" with the password "testuser4" exists
	 And the "contributor" user "user5" with the password "testuser5" exists
	 And the "contributor" user "user6" with the password "testuser6" exists
	Given the user "user1" has the image "employee-photo" added to the "gsdm_employee_photo_static" metadata
	 And the user "user2" has the image "employee-photo" added to the "gsdm_employee_photo_static" metadata
	 And the user "user3" has the image "employee-photo" added to the "gsdm_employee_photo_static" metadata
	 And the user "user4" has the image "employee-photo" added to the "gsdm_employee_photo_static" metadata
	 And the user "user5" has the image "employee-photo" added to the "gsdm_employee_photo_static" metadata
	 And the user "user6" has the image "employee-photo" added to the "gsdm_employee_photo_static" metadata
	Given the "gsdm_employee_photo_static" metadata for the user "admin" is not set
	Given the "gsdm_user_filter_client1" metadata for the user "user1" is not set
	 And the "gsdm_user_filter_client1" metadata for the user "user2" is not set
	 And the "gsdm_user_filter_client1" metadata for the user "user3" is not set
	 And the "gsdm_user_filter_client1" metadata for the user "user4" is not set
	 And the "gsdm_user_filter_client1" metadata for the user "user5" is not set
	 And the "gsdm_user_filter_client1" metadata for the user "user6" is not set
	 And the "gsdm_user_filter_client1" metadata for the user "admin" is not set
	Given the "gsdm_user_filter_client2" metadata for the user "user1" is not set
	 And the "gsdm_user_filter_client2" metadata for the user "user2" is not set
	 And the "gsdm_user_filter_client2" metadata for the user "user3" is not set
	 And the "gsdm_user_filter_client2" metadata for the user "user4" is not set
	 And the "gsdm_user_filter_client2" metadata for the user "user5" is not set
	 And the "gsdm_user_filter_client2" metadata for the user "user6" is not set
	 And the "gsdm_user_filter_client2" metadata for the user "admin" is not set
	Given I have "content" with the title "Employee Grid Client Test" and the slug "employee-grid-client-test" in wordpress
	 And the "content" "Employee Grid Client Test" has the "gsdm_content_template_meta_box" "gsdm_content_type" set to "employee-grid"
	Given I have "page" with the title "Employee Grid Client Test Page" and the slug "employee-grid-client-test-page" in wordpress
     And the "page" "Employee Grid Client Test Page" has the page template set to "page-content-wizard.php"
	 And the "page" "Employee Grid Client Test Page" has the "gsdm_page_content_repeater_meta_box" "gsdm_content_repeater" set to ""
     And the "page" "Employee Grid Client Test Page" has the "content" "Employee Grid Client Test" added to the repeater

Scenario: User Profile Client Category Selections
	Given I am on "/wp-admin/users.php"
	 And I follow "user1"
	Then I should see "Client Categories"
	When I check "gsdm_user_filter_client1"	
	 And I press "Update"
	Then the checkbox "gsdm_user_filter_client1" should be checked
	When I uncheck "gsdm_user_filter_client1"
	 And I press "Update"
	Then the checkbox "gsdm_user_filter_client1" should be unchecked

Scenario: Content Client Filters Selection
	Given I go to the wordpress "content" post titled "Employee Grid Client Test" to edit it
	When I select "client1" from "gsdm_employee_grid_filter"
	 And I press "Update"
	Then I should see that the "client1" option from "gsdm_employee_grid_filter" is selected

Scenario: View 4 Client Users and 1 Generic User In The Grid
	Given the "gsdm_user_filter_client1" metadata for the user "user2" is set to "on"
	 And the "gsdm_user_filter_client1" metadata for the user "user3" is set to "on"
	 And the "gsdm_user_filter_client1" metadata for the user "user4" is set to "on"
	 And the "gsdm_user_filter_client1" metadata for the user "user5" is set to "on"
	 And the "gsdm_employee_photo_static" metadata for the user "user6" is not set
	Given the "content" "Employee Grid Client Test" has the "gsdm_content_employee_grid_meta_box" "gsdm_employee_grid_filter" set to "client1"
	Given I am on "/employee-grid-client-test-page"
	Then I should see 5 ".employee-grid li" elements
	 And the ".employee-grid li:last-child img" element should have the attribute "alt" that contains "user1"

Scenario: View 5 Homepage Users and 0 Generic Users In The Grid
	Given the "gsdm_user_filter_client1" metadata for the user "user2" is set to "on"
	 And the "gsdm_user_filter_client1" metadata for the user "user3" is set to "on"
	 And the "gsdm_user_filter_client1" metadata for the user "user4" is set to "on"
	 And the "gsdm_user_filter_client1" metadata for the user "user5" is set to "on"
	 And the "gsdm_user_filter_client1" metadata for the user "user6" is set to "on"
	Given the "content" "Employee Grid Client Test" has the "gsdm_content_employee_grid_meta_box" "gsdm_employee_grid_filter" set to "client1"
	Given I am on "/employee-grid-client-test-page"
	Then I should see 5 ".employee-grid li" elements
	 And the ".employee-grid li:nth-child(1) img" element should have the attribute "alt" that does not contain "user1"
	 And the ".employee-grid li:nth-child(2) img" element should have the attribute "alt" that does not contain "user1"
	 And the ".employee-grid li:nth-child(3) img" element should have the attribute "alt" that does not contain "user1"
	 And the ".employee-grid li:nth-child(4) img" element should have the attribute "alt" that does not contain "user1"
	 And the ".employee-grid li:nth-child(5) img" element should have the attribute "alt" that does not contain "user1"



	

