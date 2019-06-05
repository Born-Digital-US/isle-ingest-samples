Feature: Test ORAL HISTORIES CModel
  In order to prove that the ORAL HISTORIES CModel works in ISLE
  As a developer
  I need to test some sample data

# Able to ingest the test ORAL HISTORIES sample objects?
  @api @apache @javascript @oralhistories @sample-setup @sample-teardown
  Scenario: Ingest ORAL HISTORIES Sample Object
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
    Then I click on the selector "#edit-table-rows-islandoraoralhistoriescmodel-selected"
    Then I click on the selector "#edit-submit"
    Then I click "Overview"


    Then I click "Add an object to this Collection"
    When select "Islandora Oral Histories Content Model" from "models"
    And I wait for AJAX to finish
    Then I press "Next"
    And wait for the page to be loaded
    Then I click on the selector "#edit-next"
    Then I fill in "edit-titleinfo-title" with "Z (ORAL HISTORIES) TEST"
    Then I click on the selector "#edit-next"
    When I attach the file "/var/www/html/isle-ingest-samples/behat/features/assets/ORAL_HISTORIES/OH_01/MP3.mp3" to "edit-media-file-upload"
    Then I press "Upload"
    Then I wait for AJAX to finish
    And wait 30 seconds
    When I attach the file "/var/www/html/isle-ingest-samples/behat/features/assets/ORAL_HISTORIES/OH_01/Transcript.xml" to "edit-transcript-file-upload"
    Then I press "Upload"
    Then I wait for AJAX to finish
    And wait 30 seconds
    Then I click on the selector "#edit-next"
    And wait for the page to be loaded
    And wait 20 seconds
    # MAX 30 minutes for this (3x)
    Then wait for Ingest to complete
    #Then grab me a screenshot
    Then wait for Ingest to complete
    #Then grab me a screenshot
    Then wait for Ingest to complete
    #Then grab me a screenshot
    # Make sure the object ingested
    Given I am on "/islandora/search/%22Z%20%28ORAL%20HISTORIES%29%20TEST%22?type=dismax"
    Then I should see "(1 - 1 of 1)"
    Then I should see "Z (ORAL HISTORIES) TEST"
    


    ## Able to upload (replace) thumbnail for ORAL HISTORIES object?
    #@api @apache @javascript @oralhistories
    #Scenario: Replace ORAL HISTORIES Thumbnail
    #Given I am logged in as a user with the "administrator" role
    Given that I navigate to the page for the object named "Z (ORAL HISTORIES) TEST"
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
    Then I should see "Z (ORAL HISTORIES) TEST"
    
    # Re-upload original thumbnail
    #Given I am logged in as a user with the "administrator" role
    Given that I navigate to the page for the object named "Z (ORAL HISTORIES) TEST"
    Then I should see the link "Manage"
    When I click "Manage"
    Given I wait for AJAX to finish
    Then I should see "PARENT COLLECTIONS"
    Then I click "Datastreams"
    Given I click "replace" in the "TN" row
    When I attach the file "/var/www/html/isle-ingest-samples/behat/features/assets/ORAL_HISTORIES/OH_01/Thumbnail.jpg" to "edit-file-upload"
    And I press "Upload"
    When wait 3 seconds
    And I press "Add Contents"
    Then I should see "Z (ORAL HISTORIES) TEST"


    ## Able to delete TN derivative for ORAL HISTORIES object? *** 
    #@api @apache @javascript @oralhistories
    #Scenario: Delete TN derivative for ORAL HISTORIES Object
    #Given I am logged in as a user with the "administrator" role
    Given that I navigate to the page for the object named "Z (ORAL HISTORIES) TEST"
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
    #Given I am logged in as a user with the "administrator" role
    Given that I navigate to the page for the object named "Z (ORAL HISTORIES) TEST"
    Then I should see the link "Manage"
    When I click "Manage"
    Then I click "Datastreams"
    Given I click "Add a datastream"
    Then I fill in "edit-dsid" with "TN"
    Then I fill in "edit-label" with "Thumbnail"
    When I attach the file "/var/www/html/isle-ingest-samples/behat/features/assets/ORAL_HISTORIES/OH_01/Thumbnail.jpg" to "edit-file-upload"
    And I press "Upload"
    When wait 3 seconds
    And I press "Add Datastream"
    Then I should see "Z (ORAL HISTORIES) TEST"
    Then I should see the link "Manage"
    When I click "Manage"
    Then I click "Datastreams"
    Given I click "regenerate" in the "TN" row
    Then I should see "Are you sure you want to regenerate the derivative for the TN datastream?"
    Then I press "Regenerate"
  
    ## Able to regenerate all derivatives for ORAL HISTORIES object? 
    #@api @apache @javascript @oralhistories
    #Scenario: Regenerate all derivatives for ORAL HISTORIES Object
    #Given I am logged in as a user with the "administrator" role
    Given that I navigate to the page for the object named "Z (ORAL HISTORIES) TEST"
    Then I should see the link "Manage"
    When I click "Manage"
    Then I click "Properties"
    Then I should see "Item Label"
    Then I press "Regenerate all derivatives"
    Then I should see "This will create a new version for every datastream on the object. Please wait while this happens."
    Given I press "Regenerate"
    Given wait 20 seconds
    Then wait for Ingest to complete
    #Then grab me a screenshot
    Then I should see the link "Derivatives successfully created."
    Given I click "Derivatives successfully created." 
    Then I should see "Created"


    ## Able to download a ORAL HISTORIES object? 
    #@api @apache @oralhistories @javascript
    #Scenario: Check for ORAL HISTORIES OBJ download
    #Given I am logged in as a user with the "administrator" role
    Given that I navigate to the page for the object named "Z (ORAL HISTORIES) TEST"
    Then I should see the link "Manage"
    When I click "Manage"
    Then I click "Datastreams"
    Given I click "download" in the "OBJ" row
    Then wait 30 seconds


    ## Able to search for newly ingested ORAL HISTORIES object using Islandora simple search?
    #@api @apache @oralhistories
    #Scenario: Check for ORAL HISTORIES Objects using simple search
    #Given I am logged in as a user with the "administrator" role
    Given I am on "/islandora/search/ORAL%20HISTORIES?type=dismax"
    Then I should see "Z (ORAL HISTORIES) TEST"



    ## Able to edit MODS datastream for ORAL HISTORIES object? ("replace") ****
    #@api @apache @oralhistories
    #Scenario: Replace MODS datastream for ORAL HISTORIES Object
    #Given I am logged in as a user with the "administrator" role
    # Navigate to Object
    Given that I navigate to the page for the object named "Z (ORAL HISTORIES) TEST"
    Then I should see "Z (ORAL HISTORIES) TEST"
    # Navigate to and replace MODS datastream
    Then I click "Manage"
    Then I click "Datastreams"
    Then I should see "MODS Record"
    Given I click "replace" in the "MODS" row
    Then I should see "Replace Datastream"
    Then I should see "Label: MODS Record"
    When I attach the file "assets/ORAL_HISTORIES/OH_01/MODS_REPLACED.xml" to "edit-file-upload"
    Given I press "Upload"
    Then I press "Add Contents"
    #Extra step required to forced reindexing
    Given that I navigate to the page for the object named "Z (ORAL HISTORIES) TEST"
    Then I should see "Z (ORAL HISTORIES) TEST"
    Then I click "Manage"
    Then I click "Datastreams"
    Then I should see "MODS Record"
    Given I click "edit" in the "MODS" row
    Then I press "Update"
    Given the cache has been cleared
    Given that I navigate to the page for the object named "Z (ORAL HISTORIES) TEST REPLACED"
    Then I should see "Z (ORAL HISTORIES) TEST REPLACED"
    # Able to search for newly edited MODS datastream for AUDIO object using Islandora simple search?
    Given I am on "/islandora/search/Z%20%28ORAL%20HISTORIES%29%20TEST%20REPLACED?type=dismax"
    Then I should see "Z (ORAL HISTORIES) TEST REPLACED"
  
    # Restore Original MODS Datastream
    #Given I am logged in as a user with the "administrator" role
    Given that I navigate to the page for the object named "Z (ORAL HISTORIES) TEST REPLACED"
    Then I should see "Z (ORAL HISTORIES) TEST"
    Then I click "Manage"
    Then I click "Datastreams"
    Then I should see "MODS Record"
    Given I click "replace" in the "MODS" row
    Then I should see "Replace Datastream"
    Then I should see "Label: MODS Record"
    When I attach the file "assets/ORAL_HISTORIES/OH_01/MODS.xml" to "edit-file-upload"
    Given I press "Upload"
    Then I press "Add Contents"
    Given that I navigate to the page for the object named "Z (ORAL HISTORIES) TEST"
    Then I should see "Z (ORAL HISTORIES) TEST"
    Then I click "Manage"
    Then I click "Datastreams"
    Then I should see "MODS Record"
    Given I click "edit" in the "MODS" row
    Then I press "Update"
    Given the cache has been cleared
    Given that I navigate to the page for the object named "Z (ORAL HISTORIES) TEST"
    Then I should not see "Z (ORAL HISTORIES) TEST REPLACED"
    And I should see "Z (ORAL HISTORIES) TEST"


    ## Able to edit Object Title for ORAL HISTORIES Object 
    #@api @apache @oralhistories
    #Scenario: Edit ORAL HISTORIES object title 
    #Given I am logged in as a user with the "administrator" role
    # Navigate to Object
    Given that I navigate to the page for the object named "Z (ORAL HISTORIES) TEST"
    Then I should see "Z (ORAL HISTORIES) TEST"  
    # Navigate to and change Object title
    Then I click "Manage"
    Then I click "Datastreams"
    Then I should see "MODS Record"
    Given I click "edit" in the "MODS" row
    Then I fill in "edit-titleinfo-title" with "Z (ORAL HISTORIES) TEST EDITED"
    When I press "Update"
    Then I should see "Z (ORAL HISTORIES) TEST EDITED"
    # Test that object title did change and that search picks it up
    Given I am on "/islandora/search/Z%20%28ORAL%20HISTORIES%29%20TEST%20EDITED?type=dismax"
    Then I should see "samples:"
    # Change Object title back to original
    Given that I navigate to the page for the object named "Z (ORAL HISTORIES) TEST"
    Then I should see "Z (ORAL HISTORIES) TEST EDITED"
    Then I click "Manage"
    Then I click "Datastreams"
    Then I should see "MODS Record"
    Given I click "edit" in the "MODS" row
    Then I fill in "edit-titleinfo-title" with "Z (ORAL HISTORIES) TEST"
    When I press "Update"
    Then I should see "Z (ORAL HISTORIES) TEST"
    # Check that object title is original and that search is picking it up
    Given I am on "/islandora/search/Z%20%28ORAL%20HISTORIES%29%20TEST?type=dismax"
    Then I should see "samples:"
    #similar test for "replace"


    ## Able to edit the Item Label of an ORAL HISTORIES object's Properties?
    #@api @apache @oralhistories
    #Scenario: Edit ORAL HISTORIES object Item Label
    #Given I am logged in as a user with the "administrator" role
    # Navigate to Object
    Given that I navigate to the page for the object named "Z (ORAL HISTORIES) TEST"
    Then I should see "Z (ORAL HISTORIES) TEST"
    # Navigate to and change item label form  
    Then I click "Manage"
    Then I click "Properties"
    Then I should see "A human-readable label"
    Then I fill in "edit-object-label" with "Z (ORAL HISTORIES) TEST LABEL-EDITED"
    When I press "Update Properties"
    Then I should see "Z (ORAL HISTORIES) TEST LABEL-EDITED"
    # Able to search for newly edited Item Label of an AUDIO object's Properties using Islandora simple search?
    Given I am on "/islandora/search/Z%20%28ORAL%20HISTORIES%29%20TEST%20LABEL-EDITED?type=dismax"
    Then I should see "Z (ORAL HISTORIES) TEST"
    Given that I navigate to the page for the object named "Z (ORAL HISTORIES) TEST"
    Then I should see "Z (ORAL HISTORIES) TEST LABEL-EDITED"
    # Change item label back to original
    Then I click "Manage"
    Then I click "Properties"
    Then I should see "A human-readable label"
    Then I fill in "edit-object-label" with "Z (ORAL HISTORIES) TEST"
    When I press "Update Properties"
    Then I should see "Z (ORAL HISTORIES) TEST"
    # Check that item label is now original
    Given I am on "/islandora/search/Z%20%28ORAL%20HISTORIES%29%20TEST?type=dismax"
    Then I should see "Z (ORAL HISTORIES) TEST"

    ##Delete newly ingested object
    #@api @apache @javascript @oralhistories
    #Scenario: Delete newly ingested ORAL HISTORIES object
    #Given I am logged in as a user with the "administrator" role
    Given that I navigate to the page for the object named "Z (ORAL HISTORIES) TEST"
    # Delete new object
    Then I should see "In collections"
    When I click "Manage"
    Then I click "Properties"
    Then I should see "Item Label"
    Then I press "Permanently remove 'Z (ORAL HISTORIES) TEST' from repository"
    Then I should see "This action cannot be undone."
    Then I press "Delete"
    And I wait for AJAX to finish
    And wait 20 seconds
    # Check that new object is deleted
    Given I am on "/islandora/search/%22Z%20%28%29%20TEST%22?type=dismax"
    Then I should see "(0 - 0 of 0)"