Feature: 404 Page
As the product owner, I would like the site to have a custom 404 page to reflect the personality of the brand.
I would like the 404 page to have the same content modules as the customizable pages.  

Background:
	Given I have logged into wordpress as "admin" with the password "JTK17[07E"
	Given I have "content" with the title "404 Test Content" and the slug "404-test-content" in wordpress
	 And the "content" "404 Test Content" has the "gsdm_content_template_meta_box" "gsdm_content_type" set to "text"
	 And the "content" "404 Test Content" has the content "Taco Time!"
	Given I have "page" with the title "404" and the slug "oops" in wordpress
	 And the "page" "404" has the page template set to "page-content-wizard.php"
	 And the "page" "404" has the "gsdm_page_content_repeater_meta_box" "gsdm_content_repeater" set to ""
	 And the "page" "404" has the "content" "404 Test Content" added to the repeater

Scenario: Ability to view post content
	Given I am on "/supercalafragilisticexpealadocious"
	Then I should see "Taco Time!"

