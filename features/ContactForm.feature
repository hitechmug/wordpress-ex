Feature: Contact Form
As an admin user, I would like to add a form for users to fill out so that they can initiate communication with various departments within the agency.
As a contact form message recipient, I would like the contact form to have error validation included to ensure that messages received are more informative.
* All fields are required
* Email field should validate to a valid email address
* First, Last, and Phone should have no more than 50 characters
* Message should allow no more than 200 characters.

Background:
	Given I have logged into wordpress as "admin" with the password "JTK17[07E"
	Given I have "content" with the title "Test Contact Form" and the slug "test-contact-form" in wordpress
	 And the "content" "Test Contact Form" has the "gsdm_content_template_meta_box" "gsdm_content_type" set to "contact-form"
	 And the "content" "Test Contact Form" has the "gsdm_content_section_header_meta_box" "gsdm_section_header_line_1" set to "Section"
	 And the "content" "Test Contact Form" has the "gsdm_content_section_header_meta_box" "gsdm_section_header_line_2" set to "Header"
	Given I have "page" with the title "Test Contact Form Page" and the slug "test-contact-form-page" in wordpress
	 And the "page" "Test Contact Form Page" has the page template set to "page-content-wizard.php"
	 And the "page" "Test Contact Form Page" has the "gsdm_page_content_repeater_meta_box" "gsdm_content_repeater" set to ""
     And the "page" "Test Contact Form Page" has the "content" "Test Contact Form" added to the repeater

Scenario: Intro Copy Saves
	Given I go to the wordpress "content" post titled "Test Contact Form" to edit it
	When I fill in "gsdm_contact_form_intro_copy" with "I would like to give you a backstage pass to my imagination."
	 And I press "Update"
	Then the "gsdm_contact_form_intro_copy" field should contain "I would like to give you a backstage pass to my imagination."

Scenario: Intro Copy Is Visible On Page
	Given the "content" "Test Contact Form" has the "gsdm_content_contact_form_meta_box" "gsdm_contact_form_intro_copy" set to "These kind of things only happen for the first time once."
	When I am on "/test-contact-form-page"
	Then I should see "These kind of things only happen for the first time once."

Scenario: Contact Form Contains Expected Elements
	When I am on "/test-contact-form-page/?fake_form=1"
	Then I should see "Section"
	 And I should see "Header"
	 And I should see "First Name"
	 And I should see "Last Name"
	 And I should see "Email Address"
	 And I should see "Phone Number"
	 And I should see "Regarding"
	 And I should see "Location"
	 And I should see "Message"

@javascript
Scenario: Entering Valid Data And Clicking Submit Shows No Input Errors (Captcha stops the confirmation screen)
	When I am on "/test-contact-form-page/?fake_form=1"
	 And I fill in "First Name" with "Test"
	 And I fill in "Last Name" with "Tester"
	 And I fill in "Email Address" with "test@test.com"
	 And I fill in "Phone" with "555-555-1234"
	 And I press the ".field.regarding .cs-placeholder" element
	 And I press the "li[data-value=newbiz]" element
	 And I press the ".field.location .cs-placeholder" element
	 And I press the "li[data-value^=Austin]" element
	 And I fill in "Message" with "It depends on your ability to take a risk on eating something when you dont know what it is. Thats why I enjoy eating in the dark."
	 And I wait for "1000"
	Then I should not see "First name is required"
	 And I should not see "Last name is required"
	 And I should not see "A valid email address is required"
	 And I should not see "Phone number is required"
	 And I should not see "Message is required"

@javascript
Scenario: Entering Empty Data Shows Error Messaging. Subsequent Submit Of Valid Data Garners Success.
	When I am on "/test-contact-form-page/?fake_form=1"
	 And I press "Submit"
	Then I should see "First name is required"
	 And I should see "Last name is required"
	 And I should see "A valid email address is required"
	 And I should see "Phone number is required"
	 And I should see "Message is required"
	When I fill in "First Name" with "Test"
	 And I fill in "Last Name" with "Tester"
	 And I fill in "Email Address" with "test@test.com"
	 And I fill in "Phone" with "555-555-1234"
	 And I press the ".field.regarding .cs-placeholder" element
	 And I press the "li[data-value=newbiz]" element
	 And I press the ".field.location .cs-placeholder" element
	 And I press the "li[data-value^=Austin]" element
	 And I fill in "Message" with "It depends on your ability to take a risk on eating something when you dont know what it is. Thats why I enjoy eating in the dark."
	 And I press "Submit"
	 And I wait for "1000"
	Then I should not see "First name is required"
	 And I should not see "Last name is required"
	 And I should not see "A valid email address is required"
	 And I should not see "Phone number is required"
	 And I should not see "Message is required"

@javascript
Scenario: Entering Bad Email Data Shows Error Messaging. Subsequent Submit Of Valid Data Garners Success.
	When I am on "/test-contact-form-page/?fake_form=1"
	 And I fill in "First Name" with "Test"
	 And I fill in "Last Name" with "Tester"
	 And I fill in "Email Address" with "testtester"
	 And I fill in "Phone" with "555-555-1234"
	 And I press the ".field.regarding .cs-placeholder" element
	 And I press the "li[data-value=newbiz]" element
	 And I press the ".field.location .cs-placeholder" element
	 And I press the "li[data-value^=Austin]" element
	 And I fill in "Message" with "It depends on your ability to take a risk on eating something when you dont know what it is. Thats why I enjoy eating in the dark."
	 And I press "Submit"
	Then I should see "A valid email address is required"
	When I fill in "Email Address" with "test@tester.com"
	 And I press "Submit"
	 And I wait for "1000"
	And I should not see "A valid email address is required"

@javascript
Scenario: Maximizing Character Count Limits
	When I am on "/test-contact-form-page/?fake_form=1"
	When I fill in "First Name" with "FIRSTNAMEFIRSTNAMEFIRSTNAMEFIRSTNAMEFIRSTNAMEFIRSTNAME"
	Then the "First Name" field should contain "FIRSTNAMEFIRSTNAMEFIRSTNAMEFIRSTNAMEFIRSTNAMEFIRST"
	 And the "First Name" field should not contain "FIRSTNAMEFIRSTNAMEFIRSTNAMEFIRSTNAMEFIRSTNAMEFIRSTNAME"
	When I fill in "Last Name" with "LASTNAMELASTNAMELASTNAMELASTNAMELASTNAMELASTNAMELASTNAME"
	Then the "Last Name" field should contain "LASTNAMELASTNAMELASTNAMELASTNAMELASTNAMELASTNAMELA"
	 And the "Last Name" field should not contain "LASTNAMELASTNAMELASTNAMELASTNAMELASTNAMELASTNAMELASTNAME"
	When I fill in "Email Address" with "EMAILADDRESSEMAILADDRESSEMAILADDRESSEMAILADDRESSEMAILADDRESS"
	Then the "Email Address" field should contain "EMAILADDRESSEMAILADDRESSEMAILADDRESSEMAILADDRESSEM"
	 And the "Email Address" field should not contain "EMAILADDRESSEMAILADDRESSEMAILADDRESSEMAILADDRESSEMAILADDRESS"
	When I fill in "Phone" with "123456789012345678901234567890123456789012345678901234567890"
	Then the "Phone" field should contain "12345678901234567890123456789012345678901234567890"
	 And the "Phone" field should not contain "123456789012345678901234567890123456789012345678901234567890"
	When I fill in "Message" with "Have you urinated? Have you drained your bladder? Are you free? Because if you havent it will only come out later. I'm giving you some information that your bodily fluids may penetrate your clothing fibre's without warning."
	Then the "Message" field should contain "Have you urinated? Have you drained your bladder? Are you free? Because if you havent it will only come out later. I'm giving you some information that your bodily fluids may penetrate your clothing f"
	 And the "Message" field should not contain "Have you urinated? Have you drained your bladder? Are you free? Because if you havent it will only come out later. I'm giving you some information that your bodily fluids may penetrate your clothing fibre's without warning."


	