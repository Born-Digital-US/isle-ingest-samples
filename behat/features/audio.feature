Feature: Test Audio CModel
  In order to prove that the Audio CModel works in ISLE
  As a developer
  I need to test some sample data

    #@api @apache @setup
    #Scenario: Enable Simple Search
    #  Given I am logged in as a user with the "administrator" role
    #  And I am on "/admin/structure/block"
    #  Then I should see the link "Add block"
    #  Given I select "Sidebar first" from "edit-blocks-islandora-solr-simple-region"
    #  Then I press "Save blocks"

# Able to ingest the test AUDIO sample objects?
  @api @apache @javascript @audio @sample-setup @sample-teardown
  Scenario: Ingest Audio Sample Object
    Given I am logged in as a user with the "administrator" role
    #Then I create the behat test collection
    # Navigate to parent collection
    And I am on "/islandora/object/behattest:collection"
    Then I should see "Behat Test Collection"
    # Navigate through new object form and ingest new object

    Then I click "Manage"
    Then I click "Properties"
    Then I select "A" from "edit-object-state"
    Then I click on the selector "#edit-submit"
    Then I click "Collection"
    Then I click on the selector "#edit-table-rows-islandoracollectioncmodel-selected"
    Then I click on the selector "#edit-table-rows-islandorasp-audiocmodel-selected"
    Then I click on the selector "#edit-submit"
    Then I click "Overview"

    Then I click "Add an object to this Collection"
    When select "Islandora Audio Content Model" from "models"
    And I wait for AJAX to finish
    Then I press "Next"
    And wait for the page to be loaded
    Then I click on the selector "#edit-next"
    Then I fill in "edit-titleinfo-title" with "Z (Audio) TEST"
    Then I click on the selector "#edit-next"
    When I attach the file "/var/www/html/isle-ingest-samples/behat/features/assets/Audio/Z_AUDIO_TEST.mp3" to "edit-audio-file-upload"
    Then I press "Upload"
    Then I wait for AJAX to finish
    Given I check the box "Upload Thumbnail"
    When I attach the file "/var/www/html/isle-ingest-samples/behat/features/assets/Audio/Z_AUDIO_TEST.png" to "edit-thumbnail-file-upload"
    Then I press "Upload"
    Then I wait for AJAX to finish
    Then I click on the selector "#edit-next"
    # And wait for the page to be loaded
    Then wait for Ingest to complete
    # Make sure the object ingested
    Given I am on "/islandora/search/%22Z%20%28Audio%29%20TEST%22?type=dismax"
    Then I should see "(1 - 1 of 1)"
    Then I should see "Z (Audio) TEST"



    # Able to upload (replace) thumbnail for Audio object?
    #@api @apache @javascript @audio
    #Scenario: Replace Audio Thumbnail
    #Given I am logged in as a user with the "administrator" role
    Given that I navigate to the page for the object named "Z (Audio) TEST"
    Then I should see the link "Manage"
    When I click "Manage"
    Given I wait for AJAX to finish
    Then I should see "PARENT COLLECTIONS"
    Then I click "Datastreams"
    Given I click "replace" in the "TN" row
    Then I should see "Update Datastream"
    When I attach the file "assets/ducky-5.jpg" to "edit-file-upload"
    And I press "Upload"
    When wait 3 seconds
    And I press "Add Contents"
    Then I should see "Z (Audio) TEST"

    # Re-upload original thumbnail
    Given I am logged in as a user with the "administrator" role
    Given that I navigate to the page for the object named "Z (Audio) TEST"
    Then I should see the link "Manage"
    When I click "Manage"
    Given I wait for AJAX to finish
    Then I should see "PARENT COLLECTIONS"
    Then I click "Datastreams"
    Given I click "replace" in the "TN" row
    When I attach the file "/var/www/html/isle-ingest-samples/behat/features/assets/Audio/Z_AUDIO_TEST.png" to "edit-file-upload"
    And I press "Upload"
    When wait 3 seconds
    And I press "Add Contents"
    Then I should see "Z (Audio) TEST"


    # Able to delete TN derivative for AUDIO object? ***
    #@api @apache @javascript @audio
    #Scenario: Delete TN derivative for Audio Object
    #Given I am logged in as a user with the "administrator" role
    Given that I navigate to the page for the object named "Z (Audio) TEST"
    Then I should see the link "Manage"
    When I click "Manage"
    Given I wait for AJAX to finish
    When wait 3 seconds
    Then I should see "PARENT COLLECTIONS"
    Then I click "Datastreams"
    Given I click "delete" in the "TN" row
    Then I check the box "Delete Derivatives"
    Then I press "Delete"

    #Add Original Thumbnail and Thumbnail datastream back
    Given I am logged in as a user with the "administrator" role
    Given that I navigate to the page for the object named "Z (Audio) TEST"
    Then I should see the link "Manage"
    When I click "Manage"
    Then I click "Datastreams"
    Given I click "Add a datastream"
    Then I fill in "edit-dsid" with "TN"
    Then I fill in "edit-label" with "Thumbnail"
    When I attach the file "/var/www/html/isle-ingest-samples/behat/features/assets/Audio/Z_AUDIO_TEST.png" to "edit-file-upload"
    And I press "Upload"
    When wait 3 seconds
    And I press "Add Datastream"
    Then I should see "Z (Audio) TEST"
    Then I should see the link "Manage"
    When I click "Manage"
    Then I click "Datastreams"
    Given I click "regenerate" in the "TN" row
    Then I should see "Are you sure you want to regenerate the derivative for the TN datastream?"
    Then I press "Regenerate"

    # Able to regenerate all derivatives for AUDIO object? ***  See lower tests
    #@api @apache @javascript @audio
    #Scenario: Regenerate all derivatives for Audio Object
    #Given I am logged in as a user with the "administrator" role
    Given that I navigate to the page for the object named "Z (Audio) TEST"
    Then I should see the link "Manage"
    When I click "Manage"
    Then I click "Properties"
    Then I should see "Item Label"
    Then I press "Regenerate all derivatives"
    Then I should see "This will create a new version for every datastream on the object. Please wait while this happens."
    Given I press "Regenerate"
    Given wait 20 seconds
    Then I should see the link "Derivatives successfully created."
    Given I click "Derivatives successfully created."
    Then I should see "Created"


    ## Able to download an AUDIO object?
    #@api @apache @audio
    #Scenario: Check for Audio OBJ download
    #Given I am logged in as a user with the "administrator" role
    Given that I navigate to the page for the object named "Z (Audio) TEST"
    Then I should see the link "Manage"
    When I click "Manage"
    Then I click "Datastreams"
    Given I click "download" in the "OBJ" row
    Then wait 30 seconds


    # Able to search for newly ingested AUDIO object using Islandora simple search?
    #@api @apache @audio
    #Scenario: Check for Audio Objects using simple search
    #Given I am logged in as a user with the "administrator" role
    Given I am on "/islandora/search/Audio?type=dismax"
    Then I should see "Z (Audio) TEST"



    # Able to edit MODS datastream for AUDIO object? ("replace") ****
    #@api @apache @audio
    #Scenario: Replace MODS datastream for Audio Object
    #Given I am logged in as a user with the "administrator" role
    # Navigate to Object
    Given that I navigate to the page for the object named "Z (Audio) TEST"
    Then I should see "Z (Audio) TEST"
    # Navigate to and replace MODS datastream
    Then I click "Manage"
    Then I click "Datastreams"
    Then I should see "MODS Record"
    Given I click "replace" in the "MODS" row
    Then I should see "Replace Datastream"
    Then I should see "Label: MODS Record"
    When I attach the file "assets/MODS-replace-warbler.xml" to "edit-file-upload"
    Given I press "Upload"
    Then I press "Add Contents"
    #Extra step required to forced reindexing
    Given that I navigate to the page for the object named "Z (Audio) TEST"
    Then I should see "Z (Audio) TEST"
    Then I click "Manage"
    Then I click "Datastreams"
    Then I should see "MODS Record"
    Given I click "edit" in the "MODS" row
    Then I press "Update"
    Given the cache has been cleared
    Given that I navigate to the page for the object named "Z (Audio) TEST REPLACED"
    Then I should see "Z (Audio) TEST REPLACED"
    # Able to search for newly edited MODS datastream for AUDIO object using Islandora simple search?
    Given I am on "/islandora/search/Z%20%28Audio%29%20TEST%20REPLACED?type=dismax"
    Then I should see "Z (Audio) TEST REPLACED"

    # Restore Original MODS Datastream
    #Given I am logged in as a user with the "administrator" role
    Given that I navigate to the page for the object named "Z (Audio) TEST REPLACED"
    Then I should see "Z (Audio) TEST"
    Then I click "Manage"
    Then I click "Datastreams"
    Then I should see "MODS Record"
    Given I click "replace" in the "MODS" row
    Then I should see "Replace Datastream"
    Then I should see "Label: MODS Record"
    When I attach the file "assets/Audio/Z_AUDIO_TEST.xml" to "edit-file-upload"
    Given I press "Upload"
    Then I press "Add Contents"
    Given that I navigate to the page for the object named "Z (Audio) TEST"
    Then I should see "Z (Audio) TEST"
    Then I click "Manage"
    Then I click "Datastreams"
    Then I should see "MODS Record"
    Given I click "edit" in the "MODS" row
    Then I press "Update"
    Given the cache has been cleared
    Given that I navigate to the page for the object named "Z (Audio) TEST"
    Then I should not see "Z (Audio) TEST REPLACED"
    And I should see "Z (Audio) TEST"


    # Able to edit Object Title for audio Object
    #@api @apache @audio
    #Scenario: Edit Audio object title
    #Given I am logged in as a user with the "administrator" role
    # Navigate to Object
    Given that I navigate to the page for the object named "Z (Audio) TEST"
    Then I should see "Z (Audio) TEST"
    # Navigate to and change Object title
    Then I click "Manage"
    Then I click "Datastreams"
    Then I should see "MODS Record"
    Given I click "edit" in the "MODS" row
    Then I should see "Title of the work"
    Then I fill in "edit-titleinfo-title" with "Z (Audio) TEST EDITED"
    When I press "Update"
    Then I should see "Z (Audio) TEST EDITED"
    # Test that object title did change and that search picks it up
    Given I am on "/islandora/search/Z%20%28Audio%29%20TEST%20EDITED?type=dismax"
    Then I should see "samples:"
    # Change Object title back to original
    Given that I navigate to the page for the object named "Z (Audio) TEST"
    Then I should see "Z (Audio) TEST EDITED"
    Then I click "Manage"
    Then I click "Datastreams"
    Then I should see "MODS Record"
    Given I click "edit" in the "MODS" row
    Then I should see "Title of the work"
    Then I fill in "edit-titleinfo-title" with "Z (Audio) TEST"
    When I press "Update"
    Then I should see "Z (Audio) TEST"
    # Check that object title is original and that search is picking it up
    Given I am on "/islandora/search/Z%20%28Audio%29%20TEST?type=dismax"
    Then I should see "samples:"


    # Able to edit the Item Label of an AUDIO object's Properties?
    #@api @apache @audio
    #Scenario: Edit Audio object Item Label
    #Given I am logged in as a user with the "administrator" role
    # Navigate to Object
    Given that I navigate to the page for the object named "Z (Audio) TEST"
    Then I should see "Z (Audio) TEST"
    # Navigate to and change item label form
    Then I click "Manage"
    Then I click "Properties"
    Then I should see "A human-readable label"
    Then I fill in "edit-object-label" with "Z (Audio) TEST LABEL-EDITED"
    When I press "Update Properties"
    Then I should see "Z (Audio) TEST LABEL-EDITED"
    # Able to search for newly edited Item Label of an AUDIO object's Properties using Islandora simple search?
    Given I am on "/islandora/search/Z%20%28Audio%29%20TEST%20LABEL-EDITED?type=dismax"
    Then I should see "Z (Audio) TEST"
    Given that I navigate to the page for the object named "Z (Audio) TEST"
    Then I should see "Z (Audio) TEST LABEL-EDITED"
    # Change item label back to original
    Then I click "Manage"
    Then I click "Properties"
    Then I should see "A human-readable label"
    Then I fill in "edit-object-label" with "Z (Audio) TEST"
    When I press "Update Properties"
    Then I should see "Z (Audio) TEST"
    # Check that item label is now original
    Given I am on "/islandora/search/Z%20%28Audio%29%20TEST?type=dismax"
    Then I should see "Z (Audio) TEST"

    ##Delete newly ingested object
    #@api @apache @javascript @audio
    #Scenario: Delete newly ingested Audio object
    #Given I am logged in as a user with the "administrator" role
    Given that I navigate to the page for the object named "Z (Audio) TEST"
    # Delete new object
    Then I should see "In collections"
    When I click "Manage"
    Then I click "Properties"
    Then I should see "Item Label"
    Then I press "Permanently remove 'Z (Audio) TEST' from repository"
    Then I should see "This action cannot be undone."
    Then I press "Delete"
    And I wait for AJAX to finish
    And wait 5 seconds
    # Check that new object is deleted
    Given I am on "/islandora/search/%22Z%20%28Audio%29%20TEST%22?type=dismax"
    Then I should see "(0 - 0 of 0)"


    # @api @apache @javascript @audio
    # Scenario: Delete Behat Test Orphaned Objects Audio
    #   Given I am logged in as a user with the "administrator" role
    #   When I am on "/admin/reports/orphaned_objects/list"
    #   And I click on the selector "#edit-submit-all"
    #   And I click on the selector "#edit-confirm-submit"
    #   Then wait 30 seconds
