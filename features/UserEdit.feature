Feature: User Edit - Non-Admin Role Restrictions

As an admin user, I would like the ability to include animated photos when users hover over the image so that we can add some interest and personality to the employee photo display.
#tested in EmployeePhotGrid.feature
As the CMS manager, I would like for ONLY users with administrator-level access to be able to make modifications to the employee photos, client filters, and instagram username/ability to contribute to the feed.
* All users can make standard WP changes to their user profile (change password, display name, etc.)
* Only users with admin access can update the GSDM customized pieces.

Background:
	Given I have logged into wordpress as "admin" with the password "JTK17[07E" 	
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
	 And I have uploaded the image "employee-photo.png" into the wordpress media library
	 And I am on "/wp-admin/users.php"
	 And I follow "user1"
	Then I should see "Remove Image"
	When I press "Remove Headshot Photo"
	 And I press "Update"
	Then I should not see "Remove Headshot Image"

@javascript
Scenario: Employee Static Photo Image Removing
	Given the user "user1" has the image "employee-photo" added to the "gsdm_employee_photo_static" metadata
	 And I have uploaded the image "employee-photo.png" into the wordpress media library
	 And I am on "/wp-admin/users.php"
	 And I follow "user1"
	Then I should see "Remove Image"
	When I press "Remove Static Employee Photo"
	 And I press "Update"
	Then I should not see "Remove Image"

@javascript
Scenario: Employee Animated Photo Image Removing
	Given the user "user1" has the image "employee-photo" added to the "gsdm_employee_photo_animated" metadata
	 And I have uploaded the image "employee-headshot.jpg" into the wordpress media library
	 And I am on "/wp-admin/users.php"
	 And I follow "user1"
	Then I should see "Remove Image"
	When I press "Remove Animated Employee Photo"
	 And I press "Update"
	Then I should not see "Remove Image"


