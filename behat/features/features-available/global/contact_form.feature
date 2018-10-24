Feature: Contact Forms
  In order to prove that contact forms are working properly
  As a developer
  I want to verify that side-wide, institution, and object contact forms all work as expected.

  @core @api @prod
  Scenario: Do I see the contact link in the main menu and does it open up the site-wide contact form?
    Given I am on the homepage
    When I follow "Contact" in the "main_nav"
    Then the response should not contain "messages error"
    And I should see "Contact" in an item with selector "h1.page-header"
    And "#contact-site-form" selector should be visible

  @core @api
  Scenario: I fill out and submit the contact form.
    Given I am on "contact"
    And I fill in the following:
      |name|Behat Test Name|
      |mail|behat@example.com|
      |subject|Behat subject|
      |message|Behat message. Behat message.|
    And I select "Report a Problem" from "cid"
    When I press "Submit"
    Then I should see "Your message has been sent"
    And I should not see "Unable to send e-mail. Contact the site administrator if the problem persists."
    And the response should not contain "messages error"


  @core @api @javascript
  Scenario: I fill out and submit a participating institution contact form.
    Given I am on "contact/contact-smith-college-collections"
    And wait for the page to be loaded
    And I fill in the following:
      |name|Behat Test Name|
      |mail|behat@example.com|
      |subject|Behat Test Subject|
      |message|Behat message. Behat message.|
    And I select "Website feedback" from "cid"
    When I press "Submit"
    Then I should see "Your message has been sent"
    And I should not see "Unable to send e-mail. Contact the site administrator if the problem persists."
    And the response should not contain "messages error"
