Feature: Test Book CModel
  In order to prove that the Book CModel works in ISLE
  As a developer
  I need to test some sample data

  # Able to ingest the test BOOK sample objects?
  @api @apache @javascript @book @sample-setup @sample-teardown
  Scenario: Ingest Book Sample Object
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
    Then I click on the selector "#edit-table-rows-islandorabookcmodel-selected"
    Then I click on the selector "#edit-submit"
    Then I click "Overview"


    Then I click "Add an object to this Collection"
    When select "Islandora Internet Archive Book Content Model" from "models"
    And I wait for AJAX to finish
    Then I press "Next"
    And wait for the page to be loaded

    Then I click on the selector "#edit-next"
    Then I fill in "edit-titleinfo-title" with "Z (BOOK) TEST"
    Then I click on the selector "#edit-next"
    When I attach the file "/var/www/html/isle-ingest-samples/behat/features/assets/Book/Z_Book_TEST/Z_Book_TEST.pdf" to "edit-pdf-file-upload"
    Then I press "Upload"
    Then I wait for AJAX to finish
    Then I click on the selector "#edit-next"

    And wait for the page to be loaded
    Then wait 20 seconds

    # MAX 30 minutes for this (3x)
    Then wait for Ingest to complete
    #Then grab me a screenshot
    Then wait for Ingest to complete
    #Then grab me a screenshot
    Then wait for Ingest to complete
    #Then grab me a screenshot

    Then I wait for AJAX to finish
    Then I should see "has been ingested"

    # Make sure the object ingested
    #Given I am logged in as a user with the "administrator" role
    Given I am on "/islandora/search/%22Z%20%28BOOK%29%20TEST%22?type=dismax"
    Then I should see "(1 - 16 of 16)"
    Then I should see "Z (BOOK) TEST"


  # Able to upload (replace) thumbnail for BOOK object?
    #@api @apache @javascript @book
    #Scenario: Replace BOOK Thumbnail
    #Given I am logged in as a user with the "administrator" role
    Given that I navigate to the page for the object named "Z (BOOK) TEST"
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
    Then I should see "Z (BOOK) TEST"

    # Regenerate original thumbnail
    #Given I am logged in as a user with the "administrator" role
    Given that I navigate to the page for the object named "Z (BOOK) TEST"
    Then I should see the link "Manage"
    When I click "Manage"
    Given I wait for AJAX to finish
    Then I should see "PARENT COLLECTIONS"
    Then I click "Datastreams"
    Given I click "regenerate" in the "TN" row
    Then I should see "Are you sure you want to regenerate the derivative for the TN datastream?"
    Then I press "Regenerate"


    ## Able to delete TN derivative for BOOK object? ***
    #@api @apache @javascript @book
    #Scenario: Delete TN derivative for BOOK Object
    #Given I am logged in as a user with the "administrator" role
    Given that I navigate to the page for the object named "Z (BOOK) TEST"
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
    Given that I navigate to the page for the object named "Z (BOOK) TEST"
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
    Then I should see "Z (BOOK) TEST"
    Then I should see the link "Manage"
    When I click "Manage"
    Then I click "Datastreams"
    Given I click "regenerate" in the "TN" row
    Then I should see "Are you sure you want to regenerate the derivative for the TN datastream?"
    Then I press "Regenerate"

    ## Able to regenerate all derivatives for BOOK object? ***  See lower tests
    #@api @apache @javascript @book
    #Scenario: Regenerate all derivatives for BOOK Object
    #Given I am logged in as a user with the "administrator" role
    Given that I navigate to the page for the object named "Z (BOOK) TEST"
    Then I should see the link "Manage"
    When I click "Manage"
    Then I click "Properties"
    Then I should see "Item Label"
    Then I press "Regenerate all derivatives"
    Then I should see "This will create a new version for every datastream on the object. Please wait while this happens."
    Given I press "Regenerate"

    Given wait 20 seconds
    # MAX 20 minutes for this (2x)
    Then wait for Ingest to complete
    #Then grab me a screenshot
    Then wait for Ingest to complete
    #Then grab me a screenshot
    Then I should see the link "Derivatives successfully created."




    # Able to download an BOOK object?
    #@api @apache @javascript @book
    #Scenario: Check for BOOK OBJ download
    #Given I am logged in as a user with the "administrator" role
    Given that I navigate to the page for the object named "Z (BOOK) TEST"
    Then I click "Manage"
    Then I click "Book"
    Then I click on the selector "#edit-submit"
    Then wait for Ingest to complete
    Then grab me a screenshot
    Then I click "Datastreams"
    Then I should see "PDF"
    Given I click "download" in the "PDF" row


    ## Able to search for newly ingested BOOK object using Islandora simple search?
    #@api @apache @javascript @book
    #Scenario: Check for BOOK Objects using simple search
    #Given I am logged in as a user with the "administrator" role
    Given I am on "/islandora/search/BOOK?type=dismax"
    Then I should see "Z (BOOK) TEST"



    ## Able to edit MODS datastream for BOOK object? ("replace") ****
    #@api @apache @javascript @book
    #Scenario: Replace MODS datastream for BOOK Object
    #Given I am logged in as a user with the "administrator" role
    # Navigate to Object
    Given that I navigate to the page for the object named "Z (BOOK) TEST"
    Then I should see "Z (BOOK) TEST"
    # Navigate to and replace MODS datastream
    Then I click "Manage"
    Then I click "Datastreams"
    Then I should see "MODS Record"
    Given I click "replace" in the "MODS" row
    Then I should see "Replace Datastream"
    Then I should see "Label: MODS Record"
    When I attach the file "/var/www/html/isle-ingest-samples/behat/features/assets/Book/Z_Book_TEST/MODS_Z_Book_TEST_REPLACE.xml" to "edit-file-upload"
    Given I press "Upload"
    Then I press "Add Contents"
    #Extra step required to forced reindexing
    Given that I navigate to the page for the object named "Z (BOOK) TEST"
    Then I should see "Z (BOOK) TEST"
    Then I click "Manage"
    Then I click "Datastreams"
    Then I should see "MODS Record"
    Given I click "edit" in the "MODS" row
    Then I press "Update"
    Given the cache has been cleared
    Given that I navigate to the page for the object named "Z (BOOK) TEST"
    Then I should see "Z (BOOK) TEST REPLACED"
    # Able to search for newly edited MODS datastream for BOOK object using Islandora simple search?
    Given I am on "/islandora/search/Z%20%28BOOK%29%20TEST%20REPLACED?type=dismax"
    Then I should see "Z (BOOK) TEST REPLACED"

    # Restore Original MODS Datastream
    #Given I am logged in as a user with the "administrator" role
    Given that I navigate to the page for the object named "Z (BOOK) TEST REPLACED"
    Then I should see "Z (BOOK) TEST"
    Then I click "Manage"
    Then I click "Datastreams"
    Then I should see "MODS Record"
    Given I click "replace" in the "MODS" row
    Then I should see "Replace Datastream"
    Then I should see "Label: MODS Record"
    When I attach the file "/var/www/html/isle-ingest-samples/behat/features/assets/Book/Z_Book_TEST/MODS_Z_Book_TEST.xml" to "edit-file-upload"
    Given I press "Upload"
    Then I press "Add Contents"
    Given that I navigate to the page for the object named "Z (BOOK) TEST"
    Then I should see "Z (BOOK) TEST"
    Then I click "Manage"
    Then I click "Datastreams"
    Then I should see "MODS Record"
    Given I click "edit" in the "MODS" row
    Then I press "Update"
    Given the cache has been cleared
    Given that I navigate to the page for the object named "Z (BOOK) TEST"
    Then I should not see "Z (BOOK) TEST REPLACED"
    And I should see "Z (BOOK) TEST"


    ## Able to edit Object Title for BOOK Object
    #@api @apache @javascript @book
    #Scenario: Edit BOOK object title
    #Given I am logged in as a user with the "administrator" role
    # Navigate to Object
    Given that I navigate to the page for the object named "Z (BOOK) TEST"
    Then I should see "Z (BOOK) TEST"
    # Navigate to and change Object title
    Then I click "Manage"
    Then I click "Datastreams"
    Then I should see "MODS Record"
    Given I click "edit" in the "MODS" row
    Then I should see "Title"
    Then I fill in "edit-titleinfo-title" with "Z (BOOK) TEST EDITED"
    When I press "Update"
    Then I should see "Z (BOOK) TEST EDITED"
    # Test that object title did change and that search picks it up
    Given I am on "/islandora/search/Z%20%28BOOK%29%20TEST%20EDITED?type=dismax"
    Then I should see "samples:"
    # Change Object title back to original
    Given that I navigate to the page for the object named "Z (BOOK) TEST"
    Then I should see "Z (BOOK) TEST EDITED"
    Then I click "Manage"
    Then I click "Datastreams"
    Then I should see "MODS Record"
    Given I click "edit" in the "MODS" row
    Then I should see "Title"
    Then I fill in "edit-titleinfo-title" with "Z (BOOK) TEST"
    Then I click on the selector "#edit-update"
    Then I should see "Z (BOOK) TEST"
    # Check that object title is original and that search is picking it up
    Given I am on "/islandora/search/Z%20%28BOOK%29%20TEST?type=dismax"
    Then I should see "samples:"
    # similar test for "replace" 


    ## Able to edit the Item Label of an BOOK object's Properties?
    #@api @apache @book
    #Scenario: Edit BOOK object Item Label
    #Given I am logged in as a user with the "administrator" role
    # Navigate to Object
    Given that I navigate to the page for the object named "Z (BOOK) TEST"
    Then I should see "Z (BOOK) TEST"
    # Navigate to and change item label form
    Then I click "Manage"
    Then I click "Properties"
    Then I should see "A human-readable label"
    Then I fill in "edit-object-label" with "Z (BOOK) TEST LABEL-EDITED"
    When I press "Update Properties"
    Then I should see "Z (BOOK) TEST LABEL-EDITED"
    # Able to search for newly edited Item Label of an BOOK object's Properties using Islandora simple search?
    Given I am on "/islandora/search/Z%20%28BOOK%29%20TEST%20LABEL-EDITED?type=dismax"
    Then I should see "Z (BOOK) TEST"
    Given that I navigate to the page for the object named "Z (BOOK) TEST"
    Then I should see "Z (BOOK) TEST LABEL-EDITED"
    # Change item label back to original
    Then I click "Manage"
    Then I click "Properties"
    Then I should see "A human-readable label"
    Then I fill in "edit-object-label" with "Z (BOOK) TEST"
    When I press "Update Properties"
    Then I should see "Z (BOOK) TEST"
    # Check that item label is now original
    Given I am on "/islandora/search/Z%20%28BOOK%29%20TEST?type=dismax"
    Then I should see "Z (BOOK) TEST"

    ##Delete newly ingested object
    #@api @apache @javascript @book
    #Scenario: Delete newly ingested BOOK object
    #Given I am logged in as a user with the "administrator" role
    Given that I navigate to the page for the object named "Z (BOOK) TEST"
    # Delete new object
    Then I should see the link "Pages"
    When I click "Manage"
    Then I click "Properties"
    Then I should see "Item Label"
    Then I press "Delete Book"
    Then I should see "This will remove the book object and all related page objects. This action cannot be undone."
    Then I press "Delete"
    And I wait for AJAX to finish
    And wait 20 seconds
    # Check that new object is deleted
    Then wait 20 seconds
    When I am on "/islandora/search/%22Z%20%28BOOK%29%20TEST%22?type=dismax"
    Then I should see "(0 - 0 of 0)"
    #Delete newly ingested object

    #@api @apache @javascript @book @sample-teardown
    #Scenario: Delete Behat Test Collection
    #Given I am logged in as a user with the "administrator" role
    #When I am on "/islandora/object/behattest:collection"
    #When I click "Manage"
    #Then I click "Properties"
    #Then I click on the selector "#edit-delete"
    #Then I click on the selector "#edit-submit"
    #And I wait for AJAX to finish
