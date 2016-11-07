Feature: Client Custom Post Type
As an admin user, I would like to be able to add client logos to the site. 

Background:
	Given I have logged into wordpress as "admin" with the password "JTK17[07E"
	 And I have "client" with the title "Test Client" and the slug "test-logo-client" in wordpress
     And the "client" "Test Client" has the content ""
     And I do not have meta data "gsdm_client_logos_meta_box" for "client" titled "Test Client"


Scenario: Do we have meta boxes
     When I go to the wordpress "client" post titled "Test Client" to edit it    
	 Then I should see "Logos"

@javascript
Scenario: Display Image is an image meta box
	Given I have uploaded the image "testPattern1.jpg" into the wordpress media library
     When I go to the wordpress "client" post titled "Test Client" to edit it
      And I press "Choose Display Image"
	 Then I should see the wordpress choose image dialog

@javascript
Scenario: Hover Image is an image meta box
    Given I have uploaded the image "testPattern2.jpg" into the wordpress media library
	 When I go to the wordpress "client" post titled "Test Client" to edit it
      And I press "Choose Hover Image"
	 Then I should see the wordpress choose image dialog

@javascript
Scenario: Confirm that images for default and hover state can be successfully uploaded and viewed on the page
   Given I have uploaded the image "testPattern1.jpg" into the wordpress media library
     And I have uploaded the image "testPattern2.jpg" into the wordpress media library
     And the "attachment" titled "testPattern1" is attached as "gsdm_client_logos_meta_box" meta to the "client" titled "Test Client" as "gsdm_display_logo"
	 And the "attachment" titled "testPattern2" is attached as "gsdm_client_logos_meta_box" meta to the "client" titled "Test Client" as "gsdm_hover_logo"
	When I am on "/client/test-logo-client"
	Then the ".client-logo-display" element should have a css setting "background-image" that "contains" "testPattern1"
	 And the ".client-logo-hover" element should have a css setting "background-image" that "contains" "testPattern2"
	 And I "mouseOver" the element "#wpadminbar" and wait for "1000"
	 And the ".client-logo-hover" element should have a css setting "opacity" that "equals" "0" 
	 And I "mouseOver" the element ".client-logo-hover" and wait for "1000" I should see the css setting "opacity" change to "1"



	



