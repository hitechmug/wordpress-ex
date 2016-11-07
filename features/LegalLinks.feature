Feature: Legal Links
As an admin user, I would like to be able to add links to the legal pages in the footer of every page. 
I would also like to add text that says "Copyright (C) " and the current year.

Background:
	Given I have started a new session

@javascript
Scenario: Ability to see legal links on site
	Given I am on "/home-page"
	 Then I should see an "ul#menu-legal" element
	 And I should see the current year in the "#menu-legal .legal-copyright" element


