Feature: Text Pages
In order to communicate
As a website admin
I would like to be able to create text web pages

Background: 
	Given I have logged into wordpress as "admin" with the password "JTK17[07E"

Scenario Outline: Page Type Creation Testing
    Given I am on "/wp-admin" 
    Given I have "<type>" with the title "<title>" and the slug "<slug>" in wordpress
	  And the "<type>" "<title>" has the content "<content>"
	  And the "<type>" "<title>" has the "gsdm_content_template_meta_box" "gsdm_content_type" set to "text"
	 When I go to "<url>"
     Then I should see "<find>"

Examples:
| type    | title               | slug               | url							| find        | content                                                                                                                                                           |
| content | Simple Content Test | text-page-2content | /content/text-page-2content	| shackalack  | Lorizzle go to hizzle dolor pot check out this, consectetuer adipiscing boom shackalack. Nullizzle pot phat, aliquet dope, rizzle quis, gravida vizzle, for sure. |
| page    | Simple Page Test    | text-page-1        | /text-page-1					| Kickstarter | Next level Kickstarter yr hashtag. +1 sustainable Banksy fanny pack, single-origin coffee whatever brunch ethical fixie forage.                                   |
| page    | Simple Page Test    | text-page-1        | /text-page-1					| shackalack | Next level [content slug='text-page-2content'] Kickstarter yr hashtag. +1 sustainable Banksy fanny pack, single-origin coffee whatever brunch ethical fixie forage.                  |

