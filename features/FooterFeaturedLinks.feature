Feature: Footer Featured Links
As an admin user, I would like the ability to promote 2 site pages in the footer of every page.

Background:
	Given I have started a new session

Scenario: Ability to click 'careers'
	Given I am on "/home-page"
	When I follow "Careers"
	Then I should be on "/jobs/"
	When I follow "Contact"
	Then I should be on "/contact/"