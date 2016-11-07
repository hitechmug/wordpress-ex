Feature: Section Header Metabox
As an admin user I would like the ability to include section headers for the individual content modules
* Headers are optional
* Each of the headers will be formatted in 2 lines with a horizontal divide below

Background: 
	Given I have logged into wordpress as "admin" with the password "JTK17[07E"
	 And I have "content" with the title "Test Section Header" and the slug "test-section-header" in wordpress
	 And the "content" "Test Section Header" has the "gsdm_content_template_meta_box" "gsdm_content_type" set to "text"
	 And I have "page" with the title "Test Section Header Page" and the slug "test-section-header-page" in wordpress
	 And the "page" "Test Section Header Page" has the page template set to "page-content-wizard.php"
	 And the "page" "Test Section Header Page" has the "content" "Test Section Header" added to the repeater

Scenario: Section Header Metabox Saves Data
	Given I go to the wordpress "content" post titled "Test Section Header" to edit it
	 And I fill in "Line 1" with "Buseyisms"
	 And I fill in "Line 2" with "Explained"
	 And I press "Update"
	Then the "Line 1" field should contain "Buseyisms"
	 And the "Line 2" field should contain "Explained"

Scenario: Section Header Appears Correctly On Page 
	Given the "content" "Test Section Header" has the "gsdm_content_section_header_meta_box" "gsdm_section_header_line_1" set to "Section"
	 And the "content" "Test Section Header" has the "gsdm_content_section_header_meta_box" "gsdm_section_header_line_2" set to "Header"
	When I am on "/test-section-header-page"
	 Then I should see "Section"
	 And I should see "Header"

	 
	
	



