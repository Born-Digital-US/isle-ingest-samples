<?php

use Drupal\DrupalExtension\Context\RawDrupalContext;
use Drupal\DrupalUserManager;

use Behat\Behat\Context\SnippetAcceptingContext;
use Behat\Gherkin\Node\PyStringNode;
use Behat\Gherkin\Node\TableNode;
use Behat\Behat\Tester\Exception\PendingException;
use Symfony\Component\Console\Helper\ProgressIndicator;
use Behat\Mink\Driver\Selenium2Driver;

/**
 * Defines application features from the specific context.
 */
class FeatureContext extends RawDrupalContext implements SnippetAcceptingContext {

  /**
   * @test_environments
   *
   * An array
   */
  private $test_environments;
  private $environment_id;
  private $assets_path;
  private $user;
  private $behat_test_collection_pid;

  /**
   * Initializes context.
   *
   * Every scenario gets its own context instance.
   * You can also supply arbitrary arguments to the
   * context constructor through behat.yml.
   *
   * @variable array $parameters.
   *   'environment_identifier' => selects which column of urls should be
   *     used from the test_urls.csv file.
   */
  public function __construct($parameters) {
    if(empty($parameters['environment_identifier'])) {
      throw new Exception("Environment identifier not found. Ensure that it is provided for the current profile in behat.yml.");
    }
    $this->environment_id = $parameters['environment_identifier'];
    $this->assets_path = $parameters['assets_path'];
    $urlsfile = $this->assets_path . "test_urls.csv";
    $csv = array_map('str_getcsv', file($urlsfile));
    $this->tests_environments = array();
    $headers = array_shift($csv);
    foreach($csv as $row_key => $test) {
      $test = array_combine($headers, $test);
      $this->test_environments[$test['Test ID']] = $test;
    }
    $this->behat_test_collection_pid = 'behattest:collection';
  }

  // /**
  //    * @Then I should see that the page title is :$expectedTitle
  //    */
  // public function iShouldSeeThatThePageTitleIs($expectedTitle)
  // { // Source: https://stackoverflow.com/questions/40804157/how-to-assert-page-tab-window-title-in-behat-mink
  //     $titleElement = $this->getSession()->getPage()->find('css', 'head title');
  //     if ($titleElement === null) {
  //         throw new PendingException('Page title element was not found!');
  //     } else {
  //         $title = $titleElement->getText();
  //         if ($expectedTitle !== $title) {
  //             throw new PendingException("Incorrect title! Expected:$expectedTitle | Actual:$title ");
  //         }
  //     }
  // }

  /**
   * @Then I should see that the page title is :arg1
   */
  public function iShouldSeeThatThePageTitleIs($arg1)
  {
    $titleElement = $this->getSession()->getPage()->find('css', 'head title');
    if ($titleElement === null) {
        throw new Exception('Page title element was not found!');
    } else {
        $title = $titleElement->getText();
        if ($arg1 !== $title) {
            throw new Exception("Incorrect title! Expected:$arg1 | Actual:$title ");
        }
    }
  }

  /**
   * @Then /^"([^"]*)" selector should be visible$/
   */
  public function selectorshouldBeVisible($selector) {
    $this->scrollIntoView($selector);
    $el = $this->getSession()->getPage()->find('css', $selector);

    $style = '';
    if(!empty($el)){
      $style = preg_replace('/\s/', '', $el->getAttribute('style'));
    } else {
      throw new Exception("Element ({$selector}) not found");
    }

    if(false !== strstr($style, 'display:none')) {
      throw new Exception("Element ({$selector}) is present but not visible");
    }
  }

  /**
   * @Then /^"([^"]*)" selector should not be visible$/
   */
  public function selectorshouldNotBeVisible($selector) {
    $this->scrollIntoView($selector);
    $el = $this->getSession()->getPage()->find('css', $selector);
    $style = '';
    if(!empty($el)){
      $style = preg_replace('/\s/', '', $el->getAttribute('style'));
      if ((false == strstr($style, 'display:none'))) {
        throw new Exception("Element ({$selector}) is present and does not have \"display:none\". It should not be visible");
      }
    }
  }

  /**
   * @Then :selector selector should be visible in( the) :region( region)
   */
  public function selectorshouldBeVisibleInRegion($selector, $region) {
    $this->scrollIntoView($selector);
    $regionObj = $this->getSession()->getPage()->find('region', $region);
    if(empty($regionObj)) {
      throw new Exception("Region ({$region}) not found");
    }
    $el = $regionObj->find('css', $selector);
    if(!empty($el)){
      $style = preg_replace('/\s/', '', $el->getAttribute('style'));
    } else {
      throw new Exception("Element ({$selector}) not found in ({$region})");
    }

    if(false !== strstr($style, 'display:none')) {
      throw new Exception("Element ({$selector}) is present but not visible");
    }
  }

  /**
   * @Then I should see :text( text) in an item with selector :selector
   */
  public function textShouldBeVisibleInSelector($text, $selector)
  {
    $this->scrollIntoView($selector);
    $el = $this->getSession()->getPage()->find('css', $selector);
    if (!empty($el)) {
      $eltext = $el->getText();
      if (stripos($eltext, $text) === FALSE) {
        throw new Exception("Text ({$text}) not found in selector ({$selector})");
      }
    }
    else {
      throw new Exception("Selector ({$selector}) not found.");
    }
  }

  /**
   * @Given I am viewing the page for :test_id( test)
   */
  public function iAmViewingATestID($test_id)
  {
    if(empty($this->test_environments[$test_id][$this->environment_id])) {
      throw new Exception("No testing url is defined for this test.");
    } else {
      echo "Testing $test_id  at " . $this->test_environments[$test_id][$this->environment_id] . ".";
      $this->getSession()->visit($this->locatePath($this->test_environments[$test_id][$this->environment_id]));
    }
  }

  /**
   * Click some text
   *
   * @When /^I click on the text "([^"]*)"$/
   */
  public function iClickOnTheText($text)
  {
    $session = $this->getSession();
    $element = $session->getPage()->find(
      'xpath',
      $session->getSelectorsHandler()->selectorToXpath('xpath', '*//*[text()="'. $text .'"]')
   );
    if (null === $element) {
      throw new \InvalidArgumentException(sprintf('Cannot find text: "%s"', $text));
    }
    $element->click();

  }

  /**
   * @When I click :text in the selector :selector
   */
  public function iClickTextInTheSelector($text, $selector)
  {
    $this->scrollIntoView($selector);
    $el = $this->getSession()->getPage()->find('css', $selector);
    if (!empty($el)) {

      $found = $el->find('xpath', "//*[text()=\"{$text}\"]");
      if($found) {
        $found->click();
      }
      else {
        throw new \InvalidArgumentException(sprintf('Cannot find text: "%s" in the "%s" selector', $text, $selector));
      }
    }
    else {
      throw new \InvalidArgumentException("CSS selector ({$selector}) not found");
    }
  }

  /**
   * @Given I am now logged in as :name
   */
  public function iAmNowLoggedInAs($name) {
    // from https://www.jeffgeerling.com/blog/2018/logging-existing-user-behat-test-drupal-extension
    $domain = $this->getMinkParameter('base_url');

    // Pass base url to drush command.
    $uli = $this->getDriver('drush')->drush('uli', [
      "--name '" . $name . "'",
      "--browser=0",
      "--uri=$domain",
    ]);

    // Trim EOL characters.
    $uli = trim($uli);

    // Log in.
    $this->getSession()->visit($uli);
  }

  /**
   * Click some selector
   *
   * @When /^I click on the selector "([^"]*)"$/
   *
   * TODO This doesn't work!
   */
  public function iClickOnTheSelector($selector)
  {
    $this->scrollIntoView($selector);
    $element = $this->getSession()->getPage()->find('css', $selector);
    if (null === $element) {
      throw new \InvalidArgumentException(sprintf('Cannot find selector: "%s"', $selector));
    }
    $element->click();
  }

  /**
   * Look for regex pattern.
   *
   * @Then I should see :pattern regex pattern
   *
   * @param $pattern
   * @throws Exception
   */
  function patternIsFound($pattern) {
    $page_text = $this->getSession()->getPage()->getText();
    var_export($page_text);
    if (!preg_match($this->patternRegex($pattern), $page_text, $matches)) {
      throw new Exception("No text matching the regex pattern \"$pattern\" was found.");
    }
  }

  /**
   * Utility function wraps a regex pattern to make it suitable
   * for use in the preg_match function.
   *
   * @param $pattern
   * @return string
   */
  private function patternRegex($pattern) {
    return '/'.$pattern.'/ui';
  }


  /**
   * Look for absence of regex pattern.
   *
   * @Then I should not see :pattern regex pattern
   *
   * @param $pattern
   * @throws Exception
   */
  function patternIsNotFound($pattern) {
    $page_text = $this->getSession()->getPage()->getText();
    if (preg_match($this->patternRegex($pattern), $page_text, $matches)) {
      throw new Exception("Text matching the regex pattern \"$pattern\" was found, and should not have been.");
    }
  }

  /**
   * Look for regex pattern in a region.
   *
   * @Then I should see :pattern regex pattern in the :region( region)
   *
   * @param $pattern
   * @throws Exception
   */
  function patternIsFoundInRegion($pattern, $region) {
    $regionObj = $this->getSession()->getPage()->find('region', $region);
    if(empty($regionObj)) {
      throw new Exception("Region ({$region}) not found");
    }

    $text = $regionObj->getText();
    if (!preg_match($this->patternRegex($pattern), $text, $matches)) {
      throw new Exception("No text matching the regex pattern \"$pattern\" was found in the $region region.");
    }
  }

  /**
   * Look for absence of a regex pattern in a region.
   *
   * @Then I should not see :pattern regex pattern in the :region( region)
   *
   */
  function patternIsNotFoundInRegion($pattern, $region) {
    $regionObj = $this->getSession()->getPage()->find('region', $region);
    if(!empty($regionObj)) {
      $text = $regionObj->getText();
      if (preg_match($this->patternRegex($pattern), $text, $matches)) {
        throw new Exception("Text matching the regex pattern \"$pattern\" was found in the $region region, and should not have been.");
      }
    }
  }

  /**
   * Look for regex pattern in a selector.
   *
   * @Then I should see :pattern regex pattern in an item with selector :selector
   *
   * @param $pattern
   *   A regex pattern that we are searching for.
   * @param $selector
   *   A css selector for the page elements we want to search in.
   * @throws Exception
   */
  function patternIsFoundInSelector($pattern, $selector) {
    $this->scrollIntoView($selector);
    $element = $this->getSession()->getPage()->find('css', $selector);
    if(empty($element)) {
      throw new Exception("Region ({$selector}) not found");
    }

    $text = $element->getText();
    if (!preg_match($this->patternRegex($pattern), $text, $matches)) {
      throw new Exception("No text matching the regex pattern \"$pattern\" was found in the $selector selector.");
    }
  }

  /**
   * Look for absence of a regex pattern in a selector.
   *
   * @Then I should not see :pattern regex pattern in an item with selector :selector
   *
   * @param $pattern
   *   A regex pattern that we are searching for.
   * @param $selector
   *   A css selector for the page elements we want to search in.
   * @throws Exception
   */
  function patternIsNotFoundInSelector($pattern, $selector) {
    $this->scrollIntoView($selector);
    $element = $this->getSession()->getPage()->find('css', $selector);
    if(!empty($element)) {
      $text = $element->getText();
      if (preg_match($this->patternRegex($pattern), $text, $matches)) {
        throw new Exception("No text matching the regex pattern \"$pattern\" was found in the $selector selector.");
      }
    }
  }

  /**
   * @Then I should see :count solr search results
   *
   * @param $count
   *   The number of search results we expect.
   * @throws Exception
   */
  public function iShouldSeeCountSolrSearchResults($count)
  {
    $actual_count = $this->countSelectorItems('.row.islandora-solr-search-result');
    if (((int) $count) !== $actual_count) {
      throw new Exception("Number of solr search results ($actual_count) does not match expected ($count).");
    }
  }

  /**
   * @Then I should see :count :selector items
   * @param $count
   *   The number of search results we expect.
   * @param $selector
   *   A css selector for the page elements we want to look in.
   * @throws Exception
   */
  public function iShouldSeeCountSelectorItems($count, $selector)
  {
    $this->scrollIntoView($selector);
    $actual_count = $this->countSelectorItems($selector);
    if (((int)$count) !== $actual_count) {
      throw new Exception("Number of items matching \"$selector\" ($actual_count) does not match expected ($count).");
    }
  }

  /**
   * @Then I should see at least :count solr search results
   * @param $count
   *   The minimum number of search results we expect.
   * @throws Exception
   */
  public function iShouldSeeAtLeastCountSolrSearchResults($count)
  {
    $actual_count = $this->countSelectorItems('.row.islandora-solr-search-result');
    if (((int) $count) > $actual_count) {
      throw new Exception("Number of solr search results ($actual_count) is less than expected ($count).");
    }
  }

  /**
   * @Then I should see at least :count :selector items
   * @param $count
   *   The minimum number of search results we expect.
   * @param $selector
   *   A css selector for the page elements we want to look in.
   * @throws Exception
   */
  public function iShouldSeeAtLeastCountSelectorItems($count, $selector)
  {
    $this->scrollIntoView($selector);
    $actual_count = $this->countSelectorItems($selector);
    if (((int)$count) > $actual_count) {
      throw new Exception("Number of items matching \"$selector\" ($actual_count) is less than expected ($count).");
    }
  }

  /**
   * @Then I should see at most :count solr search results
   * @param $count
   *   The maximum number of search results we expect.
   * @throws Exception
   */
  public function iShouldSeeAtMostCountSolrSearchResults($count)
  {
    $actual_count = $this->countSelectorItems('.row.islandora-solr-search-result');
    if (((int) $count) < $actual_count) {
      throw new Exception("Number of solr search results ($actual_count) is greater than expected ($count).");
    }
  }

  /**
   * @Then I should see at most :count :selector items
   * @param $count
   *   The maximum number of search results we expect.
   * @param $selector
   *   A css selector for the page elements we want to look in.
   * @throws Exception
   */
  public function iShouldSeeAtMostCountSelectorItems($count, $selector)
  {
    $this->scrollIntoView($selector);
    $actual_count = $this->countSelectorItems($selector);
    if (((int)$count) < $actual_count) {
      throw new Exception("Number of items matching \"$selector\" ($actual_count) is greater than expected ($count).");
    }
  }

  /**
   * @When /^wait (\d+\.*\d*) seconds?$/
   */
  public function waitSeconds($seconds)
  {
    $this->getSession()->wait(1000*$seconds);
  }

  /**
   * @When /^wait for the page to be loaded$/
   */
  public function waitForThePageToBeLoaded()
  {
    $this->getSession()->wait(10000, "document.readyState === 'complete'");
  }

  /**
   * Count number of page elements found by a css selector
   *
   * @param $selector
   *   A css pattern.
   * @return int
   *   The count.
   */
  private function countSelectorItems($selector) {
    return count($this->getSession()->getPage()->findAll('css', $selector));
  }

  /**
   * Create behat test collection object.
   *
   * @Then /^I create the behat test collection$/
   */
  public function ICreateBehatTestCollection() {
//    $drupal_user = user_load($this->getUserManager()->getCurrentUser()->uid);
//    $connection = islandora_get_tuque_connection($drupal_user);
//    $repository = $connection->repository;
    module_load_include('inc', 'islandora', 'includes/utilities');
    $relationships = array('relationship' => 'isMemberOfCollection', 'pid' => 'islandora:root');
    $object = islandora_prepare_new_object($this->behat_test_collection_pid, "Behat Test Collection", array(), array('islandora:collectionCModel'), array($relationships));
    islandora_add_object($object);


    $test = islandora_object_load($this->behat_test_collection_pid);
    if(empty($test)) {
      throw new Exception("Could not make the behat test collection");
    }
  }

  /**
   * Delete the behat test collection object.
   *
   * @Then /^I delete the behat test collection$/
   */
  public function IDeleteBehatTestCollection() {
    $drupal_user = user_load($this->getUserManager()->getCurrentUser()->uid);
    $connection = islandora_get_tuque_connection($drupal_user);
    $repository = $connection->repository;
    $object = islandora_object_load($this->behat_test_collection_pid);
    if(empty($object)) {
      throw new Exception("Unable to find the behat test collection in order to delete it.");
    }
    foreach($object as $datastream) {
      $object->purgeDatastream($datastream->id);
    }
    try {
      $repository->purgeObject($this->behat_test_collection_pid);
    }
    catch(Exception $e) {
      throw new Exception("Could not purge the behat test collection. Message: " . $e->getMessage());
    }

  }

  /**
   * Create a compound object with one child.
   *
   * @Then /^I make a compound object$/
   */
  public function ImakeSimpleCompoundObject($pid) {
    $drupal_user = user_load($this->getUserManager()->getCurrentUser()->uid);
    $connection = islandora_get_tuque_connection($drupal_user);
    $repository = $connection->repository;
    $object = $repository->constructObject('behattest:collection');
    $object->label = "Behat Test Collection";
    $object->relationships->add(FEDORA_RELS_EXT_URI, 'isMemberOfCollection', 'islandora:root');
    $object->relationships->add(FEDORA_RELS_EXT_URI, 'hasModel', 'islandora:collectionCModel');
    $repository->ingestObject($object);
    ;
  }


  /**
   * This works for Selenium and other real browsers that support screenshots.
   *
   * @Then /^grab me a screenshot$/
   */
  public function grab_me_a_screenshot() {

    $driver = $this->getSession()->getDriver();
    // quit silently when unsupported
    if (!($driver instanceof Selenium2Driver)) {
      return;
    }

    $image_data = $this->getSession()->getDriver()->getScreenshot();
    if(empty($image_data)) {
      throw new Exception("Could not take a screenshot");
    }
    $filename = 'screenshot_' . date('Ymd\TH:i:s') . '.jpg';
    // TODO: un-hardcode the path.
    $file_and_path = DRUPAL_ROOT . "/sites/behat/debug/screenshots/" . $filename;
    try {
      file_put_contents($file_and_path, $image_data);
    }
    catch(Exception $e) {
      throw new Exception("Could not save the screenshot. Message: " . $e->getMessage());
    }
  }

  /**
   * @BeforeStep
   */
  public function maximizeScreen() {
    $driver = $this->getSession()->getDriver();
    // quit silently when unsupported
    if (!($driver instanceof Selenium2Driver)) {
      return;
    }
    $driver->resizeWindow(1440,2500);
  }

  /**
   * @When I scroll :selector into view
   *
   * @param string $selector Allowed selectors: #id, .className, //xpath
   *
   * @throws \Exception
   */
  public function scrollIntoView($selector) {

      $locator = substr($selector, 0, 1);

      switch ($locator) {
        case '/' : // XPath selector
          $function = <<<JS
(function(){
  var elem = document.evaluate($selector, document, null, XPathResult.FIRST_ORDERED_NODE_TYPE, null).singleNodeValue;
  if(elem.length > 0) {
  elem.scrollIntoView(false);
  }
})()
JS;
          break;

        case '#' : // ID selector
          $selector = substr($selector, 1);
          $function = <<<JS
(function(){
  var elem = document.getElementById("$selector");
  elem.scrollIntoView(false);
})()
JS;
          break;

        case '.' : // Class selector
          $selector = substr($selector, 1);
          $function = <<<JS
(function(){
  var elem = document.getElementsByClassName("$selector");
  elem[0].scrollIntoView(false);
})()
JS;
          break;

        default:
//          throw new \Exception(__METHOD__ . ' Couldn\'t find selector: ' . $selector . ' - Allowed selectors: #id, .className, //xpath');
          break;
      }

      try {
        $this->getSession()
             ->executeScript($function);
      } catch (Exception $e) {
//        throw new \Exception(__METHOD__ . ' failed');
      }
    }

}
