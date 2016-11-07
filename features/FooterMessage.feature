Feature: Footer Message
As an admin user I would like the ability to include a unique customizable message in the footer of every page
The post pages will have one message for each post type

Background:
	Given I have logged into wordpress as "admin" with the password "JTK17[07E"
	And the theme setting "event_footer_message" is set to "Event Footer Message"
	And the theme setting "news_footer_message" is set to "News Footer Message"
	And the theme setting "blog_footer_message" is set to "Blog Footer Message"
	And I have "event" with the title "Footer Message Blog Post" and the slug "footer-message-event-post" in wordpress
	And I have "news" with the title "Footer Message Blog Post" and the slug "footer-message-news-post" in wordpress
	And I have "post" with the title "Footer Message Blog Post" and the slug "footer-message-blog-post" in wordpress

Scenario: View footer message on the event post pages
	Given I am on "/event/footer-message-event-post"
	Then I should see "Event Footer Message"

Scenario: View footer message on the news post pages
	Given I am on "/news/footer-message-news-post"
	Then I should see "News Footer Message"

Scenario: View footer message on the blog post pages
	Given I am on "/footer-message-blog-post"
	Then I should see "Blog Footer Message"

	



