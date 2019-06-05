Feature: Test Compound Object CModel
  In order to prove that the Compound Object CModel works in ISLE
  As a developer
  I need to test some sample data

  # Able to ingest the test Compound Object sample objects?
  @api @apache @compound @javascript @sample-setup @sample-teardown
  Scenario: Ingest Compound Object Sample Object
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
    Then I click on the selector "#edit-table-rows-islandoracompoundcmodel-selected"
    Then I click on the selector "#edit-table-rows-islandorasp-basic-image-selected"
    Then I click on the selector "#edit-submit"
    Then I click "Overview"

    Then I click "Add an object to this Collection"
    Then I should see "Select a Content Model to Ingest"
    When select "Islandora Basic Image Content Model" from "models"
    And I wait for AJAX to finish
    Then I press "Next"
    And wait for the page to be loaded
    Then I should see "MARCXML File"
    Then I click on the selector "#edit-next"
    Then I should see "Title"
    Then I fill in "edit-titleinfo-title" with "Z (Compound Child) 1"
    Then I click on the selector "#edit-next"
    When I attach the file "/var/www/html/isle-ingest-samples/behat/features/assets/Compound/Z_COMPOUND_CHILD_1/Z_COMPOUND_CHILD_1.jpg" to "edit-file-upload"
    Then I press "Upload"
    Then I wait for AJAX to finish
    Then I click on the selector "#edit-next"
    And wait for the page to be loaded
    And wait 20 seconds
    Then wait for Ingest to complete
    ## Make sure the object ingested
    Given I am logged in as a user with the "administrator" role
    When I am on "/islandora/search/%22Z%20%28Compound%20Child%29%201%22?type=dismax"
    Then I should see "(1 - 1 of 1)"
    Then I should see "Z (Compound Child) 1"
    # Add second object
    And I am on "/islandora/object/behattest:collection"
    Then I should see "Behat Test Collection"
    # Navigate through new object form and ingest new object
    Then I click "Manage"
    Then I click "Add an object to this Collection"
    Then I should see "Select a Content Model to Ingest"
    When select "Islandora Basic Image Content Model" from "models"
    And I wait for AJAX to finish
    Then I press "Next"
    And wait for the page to be loaded
    Then I should see "MARCXML File"
    Then I click on the selector "#edit-next"
    Then I should see "Title"
    Then I fill in "edit-titleinfo-title" with "Z (Compound Child) 2"
    Then I click on the selector "#edit-next"
    When I attach the file "/var/www/html/isle-ingest-samples/behat/features/assets/Compound/Z_COMPOUND_CHILD_2/Z_COMPOUND_CHILD_2.jpg" to "edit-file-upload"
    Then I press "Upload"
    Then I wait for AJAX to finish
    Then I click on the selector "#edit-next"
    And wait for the page to be loaded
    And wait 20 seconds
    Then wait for Ingest to complete
    ## Make sure the object ingested
    Given I am logged in as a user with the "administrator" role
    When I am on "/islandora/search/%22Z%20%28Compound%20Child%29%202%22?type=dismax"
    Then I should see "(1 - 1 of 1)"
    Then I should see "Z (Compound Child) 2"
    And I am on "/islandora/object/behattest:collection"
    Then I should see "Behat Test Collection"
    # Navigate through compound object form and ingest compound object
    Then I click "Manage"
    Then I click "Add an object to this Collection"
    Then I should see "Select a Content Model to Ingest"
    When select "Islandora Compound Object Content Model" from "models"
    And I wait for AJAX to finish
    Then I press "Next"
    And wait for the page to be loaded
    Then I should see "MARCXML File"
    Then I click on the selector "#edit-next"

    Then I should see "Title"
    Then I fill in "edit-titleinfo-title" with "Z (Compound Object) TEST"
    Then I click on the selector "#edit-next"
    And wait for the page to be loaded
    And wait 25 seconds
    ## Make sure the object ingested
    Given I am logged in as a user with the "administrator" role
    When I am on "/islandora/search/%22Z%20%28Compound%20Object%29%20TEST%22?type=dismax"
    Then I should see "(1 - 1 of 1)"
    Then I should see "Z (Compound Object) TEST"
    Given that I navigate to the page for the object named "Z (Compound Object) TEST"
    And I click "Manage"
    And I click "Compound"
    Then I should see "Add child objects"
    Then I fill in "edit-child" with "Z (Compound Child) 1"
    And I press the "1" key in the "edit-child" field
    And I wait for AJAX to finish 
    Then I click on the selector "#autocomplete"
    Then I should see "behattest:"
    Then I click on the selector "#edit-submit"
    And wait 20 seconds
    Then I should see "Add child objects"
    Then I fill in "edit-child" with "Z (Compound Child) 2"
    And I press the "2" key in the "edit-child" field
    And I wait for AJAX to finish 
    Then I click on the selector "#autocomplete"
    Then I should see "behattest:"
    Then I click on the selector "#edit-submit"
    And wait 20 seconds
    Given I am logged in as a user with the "administrator" role
    Given that I navigate to the page for the object named "Z (Compound Object) TEST"
    Then I should see "Z (Compound Child) 1"
    


    ## Able to upload (replace) thumbnail for Compound Object object?
    #@api @apache @javascript @compound
    #Scenario: Replace Compound Object Thumbnail
    #Given I am logged in as a user with the "administrator" role
    Given that I navigate to the page for the object named "Z (Compound Object) TEST"
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
    Then I should see "Z (Compound Child) 1"
    Given that I navigate to the page for the object named "Z (Compound Object) TEST"
    Then I should see the link "Manage"
    When I click "Manage"
    Given I wait for AJAX to finish
    Then I should see "PARENT COLLECTIONS"
    Then I click "Datastreams"
    Given I click "replace" in the "TN" row
    Then I should see "Update Datastream"
    When I attach the file "/var/www/html/isle-ingest-samples/behat/features/assets/Compound/Z_COMPOUND_CHILD_1/Z_COMPOUND_CHILD_1.jpg" to "edit-file-upload"
    And I press "Upload"
    When wait 3 seconds
    And I press "Add Contents"
    Then I should see "Z (Compound Child) 1"

    ## Able to delete TN derivative for Compound Object object? *** 
    #@api @apache @javascript @compound
    #Scenario: Delete TN derivative for Compound Object Object
    #Given I am logged in as a user with the "administrator" role
    Given that I navigate to the page for the object named "Z (Compound Object) TEST"
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
    Given that I navigate to the page for the object named "Z (Compound Object) TEST"
    Then I should see the link "Manage"
    When I click "Manage"
    Then I click "Datastreams"
    Given I click "Add a datastream"
    Then I fill in "edit-dsid" with "TN"
    Then I fill in "edit-label" with "Thumbnail"
    When I attach the file "/var/www/html/isle-ingest-samples/behat/features/assets/Compound/Z_COMPOUND_CHILD_1/Z_COMPOUND_CHILD_1.jpg" to "edit-file-upload"
    And I press "Upload"
    When wait 5 seconds
    And I press "Add Datastream"
    Then I should see "Z (Compound Child) 1"

    ## Able to search for newly ingested Compound Object object using Islandora simple search?
    #@api @apache @compound
    #Scenario: Check for Compound Object Objects using simple search
    Given I am logged in as a user with the "administrator" role
    Given I am on "/islandora/search/Compound%20Object?type=dismax"
    Then I should see "Z (Compound Object) TEST"



    ## Able to edit MODS datastream for Compound Object object? ("replace") ****
    #@api @apache @javascript @compound
    #Scenario: Replace MODS datastream for Compound Object Object
    #Given I am logged in as a user with the "administrator" role
    # Navigate to Object
    Given that I navigate to the page for the object named "Z (Compound Object) TEST"
    Then I should see "Z (Compound Child) 1"
    # Navigate to and replace MODS datastream
    Then I click "Manage"
    Then I click "Datastreams"
    Then I should see "MODS Record"
    Given I click "replace" in the "MODS" row
    Then I should see "Replace Datastream"
    Then I should see "Label: MODS Record"
    When I attach the file "/var/www/html/isle-ingest-samples/behat/features/assets/Compound/Z_COMPOUND_OBJECT_TEST_REPLACED.xml" to "edit-file-upload"
    Given I press "Upload"
    Then I press "Add Contents"
    #Extra step required to forced reindexing
    Given that I navigate to the page for the object named "Z (Compound Object) TEST"
    Then I should see "Z (Compound Child) 1"
    Then I click "Manage"
    Then I click "Datastreams"
    Then I should see "MODS Record"
    Given I click "edit" in the "MODS" row
    Then I press "Update"
    Given the cache has been cleared
    # Able to search for newly edited MODS datastream for Compound Object object using Islandora simple search?
    Given I am on "/islandora/search/Z%20%28Compound%20Object%29%20TEST%20REPLACED?type=dismax"
    Then I should see "Z (Compound Object) TEST REPLACED"
  
    # Restore Original MODS Datastream
    Given I am logged in as a user with the "administrator" role
    Given that I navigate to the page for the object named "Z (Compound Object) TEST REPLACED"
    Then I should see "Z (Compound Child) 1"
    Then I click "Manage"
    Then I click "Datastreams"
    Then I should see "MODS Record"
    Given I click "replace" in the "MODS" row
    Then I should see "Replace Datastream"
    Then I should see "Label: MODS Record"
    When I attach the file "/var/www/html/isle-ingest-samples/behat/features/assets/Compound/Z_COMPOUND_OBJECT_TEST.xml" to "edit-file-upload"
    Given I press "Upload"
    Then I press "Add Contents"
    Given that I navigate to the page for the object named "Z (Compound Object) TEST"
    Then I should see "Z (Compound Child) 1"
    Then I click "Manage"
    Then I click "Datastreams"
    Then I should see "MODS Record"
    Given I click "edit" in the "MODS" row
    Then I press "Update"
    And wait 20 seconds
    Given the cache has been cleared
    When I am on "/islandora/search/%22Z%20%28Compound%20Object%29%20TEST%22?type=dismax"
    Then I should see "(1 - 1 of 1)"
    Then I should see "Z (Compound Object) TEST"


    ## Able to edit Object Title for Compound Object Object 
    #@api @apache @javascript @compound
    #Scenario: Edit Compound Object object title 
    #Given I am logged in as a user with the "administrator" role
    # Navigate to Object
    Given that I navigate to the page for the object named "Z (Compound Object) TEST"
    Then I should see "Z (Compound Child) 1"  
    # Navigate to and change Object title
    Then I click "Manage"
    Then I click "Datastreams"
    Then I should see "MODS Record"
    Given I click "edit" in the "MODS" row
    Then I should see "Title"
    Then I fill in "edit-titleinfo-title" with "Z (Compound Object) TEST EDITED"
    Then I click on the selector "#edit-update"
    Then I should see "Z (Compound Child) 1"
    When I am on "/islandora/search/%22Z%20%28Compound%20Object%29%20TEST%22?type=dismax"
    Then I should see "(1 - 1 of 1)"
    # Test that object title did change and that search picks it up
    Given I am on "/islandora/search/Z%20%28Compound%20Object%29%20TEST%20EDITED?type=dismax"
    Then I should see "samples:"
    # Change Object title back to original
    Given that I navigate to the page for the object named "Z (Compound Object) TEST"
    Then I should see "Z (Compound Child) 1"
    Then I click "Manage"
    Then I click "Datastreams"
    Then I should see "MODS Record"
    Given I click "edit" in the "MODS" row
    Then I should see "Title"
    Then I fill in "edit-titleinfo-title" with "Z (Compound Object) TEST"
    Then I click on the selector "#edit-update"
    Then I should see "Z (Compound Child) 1"
    # Check that object title is original and that search is picking it up
    Given I am on "/islandora/search/Z%20%28Compound%20Object%29%20TEST?type=dismax"
    Then I should see "samples:"
    #similar test for "replace"


    ## Able to edit the Item Label of an Compound Object object's Properties?
    #@api @apache @javascript @compound
    #Scenario: Edit Compound Object object Item Label
    #Given I am logged in as a user with the "administrator" role
    # Navigate to Object
    Given that I navigate to the page for the object named "Z (Compound Object) TEST"
    Then I should see "Z (Compound Child) 1"
    # Navigate to and change item label form  
    Then I click "Manage"
    Then I click "Properties"
    Then I should see "A human-readable label"
    Then I fill in "edit-object-label" with "Z (Compound Object) TEST LABEL-EDITED"
    When I press "Update Properties"
    And wait 20 seconds
    When I am on "/islandora/search/%22Z%20%28Compound%20Object%29%20TEST%22?type=dismax"
    Then I should see "(1 - 1 of 1)"
    Then I should see "Z (Compound Object) TEST LABEL-EDITED"
    # Able to search for newly edited Item Label of an Compound Object object's Properties using Islandora simple search?
    Given I am on "/islandora/search/Z%20%28Compound%20Object%29%20TEST%20LABEL-EDITED?type=dismax"
    Then I should see "Z (Compound Object) TEST"
    Given that I navigate to the page for the object named "Z (Compound Object) TEST"
    Then I should see "Z (Compound Child) 1"
    # Change item label back to original
    Then I click "Manage"
    Then I click "Properties"
    Then I should see "A human-readable label"
    Then I fill in "edit-object-label" with "Z (Compound Object) TEST"
    Then I press "Update Properties"
    # Check that item label is now original
    Given I am on "/islandora/search/Z%20%28Compound%20Object%29%20TEST?type=dismax"
    Then I should see "Z (Compound Object) TEST"

    ##Delete newly ingested object
    #@api @apache @javascript @compound 
    #Scenario: Delete newly ingested Compound Object object
    #Given I am logged in as a user with the "administrator" role
    Given that I navigate to the page for the object named "Z (Compound Object) TEST"
    # Delete new object
    Then I should see "In collections"
    When I click "Manage"
    Then I click "Properties"
    Then I should see "Item Label"
    Then I press "Permanently remove 'Z (Compound Object) TEST' from repository"
    Then I should see "This action cannot be undone."
    Then I press "Delete"
    And I wait for AJAX to finish
    And wait 20 seconds
    # Delete first child object
    Given that I navigate to the page for the object named "Z (Compound Child) 1"
    Then I should see "In collections"
    When I click "Manage"
    Then I click "Properties"
    Then I should see "Item Label"
    Then I press "Permanently remove 'Z (Compound Child) 1' from repository"
    Then I should see "This action cannot be undone."
    Then I press "Delete"
    And I wait for AJAX to finish
    And wait 20 seconds
    # Delete second child object
    Given that I navigate to the page for the object named "Z (Compound Child) 2"
    Then I should see "In collections"
    When I click "Manage"
    Then I click "Properties"
    Then I should see "Item Label"
    Then I press "Permanently remove 'Z (Compound Child) 2' from repository"
    Then I should see "This action cannot be undone."
    Then I press "Delete"
    And I wait for AJAX to finish
    And wait 20 seconds
    # Check that second child object is deleted
    When I am on "/islandora/search/%22Z%20%28Compound%20Object%29%20TEST%22?type=dismax"
    Then I should see "(0 - 0 of 0)"
    When I am on "/islandora/search/%22Z%20%28Compound%20Child%29%201%22?type=dismax"
    Then I should see "(0 - 0 of 0)"
    When I am on "/islandora/search/%22Z%20%28Compound%20Child%29%202%22?type=dismax"
    Then I should see "(0 - 0 of 0)"

