Feature: Test Islandora Webform ajax loading, submit, view and delete submission

  @core @api @javascript
  Scenario: View object contact form, fill it out and submit, log in as admin and view the submission, and then delete it.
    Given I am viewing the page for "object with contact form"
    Then I should see "Contact Us" in an item with selector ".webform-link"
    When I click "Contact Us"
    And I wait for AJAX to finish
    And I should see the button "Submit"
    When I fill in the following:
      | submitted[your_email] | behat@example.com             |
      | submitted[message]    | Behat message. Behat message. |
    And I press "Submit"
    And wait 5 seconds
    Then the response should contain "alert-success"
    And I should not see "Unable to send e-mail."
    And the response should not contain "messages error"
    Given I am logged in as a user with the "administrator" role
    And I am viewing the page for "object with contact form"
    Then I should see "Submissions" in the "primary_tabs" region
    When I click "Submissions" in the "primary_tabs"
    And wait for the page to be loaded
    Then ".table-responsive .sticky-table" selector should be visible
    When I click "Edit" in the selector "#block-system-main .table-responsive .sticky-table > tbody > tr:last-child"
    And wait for the page to be loaded
    Then I should see "Behat message. Behat message."
    And I should see "Delete" in the "primary_tabs" region
    When I click "Delete" in the "primary_tabs"
    And wait for the page to be loaded
    Then I should see "Are you sure you want to delete this submission?"
    When I press "Delete"
    And wait for the page to be loaded
    Then the response should contain "messages status"
    And the response should not contain "messages error"


