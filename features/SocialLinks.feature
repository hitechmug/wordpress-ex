Feature: Social Links
As an admin user, I would like the ability to put links to our Twitter, Facebook, Instagram, LinkedIn, and YouTube pages in the footer of every page.

Background:
	Given I have started a new session

Scenario: Ability to see social links on site
	Given I am on "/home-page"
	Then I should see an "ul#menu-social" element