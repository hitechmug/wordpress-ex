Feature: Takeover Page
As a gsdm.com admin I would like 
to be able to set a page that takes over the site from the "default home page".

Background:
	Given I have logged into wordpress as "admin" with the password "JTK17[07E"
	 And I have "page" with the title "Test Home Page" and the slug "test-home-page" in wordpress
	 And I have "page" with the title "Test Takeover Page" and the slug "test-takeover-page" in wordpress
	 And I change the template to "page-takeover.php" for the wordpress "page" post titled "Test Takeover Page"
	 And I add the custom field "gsdm_redirect_slug" with the value "test-home-page" to the wordpress "page" post titled "Test Takeover Page"
	 And I set the front page to the wordpress "page" post titled "Test Takeover Page"
    
Scenario: Has a link that directs users to the standard home page.
	Given I am on "/"
	 And I follow "Continue to GSDM.com"
    Then I should be on "/test-home-page/"
