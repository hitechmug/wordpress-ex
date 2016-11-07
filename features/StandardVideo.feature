Feature: Standard Video
As a gsdm.com admin I would like to be able to add a video to a page.
I would like to have an option to make the video loop.

Background:
	Given I have logged into wordpress as "admin" with the password "JTK17[07E"
	 And I have uploaded the image "testPattern1.jpg" into the wordpress media library
	  And I have "content" with the title "Test Video Content" and the slug "test-video-content" in wordpress
	  And the "content" "Test Video Content" has the "gsdm_content_template_meta_box" "gsdm_content_type" set to "video"
	Given I have "page" with the title "Test Video Page" and the slug "test-video-page" in wordpress
	 And the "page" "Test Video Page" has the page template set to "page-content-wizard.php"
	 And the "page" "Test Video Page" has the "gsdm_page_content_repeater_meta_box" "gsdm_content_repeater" set to ""
	 And the "page" "Test Video Page" has the "content" "Test Video Content" added to the repeater

Scenario: Meta Data saves to the database
	When I go to the wordpress "content" post titled "Test Video Content" to edit it 
	 And I fill in "gsdm_video_id" with "798022"
	 And I check "gsdm_video_looping"
	 And I press "Update"
	Then the "gsdm_video_id" field should contain "798022"
	 And the checkbox "gsdm_video_looping" should be checked

@javascript
Scenario: Expected elements are visible on the page
	#Given the "attachment" titled "testPattern1" is attached as "gsdm_content_image_meta_box" meta to the "content" titled "Test Video Content" as "gsdm_content_image"
	 #And the "content" "Test Video Content" has the "gsdm_content_section_header_meta_box" "gsdm_section_header_line_1" set to "Section"
	 #And the "content" "Test Video Content" has the "gsdm_content_section_header_meta_box" "gsdm_section_header_line_2" set to "Header"
	 #And the "content" "Test Image Content" has the content "<div class=jumbo-promo>Testing Overlays</div>"
	#When I am on "/test-video-page"
	#Then I should see "Section"
	 #And I should see "Header"
	 #And I should see "Test Video Header"
	 #And I should see "Test Video Subheader"
	 #And I should see "Testing Overlays"

@javascript
Scenario: Update the video settings in the new content item
	#Given the "attachment" titled "testPattern1" is attached as "gsdm_content_image_meta_box" meta to the "content" titled "Test Video Content" as "gsdm_content_image"
	 #And the "content" "Test Video Content" has the "gsdm_content_video_meta_box" "gsdm_video_id" set to "798022"
	#When I am on "/test-video-page/?fake_vimeo=1"
	#Then I should see an "#vplayer798022" element
	 #And the ".full-container.full-image" element should have a css setting "background-image" that "contains" "testPattern1"
	#When I play the "#vplayer798022" video
	#Then I should not see "Test Video Header Poster Frame"
    #When I wait for the "#vplayer798022" video to finish playing
	#Then I should see "Test Video Header Poster Frame"


