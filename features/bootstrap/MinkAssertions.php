<?php

use Behat\Behat\Context\ClosuredContextInterface,
Behat\Behat\Context\TranslatedContextInterface,
Behat\Behat\Context\BehatContext,
Behat\Behat\Exception\PendingException;
use Behat\Gherkin\Node\PyStringNode,
Behat\Gherkin\Node\TableNode;

use Behat\MinkExtension\Context\MinkContext;

/**
 * MinkAssertions short summary.
 *
 * MinkAssertions description.
 *
 * @version 1.0
 * @author sfaulkne
 */
class MinkAssertions extends MinkContext
{
    public function __construct()
    {
    }
    
    public function assert($eq,$message) {
        if (!$eq) {
            print "Assert: " . $message . "\n";
            throw new Exception($message);
        }
    } 

    public function assertJavascriptExecution($timeOut,$command,$condition, $failureMessage) {
        $this->getSession()->executeScript($command);  
        $this->getSession()->wait($timeOut,$condition);
        $res = $this->getSession()->evaluateScript("return " . $condition);  
        if (!$res) {
            throw new Exception($failureMessage);
        }
    }

    public function assertJavascriptState($timeOut,$condition, $failureMessage) {
        $this->getSession()->wait($timeOut,$condition);
        $res = $this->getSession()->evaluateScript("return " . $condition);  
        if (!$res) {
            throw new Exception($failureMessage);
        }
        print "state asserted";
    }

    
    public function spin ($lambda, $wait = 60)
    {
        for ($i = 0; $i < $wait; $i++)
        {
            try {
                if ($lambda($this)) {
                    return true;
                }
            
            } catch (Exception $e) {
                // do nothing
            }

            sleep(1);
        }

        $backtrace = debug_backtrace();

        throw new Exception(
        "Timeout thrown by " . $backtrace[1]['class'] . "::" . $backtrace[1]['function'] . "()\n" .
        $backtrace[1]['file'] . ", line " . $backtrace[1]['line']
        );
    }
    
    private function getStyle($cssSelector,$css) {
        $res = $this->getSession()->evaluateScript("return $('".$cssSelector."').css('".$css."')");  
        return $res;
    }
    
    /**
     * @Then /^the "([^"]*)" element should have a css setting "([^"]*)" that "(equals|does not equal|contains|does not contain)" "([^"]*)"$/
     */
    public function assertCssValue($cssSelector, $cssProperty, $comparator, $value)
    {
        $this->getSession()->wait(10000, 'typeof window.jQuery == "function"');
        $res = $this->getStyle($cssSelector, $cssProperty);
        switch($comparator) {
            case "equals":
                if ($res != $value) {
                    throw new Exception(sprintf('The element $("%1$s").css("%2$s") does not equal %3$s. Instead it equals %4$s. ',$cssSelector,$cssProperty, $value, $res));
                }
                break;
            case "does not equal":
                if ($res == $value) {
                    throw new Exception(sprintf('The element $("%1$s").css("%2$s") equals %3$s ',$cssSelector,$cssProperty, $value));
                }
                break;
            case "contains":
                print "contains";
                if (strpos($res, $value) === FALSE) {
                    throw new Exception(sprintf('The element $("%1$s").css("%2$s") does not contain %3$s ',$cssSelector,$cssProperty, $value));
                } else {
                    print "passed";
                }
                break;
            case "does not contain":
                if (strpos($res, $value) !== FALSE) {
                    throw new Exception(sprintf('The element $("%1$s").css("%2$s") contains %3$s ',$cssSelector,$cssProperty, $value));
                }
                break;
        }
    }
    
    
   /**
    * @Then /^I should see the "([^"]*)" modal$/
    */
   public function iShouldSeeTheModal($element)
   {
       $this->getSession()->wait(20000, '(0 === jQuery.active && 0 === jQuery(\':animated\').length)');
       $el = $this->getSession()->getPage()->find('css', $element);
       
       if(null === $el) {
            throw new Exception('The element ' . $element . ' was not found.');
       }
       
       $this->assert($el->isVisible(), $element . ' is not visible');
   }
}
