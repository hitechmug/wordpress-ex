Feature: Image Gallery Metabox
As an admin user, I would like the ability to add a gallery of images to the site. 
* The images will span the full width of the screen
* There will be one control that progresses users to the next screen
* There will be one non-interactive progress indicator (1 of 6, 2 of 6, 3 of 6, etc.)
* Gallery will NOT autoplay
* Gallery will loop
* Slides do not have any associated copy

Background:
	Given I have logged into wordpress as "admin" with the password "JTK17[07E"
	 And I have uploaded the image "testPattern1.jpg" into the wordpress media library
	 And I have uploaded the image "testPattern2.jpg" into the wordpress media library
	Given I have "content" with the title "Image Gallery Test" and the slug "image-gallery-test" in wordpress
	 And the "content" "Image Gallery Test" has the "gsdm_content_image_gallery_meta_box" "gsdm_image_gallery_repeater" set to ""
	 And the "content" "Image Gallery Test" has the "gsdm_content_image_gallery_meta_box" "gsdm_image_gallery_control_color" set to ""
	 And the "content" "Image Gallery Test" has the "gsdm_content_image_gallery_meta_box" "gsdm_image_gallery_control_alignment" set to ""
	 And the "content" "Image Gallery Test" has the "gsdm_content_template_meta_box" "gsdm_content_type" set to "image-gallery"
	 And the "content" "Image Gallery Test" has the "gsdm_content_section_header_meta_box" "gsdm_section_header_line_1" set to "Section"
	 And the "content" "Image Gallery Test" has the "gsdm_content_section_header_meta_box" "gsdm_section_header_line_2" set to "Header"
	Given I have "page" with the title "Test Image Gallery Page" and the slug "test-image-gallery-page" in wordpress
     And the "page" "Test Image Gallery Page" has the page template set to "page-content-wizard.php"
	 And the "page" "Test Image Gallery Page" has the "gsdm_page_content_repeater_meta_box" "gsdm_content_repeater" set to ""
     And the "page" "Test Image Gallery Page" has the "content" "Image Gallery Test" added to the repeater

@javascript
Scenario: Image Gallery Metabox Image Button
      Given I go to the wordpress "content" post titled "Image Gallery Test" to edit it
      When I press "Add A Gallery Image"
	   And I press the ".gsdm-image-gallery-item:last-child .gsdm-meta-choose-item.meta-image.button" element
	  Then I should see the wordpress choose image dialog

Scenario: Image Gallery Metabox Control Text Settings Styling
	Given I go to the wordpress "content" post titled "Image Gallery Test" to edit it
	When I select the radio button labeled "Light"
	 And I select the radio button labeled "Right"
	 And I press "Update"
	Then the radio button labeled "Light" should be checked
	 And the radio button labeled "Right" should be checked		 

@javascript
Scenario: Image Gallery Content Appears Correctly On Page 
	Given the "content" "Image Gallery Test" has the image gallery repeater item titled "Repeater 1" and the image "testPattern1"
	 And the "content" "Image Gallery Test" has the image gallery repeater item titled "Repeater 2" and the image "testPattern2"
	 And the "content" "Image Gallery Test" has the image gallery repeater item titled "Repeater 3" and the image "testPattern1"
	 And the "content" "Image Gallery Test" has the image gallery repeater item titled "Repeater 4" and the image "testPattern2"	 
	When I am on "/content/image-gallery-test"
	Then I should see "Section"
	 And I should see "Header"
	 And I should see "1/4"
	#testing NOT auto playing
	When I wait for "10000"
	Then I should see "1/4"
	When I press "View Next Slide"
	 And I wait for "1000"
	Then I should see "2/4"

@javascript
Scenario: Image Gallery Metabox Control Gallery Settings Padding Styling 
	Given I go to the wordpress "content" post titled "Image Gallery Test" to edit it
	When I check "Full width, no horizontal padding"
	And I press "Update"
	Then the checkbox "Full width, no horizontal padding" should be checked
	When I am on "/content/image-gallery-test"
	Then I should see a "section" element 
	 And the "section" element should have the attribute "style" that contains "margin-left:0; margin-right: 0;"

Scenario: Image Gallery Metabox Control Gallery Settings Hide Controls Styling 
	Given I go to the wordpress "content" post titled "Image Gallery Test" to edit it
	When I check "Hide Controls"
	And I press "Update"
	Then the checkbox "Hide Controls" should be checked

Scenario: Image Gallery Metabox Control Gallery Settings Autoplay Styling 
	Given I go to the wordpress "content" post titled "Image Gallery Test" to edit it
	When I check "Autoplay"
	And I fill in "gsdm_image_gallery_autoplay_time" with "500"
	And I press "Update"
	Then the checkbox "Autoplay" should be checked
	And the "gsdm_image_gallery_autoplay_time" field should contain "500"

Scenario: Image Gallery Metabox Control Gallery Settings Loop Styling 
	Given I go to the wordpress "content" post titled "Image Gallery Test" to edit it
	When I check "Loop Gallery"
	And I press "Update"
	Then the checkbox "Loop Gallery" should be checked

