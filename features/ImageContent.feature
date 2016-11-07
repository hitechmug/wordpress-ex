Feature: Image Content (Jumbo Image)
As a gsdm.com admin I would like to be able to add an image as content to a page. 
# 16:9 aspect ratio
#* should scale with screen width
#* should have center as the focal point
#* should have no padding, margins etc


Background: 	
    Given I have logged into wordpress as "admin" with the password "JTK17[07E"
      And I have uploaded the image "testPattern1.jpg" into the wordpress media library
	  And I have "content" with the title "Test Image Content" and the slug "test-image-content" in wordpress
	  And the "content" "Test Image Content" has the "gsdm_content_template_meta_box" "gsdm_content_type" set to "image"
	  And the "content" "Test Image Content" has the "gsdm_content_section_header_meta_box" "gsdm_section_header_line_1" set to "Section"
	  And the "content" "Test Image Content" has the "gsdm_content_section_header_meta_box" "gsdm_section_header_line_2" set to "Header"
	  And I have "page" with the title "Test Image Page" and the slug "image-test" in wordpress
	  And I do not have meta data "gsdm_content_image_meta_box" for "content" titled "Test Image Content"

@javascript
Scenario: Does image metabox open media picker
	When I go to the wordpress "content" post titled "Test Image Content" to edit it
	Then I should see "Choose Image"
	When I press the "#gsdm_content_image_meta_box button.gsdm-meta-choose-item" element
    Then I should see the wordpress choose image dialog

@javascript
Scenario: Formatting selections are available
	When I go to the wordpress "content" post titled "Test Image Content" to edit it
	 And I press "Visual"
	 And I press the "div[aria-label='Toolbar Toggle']" element
	 And I press "Formats"
	Then I should see "Jumbo Promo"
	 And I should see "Masthead"
	 And I should see "Caption"

@javascript
Scenario: The output of an image content
 	Given the "attachment" titled "testPattern1" is attached as "gsdm_content_image_meta_box" meta to the "content" titled "Test Image Content" as "gsdm_content_image"
	 And the "content" "Test Image Content" has the content "<div class=jumbo-promo>Testing Overlays</div>"
     And I "append" the "content" shortcode to the "content" post titled "Test Image Content" by "id" to the "page" post titled "Test Image Page"
    When I am on "/image-test"
    Then I should see an "img" element 
	 And the "img" element should have the attribute "src" that contains "testPattern1"
	 And I should see "Section"
	 And I should see "Header"
	 And I should see "Testing Overlays"
