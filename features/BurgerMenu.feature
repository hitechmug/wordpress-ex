Feature: Burger Menu
As a gsdm.com admin I would like 
to be able to select and 
have these pages display in a slide out menu.

Background:
	Given I am on "/home-page"

@javascript
Scenario: Ability to see burger menu and have menu open and close
	When I press "main-menu-btn"
	 And I wait for "1000"
	Then I should see a "#main-menu.in" element
	When I press "main-menu-btn"
	 And I wait for "1000"
	Then I should not see a "#main-menu.in" element

@javascript
Scenario: Ability to view nav items, follow links 
	When I press "main-menu-btn"
	 And I wait for "1000"
	Then I should see "Home"
	 And I should see "About"
	When I follow "About"
	 And I wait for "1000"
	Then I should be on "/about/"



