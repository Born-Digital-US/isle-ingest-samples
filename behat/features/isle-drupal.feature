Feature: Drupal Basics
  In order to prove Drupal is loaded properly
  As a developer
  I need to check some basic Drupal paths

  # Able to view domain / website url as anonymous user?
  # Able to login to Drupal site as an admin user?
  # Able to view persistent data folders for xml/xslt/sites and for fedora data store?
  # If Drupal multisite, able to login to multisite (not parent) site?
  # Drupal Status Report not showing errors? https://<domain>/node#overlay=admin/reports/status

  @apache @javascript
  Scenario: Viewing homepage
    Given I am an anonymous user
    And I am on "/"
    Then I should see a "body" element
    # THEME DEPENDENT
    And I wait for AJAX to finish
    Then I should see "Powered by Drupal"

  @apache
  Scenario: Viewing login page anonymously
    Given I am an anonymous user
    And I am on "/user"
    Then I should see a "body" element
    Then I should see "User account"

@apache @javascript
  Scenario: Viewing login page as admin
    Given I am logged in as a user with the "administrator" role
    And I am on "/user"
    Then I should see "Member for"

  @apache @api
  Scenario: Viewing login page as new user
    # Given I log in as isle
    Given users:
      | name  | mail              | status | role |
      | behat | behat@example.com | 1      | authenticated user |
    Given I am logged in as "behat"
    # really i want to log in as "isle"
    And I am on "/user"
    Then I should see a "body" element
    Then I should see "behat"
    Then I should see "Member for"
