Feature: Remove Shortcode Processing on Content Custom Type
# Note this test may be obsolete because of changes made to the text item to allow HTML formatting to be visible

Background:
	Given I have logged into wordpress as "admin" with the password "JTK17[07E"
     And I have "content" with the title "Test Shortcode Content" and the slug "test-shortcode-content" in wordpress
	 And the "content" "Test Shortcode Content" has the content "Letterpress readymade cronut"
    Given I have "page" with the title "Test Shortcode Page" and the slug "test-shortcode-page" in wordpress
     And I "append" the "content" shortcode to the "content" post titled "Test Shortcode Content" by "id" to the "page" post titled "Test Shortcode Page"
    Given I have "content" with the title "Test Shortcode Content 2" and the slug "test-shortcode-content2" in wordpress 
     And I "append" the "content" shortcode to the "content" post titled "Test Shortcode Content" by "id" to the "content" post titled "Test Shortcode Content 2"     
       
Scenario: View Short Code Content in Page
	Given I am on "/test-shortcode-page"
	Then I should see "Letterpress readymade cronut"
    
#Scenario: View Short Code in Single
	#Given I am on "/test-shortcode-content2"
	#Then I should not see "Letterpress readymade cronut"    
