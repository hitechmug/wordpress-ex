Feature: Client Taxonomy
As an admin user I would like to be able to tag posts/pages by client. 
I would like the list to be editable so that I can add new clients as I need, and separate from the free-form tag structure.

Background:
	Given I have logged into wordpress as "admin" with the password "JTK17[07E"

Scenario: Ability to view the taxonomy on posts
	Given I am on "/wp-admin/edit.php"
	Then I should see "Client Categories"

Scenario: Ability to view the taxonomy on pages
	Given I am on "/wp-admin/edit.php?post_type=page"
	Then I should see "Client Categories"


