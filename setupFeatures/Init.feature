Feature: Initialize Basic Stuff

Scenario: Default Wordpress Settings
	Given I have logged into wordpress as "admin" with the password "JTK17[07E"
	  And I am using the theme "gsdm"
	  And I create a menu named "Header"
	  And I create a menu named "Footer"
	  And I create a menu named "Social"
	  And I create a menu named "Legal"
	  And I create a menu named "Featured"
	  And I set the menu "Header" to the theme location "header"
	  And I set the menu "Footer" to the theme location "footer"
	  And I set the menu "Social" to the theme location "social"
	  And I set the menu "Legal" to the theme location "legal"
	  And I set the menu "Featured" to the theme location "featured"
	  And I add a new menu item "Home" to the Menu "Header" that goes to "/home-page/"
	  And I add a new menu item "About" to the Menu "Header" that goes to "/about/"
	  And I add a new menu item "Home" to the Menu "Footer" that goes to "/home-page/"
	  And I add a new menu item "Home" to the Menu "Social" that goes to "/home-page/"
	  And I add a new menu item "Home" to the Menu "Legal" that goes to "/home-page/"
	  And I add a new menu item "Careers" to the Menu "Featured" that goes to "/jobs/"
	  And I add a new menu item "Contact" to the Menu "Featured" that goes to "/contact/"
	  And I have changed the permalink to "/%postname%/"
      And I have "page" with the title "Home Page" and the slug "home-page" in wordpress
	  And I have "page" with the title "About Page" and the slug "about" in wordpress
	  And I have "page" with the title "Jobs Page" and the slug "jobs" in wordpress
	  And I have "page" with the title "Contact Page" and the slug "contact" in wordpress
	  And I set the front page to "Home Page"