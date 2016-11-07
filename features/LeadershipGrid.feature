Feature: Leadership Grid
As an admin user I would like the ability to add information about the four senior leaders to the site. 
The information will be presented in a grid. Each tile will contain:
* First name
* Last name
* Title
* LinkedIn resume link
* Short description


Background: 
	Given I have logged into wordpress as "admin" with the password "JTK17[07E"
	 And I have "content" with the title "Test Leader Grid" and the slug "test-leader-grid" in wordpress
	 And the "content" "Test Leader Grid" has the "gsdm_content_template_meta_box" "gsdm_content_type" set to "leader-grid"
	 And the "content" "Test Leader Grid" has the "gsdm_content_leader_grid_meta_box" "gsdm_leader_grid_repeater" set to ""
	 And the "content" "Test Leader Grid" has the "gsdm_content_section_header_meta_box" "gsdm_section_header_line_1" set to "Section"
	 And the "content" "Test Leader Grid" has the "gsdm_content_section_header_meta_box" "gsdm_section_header_line_2" set to "Header"
	Given I have "page" with the title "Test Leader Grid Page" and the slug "test-leader-grid-page" in wordpress
	 And the "page" "Test Leader Grid Page" has the page template set to "page-content-wizard.php"
	 And the "page" "Test Leader Grid Page" has the "gsdm_page_content_repeater_meta_box" "gsdm_content_repeater" set to ""
	 And the "page" "Test Leader Grid Page" has the "content" "Test Leader Grid" added to the repeater

@javascript
Scenario: Contact Info Metabox Functionality
	Given I go to the wordpress "content" post titled "Test Leader Grid" to edit it
	And I select "Leadership Grid" from "gsdm_content_type"
	When I press "Add A Leader"
	Then I should see "First Name:"
	 And I should see "Last Name:"
	 And I should see "Title:"
	 And I should see "LinkedIn URL:"
	 And I should see "Description:"
	 And I should see an ".gsdm-leader-grid-item:not(.template)" element
	When I fill in the ".gsdm-leader-grid-item:last-child .gsdm-meta-leader-grid-first" element with "Ronald"
	 And I fill in the ".gsdm-leader-grid-item:last-child .gsdm-meta-leader-grid-last" element with "McDonald"
	 And I fill in the ".gsdm-leader-grid-item:last-child .gsdm-meta-leader-grid-title" element with "Clown"
	 And I fill in the ".gsdm-leader-grid-item:last-child .gsdm-meta-leader-grid-linkedin" element with "http://www.mcdonalds.com"
	 And I fill in the ".gsdm-leader-grid-item:last-child .gsdm-meta-leader-grid-description" element with "A clown character used as the primary mascot of the McDonald's fast-food restaurant chain."
	 And I press "Update"
	Then the ".gsdm-leader-grid-item:last-child .gsdm-meta-leader-grid-first" element should have the attribute "value" that contains "Ronald"
	 And the ".gsdm-leader-grid-item:last-child .gsdm-meta-leader-grid-last" element should have the attribute "value" that contains "McDonald"
	 And the ".gsdm-leader-grid-item:last-child .gsdm-meta-leader-grid-title" element should have the attribute "value" that contains "Clown"
	 And the ".gsdm-leader-grid-item:last-child .gsdm-meta-leader-grid-linkedin" element should have the attribute "value" that contains "http://www.mcdonalds.com"
	 And the ".gsdm-leader-grid-item:last-child .gsdm-meta-leader-grid-description" element should contain "A clown character used as the primary mascot of the McDonald's fast-food restaurant chain." 
	When I press the ".gsdm-leader-grid-item:last-child button[title='remove contact']" element
	Then I should not see "First Name:"
	 And I should not see "Last Name:"
	 And I should not see "Title:"
	 And I should not see "LinkedIn URL:"
	 And I should not see "Description:"
	 And I should not see an ".gsdm-leader-grid-item:not(.template)" element
	When I press "Update"
	Then I should not see "First Name:"
	 And I should not see "Last Name:"
	 And I should not see "Title:"
	 And I should not see "LinkedIn URL:"
	 And I should not see "Description:"
	 And I should not see an ".gsdm-leader-grid-item:not(.template)" element

@javascript
Scenario: Leadership Grid Appears Correctly On Page 
	Given the "content" "Test Leader Grid" has the "gsdm_content_leader_grid_meta_box" "gsdm_leader_grid_repeater" set to "[{\"first\": \"Bob\", \"last\": \"Barker\", \"title\": \"Game Show Host\", \"description\": \"He is best known for hosting CBS's The Price Is Right from 1972 to 2007.\", \"linkedin\": \"https://www.linkedin.com/\"}, {\"first\": \"Robert\", \"last\": \"Saget\", \"title\": \"Stand-up Comedian\", \"description\": \"Grammy Award nominated American stand-up comedian, actor and television host.\", \"linkedin\": \"http://www.yahoo.com\"}]"
	When I am on "/test-leader-grid-page"
	Then I should see "Section"
	 And I should see "Header"
	Then I should see "Bob"
	 And I should see "Barker"
	 And I should see "Game Show Host"
	 And I should see "Robert"
	 And I should see "Saget"
	 And I should see "Stand-up Comedian"
	 And I should not see "He is best known for hosting CBS's The Price Is Right from 1972 to 2007."
	When I follow "resume for Bob Barker"
	 And I switch tabs
	Then I should be on "https://www.linkedin.com/"
	 
	
	



