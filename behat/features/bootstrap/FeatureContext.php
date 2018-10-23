<?php

use Drupal\DrupalExtension\Context\RawDrupalContext;
use Behat\Behat\Context\SnippetAcceptingContext;
use Behat\Gherkin\Node\PyStringNode;
use Behat\Gherkin\Node\TableNode;
use Behat\Behat\Tester\Exception\PendingException;
use Behat\Mink\Driver\Selenium2Driver;
use Behat\Behat\Hook\Scope\AfterStepScope;

/**
 * Defines application features from the specific context.
 */
class FeatureContext extends RawDrupalContext implements SnippetAcceptingContext {

	/**
	* Initializes context.
	*
	* Every scenario gets its own context instance.
	* You can also pass arbitrary arguments to the
	* context constructor through behat.yml.
	*/
	public function __construct() {
	}

	/**
	 * @AfterStep
	 */
	public function takeScreenshotAfterFailedStep(AfterStepScope $scope) {
		if ($scope->getTestResult()->getResultCode() == 99) {
			$this->takeScreenshot();
		}
	}

	/**
	 * Store a screenshot.
	 */
	private function takeScreenshot() {
		$screenshot = $this->getSession()->getDriver()->getScreenshot();
		$path = '/home/circleci/born-digital/data/bd-samples/behat/screenshot' . date('d-m-y') . '-' . uniqid() . '.png';

		file_put_contents($path, $screenshot);
		print 'Screenshot at: ' . $path;
	}


	// public function turnOnImplicitWait()
	// {
	//     // Set up implicit timeouts
	//     $driver = $this->getSession()->getDriver()->getWebDriverSession();
	//     $driver->timeouts()->implicit_wait(array("ms" => 10000));
	// }
	//
	// public function turnOffImplicitWait()
	// {
	//     // Set up implicit timeouts
	//     $driver = $this->getSession()->getDriver()->getWebDriverSession();
	//     $driver->timeouts()->implicit_wait(array("ms" => 0));
	// }
	//
	// /**
	//  * @Given /^I set (?:|the )implicit wait to ([\d]+)? (m|mins?|s|seconds?|ms|milliseconds)?(?:| .*)$/
	//  */
	// public function setImplicitWait($time, $msormins)
	// {
	//     $driver = $this->getSession()->getDriver()->getWebDriverSession();
	//     if ($msormins == "min" | $msormins == "mins") {
	//         $time = $time * 60000;
	//     } elseif ($msormins == "s" | $msormins == "seconds") {
	//         $time = $time * 1000;
	//     } elseif ($msormins == "ms" | $msormins == "milliseconds") {
	//         $time = $time * 1;
	//     }
	//     $driver->timeouts()->implicit_wait(array("ms" => $time));
	// }

	// /**
	//  * @Given I wait for :arg1 seconds
	//  */
	// public function iWaitForSeconds($time)
	// {
	// 	sleep($time);
	// }

	/**
	 * @Given I wait :arg1 seconds
	 */
	public function iWaitSeconds($time)
	{
			sleep($time);
	}

	/**
	 * @Given I bust cache
	 */
	public function iBustCache()
	{
			// hopefully never need this SUPER hack

			// shell_exec('wget http://127.0.0.1:8080/2020/data-search/Search-the-Data#objid=5338 &');
			// sleep(10);
			// shell_exec('service apache2 restart');
	}
}
