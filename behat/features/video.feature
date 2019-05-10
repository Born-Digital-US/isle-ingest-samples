Feature: Test Video CModel
  In order to prove that the Video CModel works in ISLE
  As a developer
  I need to test some sample data

# Able to ingest these test VIDEO sample objects?
    #(Javascript does not work because it cannot interact with second "Next" button)
  @api @apache @video
  Scenario: Injest Video Sample Objects
    Given I am logged in as a user with the "administrator" role
    # Navigate to parent collection
    And I am on "/islandora/object/samples%3Acollection"
    Then I should see "ICG Samples"
    # Navigate through new object form and ingest new object
    Then I click "Manage"
    Then I click "Add an object to this Collection"
    When select "Islandora Video Content Model" from "models"
    Then I press "Next"
    # (Next again because we always skip MARCXML)
    Then I press "Next"
    Then I fill in "edit-titleinfo-title" with "Z American Safey Razor (Video) TEST OBJECT"
    Then I press "Next"
    When I attach the file "/var/www/html/isle-ingest-samples/behat/features/assets/Videos/ZsafetyRazorTEST.mp4" to "edit-file-upload"
    Then I press "Upload"
    Then I press "Ingest"
    # Make sure the object ingested
    When I am on "/islandora/object/samples%3Acollection"
    Then I click "last"
    Then I should see the link "Z American Safey Razor (Video) TEST OBJECT"
    # Delete new object
    When I click "Z American Safey Razor (Video) TEST OBJECT"
    Then I should see "In collections"
    When I click "Manage"
    Then I click "Properties"
    Then I should see "Item Label"
    Then I press "Permanently remove 'Z American Safey Razor (Video...' from repository"
    Then I should see "This action cannot be undone."
    Then I press "Delete"
    # Check that new object is deleted
    When I am on "/islandora/object/samples%3Acollection"
    Then I click "last"
    Then I should not see the link "Z American Safey Razor (Video) TEST OBJECT"

