Feature: Instagram Feed
As an admin user, I would like to add images from our Instagram feed to the site footer. The hashtag to watch is #GSDM. 
The display for the images should be a grid of 4 columns.

Background:
	Given I have logged into wordpress as "admin" with the password "JTK17[07E"
	Given the "contributor" user "user1" with the password "testuser1" exists
	 And the "contributor" user "user2" with the password "testuser2" exists
	 And the "contributor" user "user3" with the password "testuser3" exists
	 And the "contributor" user "user4" with the password "testuser4" exists
	 And the "contributor" user "user5" with the password "testuser5" exists
	 And the "contributor" user "user6" with the password "testuser6" exists
	Given the "gsdm_user_instagram_username" metadata for the user "user1" is set to "dickensmb"
	 And the "gsdm_user_instagram_username" metadata for the user "user2" is set to "wfmarceau"
	 And the "gsdm_user_instagram_username" metadata for the user "user3" is set to "sgilliam"
	 And the "gsdm_user_instagram_username" metadata for the user "user4" is set to "jlburruss"
	 And the "gsdm_user_instagram_username" metadata for the user "user5" is set to "caitcmcd"
	 And the "gsdm_user_instagram_username" metadata for the user "user6" is not set
	Given the "gsdm_user_instagram_userid" metadata for the user "user1" is set to "16233883"
	 And the "gsdm_user_instagram_userid" metadata for the user "user2" is set to "1823685"
	 And the "gsdm_user_instagram_userid" metadata for the user "user3" is set to "8506440"
	 And the "gsdm_user_instagram_userid" metadata for the user "user4" is set to "2777417"
	 And the "gsdm_user_instagram_userid" metadata for the user "user5" is set to "11053494"
	 And the "gsdm_user_instagram_userid" metadata for the user "user6" is not set
	Given the "gsdm_user_instagram_feed" metadata for the user "user1" is set to "on"
	 And the "gsdm_user_instagram_feed" metadata for the user "user2" is set to "on"
	 And the "gsdm_user_instagram_feed" metadata for the user "user3" is set to "on"
	 And the "gsdm_user_instagram_feed" metadata for the user "user4" is set to "on"
	 And the "gsdm_user_instagram_feed" metadata for the user "user5" is not set
	 And the "gsdm_user_instagram_feed" metadata for the user "user6" is not set

Scenario: Feed displays on the page
	#Given I am on "/home-page"
	#Then the "#instagram-feed iframe" element should have the attribute "src" that contains "/wp-content/themes/gsdm/instagram.php" 

Scenario: User can add instagram name to profile
	Given I am on "/wp-admin/profile.php"
	When I fill in "gsdm_user_instagram_username" with "instaname"
	 And I press "Update Profile"
	Then the "gsdm_user_instagram_username" field should contain "instaname"
	When I fill in "gsdm_user_instagram_username" with ""
	 And I press "Update Profile"
	Then the "gsdm_user_instagram_username" field should not contain "instaname"

Scenario: User can add instagram user to feed
	Given I am on "/wp-admin/profile.php"
	When I check "gsdm_user_instagram_feed"
	When I press "Update Profile"
	Then the checkbox "gsdm_user_instagram_feed" should be checked
	When I uncheck "gsdm_user_instagram_feed"
	Then I press "Update Profile"
	Then the checkbox "gsdm_user_instagram_feed" should not be checked

Scenario: Only approved users display in the feed
	Given the "gsdm_user_instagram_feed" metadata for the user "user2" is not set
	 And the "gsdm_user_instagram_feed" metadata for the user "user3" is not set
	 And the "gsdm_user_instagram_feed" metadata for the user "user4" is not set
	Given I am on "/wp-content/themes/gsdm/instagram.php?fake_instagram=1"
	Then I should see 2 "#instagram li" elements
	And the "#instagram li:first-child img" element should have the attribute "alt" that contains "Ponies are welcome for breakfast at Kerbey Lane #nofilter #gsdm" 
	
Scenario: Grid of 12 images is displaying with 4 active contributors
	Given I am on "/wp-content/themes/gsdm/instagram.php?fake_instagram=1"
	Then I should see 12 "#instagram li" elements

Scenario: Feed sorts correctly with 2 active contributors
	Given the "gsdm_user_instagram_feed" metadata for the user "user3" is not set
	 And the "gsdm_user_instagram_feed" metadata for the user "user4" is not set
	Given I am on "/wp-content/themes/gsdm/instagram.php?fake_instagram=1"
	Then I should see 9 "#instagram li" elements
	And the "#instagram li:first-child img" element should have the attribute "alt" that contains "not a bad day at work. #gsdm #toroymoi #austin"

Scenario: Feed sorts correctly with 4 active contributors
	Given I am on "/wp-content/themes/gsdm/instagram.php?fake_instagram=1"
	Then the "#instagram li:first-child img" element should have the attribute "alt" that contains "Using the community garden as my office until next meeting." 