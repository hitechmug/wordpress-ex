Feature: Footer Links
As a gsdm.com admin I would like 
to be able to display site links at the footer of the page.

Background:
	Given I have started a new session

Scenario: Ability to see footer links on site
	Given I am on "/home-page"
	Then I should see an "ul#menu-footer" element


