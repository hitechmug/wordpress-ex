Feature: Font Test
As an admin user, I would like the text content I add to the site to default to using 
the approved font families and font sizes.

Background: 
	Given I have logged into wordpress as "admin" with the password "JTK17[07E"
	Given I have "content" with the title "Font Test" and the slug "font-test" in wordpress 

@javascript
Scenario: Correct font displays for headers
	Given I go to the wordpress "content" post titled "Font Test" to edit it
	And I fill in the "#content" element with "<h1>This is a Header</h1><p>This is a paragraph</p>"
	And I press "Update"
	And I am on "/content/font-test"
	Then the "h1" element should have a css setting "font-family" that "contains" "Brandon Grot W01 Bold"
	And the "p" element should have a css setting "font-family" that "contains" "Helvetica Neue"
	And the "p" element should have a css setting "font-size" that "contains" "13px"
