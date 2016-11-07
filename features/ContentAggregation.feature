Feature: Content Aggregation
As a gsdm.com admin 
I would like to be able to pull the content 
from several different pages into a single page.

Background: 
	Given I have logged into wordpress as "admin" with the password "JTK17[07E"
	Given I have "content" with the title "Test Content Aggregation" and the slug "test-content-aggregation" in wordpress
	 And the "content" "Test Content Aggregation" has the content "Letterpress readymade cronut, Godard Blue Bottle flexitarian selvage ethical Thundercats McSweeney's 3 wolf moon."
	Given I have "page" with the title "Test Content Aggregation Page" and the slug "test-content-aggregation-page" in wordpress
	 And I "append" the "content" shortcode to the "content" post titled "Test Content Aggregation" by "id" to the "page" post titled "Test Content Aggregation Page" 
		
Scenario: View Short Code Content in Page
	Given I am on "/test-content-aggregation-page"
	 Then I should see "Letterpress readymade cronut"