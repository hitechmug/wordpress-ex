Feature: Client Grid Columns
As an admin user, I would like to be able to add client logos to the site
and to define the number of columns in the client grid individually for desktop, tablet, and mobile devices.

Background:
	Given I have logged into wordpress as "admin" with the password "JTK17[07E"
	Given I have uploaded the image "testPattern1.jpg" into the wordpress media library
	 And I have uploaded the image "testPattern2.jpg" into the wordpress media library
	Given I have "client" with the title "Test Client Logo1" and the slug "test-client-logo1" in wordpress
	 And the "attachment" titled "testPattern1" is attached as "gsdm_client_logos_meta_box" meta to the "client" titled "Test Client Logo1" as "gsdm_display_logo"
	 And the "attachment" titled "testPattern2" is attached as "gsdm_client_logos_meta_box" meta to the "client" titled "Test Client Logo1" as "gsdm_hover_logo"
	Given I have "client" with the title "Test Client Logo2" and the slug "test-client-logo2" in wordpress
	 And the "attachment" titled "testPattern1" is attached as "gsdm_client_logos_meta_box" meta to the "client" titled "Test Client Logo2" as "gsdm_display_logo"
	 And the "attachment" titled "testPattern2" is attached as "gsdm_client_logos_meta_box" meta to the "client" titled "Test Client Logo2" as "gsdm_hover_logo"
	Given I have "content" with the title "Test Client Grid Content" and the slug "test-client-grid-content" in wordpress
	 And the "content" "Test Client Grid Content" has the "gsdm_content_template_meta_box" "gsdm_content_type" set to "client-grid"
	 And the "content" "Test Client Grid Content" has the "gsdm_content_section_header_meta_box" "gsdm_section_header_line_1" set to "Section"
	 And the "content" "Test Client Grid Content" has the "gsdm_content_section_header_meta_box" "gsdm_section_header_line_2" set to "Header"
	Given I have "page" with the title "Test Client Grid Page" and the slug "test-client-grid" in wordpress
	 And the "page" "Test Client Grid Page" has the page template set to "page-content-wizard.php"
	 And the "page" "Test Client Grid Page" has the "gsdm_page_content_repeater_meta_box" "gsdm_content_repeater" set to ""
	 And the "page" "Test Client Grid Page" has the "content" "Test Client Grid Content" added to the repeater

Scenario Outline: Grid Column Setting Tests
    Given I go to the wordpress "content" post titled "Test Client Grid Content" to edit it
	 And I select "<xs_option>" from "gsdm_client_grid_cols_xs"
	 And I select "<sm_option>" from "gsdm_client_grid_cols_sm"
	 And I select "<md_option>" from "gsdm_client_grid_cols_md"
	 And I select "<lg_option>" from "gsdm_client_grid_cols_lg"
	 And I press "Update"
	When I am on "/test-client-grid"
	Then I should see "Section"
	And I should see "Header"
	And I should see an "<xs_class>" element
	 And I should see an "<sm_class>" element
	 And I should see an "<md_class>" element
	 And I should see an "<lg_class>" element

Examples:
| xs_option	| sm_option	| md_option | lg_option	| xs_class		| sm_class		| md_class		| lg_class		|
| 1         | 1			| 1			| 1			| .col-xs-12	| .col-sm-12	| .col-md-12	| .col-lg-12	|	                                                                                                                           
| 2         | 2			| 2			| 2			| .col-xs-6		| .col-sm-6		| .col-md-6		| .col-lg-6		|                                                                                                                         
| 3         | 3			| 3			| 3			| .col-xs-4		| .col-sm-4		| .col-md-4		| .col-lg-4		|                                                                                                                         
| 4         | 4			| 4			| 4			| .col-xs-3		| .col-sm-3		| .col-md-3		| .col-lg-3		|                                                                                                                        
| 5         | 5			| 5			| 5			| .col-xs-2-4	| .col-sm-2-4	| .col-md-2-4	| .col-lg-2-4	|                                                                                                                           
| 6         | 6			| 6			| 6			| .col-xs-2		| .col-sm-2		| .col-md-2		| .col-lg-2		|     


Scenario: Logo link metabox saves 
	Given I go to the wordpress "content" post titled "Test Client Grid Content" to edit it
	When I select "Test Client Grid Page" from "gsdm_client_grid_page_link"
	 And I press "Update"
	Then I should see that the "Test Client Grid Page" option from "gsdm_client_grid_page_link" is selected 
	
Scenario: Logo links to correct page	 
	Given I have "page" with the title "Test Logo Link Page" and the slug "test-logo-link" in wordpress
	 And the "content" "Test Client Grid Content" has the "gsdm_content_client_grid_meta_box" "gsdm_client_grid_page_link" set to the id for "page" "Test Logo Link Page"  
	 And I am on "/test-client-grid/"
	When I follow "Test Client Logo1"
	Then I should be on "/test-logo-link/#Test-Client-Logo1"                                                                                               


