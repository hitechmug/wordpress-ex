Feature: Video Collage Metabox
As an admin user I would like the ability to add a collage of images to the site that when clicked play the associated video.
* No more than 6 images/videos per video collage
* Placeholder will be provided when there are less than 6 images
* Grid will be 3 columns in tablet and desktop
* Grid will be 2 columns on phone

Background:
	Given I have logged into wordpress as "admin" with the password "JTK17[07E"
	 And I have uploaded the image "testPattern1.jpg" into the wordpress media library
	Given the "client_filters" taxonomy has the tag "client1"
	Given I have "content" with the title "Video Collage Test" and the slug "video-collage-test" in wordpress
	 And the "content" "Video Collage Test" has the "gsdm_content_video_collage_meta_box" "gsdm_video_collage_repeater" set to ""
	 And the "content" "Video Collage Test" has the "gsdm_content_template_meta_box" "gsdm_content_type" set to "video-collage"
	 And the "content" "Video Collage Test" has the "gsdm_content_section_header_meta_box" "gsdm_section_header_line_1" set to "Section"
	 And the "content" "Video Collage Test" has the "gsdm_content_section_header_meta_box" "gsdm_section_header_line_2" set to "Header"
	Given I have "page" with the title "Video Collage Test Page" and the slug "video-collage-test-page" in wordpress
     And the "page" "Video Collage Test Page" has the page template set to "page-content-wizard.php"
	 And the "page" "Video Collage Test Page" has the "gsdm_page_content_repeater_meta_box" "gsdm_content_repeater" set to ""
     And the "page" "Video Collage Test Page" has the "content" "Video Collage Test" added to the repeater
	Given the "client_filters" taxonomy has the tag "client1"

@javascript
Scenario: Video Collage Metabox Image Button
      Given I go to the wordpress "content" post titled "Video Collage Test" to edit it
      When I press "Add A Video"
	   And I press the ".gsdm-video-collage-item:last-child .gsdm-meta-choose-item.meta-image.button" element
	  Then I should see the wordpress choose image dialog

@javascript
Scenario: Video Collage Metabox Text Inputs Saving
	Given I go to the wordpress "content" post titled "Video Collage Test" to edit it
    When I press "Add A Video"
	 And I fill in the ".gsdm-video-collage-item:last-child .gsdm-meta-video-collage-label" element with "Label 1"
	 And I select "client1" from the ".gsdm-video-collage-item:last-child .gsdm-meta-video-collage-clientID" element
	 And I fill in the ".gsdm-video-collage-item:last-child .gsdm-meta-video-collage-videoID" element with "Video ID 1"
     And I press "Update"
    Then the ".gsdm-video-collage-item:last-child .gsdm-meta-video-collage-label" element should have the attribute "value" that contains "Label 1"
     And I should see that the "client_filters" taxonomy "client1" option from the ".gsdm-video-collage-item:last-child .gsdm-meta-video-collage-clientID" element is selected
	 And the ".gsdm-video-collage-item:last-child .gsdm-meta-video-collage-videoID" element should have the attribute "value" that contains "Video ID 1" 
    When I press the ".gsdm-video-collage-item:last-child .gsdm-repeater-item-remove" element
    Then I should not see "Label 1"
	 And I should not see "Video ID 1"
    When I press "Update"
    Then I should not see "Label 1"
	 And I should not see "Video ID 1"

@javascript
Scenario: No More Than Six Videos Allowed
	Given I go to the wordpress "content" post titled "Video Collage Test" to edit it
    When I press "Add A Video"
	 And I press "Add A Video"
	 And I press "Add A Video"
	 And I press "Add A Video"
	 And I press "Add A Video"
	 And I press "Add A Video"
	 And I press "Add A Video"
	 And I press "Add A Video"
	Then I should see 6 "li.gsdm-video-collage-item:not(.template)" elements

@javascript
Scenario: Video Collage Content Appears Correctly On Page 
	Given the "content" "Video Collage Test" has the video collage repeater item labeled "Repeater 1" and the image "testPattern1"
	When I am on "/video-collage-test-page"
	Then I should see "Section"
	 And I should see "Header"
	Then the ".video-collage-image-1" element should have a css setting "background-image" that "contains" "testPattern1"
	When I "mouseOver" the element ".video-collage-image-1" and wait for "1000"
	Then I should see "Repeater 1"	