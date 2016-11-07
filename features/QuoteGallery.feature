Feature: Quote Gallery
As an admin user, I would like the ability to add a list of recent quotes.
* User has the ability to add quote title text and source
* Quotes appear as a carousel that autoplays
* Gallery icons shuffle through quotes


Background:
	Given I have logged into wordpress as "admin" with the password "JTK17[07E"
	Given I have "content" with the title "Test Quote Gallery" and the slug "test-quote-gallery" in wordpress
	 And the "content" "Test Quote Gallery" has the "gsdm_content_template_meta_box" "gsdm_content_type" set to "quote-gallery"
	 And the "content" "Test Quote Gallery" has the "gsdm_content_quote_gallery_meta_box" "gsdm_quote_gallery_repeater" set to ""
	Given I have "page" with the title "Test Quote Gallery Page" and the slug "test-quote-gallery-page" in wordpress
	 And the "page" "Test Quote Gallery Page" has the page template set to "page-content-wizard.php"
	 And the "page" "Test Quote Gallery Page" has the "gsdm_page_content_repeater_meta_box" "gsdm_content_repeater" set to ""
     And the "page" "Test Quote Gallery Page" has the "content" "Test Quote Gallery" added to the repeater

@javascript
Scenario: Metabox Saves Data
	Given I go to the wordpress "content" post titled "Test Quote Gallery" to edit it
	 And I press "Add A Quote"
	When I fill in the ".gsdm-quote-gallery-item:last-child .gsdm-meta-quote-gallery-title" element with "Quote title 1"
	 And I fill in the ".gsdm-quote-gallery-item:last-child .gsdm-meta-quote-gallery-quote" element with "It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using Content here, content here"
	 And I fill in the ".gsdm-quote-gallery-item:last-child .gsdm-meta-quote-gallery-source" element with "Lorem Ipsum 1"
	 And I press "Update"
	Then the ".gsdm-quote-gallery-item:last-child .gsdm-meta-quote-gallery-title" element should have the attribute "value" that contains "Quote title 1"
	 And the ".gsdm-quote-gallery-item:last-child .gsdm-meta-quote-gallery-quote" element should contain "It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using Content here, content here"
	 And the ".gsdm-quote-gallery-item:last-child .gsdm-meta-quote-gallery-source" element should have the attribute "value" that contains "Lorem Ipsum 1"

@javascript
Scenario: Custom Meta Displays On Screen
	Given I go to the wordpress "content" post titled "Test Quote Gallery" to edit it
	 And I press "Add A Quote"
	 When I fill in the ".gsdm-quote-gallery-item:last-child .gsdm-meta-quote-gallery-title" element with "Quote title 1"
	 And I fill in the ".gsdm-quote-gallery-item:last-child .gsdm-meta-quote-gallery-quote" element with "It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using Content here, content here"
	 And I fill in the ".gsdm-quote-gallery-item:last-child .gsdm-meta-quote-gallery-source" element with "Lorem Ipsum 1"
	 And I press "Update"
	Given I am on "/content/test-quote-gallery" 
	Then I should see "Quote title 1"
	 And I should see "It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using Content here, content here"
	 And I should see "Lorem Ipsum 1"

@javascript
Scenario: Display presents as a carousel and autoplays
	Given I go to the wordpress "content" post titled "Test Quote Gallery" to edit it
	 And I press "Add A Quote"
	 When I fill in the ".gsdm-quote-gallery-item:last-child .gsdm-meta-quote-gallery-title" element with "Quote title 1"
	 And I fill in the ".gsdm-quote-gallery-item:last-child .gsdm-meta-quote-gallery-quote" element with "It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using Content here, content here"
	 And I fill in the ".gsdm-quote-gallery-item:last-child .gsdm-meta-quote-gallery-source" element with "Lorem Ipsum 1"
	 And I press "Update"
	 And I press "Add A Quote"
	 When I fill in the ".gsdm-quote-gallery-item:last-child .gsdm-meta-quote-gallery-title" element with "Quote title 2"
	 And I fill in the ".gsdm-quote-gallery-item:last-child .gsdm-meta-quote-gallery-quote" element with "It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using Content here, content here"
	 And I fill in the ".gsdm-quote-gallery-item:last-child .gsdm-meta-quote-gallery-source" element with "Lorem Ipsum 2"
	 And I press "Update"
	Given I am on "/test-quote-gallery-page"
	When I press "View Slide 1"
	Then I should see "Quote title 1"
	 And I should not see "Quote title 2"
	When I wait for "6000"
	Then I should see "Quote title 2"
	 And I should not see "Quote title 1"

@javascript
Scenario: Carousel navigation displays expected quotes
	Given I go to the wordpress "content" post titled "Test Quote Gallery" to edit it
	 And I press "Add A Quote"
	 When I fill in the ".gsdm-quote-gallery-item:last-child .gsdm-meta-quote-gallery-title" element with "Quote title 1"
	 And I fill in the ".gsdm-quote-gallery-item:last-child .gsdm-meta-quote-gallery-quote" element with "It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using Content here, content here"
	 And I fill in the ".gsdm-quote-gallery-item:last-child .gsdm-meta-quote-gallery-source" element with "Lorem Ipsum 1"
	 And I press "Update"
	 And I press "Add A Quote"
	 When I fill in the ".gsdm-quote-gallery-item:last-child .gsdm-meta-quote-gallery-title" element with "Quote title 2"
	 And I fill in the ".gsdm-quote-gallery-item:last-child .gsdm-meta-quote-gallery-quote" element with "It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using Content here, content here"
	 And I fill in the ".gsdm-quote-gallery-item:last-child .gsdm-meta-quote-gallery-source" element with "Lorem Ipsum 2"
	 And I press "Update"
	Given I am on "/test-quote-gallery-page"
	When I press "View Slide 2"
	 And I wait for "1000"
	Then I should see "Quote title 2"

