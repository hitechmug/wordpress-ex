Feature: Footer Image
As an admin user I would like the ability to include a customizable image in the footer of every page

Background:
	Given I have logged into wordpress as "admin" with the password "JTK17[07E"
	And I have uploaded the image "testPattern1.jpg" into the wordpress media library	
	And modify the theme customization "footer_image" to "testPattern1.jpg"

@javascript
Scenario: View footer image on the page
	Given I am on "/home-page"
	Then I should see a ".footer-image" element
	And the ".footer-image" element should have the attribute "style" that contains "testPattern1.jpg"
	

	
	
	



