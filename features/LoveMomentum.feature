Feature: Love and Momentum
As an admin user I would like to display our poster series on the web site. 
Each poster will consist of an image and the poster title.
* Image metabox prompts image button
* Inputs save
* Content appears correctly on page

Background:
	Given I have logged into wordpress as "admin" with the password "JTK17[07E"
	And I have uploaded the image "testPattern1.jpg" into the wordpress media library
	Given I have "poster" with the title "Test Poster Post 1" and the slug "test-poster-post-1" in wordpress
	 And I have "poster" with the title "Test Poster Post 2" and the slug "test-poster-post-2" in wordpress
	Given I have "content" with the title "Love Momentum Test" and the slug "love-momentum-test" in wordpress
	 And the "content" "Love Momentum Test" has the "gsdm_content_template_meta_box" "gsdm_content_type" set to "poster-grid"
	Given I have "page" with the title "Love Momentum Test Page" and the slug "love-momentum-test-page" in wordpress
     And the "page" "Love Momentum Test Page" has the page template set to "page-content-wizard.php"
	 And the "page" "Love Momentum Test Page" has the "gsdm_page_content_repeater_meta_box" "gsdm_content_repeater" set to ""
     And the "page" "Love Momentum Test Page" has the "content" "Love Momentum Test" added to the repeater
	
@javascript
Scenario: Poster Image Button
      Given I go to the wordpress "poster" post titled "Test Poster Post 1" to edit it
		And I press "Choose Image"
	   Then I should see the wordpress choose image dialog	

@javascript
Scenario: Poster Content Appears Correctly On Page 
	Given the "attachment" titled "testPattern1" is attached as "gsdm_poster_image_meta_box" meta to the "poster" titled "Test Poster Post 1" as "gsdm_poster_image"
	 And the "attachment" titled "testPattern1" is attached as "gsdm_poster_image_meta_box" meta to the "poster" titled "Test Poster Post 2" as "gsdm_poster_image"
	 And I am on "/love-momentum-test-page"
	Then I should see "Test Poster Post 2"
	 And the ".poster-grid-item-1 .poster-grid-image" element should have a css setting "background-image" that "contains" "testPattern1"

@javascript
Scenario: Carousel Works Correctly
	Given the "attachment" titled "testPattern1" is attached as "gsdm_poster_image_meta_box" meta to the "poster" titled "Test Poster Post 2" as "gsdm_poster_image"
	 And I am on "/love-momentum-test-page"
	When I press "Poster: Test Poster Post 2"
	 And I wait for "1000"
	Then I should see "1/2"
	#testing NOT auto playing
	When I wait for "10000"
	Then I should see "1/2"
	When I press "View Next Slide"
	 And I wait for "1000"
	Then I should see "2/2"
	


	


	









