Feature: Contact Info Metabox
As an admin user, I would like to post PR contact information on the website so that users can easily contact various Communications team members. 
As an admin user, I would like to be able to add HR contact information to the site. Contact information includes name, title, email, and phone number.
I would like a way of posting email addresses that doesn't attract spammers.

Background: 
	Given I have logged into wordpress as "admin" with the password "JTK17[07E"
	 And I have "content" with the title "Test Contact Info" and the slug "test-contact-info" in wordpress
	 And the "content" "Test Contact Info" has the "gsdm_content_template_meta_box" "gsdm_content_type" set to "contact-info"
	 And the "content" "Test Contact Info" has the "gsdm_content_contact_info_meta_box" "gsdm_contact_info_repeater" set to ""
	 And the "content" "Test Contact Info" has the "gsdm_content_section_header_meta_box" "gsdm_section_header_line_1" set to "Section"
	 And the "content" "Test Contact Info" has the "gsdm_content_section_header_meta_box" "gsdm_section_header_line_2" set to "Header"
	 And I have "page" with the title "Test Contacts Page" and the slug "test-contacts-page" in wordpress
	 And the "page" "Test Contacts Page" has the page template set to "page-content-wizard.php"
	 And the "page" "Test Contacts Page" has the "gsdm_page_content_repeater_meta_box" "gsdm_content_repeater" set to ""
	 And the "page" "Test Contacts Page" has the "content" "Test Contact Info" added to the repeater

@javascript
Scenario: Contact Info Metabox Functionality
	Given I go to the wordpress "content" post titled "Test Contact Info" to edit it
	When I press "Add A Contact"
	Then I should see "Contact Name:"
	 And I should see "Contact Email:"
	 And I should see "Contact Title:"
	 And I should see "Contact Phone Number:"
	 And I should see an ".gsdm-contact-info-item:not(.template)" element
	When I fill in the ".gsdm-contact-info-item:last-child .gsdm-meta-contact-info-name" element with "Test Metabox Name"
	 And I fill in the ".gsdm-contact-info-item:last-child .gsdm-meta-contact-info-email" element with "test@gsdm.com"
	 And I fill in the ".gsdm-contact-info-item:last-child .gsdm-meta-contact-info-phone" element with "512-555-1234"
	 And I fill in the ".gsdm-contact-info-item:last-child .gsdm-meta-contact-info-title" element with "Test Metabox Title"
	 And I press "Update"
	Then the ".gsdm-contact-info-item:last-child .gsdm-meta-contact-info-name" element should have the attribute "value" that contains "Test Metabox Name"
	 And the ".gsdm-contact-info-item:last-child .gsdm-meta-contact-info-email" element should have the attribute "value" that contains "test@gsdm.com"
	 And the ".gsdm-contact-info-item:last-child .gsdm-meta-contact-info-phone" element should have the attribute "value" that contains "512-555-1234"
	 And the ".gsdm-contact-info-item:last-child .gsdm-meta-contact-info-title" element should have the attribute "value" that contains "Test Metabox Title" 
	When I press the ".gsdm-contact-info-item:last-child button[title='remove contact']" element
	Then I should not see "Contact Name:"
	 And I should not see "Contact Email:"
	 And I should not see "Contact Title:"
	 And I should not see "Contact Phone Number:"
	 And I should not see an ".gsdm-contact-info-item:not(.template)" element
	When I press "Update"
	Then I should not see "Contact Name:"
	 And I should not see "Contact Email:"
	 And I should not see "Contact Title:"
	 And I should not see "Contact Phone Number:"
	 And I should not see an ".gsdm-contact-info-item:not(.template)" element

Scenario: Contacts Appear Correctly On Page 
	Given the "content" "Test Contact Info" has the "gsdm_content_contact_info_meta_box" "gsdm_contact_info_repeater" set to "[{\"name\": \"Test Contact 1\", \"email\": \"testcontact1@gsdm.com\", \"phone\": \"512-123-4567\", \"title\": \"title 1\"},{\"name\": \"Test Contact 2\", \"email\": \"testcontact2@gsdm.com\", \"phone\": \"512-765-4321\", \"title\": \"title 2\"}]"
	When I am on "/test-contacts-page"
	Then I should see "Section"
	 And I should see "Header"
	 And I should see "Test Contact 1"
	 And I should see "Test Contact 2"
	 And I should see "512-123-4567"
	 And I should see "512-765-4321"
	 And I should see "title 1"
	 And I should see "title 2"
	 And I should see "testcontact1@gsdm.com"
	 And I should see "testcontact2@gsdm.com"
	
	



