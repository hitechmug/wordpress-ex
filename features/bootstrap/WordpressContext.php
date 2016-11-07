<?php
require_once("MinkAssertions.php");

/**
 * WordpressContext short summary.
 *
 * WordpressContext description.
 *
 * @version 1.0
 * @author sfaulkne
 */
class WordpressContext extends MinkAssertions
{

    public function __construct()
    {
        parent::__construct();
        //need a better way to determine wordpress root
        $this->doc_root = __DIR__ . "/../../../../../";
        require_once($this->doc_root . "wp-config.php");
    }
    
    /**
     * @When /^I switch back from iframe$/
     */
    public function iSwitchBack()
    {
        $this->getSession()->switchToIFrame(null);
    }

    /**
     * @When /^I switch to the iframe "([^"]*)"$/
     */
    public function iSwitchToIframe($arg1 = null)
    {
        $this->getSession()->switchToIFrame($arg1);
    }

    // used for tests where we button press is failing below the fold
    /**
     * @Given /^I have maximized the browser window$/
     */
    public function iHaveMaximizedTheBrowserWindow()
    {
        $this->getSession()->maximizeWindow();
    }
    

    // used for tests where we don't need to log in
    /**
     * @Given /^I have started a new session$/
     */
    public function iHaveStartedANewSession()
    {
        $this->getSession()->restart();
    }

    
    /**
     * Logs into wordpress
     * 
     * @Given /^I have logged into wordpress as "([^"]*)" with the password "([^"]*)"$/
     */
    public function iHaveLoggedInWithTheUserAndThePassword($username, $password)
    {
        $this->getSession()->restart();

        $this->visit('/wp-admin');
        try {
            $this->fillField("user_login",$username);
            $this->fillField("user_pass",$password);
            $this->pressButton("wp-submit");
            
        
        } catch (Exception $e) {
            //return;
        }
        
        $this->assertPageContainsText("Howdy, " . $username);
        
    }
    
    /**
     * Logout of wordpress
     *
     * @Given /^I have logged out of wordpress$/
     */
    
    public function iHaveLoggedOut() {
        $this->visit( '/wp-login.php?action=logout' );
        $current_page = $this->getSession()->getPage();
        if ($current_page->hasLink('log out')) {
            $current_page->find('css', 'a')->click();
        }
    }    
    
    /**
     * Creates user in WordPress
     *
     * @Given /^the "([^"]*)" user "([^"]*)" with the password "([^"]*)" exists$/
     */
    public function theUserWithThePasswordExists($type, $name, $password)
    {
        
        $user = get_user_by('login', $name);
        if(!$user) {
            $user_id = wp_create_user($name, $password, $name.'@test.com');
            $user = new WP_User( $user_id );
            wp_update_user(array(
                'ID'    => $user_id,
                'nickname'  => $name
            ));
        } 
        
        // set role of user
        if( null != get_role( $type ) ) {
            $user->set_role( $type );
        } else {
            throw new Exception("Role " . $type . " doesn't exist in Wordpress.");
        }
        
    }
    
    
    /**
     * @Given /^the "([^"]*)" metadata for the user "([^"]*)" is not set$/
     */
    public function theMetadataForTheUserIsNotSet($meta_key, $name)
    {
        $user = get_user_by( 'login', $name );
        
        if(!$user) {
            throw new Exception("User " . $user . " doesn't exist.");
        } else {
            delete_user_meta($user->ID, $meta_key);
        }
    }

    
    
    /**
     * @Given /^the "([^"]*)" "([^"]*)" has the excerpt "([^"]*)"$/
     */
    public function theHasTheExcerpt($post_type, $post_title, $excerpt)
    {
        $targetPost = get_page_by_title( $post_title, "ARRAY_A", $post_type);
        if ($targetPost == null) {
            throw new Exception("Post doesn't exist.");
        } else {
            $targetPost["post_excerpt"] = $excerpt;
            $id = wp_update_post($targetPost);
            $this->assert($id > 0, "Post does not exist");
            $this->visit("/wp-admin/post.php?post=".$id."&action=edit");
            
        }
    }
    
    
    /**
     * @Given /^the "([^"]*)" "([^"]*)" has the author "([^"]*)"$/
     */
    public function theHasTheAuthor($post_type, $post_title, $post_author)
    {
        $targetPost = get_page_by_title( $post_title, "ARRAY_A", $post_type);
        
        $user = get_user_by("login", $post_author);
        
        if(!isset($user) || !isset($user->ID)) {
            throw new Exception("Can't find user with that login.");
        } else {
            
            if ($targetPost != null) {
                $targetPost["post_author"] = $user->ID;
                $id = wp_update_post($targetPost);
                $this->assert($id > 0, "Post does not exist");
                $this->visit("/wp-admin/post.php?post=".$id."&action=edit");
                
            } else {
                throw new Exception("Can't find post with that name.");
            }
            
        }

    }

    /**
     * @Given /^I have "([^"]*)" with the title "([^"]*)" and the slug "([^"]*)" in wordpress$/
     */    
    public function AssertCreatedPost($post_type, $post_title, $post_slug) {
        $targetPost = get_page_by_title( $post_title, "ARRAY_A", $post_type);
        if ($targetPost == null) {
            $a = array('post_name'   => $post_slug,'post_title' => $post_title,'post_status'   => 'publish','post_type'   => $post_type, 'post_content' => "");
            $id = wp_insert_post($a);
            $this->assert($id > 0, "Post does not exist");
            $this->visit("/wp-admin/post.php?post=".$id."&action=edit");
            //$this->pressButton("publish");
        } else {
            $targetPost["post_name"] = $post_slug;
            $targetPost["post_status"] = 'publish';
            $targetPost["post_content"] = "";
            $id = wp_update_post($targetPost);
            $this->assert($id > 0, "Post does not exist");
            $this->visit("/wp-admin/post.php?post=".$id."&action=edit");
            //$this->pressButton("publish");
            
        }
    }
    
    /**
     * @Given /^I have "([^"]*)" with the title "([^"]*)" and the slug "([^"]*)" and the date "([^"]*)" in wordpress$/
     */    
    public function AssertCreatedPostWithDate($post_type, $post_title, $post_slug, $post_date) {
        $targetPost = get_page_by_title( $post_title, "ARRAY_A", $post_type);
        if ($targetPost == null) {
            $a = array('post_name'   => $post_slug,'post_title' => $post_title,'post_status'   => 'publish','post_type'   => $post_type, 'post_content' => "", 'post_date' => $post_date);
            $id = wp_insert_post($a);
            $this->assert($id > 0, "Post does not exist");
            $this->visit("/wp-admin/post.php?post=".$id."&action=edit");
            //$this->pressButton("publish");
        } else {
            $targetPost["post_name"] = $post_slug;
            $targetPost["post_status"] = 'publish';
            $target_post["post_date"] = date($post_date);
            $targetPost["post_content"] = "";
            $id = wp_update_post($targetPost);
            $this->assert($id > 0, "Post does not exist");
            $this->visit("/wp-admin/post.php?post=".$id."&action=edit");
            //$this->pressButton("publish");
            
        }
    }
    
    /**
     * @Given /^the "([^"]*)" "([^"]*)" has the content "([^"]*)"$/
     */    
    public function AssertPostContent($post_type, $post_title, $post_content) {
        $targetPost = get_page_by_title( $post_title, "ARRAY_A", $post_type);
        $this->assert($targetPost != null, "Post content could not be modified");
        $targetPost["post_content"] = $post_content;
        $id = wp_update_post($targetPost);
        $this->assert($id > 0, "Post content could not be modified");
    }

    ///**
    // * @Given /^I have a "([^"]*)" titled "([^"]*)" meta data "([^"]*)" set to "([^"]*)"$/
    // */
    //public function assertMetaData($post_type, $post_title, $post_meta_key)
    //{
    //    $targetPost = get_page_by_title( $post_title, "ARRAY_A", $post_type);
    //    if ($targetPost != null) {
    //        delete_post_meta($targetPost["ID"],$post_meta_key);
    //        $val = get_post_meta($targetPost["ID"],$post_meta_key, true);
    //        $this->assert($val != "","Post Meta not added");
    //    } else {
    //        throw new Exception("Cannot set meta data on post that does not exists");
    //    }
    
    //}
    
    /**
     * @Given /^the "([^"]*)" titled "([^"]*)" is attached as "([^"]*)" meta to the "([^"]*)" titled "([^"]*)" as "([^"]*)"$/
     */
    public function assertMetaBoxValue($sourceType,$sourceTitle, $metaBoxName, $targetType, $targetTitle, $arrayKey) {
        $sourcePost = get_page_by_title( $sourceTitle, "ARRAY_A", $sourceType);
        $targetPost = get_page_by_title( $targetTitle, "ARRAY_A", $targetType);
        if ($targetPost != null) {
            $val = get_post_meta($targetPost["ID"],$metaBoxName, true);
            if ($val == "") {
                add_metaData("post",$targetPost["ID"],$metaBoxName,array($arrayKey => $sourcePost["ID"]));
            } else {
                
                if (is_array($val)) {
                    $orig = $val;
                    $val[$arrayKey] = $sourcePost["ID"];
                    update_metadata("post",$targetPost["ID"],$metaBoxName,$val,$orig);
                } else {
                    //Should probably throw something here
                }
            }

        } else {
            throw new Exception("Cannot set meta data on post that does not exists");
        }
    }
    
    /**
     * @Given /^I do not have meta data "([^"]*)" for "([^"]*)" titled "([^"]*)"$/
     */
    public function assertMetaDataMissing($post_meta_key,$post_type, $post_title)
    {
        $targetPost = get_page_by_title( $post_title, "ARRAY_A", $post_type);
        if ($targetPost != null) {
            delete_post_meta($targetPost["ID"],$post_meta_key);
            $val = get_post_meta($targetPost["ID"],$post_meta_key, true);
            $this->assert($val == "","Post Meta not removed");
        }
        
    }
    
    /**
     * @Given /^the "([^"]*)" "([^"]*)" has the "([^"]*)" "([^"]*)" set to "((?:[^\\"]|\\.)*)"$/
     */
    public function assertCustomMetaData($post_type, $post_title, $metabox, $metaKey, $metaValue)
    {
        $targetPost = get_page_by_title( $post_title, "ARRAY_A", $post_type);
        if ($targetPost != null) {
            
            $content_type_meta = get_post_meta($targetPost["ID"], $metabox, true);
            if($content_type_meta) {
                $content_type_meta[$metaKey] = $metaValue;
                update_post_meta($targetPost["ID"], $metabox, $content_type_meta);
            } else {
                add_post_meta($targetPost["ID"], $metabox, array($metaKey => $metaValue), true);
            }
            
            $val = get_post_meta($targetPost["ID"],$metabox, true);
            $this->assert($val != "","Post Meta not added");
            
        } else {
            throw new Exception("Cannot set meta data on post that does not exist");
        }
        
        
    }
    
    /**
     * @Given /^the "([^"]*)" "([^"]*)" has the "([^"]*)" "([^"]*)" added to the repeater$/
     */
    public function theHasTheAddedToTheRepeater($post_type, $post_title, $content_type, $content_title)
    {
        $targetPost = get_page_by_title( $post_title, "ARRAY_A", $post_type);
        $targetContent = get_page_by_title( $content_title, "ARRAY_A", $content_type);
        $metabox = "gsdm_page_content_repeater_meta_box";
        
        if ($targetPost != null && $targetContent != null) {
            $content_type_meta = get_post_meta($targetPost["ID"], $metabox, true);
            
            if($content_type_meta && isset($content_type_meta['gsdm_content_repeater'])) {
                $new = $content_type_meta['gsdm_content_repeater'] . "," . $targetContent["ID"];
                $content_type_meta['gsdm_content_repeater'] = $new;
                update_post_meta($targetPost["ID"], $metabox, $content_type_meta);
            } else {
                add_post_meta($targetPost["ID"], $metabox, array('gsdm_content_repeater' => $targetContent["ID"]), true);
            }
            
            $val = get_post_meta($targetPost["ID"],$metabox, true);
            $this->assert($val != "","Post Meta not added");
            
        } else {
            throw new Exception("Cannot set meta data on post that does not exist");
        }
    }

    
    /**
     * @Then /^I delete wordpress "([^"]*)" post titled "([^"]*)"$/
     * @Given /^I have deleted the wordpress "([^"]*)" post titled "([^"]*)"$/
     */
    public function iDeleteWordpressPostTitled($arg1, $arg2)
    {
        $thePost = get_page_by_title( $arg2, "ARRAY_A", $arg1);
        wp_delete_post($thePost["ID"], true);
    }
    
    /**
     * @Then /^I should see the wordpress choose image dialog$/
     */
    public function iShouldSeeTheWordpressChooseImageDialog()
    {
        $element = $this->getSession()->getPage()->findById('TB_iframeContent');
        $this->getSession()->switchToIFrame("TB_iframeContent");
        $this->assertPageContainsText("Add media files from your computer");
        $this->getSession()->switchToIframe(null);
    }

    
    /**
     * @Then /^I "(append|prepend)" the "([^"]*)" shortcode to the "([^"]*)" post titled "([^"]*)" by "([^"]*)" to the "([^"]*)" post titled "([^"]*)"$/
     */
    public function iAddTheShortcodeToThePostTitledByToThePostTitled($dir, $sc, $sourcePostType, $sourcePostTitle, $shortCodeAttribute, $targetPostType, $targetPostTitle)
    {
        $targetPost = get_page_by_title( $targetPostTitle, "ARRAY_A", $targetPostType);
        $this->assert($targetPost != null, "Couldn't find a page titled \"".$targetPostTitle."\"");
        $sourcePost = get_page_by_title( $sourcePostTitle, "ARRAY_A", $sourcePostType);
        $this->assert($targetPost != null, "Couldn't find a page titled \"".$sourcePostTitle."\"");
        $scAttrStr =  "";
        if (strtolower($shortCodeAttribute) == "id") {
            $scAttrStr = "id=\"" . $sourcePost["ID"] . "\"";
        } else if (strtolower($shortCodeAttribute) == "slug") {
            $scAttrStr = "slug=\"" . $sourcePost["post_name"] . "\"";
        }
        $shortCode = "[".$sc." ".$scAttrStr."]";
        if ($dir == "append") {
            $targetPost["post_content"] .= $shortCode;
        } else {
            $targetPost["post_content"] = $targetPost["post_content"] . $shortCode;
        }
        wp_update_post($targetPost);
    } 
    
    /**
     * @Given /^I change the template to "([^"]*)" for the wordpress "([^"]*)" post titled "([^"]*)"$/
     */
    public function iChangeTheTemplateToForTheWordpressPostTitled($template, $postType, $postTitle)
    {
        $page = get_page_by_title( $postTitle, "ARRAY_A", $postType);
        update_post_meta( $page['ID'], '_wp_page_template', $template );
    }
    
    
    /**
     * @Given /^the "([^"]*)" "([^"]*)" has the page template set to "([^"]*)"$/
     */
    public function theHasThePageTemplateSetTo($postType, $postTitle, $template)
    {
        $page = get_page_by_title( $postTitle, "ARRAY_A", $postType);
        update_post_meta( $page['ID'], '_wp_page_template', $template );
    }

    
    /**
     * @Given /^I add the custom field "([^"]*)" with the value "([^"]*)" to the wordpress "([^"]*)" post titled "([^"]*)"$/
     */
    public function iAddTheCustomFieldWithTheValueToTheWordpressPostTitled($custom_key, $custom_value, $postType, $postTitle)
    {
        $page = get_page_by_title( $postTitle, "ARRAY_A", $postType);
        add_post_meta( $page['ID'], $custom_key, $custom_value );
        
    }
    
    /**
     * @Given /^I have uploaded the image "([^"]*)" into the wordpress media library$/
     */
    public function uploadImageToMediaLibrary($arg1)
    {
        $path_parts = pathinfo($arg1);
        $page = get_page_by_title( $path_parts['filename'], "ARRAY_A", "attachment");

        if ($page == null) {
            $resources = realPath(__DIR__ . "\\..\\..\\resources\\");
            $dir = dir($resources);
            $filePath = $dir->path ."\\". $arg1;
			print $filePath;

            $this->visit("/wp-admin/media-new.php");
            $this->attachFileToField("async-upload",$filePath);
            $this->pressButton("Upload");
            $this->getSession()->wait(1000);
            $path_parts = pathinfo($arg1);
            $image = get_page_by_title( $path_parts['filename'], "ARRAY_A", "attachment");
            if($image != null && isset($image['ID'])) {
                update_post_meta( $image['ID'], "_wp_attachment_image_alt",  $path_parts['filename']);
            }
            $this->assert($image != null,"Media could not be uploaded.");
        }
    }
    
    /**
     * @Given /^I set the front page to the wordpress "([^"]*)" post titled "([^"]*)"$/
     */
    public function iSetTheFrontPageToTheWordpressPostTitled($postType, $postTitle)
    {
        $page = get_page_by_title( $postTitle, "ARRAY_A", $postType);
        update_option('page_on_front', $page['ID']);
        update_option('show_on_front', 'page');

    }
    
    /**
     * @When /^I go to the wordpress "([^"]*)" post titled "([^"]*)" to edit it$/
     */
    public function iGoToTheWordpressPostTitledToEditIt($postType, $postTitle)
    {
        $page = get_page_by_title( $postTitle, "ARRAY_A", $postType);
        $page_id = $page['ID'];
        $this->visit('/wp-admin/post.php?post=' . $page_id . '&action=edit');
        
        // if the "distraction-free writing" callout is in the way:
        $element = $this->getSession()->getPage()->find('css', '.wp-pointer-content a.close'); 
        if (null != $element) {
            $element->click();
        }
  
    }
    
    /**
     * @Given /^the "([^"]*)" "([^"]*)" has the featured image set to "([^"]*)"$/
     */
    public function theHasTheFeaturedImageSetTo($post_type, $post_title, $image_name)
    {
        $targetPost = get_page_by_title( $post_title, "ARRAY_A", $post_type);
        
        $media = get_page_by_title( $image_name, "ARRAY_A", 'attachment');

        if(null != $media) {
            add_post_meta($targetPost['ID'], '_thumbnail_id', $media['ID']);
            
        } else {
            throw new Exception("Image " . $image . " does not exist.");
        }
        
    }
    
    /**
     * @Given /^I search the media library tab for "([^"]*)"$/
     */
    public function iSearchMediaFor($arg1)
    {
        $this->clickLink("Media Library");
        $this->fillField("media-search-input",$arg1);
        $this->pressButton("Search Media");
        throw new PendingException();
    }
    
    /**
     * @Given /^I create a menu named "([^"]*)"$/
     */
    public function createMenuName($menu_name) {
        if (wp_get_nav_menu_object($menu_name) === false) {
            wp_create_nav_menu($menu_name);
            
        }
        $this->assert(wp_get_nav_menu_object($menu_name) !== false, "Menu was not created");
    }
    
    /**
     * @Given /^I set the front page to "([^"]*)"$/
     */
    public function iSetTheFrontPageTo($pageName)
    {
        $page = get_page_by_title($pageName);
        update_option('page_on_front', $page->ID);
        update_option('show_on_front', 'page');
    }
    
    /**
     * @Given /^I set the menu "([^"]*)" to the theme location "([^"]*)"$/
     */
    public function iSetTheMenuToTheThemeLocation($menu_name, $menu_location)
    {
        $menu = wp_get_nav_menu_object($menu_name);
        $locations = get_theme_mod('nav_menu_locations');
        $locations[$menu_location] = $menu->term_id; 
        set_theme_mod( 'nav_menu_locations', $locations );
    }
    
    /**
     * @Given /^I am using the theme "([^"]*)"$/
     */
    public function iAmUsingTheTheme($stylesheet)
    {
        switch_theme( $stylesheet );
    }
    
    /**
     * @Given /^I add a new menu item "([^"]*)" to the Menu "([^"]*)" that goes to "([^"]*)"$/
     */
    public function iAddANewMenuItemToTheMenuThatGoesTo($menuItemName, $menuName, $urlOrSlug)
    {
        $menu = wp_get_nav_menu_object($menuName);
        $this->assert($menu !== false, "Menu does not exist");
        // Set up default menu items
        wp_update_nav_menu_item($menu->term_id, 0, array(
            'menu-item-title' =>  __($menuItemName),
            'menu-item-url' => home_url($urlOrSlug), 
            'menu-item-status' => 'publish'));
        
    }
    
    
    /**
     * @Given /^the "([^"]*)" taxonomy has the tag "([^"]*)"$/
     */
    public function theTaxonomyHasTheTag($taxonomy, $term)
    {
        if(null === get_term($term, $taxonomy)) {
            wp_insert_term( $term, $taxonomy);
        }
        
    }

    
    /**
     * @Given /^I have changed the permalink to "([^"]*)"$/
     */
    public function iHaveChangedThePermalinkTo($permalinkPath)
    {
        global $wp_rewrite;
        $wp_rewrite->set_permalink_structure($permalinkPath);
        $wp_rewrite->flush_rules();
    }
    
    
    /**
     * @Given /^I accept the browser alert dialog box$/
     */
    public function iAcceptTheBrowserAlertDialogBox()
    {
        try {
            $this->getSession()->getDriver()->getWebDriverSession()->accept_alert();
        
        } catch( Exception $e ) {
            //
        }
    }
    
    // for the customizer editor
    /**
     * @Given /^modify the theme customization "([^"]*)" to "([^"]*)"$/
     */
    public function theThemeModIsSetTo($key, $value)
    {
        set_theme_mod($key, $value);
    }
    
    // for the customizer editor
    /**
     * @Given /^the theme setting "([^"]*)" is set to "([^"]*)"$/
     */
    public function theThemeSettingIsSetTo($key, $value)
    {
        update_option($key, $value);
    }
    
    
    /**
     * @Then /^the radio button labeled "([^"]*)" should be checked$/
     */
    public function theRadioButtonLabeledShouldBeChecked($labelText)
    {
        
        $radioId = null;
        $ctx = $this->getMainContext();

        /** @var $label NodeElement */
        foreach ($ctx->getSession()->getPage()->findAll('css', 'label') as $label) {
            if ($labelText === $label->getText()) {
                if ($label->hasAttribute('for')) {
                    $radioId = $label->getAttribute('for');
                    break;
                } else {
                    throw new \Exception("Radio button's label needs the 'for' attribute to be set");
                }
            }
        }
        if (!$radioId) {
            throw new \InvalidArgumentException("Label '$labelText' not found.");
        }

        // Now use the ID to check that it is selected
        
        $radioButton = $ctx->getSession()->getPage()->find('css', 'input[type="radio"]:checked#'.$radioId);
        if (!$radioButton) {
            throw new \Exception("$labelText radio button not found.");
        }

    }
    
    /**
     * @Given /^I should see that the "([^"]*)" taxonomy "([^"]*)" option from the "([^"]*)" element is selected$/
     */
    public function iShouldSeeThatTheTaxonomyOptionFromTheElementIsSelected($taxonomy, $term, $selector)
    {
        $session = $this->getSession(); 
        $element = $session->getPage()->find('css', $selector); 
        
        // errors must not pass silently
        if (null === $element) {
            throw new \InvalidArgumentException(sprintf('Could not evaluate CSS selector: "%s"', $selector));
        }
        
        $obj = get_term_by('name', $term, $taxonomy);
        
        $value=$element->getValue();
        
        
        
        if($value != $obj->term_id){
            throw new Exception('Option equals ' . $value . '. Expected ' . $obj->term_id);        
        }
    }



}
