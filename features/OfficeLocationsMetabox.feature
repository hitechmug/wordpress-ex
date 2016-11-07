Feature: Office Locations Metabox
As an admin user I would like to add a grid of office locations to the site. 
* Each location will include the city as a header, a subheader label (ex. GSD&M Home Office), the mailing address, and the telephone number.
* Addresses will be linked to their corresponding google map.
* Telephone numbers will be linked to call the phone number.

Background: 
	Given I have logged into wordpress as "admin" with the password "JTK17[07E"
	 And I have "content" with the title "Test Office Locations" and the slug "test-office-locations" in wordpress
	 And the "content" "Test Office Locations" has the "gsdm_content_office_locations_meta_box" "gsdm_office_locations_repeater" set to ""
	 And the "content" "Test Office Locations" has the "gsdm_content_section_header_meta_box" "gsdm_section_header_line_1" set to "Section"
	 And the "content" "Test Office Locations" has the "gsdm_content_section_header_meta_box" "gsdm_section_header_line_2" set to "Header"
	 And I have "page" with the title "Test Office Locations Page" and the slug "test-office-locations-page" in wordpress
	 And the "page" "Test Office Locations Page" has the page template set to "page-content-wizard.php"
	 And the "page" "Test Office Locations Page" has the "gsdm_page_content_repeater_meta_box" "gsdm_content_repeater" set to ""
	 And the "page" "Test Office Locations Page" has the "content" "Test Office Locations" added to the repeater

@javascript
Scenario: Office Locations Metabox Functionality
	Given I go to the wordpress "content" post titled "Test Office Locations" to edit it
	And I select "Office Locations" from "gsdm_content_type"
	When I press "Add A Location"
	Then I should see "Header (City)"
	 And I should see "Subheader"
	 And I should see "Street Address:"
	 And I should see "City, State ZIP:"
	 And I should see "Phone Number:"
	 And I should see an ".gsdm-office-locations-item:not(.template)" element
	When I fill in the ".gsdm-office-locations-item:last-child .gsdm-meta-office-locations-header" element with "Austin"
	 And I fill in the ".gsdm-office-locations-item:last-child .gsdm-meta-office-locations-subheader" element with "Office"
	 And I fill in the ".gsdm-office-locations-item:last-child .gsdm-meta-office-locations-address1" element with "828 West 6th Street"
	 And I fill in the ".gsdm-office-locations-item:last-child .gsdm-meta-office-locations-address2" element with "Austin, Texas 78703"
	 And I fill in the ".gsdm-office-locations-item:last-child .gsdm-meta-office-locations-phone" element with "512-242-GSDM"
	 And I press "Update"
	Then the ".gsdm-office-locations-item:last-child .gsdm-meta-office-locations-header" element should have the attribute "value" that contains "Austin"
	 And the ".gsdm-office-locations-item:last-child .gsdm-meta-office-locations-subheader" element should have the attribute "value" that contains "Office"
	 And the ".gsdm-office-locations-item:last-child .gsdm-meta-office-locations-address1" element should have the attribute "value" that contains "828 West 6th Street"
	 And the ".gsdm-office-locations-item:last-child .gsdm-meta-office-locations-address2" element should have the attribute "value" that contains "Austin, Texas 78703" 
	 And the ".gsdm-office-locations-item:last-child .gsdm-meta-office-locations-phone" element should have the attribute "value" that contains "512-242-GSDM" 
	When I press the ".gsdm-office-locations-item:last-child button[title='remove location']" element
	Then I should not see "Header (City)"
	 And I should not see "Subheader"
	 And I should not see "Street Address:"
	 And I should not see "City, State ZIP:"
	 And I should not see "Phone Number:"
	 And I should not see an ".gsdm-office-locations-item:not(.template)" element
	When I press "Update"
	Then I should not see "Header (City)"
	 And I should not see "Subheader"
	 And I should not see "Street Address:"
	 And I should not see "City, State ZIP:"
	 And I should not see "Phone Number:"
	 And I should not see an ".gsdm-office-locations-item:not(.template)" element

Scenario: Contacts Appear Correctly On Page 
	Given the "content" "Test Office Locations" has the "gsdm_content_office_locations_meta_box" "gsdm_office_locations_repeater" set to "[{\"header\": \"Austin\", \"subheader\": \"Austin Office\", \"phone\": \"512-242-GSDM\", \"address1\": \"828 West 6th Street\", \"address2\": \"Austin, Texas 78703\"},{\"header\": \"Chicago\", \"subheader\": \"Chicago Office\", \"phone\": \"312-552-6200\", \"address1\": \"200 E. Randolph Street, 41st Floor\", \"address2\": \"Chicago, Illinois 60601\"}]"
	 And the "content" "Test Office Locations" has the "gsdm_content_template_meta_box" "gsdm_content_type" set to "office-locations"
	When I am on "/test-office-locations-page"
	Then I should see "Section"
	 And I should see "Header"
	 And I should see "Austin"
	 And I should see "Austin Office"
	 And I should see "512-242-GSDM"
	 And I should see "828 West 6th Street"
	 And I should see "Austin, Texas 78703"
	 And I should see "Chicago"
	 And I should see "Chicago Office"
	 And I should see "312-552-6200"
	 And I should see "200 E. Randolph Street, 41st Floor"
	 And I should see "Chicago, Illinois 60601"
	 And the ".office-locations-item:first-child li:last-child a" element should have the attribute "href" that contains "tel:"
	When I follow "828 West 6th Street"
	 Then I should be on "https://www.google.com/maps/search/828+West+6th+StreetAustin,+Texas+78703/data=!4m2!2m1!4b1"
	
	



