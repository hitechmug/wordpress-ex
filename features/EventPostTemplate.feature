Feature: Event Post Template
As an admin user, I would like the ability to add event stories to the website. 
Event stories will contain a title, a date, and body copy. 


Background:
	Given I have logged into wordpress as "admin" with the password "JTK17[07E"
	 And I have "event" with the title "Test Event Post" and the slug "test-event-post" in wordpress
	 And the "event" "Test Event Post" has the content "Buseyisms: Fart stands for Feeling A Rectal Transmission"
	 And the "event" "Test Event Post" has the excerpt "Hunt by meowing loudly at 5am next to human slave food dispenser"

Scenario: Ability to view post content
	Given I am on "/event/test-event-post"
	Then I should see "Event"
	 And I should see "Test Event Post"
	 And I should see "Buseyisms: Fart stands for Feeling A Rectal Transmission"
	 And I should see the publish date for "event" "Test Event Post" in the ".post-date" element

@javascript
Scenario: Ability to share on linkedin
	Given I am on "/event/test-event-post"
	Then the ".share-icons .linkedin a" element should have the attribute "href" that contains "https://www.linkedin.com/shareArticle?mini=true&url=http%3A%2F%2Ftest.gsdm.com%2Fevent%2Ftest-event-post%2F&title=Test+Event+Post&summary=Hunt+by+meowing+loudly+at+5am+next+to+human+slave+food+dispenser&source=GSD%26M"
	
@javascript
Scenario: Ability to share on facebook
	Given I am on "/event/test-event-post"
	Then the ".share-icons .facebook a" element should have the attribute "href" that contains "https://www.facebook.com/sharer/sharer.php?u=http%3A%2F%2Ftest.gsdm.com%2Fevent%2Ftest-event-post%2F"

@javascript
Scenario: Ability to share on twitter
	Given I am on "/event/test-event-post"
	Then the ".share-icons .twitter a" element should have the attribute "href" that contains "https://twitter.com/intent/tweet?text=Test+Event+Post&url=http%3A%2F%2Ftest.gsdm.com%2Fevent%2Ftest-event-post%2F&via=gsdm"

@javascript
Scenario: Ability to share by email
	Given I am on "/event/test-event-post"
	Then the ".share-icons .email a" element should have the attribute "href" that contains "mailto:?subject=Check%20this%20out%20from%20GSD%26M%3A%20Test%20Event%20Post&body=Hunt%20by%20meowing%20loudly%20at%205am%20next%20to%20human%20slave%20food%20dispenser%0D%0Ahttp%3A%2F%2Ftest.gsdm.com%2Fevent%2Ftest-event-post%2F"

@javascript
Scenario: Ability to save a header image
	Given I go to the wordpress "event" post titled "Test Event Post" to edit it
	When I press "Choose Image"
	Then I should see the wordpress choose image dialog

@javascript
Scenario: Ability to view a header image
	Given I have uploaded the image "testPattern1.jpg" into the wordpress media library
	 And the "attachment" titled "testPattern1" is attached as "gsdm_post_header_image_meta_box" meta to the "event" titled "Test Event Post" as "gsdm_post_image"
	When I am on "/event/test-event-post"
	Then the "header" element should have a css setting "background-image" that "contains" "testPattern1"

#Related Posts display for all post types tested in separate test
#Category Clouds tested in separate test
