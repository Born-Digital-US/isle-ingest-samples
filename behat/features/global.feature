Feature: Test FeatureContext
  In order to prove the Drupal context is working properly
  As a developer
  I need to use the step definitions of this context

  @javascript
  Scenario: Viewing content on the homepage
    Given I am on the homepage
    And I wait for AJAX to finish
    Then I should see a "body" element
    Then I should see a "h1" element
    Then I should not see "Fatal error:"
