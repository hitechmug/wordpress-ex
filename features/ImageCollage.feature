Feature: Image Collage
As an admin, I would like the ability to create a collage of images that when selected open a larger version of the image in a modal.
* Collage will present with 6 images displaying
* Modal will cycle through as a carousel

Background:
	Given I have logged into wordpress as "admin" with the password "JTK17[07E"
	 And I have uploaded the image "testPattern1.jpg" into the wordpress media library
	 And I have uploaded the image "testPattern2.jpg" into the wordpress media library
	Given the "client_filters" taxonomy has the tag "client1"
	Given I have "content" with the title "Image Collage Test" and the slug "image-collage-test" in wordpress
	 And the "content" "Image Collage Test" has the "gsdm_content_image_collage_meta_box" "gsdm_image_collage_repeater" set to ""
	 And the "content" "Image Collage Test" has the "gsdm_content_template_meta_box" "gsdm_content_type" set to "image-collage"
	 And the "content" "Image Collage Test" has the "gsdm_content_section_header_meta_box" "gsdm_section_header_line_1" set to "Section"
	 And the "content" "Image Collage Test" has the "gsdm_content_section_header_meta_box" "gsdm_section_header_line_2" set to "Header"
	Given I have "page" with the title "Test Image Collage Page" and the slug "test-image-collage-page" in wordpress
     And the "page" "Test Image Collage Page" has the page template set to "page-content-wizard.php"
	 And the "page" "Test Image Collage Page" has the "gsdm_page_content_repeater_meta_box" "gsdm_content_repeater" set to ""
     And the "page" "Test Image Collage Page" has the "content" "Image Collage Test" added to the repeater

@javascript
Scenario: Image Collage Metabox Thumbnail Image Button
      Given I go to the wordpress "content" post titled "Image Collage Test" to edit it
      When I press "Add A Collage Image"
	   And I press the ".gsdm-image-collage-item:last-child .gsdm-meta-choose-item.meta-image.button[data-test='choose collage thumbnail image']" element
	  Then I should see the wordpress choose image dialog

@javascript
Scenario: Image Collage Metabox Full Size Image Button
      Given I go to the wordpress "content" post titled "Image Collage Test" to edit it
      When I press "Add A Collage Image"
	   And I press the ".gsdm-image-collage-item:last-child .gsdm-meta-choose-item.meta-image.button[data-test='choose collage large image']" element
	  Then I should see the wordpress choose image dialog


@javascript
Scenario: Metabox Saves
	When I go to the wordpress "content" post titled "Image Collage Test" to edit it
	 And I press "Add A Collage Image"
	 And I fill in the ".gsdm-image-collage-item:last-child .gsdm-meta-image-collage-label" element with "Item 1"
	 And I wait for "1000"
	 And I select "client1" from the ".gsdm-image-collage-item:last-child .gsdm-meta-image-collage-clientID" element
     And I press "Update"
	Then the ".gsdm-image-collage-item:last-child .gsdm-meta-image-collage-label" element should have the attribute "value" that contains "Item 1"
	 And I should see that the "client_filters" taxonomy "client1" option from the ".gsdm-image-collage-item:last-child .gsdm-meta-image-collage-clientID" element is selected

@javascript
Scenario: Image Collage Content Appears Correctly On Page 
	Given the "content" "Image Collage Test" has the image collage repeater item labeled "Repeater 1" and the image "testPattern1"
	 And the "content" "Image Collage Test" has the image collage repeater item labeled "Repeater 2" and the image "testPattern2"
	When I am on "/test-image-collage-page"
	 And I wait for "1000"
	Then I should see "Section"
	 And I should see "Header"
	 And the ".image-collage-body li.item-1 .collage-image" element should have a css setting "background-image" that "contains" "testPattern1"
	When I press "Image 1: Repeater 1"
	 And I wait for "1000"
	 Then I should see "1/2"
	#testing NOT auto playing
	When I wait for "10000"
	Then I should see "1/2"
	When I press "View Next Slide"
	 And I wait for "1000"
	Then I should see "2/2"

