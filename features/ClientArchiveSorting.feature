Feature: Client Archive Sorting
As an admin user, I would like the ability to sort the client logos 
so that I can determine the order that they will appear in the grid on the page.
* All client posts should display on a single page

Background:
	Given I have logged into wordpress as "admin" with the password "JTK17[07E"
	Given I have uploaded the image "testPattern1.jpg" into the wordpress media library
	 And I have uploaded the image "testPattern2.jpg" into the wordpress media library
	Given I have "client" with the title "Test Client Sort Logo1" and the slug "test-client-sort-logo1" in wordpress
	 And the "attachment" titled "testPattern1" is attached as "gsdm_client_logos_meta_box" meta to the "client" titled "Test Client Sort Logo1" as "gsdm_display_logo"
	 And the "attachment" titled "testPattern2" is attached as "gsdm_client_logos_meta_box" meta to the "client" titled "Test Client Sort Logo1" as "gsdm_hover_logo"
	Given I have "client" with the title "Test Client Sort Logo2" and the slug "test-client-sort-logo2" in wordpress
	 And the "attachment" titled "testPattern2" is attached as "gsdm_client_logos_meta_box" meta to the "client" titled "Test Client Sort Logo2" as "gsdm_display_logo"
	 And the "attachment" titled "testPattern1" is attached as "gsdm_client_logos_meta_box" meta to the "client" titled "Test Client Sort Logo2" as "gsdm_hover_logo"
	Given I have "content" with the title "Test Client Grid Sort Content" and the slug "test-client-grid-sort-content" in wordpress
	 And the "content" "Test Client Grid Sort Content" has the "gsdm_content_template_meta_box" "gsdm_content_type" set to "client-grid"
	Given I have "page" with the title "Test Client Grid Sort Page" and the slug "test-client-grid-sort" in wordpress
	 And the "page" "Test Client Grid Sort Page" has the page template set to "page-content-wizard.php"
	 And the "page" "Test Client Grid Sort Page" has the "gsdm_page_content_repeater_meta_box" "gsdm_content_repeater" set to ""
	 And the "page" "Test Client Grid Sort Page" has the "content" "Test Client Grid Sort Content" added to the repeater

@javascript
Scenario: Ability to drag archive items
	Given I am on "/wp-admin/edit.php?post_type=client"
	Then the "#the-list" element should have the attribute "class" that contains "ui-sortable"
	 And the "#the-list tr" element should have the attribute "class" that contains "ui-sortable-handle"

@javascript
Scenario: Ability to view all client posts on a single page
	Given I have "client" with the title "Test Client Sort Logo3" and the slug "test-client-sort-logo3" in wordpress
	 And I have "client" with the title "Test Client Sort Logo4" and the slug "test-client-sort-logo4" in wordpress
	 And I have "client" with the title "Test Client Sort Logo5" and the slug "test-client-sort-logo5" in wordpress
	 And I have "client" with the title "Test Client Sort Logo6" and the slug "test-client-sort-logo6" in wordpress
	 And I have "client" with the title "Test Client Sort Logo7" and the slug "test-client-sort-logo7" in wordpress
	 And I have "client" with the title "Test Client Sort Logo8" and the slug "test-client-sort-logo8" in wordpress
	 And I have "client" with the title "Test Client Sort Logo9" and the slug "test-client-sort-logo9" in wordpress
	 And I have "client" with the title "Test Client Sort Logo10" and the slug "test-client-sort-logo10" in wordpress
	 And I have "client" with the title "Test Client Sort Logo11" and the slug "test-client-sort-logo11" in wordpress
	 And I have "client" with the title "Test Client Sort Logo12" and the slug "test-client-sort-logo12" in wordpress
	 And I have "client" with the title "Test Client Sort Logo13" and the slug "test-client-sort-logo13" in wordpress
	 And I have "client" with the title "Test Client Sort Logo14" and the slug "test-client-sort-logo14" in wordpress
	 And I have "client" with the title "Test Client Sort Logo15" and the slug "test-client-sort-logo15" in wordpress
	 And I have "client" with the title "Test Client Sort Logo16" and the slug "test-client-sort-logo16" in wordpress
	 And I have "client" with the title "Test Client Sort Logo17" and the slug "test-client-sort-logo17" in wordpress
	 And I have "client" with the title "Test Client Sort Logo18" and the slug "test-client-sort-logo18" in wordpress
	 And I have "client" with the title "Test Client Sort Logo19" and the slug "test-client-sort-logo19" in wordpress
	 And I have "client" with the title "Test Client Sort Logo20" and the slug "test-client-sort-logo20" in wordpress
	 And I have "client" with the title "Test Client Sort Logo21" and the slug "test-client-sort-logo21" in wordpress
	 And I have "client" with the title "Test Client Sort Logo22" and the slug "test-client-sort-logo22" in wordpress
	 And I have "client" with the title "Test Client Sort Logo23" and the slug "test-client-sort-logo23" in wordpress
	 And I have "client" with the title "Test Client Sort Logo24" and the slug "test-client-sort-logo24" in wordpress
	 And I have "client" with the title "Test Client Sort Logo25" and the slug "test-client-sort-logo25" in wordpress
	 And I have "client" with the title "Test Client Sort Logo26" and the slug "test-client-sort-logo26" in wordpress
	 And I have "client" with the title "Test Client Sort Logo27" and the slug "test-client-sort-logo27" in wordpress
	 And I have "client" with the title "Test Client Sort Logo28" and the slug "test-client-sort-logo28" in wordpress
	 And I have "client" with the title "Test Client Sort Logo29" and the slug "test-client-sort-logo29" in wordpress
	 And I have "client" with the title "Test Client Sort Logo30" and the slug "test-client-sort-logo30" in wordpress
	When I am on "/wp-admin/edit.php?post_type=client"
	Then I should see at least "30" ".wp-list-table tr" elements
	


	


