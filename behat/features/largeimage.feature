Feature: Test LargeImage CModel
  In order to prove that the LargeImage CModel works in ISLE
  As a developer
  I need to test some sample data


 # Able to ingest these test LARGE IMAGE sample objects?
  @api @apache @largeimage
  Scenario: Injest Large Image Sample Object
    Given I am logged in as a user with the "administrator" role
    # Navigate to parent collection
    And I am on "/islandora/object/samples%3Acollection"
    Then I should see "ICG Samples"
    # Navigate through new object form and ingest new object
    Then I click "Manage"
    Then I click "Add an object to this Collection"
    When select "Islandora Large Image Content Model" from "models"
    Then I press "Next"
    # (Next again because we always skip MARCXML)
    Then I press "Next"
    Then I fill in "edit-titleinfo-title" with "Z Nehemiah Strong House (Large Image) TEST OBJECT"
    Then I press "Next"
    When I attach the file "/var/www/html/isle-ingest-samples/behat/features/assets/Large Image/Z Nehemiah Strong House (Large Image) TEST OBJECT.tiff" to "edit-file-upload"
    Then I press "Upload"
    Then I press "Ingest"
    # Make sure the object ingested
    When I am on "/islandora/object/samples%3Acollection"
    Then I click "last"
    Then I should see the link "Z Nehemiah Strong House (Large Image) TEST OBJECT"
    # Delete new object
    When I click "Z Nehemiah Strong House (Large Image) TEST OBJECT"
    Then I should see "In collections"
    When I click "Manage"
    Then I click "Properties"
    Then I should see "Item Label"
    Then I press "Permanently remove 'Z Nehemiah Strong House ...' from repository"
    Then I should see "This action cannot be undone."
    Then I press "Delete"
    # Check that new object is deleted
    When I am on "/islandora/object/samples%3Acollection"
    Then I click "last"
    Then I should not see the link "Z Nehemiah Strong House (Large Image) TEST OBJECT"
