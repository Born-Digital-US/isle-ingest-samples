Feature: Test Newspaper CModel
  In order to prove that the Newspaper CModel works in ISLE
  As a developer
  I need to test some sample data

# Able to ingest the test Newspaper sample objects?
  @api @apache @javascript @newspaper @sample-setup @sample-teardown
  Scenario: Ingest Newspaper Sample Object
    Given I am logged in as a user with the "administrator" role
    # Then I create the behat test collection

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
    Then I click on the selector "#edit-table-rows-islandoranewspapercmodel-selected"
    Then I click on the selector "#edit-submit"
    Then I click "Overview"

    Then I click "Add an object to this Collection"
    When select "Islandora Newspaper Content Model" from "models"
    And I wait for AJAX to finish
    Then I click on the selector "#edit-next--2"
    And wait for the page to be loaded
    Then I click on the selector "#edit-next"
    Then I fill in "edit-titleinfo-title" with "Z (Newspaper Content) TEST"
    Then I click on the selector "#edit-next"
    And wait for the page to be loaded
    And wait 10 seconds
    # Ingest Newspaper Issue Content
    Then I click "Manage"
    Then I click "Add Issue"
    Then I press "Next"
    And wait for the page to be loaded
    # Then I press "Next"
    Then I click on the selector "#edit-next"
    Then I fill in "edit-titleinfo-title" with "Z (Newspaper) TEST"
    Then I fill in "edit-origininfo-dateissued" with "2019-01-01"
    Then I click on the selector "#edit-next"
    When I attach the file "/var/www/html/isle-ingest-samples/behat/features/assets/Newspaper/Z_NEWSPAPER_TEST.pdf" to "edit-pdf-file-upload"
    Then I press "Upload"
    Then I wait for AJAX to finish
    Then I click on the selector "#edit-next"
    # And I wait for AJAX to finish
    And wait for the page to be loaded
    Then wait 20 seconds

    # MAX 30 minutes for this (3x)
    Then wait for Ingest to complete
    #Then grab me a screenshot
    Then wait for Ingest to complete
    #Then grab me a screenshot
    Then wait for Ingest to complete
    #Then grab me a screenshot


    Then I should see "Z (Newspaper) TEST"
    # Make sure the object ingested
    Given I am logged in as a user with the "administrator" role
    Given I am on "/islandora/search/%22Z%20%28Newspaper%20Content%29%20TEST%22?type=dismax"
    Then I should see "Z (Newspaper Content) TEST"
    Given that I navigate to the page for the object named "Z (Newspaper Content) TEST"
    Then I click "Expand all months"
    When I click "January 01, 2019"
    Then I should see "Z (Newspaper) TEST"



    ## Able to upload (replace) thumbnail for Newspaper object?
    #@api @apache @javascript @newspaper
    #Scenario: Replace Newspaper Thumbnail
    #Given I am logged in as a user with the "administrator" role
    Given that I navigate to the page for the object named "Z (Newspaper) TEST"
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
    Then I should see "Z (Newspaper) TEST"

    # another way to test: https://isle.localdomain/islandora/object/samples%3A1/datastream/TN
    # ultimately we want to regen thumbs in this test to go back to the original
    # Regenerate original thumbnail
    Given I am logged in as a user with the "administrator" role
    Given that I navigate to the page for the object named "Z (Newspaper) TEST"
    Then I should see the link "Manage"
    When I click "Manage"
    Given I wait for AJAX to finish
    Then I should see "PARENT COLLECTIONS"
    Then I click "Datastreams"
    Given I click "regenerate" in the "TN" row
    Then I should see "Are you sure you want to regenerate the derivative for the TN datastream?"
    Then I press "Regenerate"


    ## Able to delete TN derivative for Newspaper object? ***
    #@api @apache @javascript @newspaper
    #Scenario: Delete TN derivative for Newspaper Object
    #Given I am logged in as a user with the "administrator" role
    Given that I navigate to the page for the object named "Z (Newspaper) TEST"
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
    Given that I navigate to the page for the object named "Z (Newspaper) TEST"
    Then I should see the link "Manage"
    When I click "Manage"
    Then I click "Datastreams"
    Given I click "Add a datastream"
    Then I fill in "edit-dsid" with "TN"
    Then I fill in "edit-label" with "Thumbnail"
    When I attach the file "assets/ducky-5.jpg" to "edit-file-upload"
    And I press "Upload"
    When wait 3 seconds
    And I press "Add Datastream"
    Then I should see "Z (Newspaper) TEST"
    Then I should see the link "Manage"
    When I click "Manage"
    Then I click "Datastreams"
    Given I click "regenerate" in the "TN" row
    Then I should see "Are you sure you want to regenerate the derivative for the TN datastream?"
    Then I press "Regenerate"

    ## Able to regenerate all derivatives for Newspaper object? ***  See lower tests
    #@api @apache @javascript @newspaper
    #Scenario: Regenerate all derivatives for Newspaper Object
    #Given I am logged in as a user with the "administrator" role
    Given that I navigate to the page for the object named "Z (Newspaper) TEST"
    Then I should see the link "Manage"
    When I click "Manage"
    Then I click "Properties"
    Then I should see "Item Label"
    Then I press "Regenerate all derivatives"
    Then I should see "This will create a new version for every datastream on the object. Please wait while this happens."
    Given I press "Regenerate"
    # MAX 30 minutes for this (3x)
    Then wait for Ingest to complete
    #Then grab me a screenshot
    Then wait for Ingest to complete
    #Then grab me a screenshot
    Then wait for Ingest to complete
    #Then grab me a screenshot
    Then I should see the link "Derivatives successfully created."


    ## Able to download an Newspaper object?
    #@api @apache @newspaper @javascript
    #Scenario: Check for Newspaper OBJ download
    #Given I am logged in as a user with the "administrator" role
    Given that I navigate to the page for the object named "Z (Newspaper) TEST"
    Then I click "Manage"
    #Then grab me a screenshot
    Then I click "Datastreams"
    Then I should see "PDF"
    Given I click "download" in the "PDF" row



    ## Able to search for newly ingested Newspaper object using Islandora simple search?
    #@api @apache @newspaper
    #Scenario: Check for Newspaper Objects using simple search
    #Given I am logged in as a user with the "administrator" role
    Given I am on "/islandora/search/Newspaper?type=dismax"
    Then I should see "Z (Newspaper) TEST"



    ## Able to edit MODS datastream for Newspaper object? ("replace") ****
    #@api @apache @javascript @newspaper
    #Scenario: Replace MODS datastream for Newspaper Object
    #Given I am logged in as a user with the "administrator" role
    # Navigate to Object
    Given that I navigate to the page for the object named "Z (Newspaper) TEST"
    Then I should see "Z (Newspaper) TEST"
    # Navigate to and replace MODS datastream
    Then I click "Manage"
    Then I click "Datastreams"
    Then I should see "MODS Record"
    Given I click "replace" in the "MODS" row
    Then I should see "Replace Datastream"
    Then I should see "Label: MODS Record"
    When I attach the file "/var/www/html/isle-ingest-samples/behat/features/assets/Newspaper/Z_NEWSPAPER_TEST_REPLACE.xml" to "edit-file-upload"
    Given I press "Upload"
    Then I press "Add Contents"
    #Extra step required to forced reindexing
    Given that I navigate to the page for the object named "Z (Newspaper) TEST"
    Then I should see "Z (Newspaper) TEST"
    Then I click "Manage"
    Then I click "Datastreams"
    Then I should see "MODS Record"
    Given I click "edit" in the "MODS" row
    Then I press "Update"
    Given the cache has been cleared
    Given that I navigate to the page for the object named "Z (Newspaper) TEST"
    Then I should see "Z (Newspaper) TEST REPLACED"
    # Able to search for newly edited MODS datastream for Newspaper object using Islandora simple search?
    Given I am on "/islandora/search/Z%20%28Newspaper%29%20TEST%20REPLACED?type=dismax"
    Then I should see "Z (Newspaper) TEST REPLACED"

    # Restore Original MODS Datastream
    Given I am logged in as a user with the "administrator" role
    Given that I navigate to the page for the object named "Z (Newspaper) TEST REPLACED"
    Then I should see "Z (Newspaper) TEST"
    Then I click "Manage"
    Then I click "Datastreams"
    Then I should see "MODS Record"
    Given I click "replace" in the "MODS" row
    Then I should see "Replace Datastream"
    Then I should see "Label: MODS Record"
    When I attach the file "/var/www/html/isle-ingest-samples/behat/features/assets/Newspaper/Z_NEWSPAPER_TEST.xml" to "edit-file-upload"
    Given I press "Upload"
    Then I press "Add Contents"
    Given that I navigate to the page for the object named "Z (Newspaper) TEST"
    Then I should see "Z (Newspaper) TEST"
    Then I click "Manage"
    Then I click "Datastreams"
    Then I should see "MODS Record"
    Given I click "edit" in the "MODS" row
    Then I press "Update"
    Given the cache has been cleared
    Given that I navigate to the page for the object named "Z (Newspaper) TEST"
    Then I should not see "Z (Newspaper) TEST REPLACED"
    And I should see "Z (Newspaper) TEST"


    ## Able to edit Object Title for Newspaper Object
    #@api @apache @newspaper
    #Scenario: Edit Newspaper object title
    #Given I am logged in as a user with the "administrator" role
    # Navigate to Object
    Given that I navigate to the page for the object named "Z (Newspaper) TEST"
    Then I should see "Z (Newspaper) TEST"
    # Navigate to and change Object title
    Then I click "Manage"
    Then I click "Datastreams"
    Then I should see "MODS Record"
    Given I click "edit" in the "MODS" row
    Then I should see "Title"
    Then I fill in "edit-titleinfo-title" with "Z (Newspaper) TEST EDITED"
    When I press "Update"
    Then I should see "Z (Newspaper) TEST EDITED"
    # Test that object title did change and that search picks it up
    Given I am on "/islandora/search/Z%20%28Newspaper%29%20TEST%20EDITED?type=dismax"
    Then I should see "samples:"
    # Change Object title back to original
    Given that I navigate to the page for the object named "Z (Newspaper) TEST"
    Then I should see "Z (Newspaper) TEST EDITED"
    Then I click "Manage"
    Then I click "Datastreams"
    Then I should see "MODS Record"
    Given I click "edit" in the "MODS" row
    Then I should see "Title"
    Then I fill in "edit-titleinfo-title" with "Z (Newspaper) TEST"
    When I press "Update"
    Then I should see "Z (Newspaper) TEST"
    # Check that object title is original and that search is picking it up
    Given I am on "/islandora/search/Z%20%28Newspaper%29%20TEST?type=dismax"
    Then I should see "samples:"
    # similar test for "replace"


    ## Able to edit the Item Label of an Newspaper object's Properties?
    #@api @apache @newspaper
    #Scenario: Edit Newspaper object Item Label
    #Given I am logged in as a user with the "administrator" role
    # Navigate to Object
    Given that I navigate to the page for the object named "Z (Newspaper) TEST"
    Then I should see "Z (Newspaper) TEST"
    # Navigate to and change item label form
    Then I click "Manage"
    Then I click "Properties"
    Then I should see "A human-readable label"
    Then I fill in "edit-object-label" with "Z (Newspaper) TEST LABEL-EDITED"
    When I press "Update Properties"
    Then I should see "Z (Newspaper) TEST LABEL-EDITED"
    # Able to search for newly edited Item Label of an Newspaper object's Properties using Islandora simple search?
    Given I am on "/islandora/search/Z%20%28Newspaper%29%20TEST%20LABEL-EDITED?type=dismax"
    Then I should see "Z (Newspaper) TEST"
    Given that I navigate to the page for the object named "Z (Newspaper) TEST"
    Then I should see "Z (Newspaper) TEST LABEL-EDITED"
    # Change item label back to original
    Then I click "Manage"
    Then I click "Properties"
    Then I should see "A human-readable label"
    Then I fill in "edit-object-label" with "Z (Newspaper) TEST"
    When I press "Update Properties"
    Then I should see "Z (Newspaper) TEST"
    # Check that item label is now original
    Given I am on "/islandora/search/Z%20%28Newspaper%29%20TEST?type=dismax"
    Then I should see "Z (Newspaper) TEST"

    ##Delete newly ingested object
    #@api @apache @javascript @newspaper
    #Scenario: Delete newly ingested Newspaper object
    #Given I am logged in as a user with the "administrator" role
    Given that I navigate to the page for the object named "Z (Newspaper Content) TEST"
    Then I click "Expand all months"
    Then I should see the link "January 01, 2019"
    # Delete new object
    When I click "Manage"
    Then I click "Properties"
    Then I should see "Item Label"
    Then I press "Delete Newspaper"
    Then I should see "This will remove the"
    # Then I press "Delete"
    Then I click on the selector "#edit-submit"

    #And I wait for AJAX to finish
    And wait 5 seconds
    # MAX 30 minutes for this (3x)
    Then wait for Ingest to complete
    Then grab me a screenshot

    #Then wait for Ingest to complete
    #Then grab me a screenshot
    #Then wait for Ingest to complete
    #Then grab me a screenshot
    # Check that new object is deleted
    Given I am on "/islandora/search/%22Z%20%28Newspaper%20Content%29%20TEST%22?type=dismax"
    Then I should see "(0 - 0 of 0)"
    #Then grab me a screenshot
