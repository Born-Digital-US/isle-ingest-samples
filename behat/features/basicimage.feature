Feature: Test BasicImage CModel
  In order to prove that the BasicImage CModel works in ISLE
  As a developer
  I need to test some sample data

  # Able to ingest these test BASIC IMAGE sample objects?
  @api @apache @basicimage
  Scenario: Injest and Test BasicImage Sample Object
    # Given the following objects exist:
    #     | title |
    #     |   Z (Basic Image) TEST  |
    Given I am logged in as a user with the "administrator" role
    # Navigate to parent collection
    And I am on "/islandora/object/samples:collection"
    Then I should see "ICG Samples"
    # Navigate through new object form and ingest new object
    Then I click "Manage"
    Then I click "Add an object to this Collection"
    #Then wait for the page to be loaded
    When select "Islandora Basic Image Content Model" from "models"
    #Then I wait for AJAX to finish
    Then I press "Next"
    #Then wait for the page to be loaded
    #Then wait 3 seconds
    Then I press "Next"
    #Then wait for the page to be loaded
    #Then I wait for AJAX to finish
    Then I fill in "edit-titleinfo-title" with "Z (Basic Image) TEST"
    Then I press "Next"
    When I attach the file "/var/www/html/isle-ingest-samples/behat/features/assets/Image/ZPalm Tree typeTEST.jpg" to "edit-file-upload"
    Then I press "Upload"
    Then I press "Ingest"
    # Make sure the object ingested
    When I am on "/islandora/object/samples:collection"
    Then I click "last"
    Then I should see the link "Z (Basic Image) TEST"
    # When I click "Z (Basic Image) TEST"

    Given that I navigate to the page for the object named "Z (Basic Image) TEST"

    # Then I should see "In collections"
    When I click "Manage"
    Then I click "Properties"
    Then I should see "Item Label"
    Then I press "Permanently remove 'Z (Basic Image) TEST' from repository"
    Then I should see "This action cannot be undone."
    Then I press "Delete"
    When I am on "/islandora/object/samples:collection"
    Then I click "last"
    Then I should not see the link "Z (Basic Image) TEST"