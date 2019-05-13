Feature: Test Book CModel
  In order to prove that the Book CModel works in ISLE
  As a developer
  I need to test some sample data

# Able to ingest the test pdf sample objects?
    #(DO NOT USE JAVASCRIPT)
  @api @apache @book
  Scenario: Ingest Book Sample Object
    Given I am logged in as a user with the "administrator" role
    # Navigate to parent collection
    And I am on "/islandora/object/samples%3Acollection"
    Then I should see "ICG Samples"
    # Navigate through new object form and ingest new object
    Then I click "Manage"
    Then I click "Add an object to this Collection"
    When select "Islandora Internet Archive Book Content Model" from "models"
    Then I press "Next"
    Then I press "Next"
    Then I fill in "edit-titleinfo-title" with "Z (PDF) TEST"
    Then I press "Next"
    When I attach the file "/var/www/html/isle-ingest-samples/behat/features/assets/Book/Z_Book_TEST/Z_Book_TEST.pdf" to "edit-file-upload"
    Then I press "Upload"
    Then I press "Ingest"
    Then grab me a screenshot
    Then I should see "Z (PDF) TEST"
    # Make sure the object ingested
    When I am on "/islandora/object/samples%3Acollection"
    Then I click "last"
    Then I should see the link "Z (PDF) TEST"
    


  # Able to upload (replace) thumbnail for PDF object?
  @api @apache @javascript @book
  Scenario: Replace PDF Thumbnail
    Given I am logged in as a user with the "administrator" role
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
    Given I am logged in as a user with the "administrator" role
    Given that I navigate to the page for the object named "Z (PDF) TEST"
    Then I should see the link "Manage"
    When I click "Manage"
    Given I wait for AJAX to finish
    Then I should see "PARENT COLLECTIONS"
    Then I click "Datastreams"
   Given I click "regenerate" in the "TN" row
    Then I should see "Are you sure you want to regenerate the derivative for the TN datastream?"
    Then I press "Regenerate"


  # Able to delete TN derivative for PDF object? *** 
  @api @apache @javascript @book
  Scenario: Delete TN derivative for PDF Object
    Given I am logged in as a user with the "administrator" role
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
    Given I am logged in as a user with the "administrator" role
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
  
  # Able to regenerate all derivatives for PDF object? ***  See lower tests
  @api @apache @javascript @book
  Scenario: Regenerate all derivatives for PDF Object
    Given I am logged in as a user with the "administrator" role
    Given that I navigate to the page for the object named "Z (PDF) TEST"
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


    ## figure out how to check for original thumbnail image


  # Able to download an PDF object? *** TODO Ask Noah how to do this link***
  @api @apache @book
  Scenario: Check for PDF OBJ download
    Given I am logged in as a user with the "administrator" role
    Given I am on "/islandora/object/samples%3A1/datastream/OBJ"
    Then I should get a 200 HTTP response



  # Able to search for newly ingested PDF object using Islandora simple search?
  @api @apache @book
  Scenario: Check for PDF Objects using simple search
    Given I am logged in as a user with the "administrator" role
    Given I am on "/islandora/search/PDF?type=dismax"
    Then I should see "islandora:pdf_collection"
    Then I should see "Z (PDF) TEST"



  # Able to edit MODS datastream for PDF object? ("replace") ****
  @api @apache @javascript @book
  Scenario: Replace MODS datastream for PDF Object
    Given I am logged in as a user with the "administrator" role
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


  # Able to edit Object Title for PDF Object 
  @api @apache @book
  Scenario: Edit PDF object title 
    Given I am logged in as a user with the "administrator" role
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
  #  similar test for "replace" - but we'll need to add a new MODS xml file to "assets" so we can upload it like a TN


  # Able to edit the Item Label of an PDF object's Properties?
  @api @apache @book
  Scenario: Edit PDF object Item Label
    Given I am logged in as a user with the "administrator" role
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

  #Delete newly ingested object
  @api @apache @javascript @book
  Scenario: Delete newly ingested PDF object
    Given I am logged in as a user with the "administrator" role
    When I am on "/islandora/object/samples%3Acollection"
    Then I click "last"
    Then I should see the link "Z (PDF) TEST"
    # Delete new object
    When I click "Z (PDF) TEST"
    Then I should see "In collections"
    When I click "Manage"
    Then I click "Properties"
    Then I should see "Item Label"
    Then I press "Permanently remove 'Z (PDF) TEST' from repository"
    Then I should see "This action cannot be undone."
    Then I press "Delete"
    # Check that new object is deleted
    When I am on "/islandora/object/samples%3Acollection"
    Then I click "last"
    Then I should not see the link "Z (PDF) TEST"