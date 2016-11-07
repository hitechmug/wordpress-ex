Feature: Menus
As an admin user I would like the ability to customize groups of links on the site

Background:
	Given I have logged into wordpress as "admin" with the password "JTK17[07E"

Scenario: Ability to choose which pages show up in menu
	Given I am on "/wp-admin/nav-menus.php"
	Then the "select" element should contain "Header"
	 And the "select" element should contain "Legal"
	 And the "select" element should contain "Social"
	 And the "select" element should contain "Footer"
	 And the "select" element should contain "Featured"
