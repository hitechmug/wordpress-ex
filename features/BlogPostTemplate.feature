Feature: Blog Post Template
As an admin user I would like to add blog posts to the site. Posts should include:
* Post date
* Author
* Author Photo
* Title
* Body copy
As a blog author, I would like the ability to use a custom headshot for my blog posts rather than the static employee photo.
* Add another image uploader on the user profile for headshots. #tested on EmployeePhotoGrid.feature
* Make sure it is only editable by the administrator role. #tested on EmployeePhotoGrid.feature
* Update blog posts' author photos display to first check if a headshot exists. If not check if the static employee photo exists.

Background:
	Given I have logged into wordpress as "admin" with the password "JTK17[07E"
	Given the "gsdm_employee_photo_static" metadata for the user "admin" is not set
	Given the "gsdm_employee_headshot" metadata for the user "admin" is not set
	 And I have "post" with the title "Test Blog Post" and the slug "test-blog-post" in wordpress
	 And the "post" "Test Blog Post" has the content "Buseyisms: Fart stands for Feeling A Rectal Transmission"
	 And the "post" "Test Blog Post" has the excerpt "Hunt by meowing loudly at 5am next to human slave food dispenser"

Scenario: Ability to view post content
	Given I am on "/test-blog-post"
	Then I should see "Blog"
	 And I should see "Test Blog Post"
	 And I should see "Buseyisms: Fart stands for Feeling A Rectal Transmission"
	 And I should see "admin"
	 And I should see the publish date for "post" "Test Blog Post" in the ".post-date" element

@javascript
Scenario: Ability to share on linkedin
	Given I am on "/test-blog-post"
	Then the ".share-icons .linkedin a" element should have the attribute "href" that contains "https://www.linkedin.com/shareArticle?mini=true&url=http%3A%2F%2Ftest.gsdm.com%2Ftest-blog-post%2F&title=Test+Blog+Post&summary=Hunt+by+meowing+loudly+at+5am+next+to+human+slave+food+dispenser&source=GSD%26M"

@javascript
Scenario: Ability to share on facebook
	Given I am on "/test-blog-post"
	Then the ".share-icons .facebook a" element should have the attribute "href" that contains "https://www.facebook.com/sharer/sharer.php?u=http%3A%2F%2Ftest.gsdm.com%2Ftest-blog-post%2F"

@javascript
Scenario: Ability to share on twitter
	Given I am on "/test-blog-post"
	Then the ".share-icons .twitter a" element should have the attribute "href" that contains "https://twitter.com/intent/tweet?text=Test+Blog+Post&url=http%3A%2F%2Ftest.gsdm.com%2Ftest-blog-post%2F&via=gsdm"

@javascript
Scenario: Ability to share by email
	Given I am on "/test-blog-post"
	Then the ".share-icons .email a" element should have the attribute "href" that contains "mailto:?subject=Check%20this%20out%20from%20GSD%26M%3A%20Test%20Blog%20Post&body=Hunt%20by%20meowing%20loudly%20at%205am%20next%20to%20human%20slave%20food%20dispenser%0D%0Ahttp%3A%2F%2Ftest.gsdm.com%2Ftest-blog-post%2F"


@javascript
Scenario: Ability to save a header image
	Given I go to the wordpress "post" post titled "Test Blog Post" to edit it
	When I press "Choose Image"
	Then I should see the wordpress choose image dialog

@javascript
Scenario: Ability to view a header image
	Given I have uploaded the image "testPattern1.jpg" into the wordpress media library
	 And the "attachment" titled "testPattern1" is attached as "gsdm_post_header_image_meta_box" meta to the "post" titled "Test Blog Post" as "gsdm_post_image"
	When I am on "/test-blog-post"
	Then the "header" element should have a css setting "background-image" that "contains" "testPattern1"

@javascript
Scenario: Ability to view a blog author image
	Given I have uploaded the image "employee-photo.png" into the wordpress media library
	 And the user "admin" has the image "employee-photo" added to the "gsdm_employee_photo_static" metadata	  
	 And the "post" "Test Blog Post" has the author "admin"
	When I am on "/test-blog-post"
	Then the ".post-author-photo" element should have a css setting "background-image" that "contains" "employee-photo"

@javascript
Scenario: Ability to view a blog author headshot
	Given I have uploaded the image "employee-headshot.jpg" into the wordpress media library
	 And the user "admin" has the image "employee-headshot" added to the "gsdm_employee_headshot" metadata	  
	 And the "post" "Test Blog Post" has the author "admin"
	When I am on "/test-blog-post"
	Then the ".post-author-photo" element should have a css setting "background-image" that "contains" "employee-headshot"

@javascript
Scenario: Absence of blog author headshot or static photo bubble if no photo has been uploaded
	Given the "gsdm_employee_headshot" metadata for the user "admin" is not set	 	  
	 And the "post" "Test Blog Post" has the author "admin"
	When I am on "/test-blog-post"
	Then I should not see an ".post-author-photo" element

@javascript
	Scenario: Absence of blog author headshot or static photo bubble if no photo has been uploaded
	Given the "gsdm_employee_photo_static" metadata for the user "admin" is not set	 	  
	 And the "post" "Test Blog Post" has the author "admin"
	When I am on "/test-blog-post"
	Then I should not see an ".post-author-photo" element

#Related Posts display for all post types tested in separate test
#Recent Posts Carousel tested in separate test
#Category Clouds tested in separate test
