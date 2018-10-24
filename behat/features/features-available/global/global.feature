Feature: General site functionality
  In order to prove that the site is working properly
  As a developer
  I want to validate that the correct content is/isn't displayed on each page

  @prod
  Scenario: Viewing content on the homepage
    Given I am on the homepage
    Then I should see "Explore Compass"
    Then the response should not contain "messages error"

  @prod
  Scenario: Anonymous user viewing the homepage
    Given I am on the homepage
    And I am an anonymous user
    Then ".log-in-out .login" selector should be visible

  @javascript @api
  Scenario: Authenticated user viewing the homepage
    Given I am on the homepage
    And I am logged in as a user with the "authenticated user" role
    Then ".log-in-out .logout" selector should be visible
