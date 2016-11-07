Feature: Job List Metabox
As an admin user I would like the ability to add a list of featured job openings to the site. 
Each job description would display:
* Title
* Location (Austin, TX or Chicago, IL)
* Text blurb about the job
* Link to the full posting

At the bottom of the list is a link to the ADP site that displays all postings. 
By default, the list will display job title and location only. When users click the title/location 
it will toggle the description expansion.

Background: 
	Given I have logged into wordpress as "admin" with the password "JTK17[07E"
	 And I have "content" with the title "Job List Test" and the slug "job-list-test" in wordpress
	 And the "content" "Job List Test" has the "gsdm_content_jobs_list_meta_box" "gsdm_jobs_list_repeater" set to ""
	 And the "content" "Job List Test" has the "gsdm_content_section_header_meta_box" "gsdm_section_header_line_1" set to "Section"
	 And the "content" "Job List Test" has the "gsdm_content_section_header_meta_box" "gsdm_section_header_line_2" set to "Header"
	 And I have "page" with the title "Test Job List Page" and the slug "test-job-list-page" in wordpress
	 And the "page" "Test Job List Page" has the page template set to "page-content-wizard.php"
	 And the "page" "Test Job List Page" has the "gsdm_page_content_repeater_meta_box" "gsdm_content_repeater" set to ""
	 And the "page" "Test Job List Page" has the "content" "Job List Test" added to the repeater

@javascript
Scenario: Jobs List Metabox Functionality
	Given I go to the wordpress "content" post titled "Job List Test" to edit it
	And I select "Jobs List" from "gsdm_content_type"
	When I press "Add A Job"
	Then I should see "Job Title"
	 And I should see "Job Location"
	 And I should see "Posting Link"
	 And I should see "Job Description"
	 And I should see an ".gsdm-jobs-list-item:not(.template)" element
	When I fill in the ".gsdm-jobs-list-item:last-child .gsdm-meta-job-title" element with "Cthulu"
	 And I select "chicago" from the ".gsdm-jobs-list-item:last-child .gsdm-meta-job-location" element
	 And I fill in the ".gsdm-jobs-list-item:last-child .gsdm-meta-job-link" element with "https://en.wikipedia.org/wiki/Cthulhu"
	 And I fill in the "#gsdm-jobs-list-description-1_ifr" element with "Looking for an octopus-like head whose face was a mass of feelers, a scaly, rubbery-looking body, prodigious claws on hind and fore feet, and long, narrow wings behind."
	 And I press "Update"
	Then the ".gsdm-jobs-list-item:last-child .gsdm-meta-job-title" element should have the attribute "value" that contains "Cthulu"
	 And I should see that the "chicago" option from the ".gsdm-jobs-list-item:last-child .gsdm-meta-job-location" element is selected
	 And the ".gsdm-jobs-list-item:last-child .gsdm-meta-job-link" element should have the attribute "value" that contains "https://en.wikipedia.org/wiki/Cthulhu"
	 And I should see "<p>Looking for an octopus-like head whose face was a mass of feelers, a scaly, rubbery-looking body, prodigious claws on hind and fore feet, and long, narrow wings behind.</p>" in the ".gsdm-jobs-list-item:last-child .gsdm-meta-job-description" tinymce field
	When I press the ".gsdm-jobs-list-item:last-child .gsdm-repeater-item-remove" element
	Then I should not see "Job Title"
	 And I should not see "Job Location"
	 And I should not see "Posting Link"
	 And I should not see "Job Description"
	When I press "Update"
	Then I should not see "Job Title"
	 And I should not see "Job Location"
	 And I should not see "Posting Link"
	 And I should not see "Job Description"

@javascript
Scenario: Jobs List Appear Correctly On Page 
	Given the "content" "Job List Test" has the "gsdm_content_jobs_list_meta_box" "gsdm_jobs_list_repeater" set to "[{\"title\": \"Cthulu\", \"location\": \"austin\", \"link\": \"https://en.wikipedia.org/wiki/Cthulhu\", \"description\": \"<p>Looking for an octopus-like head whose face was a mass of feelers, a scaly, rubbery-looking body, prodigious claws on hind and fore feet, and long, narrow wings behind.</p>\"}]"
	When I am on "/test-job-list-page"
	Then I should see "Section"
	 And I should see "Header"
	 And I should see "Cthulu"
	 And I should see "Austin, TX"
	When I press "Cthulu"
	 And I wait for "1000"
	Then I should see "Looking for an octopus-like head whose face was a mass of feelers, a scaly, rubbery-looking body, prodigious claws on hind and fore feet, and long, narrow wings behind."
	When I follow "View Full Post"
	 And I switch tabs
	Then I should be on "https://en.wikipedia.org/wiki/Cthulhu"

