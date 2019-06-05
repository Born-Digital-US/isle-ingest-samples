Feature: Test PDF CModel
  In order to prove that the PDF CModel works in ISLE
  As a developer
  I need to test some sample data

# Able to ingest the test pdf sample objects?
  @api @apache @pdf @javascript @sample-setup @sample-teardown
  Scenario: Ingest PDF Sample Object
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
    Then I click on the selector "#edit-table-rows-islandorasp-pdf-selected"
    Then I click on the selector "#edit-submit"
    Then I click "Overview"


    Then I click "Add an object to this Collection"
    Then I should see "Select a Content Model to Ingest"
    When select "Islandora PDF Content Model" from "models"
    And I wait for AJAX to finish
    Then I press "Next"
    And wait for the page to be loaded
    Then I should see "MARCXML File"
    # Then wait 3 seconds
    # Then I press "Next"
    Then I click on the selector "#edit-next"

    Then I should see "Title of the PDF."
    Then I fill in "edit-titleinfo-title" with "Z (PDF) TEST"
    Then I click on the selector "#edit-next"
    When I attach the file "/var/www/html/isle-ingest-samples/behat/features/assets/PDF/Z_PDF_TEST.pdf" to "edit-file-upload"
    Then I press "Upload"
    Then I wait for AJAX to finish
    Then I click on the selector "#edit-next"
    And wait for the page to be loaded
    And wait 10 seconds
    # MAX 30 minutes for this (3x)
    Then wait for Ingest to complete
    #Then grab me a screenshot
    Then wait for Ingest to complete
    #Then grab me a screenshot
    Then wait for Ingest to complete
    #Then grab me a screenshot
    ## Make sure the object ingested

    Given I am logged in as a user with the "administrator" role
    Given I am on "/islandora/search/%22Z%20%28PDF%29%20TEST%22?type=dismax"
    Then I should see "(1 - 1 of 1)"
    Then I should see "Z (PDF) TEST"
    


    ## Able to upload (replace) thumbnail for PDF object?
    #@api @apache @javascript @pdf
    #Scenario: Replace PDF Thumbnail
    #Given I am logged in as a user with the "administrator" role
    Given that I navigate to the page for the object named "Z (PDF) TEST"
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
    Then I should see "Z (PDF) TEST"
    
    # another way to test: https://isle.localdomain/islandora/object/samples%3A1/datastream/TN
    # ultimately we want to regen thumbs in this test to go back to the original
    # Regenerate original thumbnail
    #Given I am logged in as a user with the "administrator" role
    Given that I navigate to the page for the object named "Z (PDF) TEST"
    Then I should see the link "Manage"
    When I click "Manage"
    Given I wait for AJAX to finish
    Then I should see "PARENT COLLECTIONS"
    Then I click "Datastreams"
    Given I click "regenerate" in the "TN" row
    Then I should see "Are you sure you want to regenerate the derivative for the TN datastream?"
    Then I press "Regenerate"


    ## Able to delete TN derivative for PDF object? *** 
    #@api @apache @javascript @pdf
    #Scenario: Delete TN derivative for PDF Object
    #Given I am logged in as a user with the "administrator" role
    Given that I navigate to the page for the object named "Z (PDF) TEST"
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
    Given that I navigate to the page for the object named "Z (PDF) TEST"
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
    Then I should see "Z (PDF) TEST"
    Then I should see the link "Manage"
    When I click "Manage"
    Then I click "Datastreams"
    Given I click "regenerate" in the "TN" row
    Then I should see "Are you sure you want to regenerate the derivative for the TN datastream?"
    Then I press "Regenerate"
  
    ## Able to regenerate all derivatives for PDF object? ***  See lower tests
    #@api @apache @javascript @pdf
    #Scenario: Regenerate all derivatives for PDF Object
    #Given I am logged in as a user with the "administrator" role
    Given that I navigate to the page for the object named "Z (PDF) TEST"
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
    Then wait for Ingest to complete
    #Then grab me a screenshot
    Then I should see the link "Derivatives successfully created."
    Given I click "Derivatives successfully created." 
    Then I should see "Created"


    ## figure out how to check for original thumbnail image


    ## Able to download an PDF object? 
    #@api @apache @pdf @javascript
    #Scenario: Check for PDF OBJ download
    #Given I am logged in as a user with the "administrator" role
    Given that I navigate to the page for the object named "Z (PDF) TEST"
    Then I should see the link "Manage"
    When I click "Manage"
    Then I click "Datastreams"
    Given I click "download" in the "OBJ" row
    Then wait 30 seconds



    ## Able to search for newly ingested PDF object using Islandora simple search?
    #@api @apache @pdf
    #Scenario: Check for PDF Objects using simple search
    #Given I am logged in as a user with the "administrator" role
    Given I am on "/islandora/search/PDF?type=dismax"
    Then I should see "islandora:sp_pdf_collection"
    Then I should see "Z (PDF) TEST"



    ## Able to edit MODS datastream for PDF object? ("replace") ****
    #@api @apache @javascript @pdf
    #Scenario: Replace MODS datastream for PDF Object
    #Given I am logged in as a user with the "administrator" role
    # Navigate to Object
    Given that I navigate to the page for the object named "Z (PDF) TEST"
    Then I should see "Z (PDF) TEST"
    # Navigate to and replace MODS datastream
    Then I click "Manage"
    Then I click "Datastreams"
    Then I should see "MODS Record"
    Given I click "replace" in the "MODS" row
    Then I should see "Replace Datastream"
    Then I should see "Label: MODS Record"
    When I attach the file "/var/www/html/isle-ingest-samples/behat/features/assets/PDF/Z_PDF_TEST_REPLACED.xml" to "edit-file-upload"
    Given I press "Upload"
    Then I press "Add Contents"
    #Extra step required to forced reindexing
    Given that I navigate to the page for the object named "Z (PDF) TEST"
    Then I should see "Z (PDF) TEST"
    Then I click "Manage"
    Then I click "Datastreams"
    Then I should see "MODS Record"
    Given I click "edit" in the "MODS" row
    Then I press "Update"
    Given the cache has been cleared
    Given that I navigate to the page for the object named "Z (PDF) TEST"
    Then I should see "Z (PDF) TEST REPLACED"
    # Able to search for newly edited MODS datastream for PDF object using Islandora simple search?
    Given I am on "/islandora/search/Z%20%28PDF%29%20TEST%20REPLACED?type=dismax"
    Then I should see "Z (PDF) TEST REPLACED"
  
    # Restore Original MODS Datastream
    Given I am logged in as a user with the "administrator" role
    Given that I navigate to the page for the object named "Z (PDF) TEST REPLACED"
    Then I should see "Z (PDF) TEST"
    Then I click "Manage"
    Then I click "Datastreams"
    Then I should see "MODS Record"
    Given I click "replace" in the "MODS" row
    Then I should see "Replace Datastream"
    Then I should see "Label: MODS Record"
    When I attach the file "/var/www/html/isle-ingest-samples/behat/features/assets/PDF/Z_PDF_TEST.xml" to "edit-file-upload"
    Given I press "Upload"
    Then I press "Add Contents"
    Given that I navigate to the page for the object named "Z (PDF) TEST"
    Then I should see "Z (PDF) TEST"
    Then I click "Manage"
    Then I click "Datastreams"
    Then I should see "MODS Record"
    Given I click "edit" in the "MODS" row
    Then I press "Update"
    Given the cache has been cleared
    Given that I navigate to the page for the object named "Z (PDF) TEST"
    Then I should not see "Z (PDF) TEST REPLACED"
    And I should see "Z (PDF) TEST"


    ## Able to edit Object Title for PDF Object 
    #@api @apache @pdf
    #Scenario: Edit PDF object title 
    #Given I am logged in as a user with the "administrator" role
    # Navigate to Object
    Given that I navigate to the page for the object named "Z (PDF) TEST"
    Then I should see "Z (PDF) TEST"  
    # Navigate to and change Object title
    Then I click "Manage"
    Then I click "Datastreams"
    Then I should see "MODS Record"
    Given I click "edit" in the "MODS" row
    Then I should see "Title of the PDF"
    Then I fill in "edit-titleinfo-title" with "Z (PDF) TEST EDITED"
    When I press "Update"
    Then I should see "Z (PDF) TEST EDITED"
    # Test that object title did change and that search picks it up
    Given I am on "/islandora/search/Z%20%28PDF%29%20TEST%20EDITED?type=dismax"
    Then I should see "samples:"
    # Change Object title back to original
    Given that I navigate to the page for the object named "Z (PDF) TEST"
    Then I should see "Z (PDF) TEST EDITED"
    Then I click "Manage"
    Then I click "Datastreams"
    Then I should see "MODS Record"
    Given I click "edit" in the "MODS" row
    Then I should see "Title of the PDF"
    Then I fill in "edit-titleinfo-title" with "Z (PDF) TEST"
    When I press "Update"
    Then I should see "Z (PDF) TEST"
    # Check that object title is original and that search is picking it up
    Given I am on "/islandora/search/Z%20%28PDF%29%20TEST?type=dismax"
    Then I should see "samples:"
    #similar test for "replace" - but we'll need to add a new MODS xml file to "assets" so we can upload it like a TN


    ## Able to edit the Item Label of an PDF object's Properties?
    #@api @apache @pdf
    #Scenario: Edit PDF object Item Label
    #Given I am logged in as a user with the "administrator" role
    # Navigate to Object
    Given that I navigate to the page for the object named "Z (PDF) TEST"
    Then I should see "Z (PDF) TEST"
    # Navigate to and change item label form  
    Then I click "Manage"
    Then I click "Properties"
    Then I should see "A human-readable label"
    Then I fill in "edit-object-label" with "Z (PDF) TEST LABEL-EDITED"
    When I press "Update Properties"
    Then I should see "Z (PDF) TEST LABEL-EDITED"
    # Able to search for newly edited Item Label of an PDF object's Properties using Islandora simple search?
    Given I am on "/islandora/search/Z%20%28PDF%29%20TEST%20LABEL-EDITED?type=dismax"
    Then I should see "Z (PDF) TEST"
    Given that I navigate to the page for the object named "Z (PDF) TEST"
    Then I should see "Z (PDF) TEST LABEL-EDITED"
    # Change item label back to original
    Then I click "Manage"
    Then I click "Properties"
    Then I should see "A human-readable label"
    Then I fill in "edit-object-label" with "Z (PDF) TEST"
    When I press "Update Properties"
    Then I should see "Z (PDF) TEST"
    # Check that item label is now original
    Given I am on "/islandora/search/Z%20%28PDF%29%20TEST?type=dismax"
    Then I should see "Z (PDF) TEST"

    ##Delete newly ingested object
    #@api @apache @javascript @pdf
    #Scenario: Delete newly ingested PDF object
    #Given I am logged in as a user with the "administrator" role
    Given that I navigate to the page for the object named "Z (PDF) TEST"
    # Delete new object
    Then I should see "In collections"
    When I click "Manage"
    Then I click "Properties"
    Then I should see "Item Label"
    Then I press "Permanently remove 'Z (PDF) TEST' from repository"
    Then I should see "This action cannot be undone."
    Then I press "Delete"
    And I wait for AJAX to finish
    And wait 20 seconds
    Then wait for Ingest to complete
    #Then grab me a screenshot
    # Check that new object is deleted
    Given I am on "/islandora/search/%22Z%20%28PDF%29%20TEST%22?type=dismax"
    Then I should see "(0 - 0 of 0)"