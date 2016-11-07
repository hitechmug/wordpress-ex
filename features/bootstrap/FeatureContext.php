<?php
require_once("WordpressContext.php");


//
// Require 3rd-party libraries here:
//
//   require_once 'PHPUnit/Autoload.php';
//   require_once 'PHPUnit/Framework/Assert/Functions.php';
//

/**
 * Features context.
 */
class FeatureContext extends WordpressContext
{
   
    /**
     * Initializes context.
     * Every scenario gets its own context object.
     *
     * @param array $parameters context parameters (set them up through behat.yml)
     */
    public function __construct(array $parameters)
    {
        parent::__construct();
    }
   
   
    /**
     * @When /^I wait for "([^"]*)"$/
     */
    public function iWaitFor($arg1)
    {
        $this->getSession()->wait($arg1);
            //throw new PendingException();
    }
    

    
    /**
     * @When /^I select the radio button labeled "([^"]*)"$/
     */
    public function iSelectTheRadioButton($labelText)
    {
        // Find the label by its text, then use that to get the radio item's ID
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

        // Now use the ID to retrieve the button and click it
        /** @var NodeElement $radioButton */
        $radioButton = $ctx->getSession()->getPage()->find('css', "#$radioId");
        if (!$radioButton) {
            throw new \Exception("$labelText radio button not found.");
        }

        $ctx->fillField($radioId, $radioButton->getAttribute('value'));
    }
    
    
    /**
     * @Then /^I should see that the "(?P<option>(?:[^"]|\\")*)" option from "(?P<select>(?:[^"]|\\")*)" is selected$/
     */
    public function iShouldSeeThatTheOptionFromIsSelected($option, $select)
    {

        $selectField = $this->getSession()->getPage()->find('named', array('select', "\"{$select}\""));
        if (null === $selectField) {
            throw new Exception("Can't find the " . $select . " field.");
        }
        
        $optionField = $selectField->find('named', array('option', "\"{$option}\""));

        if (null === $optionField) {
            throw new Exception("Can't find " . $option . " option.");
        }        
        
        if (!$optionField->isSelected()) {
            throw new Exception("The option " . $option . " is not selected from the " . $select . " field."); 
        }
    }
   
    /**
     * @When /^I play the "([^"]*)" video$/
     */
    public function PlayVideo($cssSelector) {
        $this->getSession()->wait(10000, 'typeof window.jQuery == "function"');
        $this->assertJavascriptExecution(15000,"$('".$cssSelector."').vimeo('play');", "!$('".$cssSelector."').data('vimeo').paused","Video did not start playing as expected!");
        $this->getSession()->wait(1000);
    }

    /**
     * @When /^I wait for the "([^"]*)" video to finish playing$/
     */
    public function FinishVideo($cssSelector) {
        $this->getSession()->wait(10000, 'typeof window.jQuery == "function"');
        $this->assertJavascriptState(60000,"$('".$cssSelector."').data('vimeo').paused","The Video did not finish playing.");
    }

    
     /**
     * @Given /^I press the "([^"]*)" element$/
     */
    public function iPressTheElement($selector)
    {
        $element = $this->getSession()->getPage()->find('css', $selector);
        $element->click();
    }
   
    
    /**
     * @Given /^the "([^"]*)" element is not visible$/
     */
     
    public function theElementIsNotVisible($arg)
    {
         $session = $this->getSession(); // assume extends RawMinkContext
         $page = $session->getPage();

         $element = $page->find('css', $arg);

                if (null === $element) {
                    throw new \LogicException('Element is not found');
                }

                if ($element->isVisible()) {
                    throw new \LogicException('Element is visible...');
                }
    }
    
     /**
     * @Given /^I fill in the "([^"]*)" element with "([^"]*)"$/
     */
    public function iFillInTheElementWith($selector, $text)
    {
        $session = $this->getSession(); // assume extends RawMinkContext
        $page = $session->getPage();

        $element = $page->find('css', $selector);
        $element->setValue($text);
    }
    
    
    /**
     * @Given /^I drag the "([^"]*)" element to the "([^"]*)" element$/
     */
    public function iDragTheElementToTheElement($selector1, $selector2)
    {
        $session = $this->getSession(); // assume extends RawMinkContext
        $page = $session->getPage();

        $element1 = $page->find('css', $selector1);
        $element2 = $page->find('css', $selector2);
        
        $element1->dragTo($element2);

    }


    /**
     * @Given /^the "([^"]*)" element is visible$/
     */
    public function theElementIsVisible($arg)
    {
         $session = $this->getSession(); // assume extends RawMinkContext
         $page = $session->getPage();

         $element = $page->find('css', $arg);

                if (null === $element) {
                    throw new \LogicException('Element is not found');
                }

                if (!$element->isVisible()) {
                    throw new \LogicException('Element is not visible...');
                }
    }
    
    
    /**
     * @Then /^the "([^"]*)" element should have the attribute "([^"]*)" that contains "([^"]*)"$/
     */
    public function theElementShouldHaveTheAttributeThat($selector, $attribute, $value)
    {

        $element = $this->getSession()->getPage()->find('css', $selector);
        
        if (null === $element) {
            throw new \LogicException('Element is not found');
        }

        $attribute_value = $element->getAttribute($attribute);
        
        $value_index = strpos($attribute_value, $value);
                
        if($value_index === FALSE) {
            throw new Exception("The value " . $value . " was not found in the attribute: " . $attribute_value);
        }
        
        
    }
    
    
    /**
     * @Then /^the "([^"]*)" element should have the attribute "([^"]*)" that does not  "([^"]*)"$/
     */
    public function theElementShouldHaveTheAttributeThatDoesNot($selector, $attribute, $value)
    {
        $element = $this->getSession()->getPage()->find('css', $selector);
        
        if (null === $element) {
            throw new \LogicException('Element is not found');
        }

        $attribute_value = $element->getAttribute($attribute);
        
        $value_index = strpos($attribute_value, $value);
                
        if($value_index === TRUE) {
            throw new Exception("The value " . $value . " was found in the attribute: " . $attribute_value);
        }
    }

    
    /**
     * @Then /^the "([^"]*)" element should have the attribute "([^"]*)" that does not contain "([^"]*)"$/
     */
    public function theElementShouldHaveTheAttributeThatNot($selector, $attribute, $value)
    {

        $element = $this->getSession()->getPage()->find('css', $selector);
        
        if (null === $element) {
            throw new \LogicException('Element is not found');
        }

        $attribute_value = $element->getAttribute($attribute);
        
        $value_index = strpos($attribute_value, $value);
                
        if($value_index != FALSE) {
            throw new Exception("The value " . $value . " was found in the attribute: " . $attribute_value);
        }
        
        
    }
    
     /**
     * @When /^I "(click|doubleClick|rightClick|mouseOver|focus|blur)" the element "([^"]*)" and wait for "([^"]*)" I should see the css setting "([^"]*)" change to "([^"]*)"$/
     */
    public function iTheElementIShouldSeeTheCssSettingChangeTo($mouseAction, $selector, $time, $setting, $value)
    {
        $session = $this->getSession(); 
        $element = $session->getPage()->find('css', $selector); 
        
        // errors must not pass silently
        if (null === $element) {
            throw new \InvalidArgumentException(sprintf('Could not evaluate CSS selector: "%s"', $selector));
        }
        
        $element->$mouseAction();
    
        $this->iWaitFor($time);
    }
    
    /**
     * @When /^I "(click|doubleClick|rightClick|mouseOver|focus|blur)" the element "([^"]*)" and wait for "([^"]*)"$/
     */
    public function iInteractWithTheElement($mouseAction, $selector, $time)
    {
        $session = $this->getSession(); 
        $element = $session->getPage()->find('css', $selector); 
        
        // errors must not pass silently
        if (null === $element) {
            throw new \InvalidArgumentException(sprintf('Could not evaluate CSS selector: "%s"', $selector));
        }
        
        $element->$mouseAction();
       
        $this->iWaitFor($time);
    }
    
    
    /**
     * @Given /^I should see the current year in the "([^"]*)" element$/
     */
    public function iShouldSeeTheCurrentYearInTheElement($selector)
    {
        $session = $this->getSession(); 
        $element = $session->getPage()->find('css', $selector); 
        
        // errors must not pass silently
        if (null === $element) {
            throw new \InvalidArgumentException(sprintf('Could not evaluate CSS selector: "%s"', $selector));
        }
        
        if(strpos($element->getText(), date("Y")) === FALSE) {
            throw new \LogicException(sprintf('Could not find the current year in the element: "%s"', $selector));
        }
        
        
    }
    
    
    
    /**
     * @Given /^I should see the publish date for "([^"]*)" "([^"]*)" in the "([^"]*)" element$/
     */
    public function iShouldSeeThePublishDateForInTheElement($post_type, $post_title, $selector)
    {
        $session = $this->getSession(); 
        $element = $session->getPage()->find('css', $selector); 
        
        // errors must not pass silently
        if (null === $element) {
            throw new \InvalidArgumentException(sprintf('Could not evaluate CSS selector: "%s"', $selector));
        }
        
        $post = get_page_by_title( $post_title, "ARRAY_A", $post_type);
        $targetDate = get_the_date("F j, Y", $post['ID']);
        
        if(strpos($element->getText(), $targetDate) === FALSE) {
            throw new \LogicException(sprintf('Could not find the current date in the element: "%s"', $selector));
        }
    }
   
    
    /**
     * Add employee photo to user profile
     * @Given /^the user "([^"]*)" has the image "([^"]*)" added to the "([^"]*)" metadata$/
     */
    public function theUserHasTheImageAddedToTheMetadata($username, $image, $metadata)
    {
        $user = get_user_by('login', $username);
        if(!$user) {
            throw new Exception("Username " . $username . " does not exist.");
        } else {
            $media = get_page_by_title( $image, "ARRAY_A", 'attachment');

            if(null != $media) {
                update_user_meta( $user->ID, $metadata, $media["ID"] );
          
            } else {
                throw new Exception("Image " . $image . " does not exist.");
            }
        }
    }
    
    
    /**
     * @Given /^the "([^"]*)" metadata for the user "([^"]*)" is set to "([^"]*)"$/
     */
    public function theMetadataForTheUserIsSetTo($meta_key, $username, $meta_value)
    {
        $user = get_user_by('login', $username);
        if(!$user) {
            throw new Exception("Username " . $username . " does not exist.");
        } else {
            update_user_meta($user->ID, $meta_key, $meta_value);
        }
    }

    
    /**
     * @Given /^the "([^"]*)" "([^"]*)" has the taxonomy "([^"]*)" set to "([^"]*)"$/
     */
    public function theHasTheTaxonomySetTo($post_type, $post_title, $taxonomy, $term)
    {
        $targetPost = get_page_by_title( $post_title, "ARRAY_A", $post_type);
        
        if ($targetPost != null) { 
            wp_set_object_terms( $targetPost["ID"], array($term), $taxonomy );
        } else {
            throw new Exception("Cannot set meta data on post that does not exists");
        }  
 
    }

    
    /**
     * @Given /^the "([^"]*)" "([^"]*)" has the term "([^"]*)" added to the taxonomy "([^"]*)"$/
     */
    public function theHasTheTermAddedToTheTaxonomy($post_type, $post_title, $term, $taxonomy)
    {
        $targetPost = get_page_by_title( $post_title, "ARRAY_A", $post_type);
        
        if ($targetPost != null) { 
            wp_set_object_terms( $targetPost["ID"], array($term), $taxonomy, true );
        } else {
            throw new Exception("Cannot set meta data on post that does not exists");
        }  
 
    }

    
    /**
     * @Given /^the "([^"]*)" "([^"]*)" has the page grid repeater item titled "([^"]*)" and the image "([^"]*)" and the id for "([^"]*)" "([^"]*)"$/
     */
    public function theHasThePageGridRepeaterItemTitledAndTheImageAndTheIdFor($post_type, $post_title, $item_title, $item_image, $promo_type, $promo_title)
    {
        $image = get_page_by_title( $item_image, "ARRAY_A", "attachment");
        $targetPost = get_page_by_title( $post_title, "ARRAY_A", $post_type);
        $promoPost = get_page_by_title( $promo_title, "ARRAY_A", $promo_type);
        
        $obj = (object) array(
                    "label" => $item_title,
                    "image" => $image["ID"],
                    "page_id"  => $promoPost["ID"]
                );
                
        if ($targetPost != null) {
            $repeater_meta = get_post_meta($targetPost["ID"], "gsdm_content_page_grid_meta_box", true);
            if($repeater_meta && isset($repeater_meta["gsdm_page_grid_repeater"])) {
                
                if(strlen($repeater_meta["gsdm_page_grid_repeater"]) > 0) {

                    $json = json_decode($repeater_meta["gsdm_page_grid_repeater"]);
                    
                    if(null === $json) {
                        throw new Exception("The meta key gsdm_page_grid_repeater returned an invalid json value");
                    }
                    array_push($json, $obj);
                    $repeater_meta["gsdm_page_grid_repeater"] = json_encode($json);
                    update_post_meta($targetPost["ID"], "gsdm_content_page_grid_meta_box", $repeater_meta);
     
                } else {
                    $repeater_meta["gsdm_page_grid_repeater"] = wp_json_encode(array($obj), JSON_UNESCAPED_UNICODE);
                    update_post_meta($targetPost["ID"], "gsdm_content_page_grid_meta_box", $repeater_meta);
                }
                
            } else {
                $repeater_meta = array(
                    "gsdm_page_grid_repeater"   => wp_json_encode(array($obj), JSON_UNESCAPED_UNICODE)
                );
                
                add_post_meta($targetPost["ID"], "gsdm_content_page_grid_meta_box", $repeater_meta, true);
                
                $test = get_post_meta($targetPost["ID"], "gsdm_content_page_grid_meta_box", true);
            }
                
        } else {
            throw new Exception("Cannot set meta data on post that does not exists");
        }        
        
    }


    
    /**
     * @Given /^the "([^"]*)" "([^"]*)" has the page grid repeater item titled "([^"]*)" and the image "([^"]*)" and the url "([^"]*)"$/
     */
    public function theHasThePageGridRepeaterItemTitledAndTheImageAndTheUrl($post_type, $post_title, $item_title, $item_image, $item_url)
    {
        $image = get_page_by_title( $item_image, "ARRAY_A", "attachment");
        $targetPost = get_page_by_title( $post_title, "ARRAY_A", $post_type);
        
        $obj = (object) array(
                    "label" => $item_title,
                    "image" => $image["ID"],
                    "page_url"  => $item_url
                );
                
        if ($targetPost != null) {
            $repeater_meta = get_post_meta($targetPost["ID"], "gsdm_content_page_grid_meta_box", true);
            if($repeater_meta && isset($repeater_meta["gsdm_page_grid_repeater"])) {
                
                if(strlen($repeater_meta["gsdm_page_grid_repeater"]) > 0) {

                    $json = json_decode($repeater_meta["gsdm_page_grid_repeater"]);
                    
                    if(null === $json) {
                        throw new Exception("The meta key gsdm_page_grid_repeater returned an invalid json value");
                    }
                    array_push($json, $obj);
                    $repeater_meta["gsdm_page_grid_repeater"] = json_encode($json);
                    update_post_meta($targetPost["ID"], "gsdm_content_page_grid_meta_box", $repeater_meta);
     
                } else {
                    $repeater_meta["gsdm_page_grid_repeater"] = wp_json_encode(array($obj), JSON_UNESCAPED_UNICODE);
                    update_post_meta($targetPost["ID"], "gsdm_content_page_grid_meta_box", $repeater_meta);
                }
                
            } else {
                $repeater_meta = array(
                    "gsdm_page_grid_repeater"   => wp_json_encode(array($obj), JSON_UNESCAPED_UNICODE)
                );
                
                add_post_meta($targetPost["ID"], "gsdm_content_page_grid_meta_box", $repeater_meta, true);
                
                $test = get_post_meta($targetPost["ID"], "gsdm_content_page_grid_meta_box", true);
            }
                
        } else {
            throw new Exception("Cannot set meta data on post that does not exists");
        }        
        
    }

    
        /**
     * @Given /^the "([^"]*)" "([^"]*)" has the image gallery repeater item titled "([^"]*)" and the image "([^"]*)"$/
         */
        public function theHasTheImageGalleryRepeaterItemTitledAndTheImage($post_type, $post_title, $item_title, $item_image)
        {
            $image = get_page_by_title( $item_image, "ARRAY_A", "attachment");
            $targetPost = get_page_by_title( $post_title, "ARRAY_A", $post_type);
        
            $obj = (object) array(
                    "image" => $image["ID"]
                );
                
            if ($targetPost != null) {
                $repeater_meta = get_post_meta($targetPost["ID"], "gsdm_content_image_gallery_meta_box", true);
                if($repeater_meta && isset($repeater_meta["gsdm_image_gallery_repeater"])) {
                
                    if(strlen($repeater_meta["gsdm_image_gallery_repeater"]) > 0) {

                        $json = json_decode($repeater_meta["gsdm_image_gallery_repeater"]);
                    
                        if(null === $json) {
                            throw new Exception("The meta key gsdm_image_gallery_repeater returned an invalid json value");
                        }
                        array_push($json, $obj);
                        $repeater_meta["gsdm_image_gallery_repeater"] = json_encode($json);
                        update_post_meta($targetPost["ID"], "gsdm_content_image_gallery_meta_box", $repeater_meta);
     
                    } else {
                        $repeater_meta["gsdm_image_gallery_repeater"] = wp_json_encode(array($obj), JSON_UNESCAPED_UNICODE);
                        update_post_meta($targetPost["ID"], "gsdm_content_image_gallery_meta_box", $repeater_meta);
                    }
                
                } else {
                    $repeater_meta = array(
                        "gsdm_image_gallery_repeater"   => wp_json_encode(array($obj), JSON_UNESCAPED_UNICODE)
                    );
                
                    add_post_meta($targetPost["ID"], "gsdm_content_image_gallery_meta_box", $repeater_meta, true);
                
                    $test = get_post_meta($targetPost["ID"], "gsdm_content_image_gallery_meta_box", true);
                }
                
            } else {
                throw new Exception("Cannot set meta data on post that does not exists");
            }       
        }

    
    
        /**
       * @Given /^I set browser window size to "([^"]*)" x "([^"]*)"$/
       */
      public function iSetBrowserWindowSizeToX($width, $height) {
        $this->getSession()->resizeWindow((int)$width, (int)$height, 'current');
      }
    
        /**
       * @Given /^I maximize the browser window size$/
       */
      public function iMaximizeBrowserSize() {
         $this->getSession()->getDriver()->maximizeWindow();
      }


    /**
     * @When /^I scroll to the "([^"]*)" element$/
     */
    public function iScrollUntilTheElementIsInView($selector)
    {
        $session = $this->getSession(); 
        $element = $session->getPage()->find('css', $selector); 

        if (null === $element) {
            throw new \InvalidArgumentException(sprintf('Could not evaluate CSS selector: "%s"', $selector));
        }

        $this->getSession()->executeScript("$('".$selector."')[0].scrollIntoView();");

    }


    /**
     * @Given /^I select "([^"]*)" from the "([^"]*)" element$/
     */
    public function iSelectFromTheElement($option, $selector)
    {
        $session = $this->getSession(); 
        $element = $session->getPage()->find('css', $selector); 
        
        // errors must not pass silently
        if (null === $element) {
            throw new \InvalidArgumentException(sprintf('Could not evaluate CSS selector: "%s"', $selector));
        }
        
        $element->selectOption($option);
   
    }

    /**
     * @Given /^I should see that the "([^"]*)" option from the "([^"]*)" element is selected$/
     */
    public function iShouldSeeThatTheOptionFromTheElementIsSelected($option, $selector)
    {
    
        $session = $this->getSession(); 
        $element = $session->getPage()->find('css', $selector); 
        
        // errors must not pass silently
        if (null === $element) {
            throw new \InvalidArgumentException(sprintf('Could not evaluate CSS selector: "%s"', $selector));
        }
        
        $value=$element->getValue();
        if($value != $option){
            throw new Exception('Option equals ' . $value);        
        }
    }

    /**
    * @Given /^I switch tabs$/
    */
    public function iSwitchTabs()
    {
        $windowNames = $this->getSession()->getWindowNames();
        $this->getSession()->wait(2000);
        $this->getSession()->switchToWindow($windowNames[count($windowNames)- 1]);
    }
    
     /**
     * @Given /^I should see "([^"]*)" in the "([^"]*)" tinymce field$/
     */
    public function iShouldSeeInTheTinymceField($value, $selector)
    {
    
        $text=$this->getSession()->evaluateScript("tinyMCE.get(jQuery('".$selector."').attr('id')).getContent();");
        if($text != $value){
        throw new Exception("This is what it really is" .$text);
        }
        //$session = $this->getSession(); 
        //$element = $session->getPage()->find('css', $selector); 
        
        //// errors must not pass silently
        //if (null === $element) {
        //    throw new \InvalidArgumentException(sprintf('Could not evaluate CSS selector: "%s"', $selector));
        //}
    } 
    
    
    /**
     * @Given /^the "([^"]*)" "([^"]*)" has the "([^"]*)" "([^"]*)" "([^"]*)" "([^"]*)" set to "([^"]*)"$/
     */
    public function theHasTheSetTo($post_type, $post_title, $post_metabox, $meta_container, $array_index, $object, $value)
    {
        $targetPost = get_page_by_title( $post_title, "ARRAY_A", $post_type);
        if ($targetPost == null) {
            throw new Exception("Post doesn't exist.");
        } else {
            $new = array();
            $new[$meta_container][$array_index][$object] = $value;
            update_post_meta($targetPost['ID'], $post_metabox, $new);
            $this->assert($targetPost['ID'] > 0, "Post does not exist");
            $this->visit("/wp-admin/post.php?post=".$targetPost['ID']."&action=edit");
            
        }
    
    }

    /**
     * @Given /^the "([^"]*)" "([^"]*)" has the "([^"]*)" "([^"]*)" set to the id for "([^"]*)" "([^"]*)"$/
     */
    public function theHasTheMetaContentSetToTheIdFor($post_type, $post_title, $post_metabox, $meta_container, $content_type, $content_title)
    {
        $targetPost = get_page_by_title( $post_title, "ARRAY_A", $post_type);
        $contentPost = get_page_by_title( $content_title, "ARRAY_A", $content_type);
        if ($targetPost == null) {
            throw new Exception("Post doesn't exist.");
        } else if($contentPost == null) {
            throw new Exception("Content post doesn't exist.");
        } else {
            $new = get_post_meta($targetPost['ID'], $post_metabox, true);
            $new[$meta_container] = $contentPost['ID'];
            update_post_meta($targetPost['ID'], $post_metabox, $new);
            $this->assert($targetPost['ID'] > 0, "Post does not exist");
            $this->visit("/wp-admin/post.php?post=".$targetPost['ID']."&action=edit");

        }
    }

    /**
     * @Given /^the "([^"]*)" "([^"]*)" has the "([^"]*)" "([^"]*)" "([^"]*)" "([^"]*)" set to the id for "([^"]*)" "([^"]*)"$/
     */
    public function theHasTheSetToTheIdFor($post_type, $post_title, $post_metabox, $meta_container, $array_index, $object, $content_type, $content_title)
    {
        $targetPost = get_page_by_title( $post_title, "ARRAY_A", $post_type);
        $contentPost = get_page_by_title( $content_title, "ARRAY_A", $content_type);
        if ($targetPost == null) {
            throw new Exception("Post doesn't exist.");
        } else if($contentPost == null) {
            throw new Exception("Content post doesn't exist.");
        } else {
            $new = get_post_meta($targetPost['ID'], $post_metabox, true);
            $new[$meta_container][$array_index][$object] = $contentPost['ID'];
            update_post_meta($targetPost['ID'], $post_metabox, $new);
            $this->assert($targetPost['ID'] > 0, "Post does not exist");
            $this->visit("/wp-admin/post.php?post=".$targetPost['ID']."&action=edit");
            
        }
    }
    
    
    /**
     * @Given /^"([^"]*)" of the "([^"]*)" elements should contain "([^"]*)"$/
     */
    public function ofTheElementsShouldContain($count, $selector, $value)
    {
        $session = $this->getSession(); 
        $elements = $session->getPage()->findAll('css', $selector); 
        
        $match = array();
        
        foreach($elements as $element) {
            if($element->getText() == $value) {
                $match[] = $element;
            }
        }
        
        $this->assert(count($match) == $count, "The number of items matching does not equal $count");
        
    }
    
    /**
     * Used for pagination
     *
     * @Given /^I wait for ajax to load more than "([^"]*)" "([^"]*)" elements$/
     */
    public function iWaitForAjaxToLoadMoreThanElements($count, $selector)
    {
        //$this->getSession()->wait(10000, 'typeof window.jQuery == "function"');
        $this->assertJavascriptState(60000,"$('".$selector."').length > " . $count,"AJAX content did not load.");
    }
    
    /**
     * Used for before news ajax loads
     *
     * @Given /^I prepare to load ajax content$/
     */
    public function ajaxClickHandler_before() {
            $javascript = "window.jQuery(document).one('ajaxStart.ss.test', function(){
            window.__ajaxStatus = function() {
                return 'waiting';
            };
        });
        window.jQuery(document).one('ajaxComplete.ss.test', function(){
            window.__ajaxStatus = function() {
                return 'no ajax';
            };
        });";
        $this->getSession()->executeScript($javascript);
    }
    
    /**
    * @Given /^I wait for ajax content to load$/
    */
    public function ajaxClickHandler_after() {
        $this->getSession()->wait(10000,
            "(typeof window.__ajaxStatus !== 'undefined' ?
                window.__ajaxStatus() : 'no ajax') !== 'waiting'"
        );
    }
    
    
    /**
     * @Given /^the "([^"]*)" "([^"]*)" has the video collage repeater item labeled "([^"]*)" and the image "([^"]*)"$/
     */
    public function theHasTheVideoCollageRepeaterItemLabeledAndTheImageAndTheClientid($post_type, $post_title, $item_title, $item_image)
    {
        $image = get_page_by_title( $item_image, "ARRAY_A", "attachment");
        $targetPost = get_page_by_title( $post_title, "ARRAY_A", $post_type);
        
        
        $obj = (object) array(
                    "label" => $item_title,
                    "image" => $image["ID"]
                );
                
        if ($targetPost != null) {
            $repeater_meta = get_post_meta($targetPost["ID"], "gsdm_content_video_collage_meta_box", true);
            if($repeater_meta && isset($repeater_meta["gsdm_video_collage_repeater"])) {
                
                if(strlen($repeater_meta["gsdm_video_collage_repeater"]) > 0) {

                    $json = json_decode($repeater_meta["gsdm_video_collage_repeater"]);
                    
                    if(null === $json) {
                        throw new Exception("The meta key gsdm_video_collage_repeater returned an invalid json value");
                    }
                    array_push($json, $obj);
                    $repeater_meta["gsdm_video_collage_repeater"] = json_encode($json);
                    update_post_meta($targetPost["ID"], "gsdm_content_video_collage_meta_box", $repeater_meta);
     
                } else {
                    $repeater_meta["gsdm_video_collage_repeater"] = wp_json_encode(array($obj), JSON_UNESCAPED_UNICODE);
                    update_post_meta($targetPost["ID"], "gsdm_content_video_collage_meta_box", $repeater_meta);
                }
                
            } else {
                $repeater_meta = array(
                    "gsdm_video_collage_repeater"   => wp_json_encode(array($obj), JSON_UNESCAPED_UNICODE)
                );
                
                add_post_meta($targetPost["ID"], "gsdm_content_video_collage_meta_box", $repeater_meta, true);
                
                $test = get_post_meta($targetPost["ID"], "gsdm_content_video_collage_meta_box", true);
            }
                
        } else {
            throw new Exception("Cannot set meta data on post that does not exists");
        } 
    }
    
    
     /**
     * @Given /^the "([^"]*)" "([^"]*)" has the image collage repeater item labeled "([^"]*)" and the image "([^"]*)"$/
     */
    public function theHasTheImageCollageRepeaterItemLabeledAndTheImage($post_type, $post_title, $item_title, $item_image)
    {
        $image = get_page_by_title( $item_image, "ARRAY_A", "attachment");
        $targetPost = get_page_by_title( $post_title, "ARRAY_A", $post_type);
        
        
        $obj = (object) array(
                    "label" => $item_title,
                    "image" => $image["ID"],
                    "thumb" => $image["ID"]
                );
                
        if ($targetPost != null) {
            $repeater_meta = get_post_meta($targetPost["ID"], "gsdm_content_image_collage_meta_box", true);
            if($repeater_meta && isset($repeater_meta["gsdm_image_collage_repeater"])) {
                
                if(strlen($repeater_meta["gsdm_image_collage_repeater"]) > 0) {

                    $json = json_decode($repeater_meta["gsdm_image_collage_repeater"]);
                    
                    if(null === $json) {
                        throw new Exception("The meta key gsdm_image_collage_repeater returned an invalid json value");
                    }
                    array_push($json, $obj);
                    $repeater_meta["gsdm_image_collage_repeater"] = json_encode($json);
                    update_post_meta($targetPost["ID"], "gsdm_content_image_collage_meta_box", $repeater_meta);
     
                } else {
                    $repeater_meta["gsdm_image_collage_repeater"] = wp_json_encode(array($obj), JSON_UNESCAPED_UNICODE);
                    update_post_meta($targetPost["ID"], "gsdm_content_image_collage_meta_box", $repeater_meta);
                }
                
            } else {
                $repeater_meta = array(
                    "gsdm_image_collage_repeater"   => wp_json_encode(array($obj), JSON_UNESCAPED_UNICODE)
                );
                
                add_post_meta($targetPost["ID"], "gsdm_content_image_collage_meta_box", $repeater_meta, true);
                
                $test = get_post_meta($targetPost["ID"], "gsdm_content_image_collage_meta_box", true);
            }
                
        } else {
            throw new Exception("Cannot set meta data on post that does not exists");
        } 
    }


    
    /**
     * @Then /^I should see that the "([^"]*)" "([^"]*)" option from the "([^"]*)" element is selected$/
     */
    public function iShouldSeeThatTheOptionFromTheElementIsSelected2($post_type, $post_title, $selector)
    {
        $targetPost = get_page_by_title( $post_title, "ARRAY_A", $post_type);
        
        $session = $this->getSession(); 
        $element = $session->getPage()->find('css', $selector);
        
        // errors must not pass silently
        if (null === $element) {
            throw new \InvalidArgumentException(sprintf('Could not evaluate CSS selector: "%s"', $selector));
        }
        
        $value=$element->getValue();
        if($value != $targetPost["ID"]){
            throw new Exception('Option equals ' . $value . '. Expected ' . $targetPost["ID"]);        
        }
 
    }
    
    /* Used to check a minimum rather than exact count */
    /**
     * @Then /^I should see at least "([^"]*)" "([^"]*)" elements$/
     */
    public function iShouldSeeAtLeastElements($count, $selector)
    {
        $session = $this->getSession(); 
        $elements = $session->getPage()->findAll('css', $selector);
        
        if($count > count($elements)) {
            throw new Exception('Expected at least ' . $count . ' elements. Only ' . count($elements) . ' found on the page.');
        }
        
        
    }
    
    
    /**
     * @Given /^I manually submit the form$/
     */
    public function iManuallySubmitTheForm()
    {
        $script = "jQuery('form').trigger('submit');";
        $this->getSession()->evaluateScript($script);
        
    }

}
