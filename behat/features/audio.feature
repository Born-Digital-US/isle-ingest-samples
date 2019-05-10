Feature: Test Audio CModel
  In order to prove that the Audio CModel works in ISLE
  As a developer
  I need to test some sample data

# Able to ingest the test AUDIO sample objects?
    #(DO NOT USE JAVASCRIPT)
  @api @apache @audio
  Scenario: Injest Audio Sample Objects
    Given I am logged in as a user with the "administrator" role
    # Navigate to parent collection
    And I am on "/islandora/object/samples%3Acollection"
    Then I should see "ICG Samples"
    # Navigate through new object form and ingest new object
    Then I click "Manage"
    Then I click "Add an object to this Collection"
    When select "Islandora Audio Content Model" from "models"
    Then I press "Next"
    Then I press "Next"
    Then I fill in "edit-titleinfo-title" with "Z Red-winged Blackbird (Audio) TEST OBJECT"
    Then I press "Next"
    When I attach the file "/var/www/html/isle-ingest-samples/behat/features/assets/Audio/ZRed-winged BlackbirdTest.mp3" to "edit-audio-file-upload"
    Then I press "Upload"
    Given I check the box "Upload Thumbnail"
    When I attach the file "/var/www/html/isle-ingest-samples/behat/features/assets/Audio/ZRed-winged BlackbirdTest.png" to "edit-thumbnail-file-upload"
    Then I press "Upload"
    Then I press "Ingest"
    # Make sure the object ingested
    When I am on "/islandora/object/samples%3Acollection"
    Then I click "last"
    Then I should see the link "Z Red-winged Blackbird (Audio) TEST OBJECT"
    # Delete new object
    When I click "Z Red-winged Blackbird (Audio) TEST OBJECT"
    Then I should see "In collections"
    When I click "Manage"
    Then I click "Properties"
    Then I should see "Item Label"
    Then I press "Permanently remove 'Z Red-winged Blackbird (Audio...' from repository"
    Then I should see "This action cannot be undone."
    Then I press "Delete"
    # Check that new object is deleted
    When I am on "/islandora/object/samples%3Acollection"
    Then I click "last"
    Then I should not see the link "Z Red-winged Blackbird (Audio) TEST OBJECT"


    # Able to upload (replace) thumbnail for Audio object?
    Given I am logged in as a user with the "administrator" role
    Given I am on "/islandora/object/samples%3A3"
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
    Then I should see "Red-winged Blackbird (Audio)"
    
    # another way to test: https://isle.localdomain/islandora/object/samples%3A1/datastream/TN
    # ultimately we want to regen thumbs in this test to go back to the original
    # Re-upload original thumbnail
    Given I am logged in as a user with the "administrator" role
    Given I am on "/islandora/object/samples%3A3"
    Then I should see the link "Manage"
    When I click "Manage"
    Given I wait for AJAX to finish
    Then I should see "PARENT COLLECTIONS"
    Then I click "Datastreams"
    Given I click "replace" in the "TN" row
    Then I should see "Label: TN Datastream"
    When I attach the file "/var/www/html/isle-ingest-samples/Batches-by-CModel/audioCModel/files/1/Worm-eating Warbler.png" to "edit-file-upload"
    And I press "Upload"
    When wait 3 seconds
    And I press "Add Contents"
    Then I should see "Red-winged Blackbird (Audio)"


    # Able to delete TN derivative for AUDIO object? *** 
    Given I am logged in as a user with the "administrator" role
    Given I am on "/islandora/object/samples%3A1"
    Then I should see the link "Manage"
    When I click "Manage"
    Given I wait for AJAX to finish
    When wait 3 seconds
    Then I should see "PARENT COLLECTIONS"
    Then I click "Datastreams"
    Given I click "delete" in the "TN" row
    Then I check the box "Delete Derivatives" 
    Then I press "Delete"
    # TODO add the "delete TN" actions, do a search and assert no TN visible
    #Replace original TN
    #(Can't replace at this point because after the first step there is no TN Datastream)
    ##Given I am logged in as a user with the "administrator" role
    ##Given I am on "/islandora/object/samples%3A3"
    ##Then I should see the link "Manage"
    ##When I click "Manage"
    ##Given I wait for AJAX to finish
    ##Then I should see "PARENT COLLECTIONS"
    ##Then I click "Datastreams"
    ##Given I click "replace" in the "TN" row
    ##Then I should see "Label: TN Datastream"
    ##When I attach the file "/var/www/html/isle-ingest-samples/Batches-by-CModel/audioCModel/files/1/Worm-eating Warbler.png" to "edit-file-upload"
    ##And I press "Upload"
    ##When wait 3 seconds
    ##And I press "Add Contents"
    ##Then I should see "Worm-eating Warbler (Audio)"

    #Add Original Thumbnail and Thumbnail datastream back
    Given I am logged in as a user with the "administrator" role
    Given I am on "/islandora/object/samples%3A1"
    Then I should see the link "Manage"
    When I click "Manage"
    Then I click "Datastreams"
    Given I click "Add a datastream"
    Then I fill in "edit-dsid" with "TN"
    Then I fill in "edit-label" with "Thumbnail"
    When I attach the file "/var/www/html/isle-ingest-samples/Batches-by-CModel/audioCModel/files/1/Worm-eating Warbler.png" to "edit-file-upload"
    And I press "Upload"
    When wait 3 seconds
    And I press "Add Datastream"
    Then I should see "Worm-eating Warbler (Audio)"
    Then I should see the link "Manage"
    When I click "Manage"
    Then I click "Datastreams"
    Given I click "regenerate" in the "TN" row
    Then I should see "Are you sure you want to regenerate the derivative for the TN datastream?"
    Then I press "Regenerate"
  
  # Able to regenerate all derivatives for AUDIO object? ***  See lower tests
    Given I am logged in as a user with the "administrator" role
    Given I am on "/islandora/object/samples%3A3"
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

    # Able to view / hear an AUDIO object?
    ## TESTS: Noah is skeptical that we can test for audio output

    # Able to download an AUDIO object?
    Given I am logged in as a user with the "administrator" role
    Given I am on "/islandora/object/samples%3A1/datastream/OBJ"
    Then I should get a 200 HTTP response



    # Able to search for newly ingested AUDIO object using Islandora simple search?
    Given I am logged in as a user with the "administrator" role
    Given I am on "/islandora/search/Audio?type=dismax"
    Then I should see "islandora:audio_collection"
    Then I should see "samples:3"
    Then I should see "samples:2"
    Then I should see "samples:1"



    # Able to edit MODS datastream for AUDIO object? ("replace") ****
    Given I am logged in as a user with the "administrator" role
    # Navigate to Object
    Given I am on "/islandora/object/samples%3A1"
    Then I should see "Worm-eating Warbler"
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
    Given I am on "/islandora/object/samples%3A1"
    Then I should see "Worm-eating Warbler"
    Then I click "Manage"
    Then I click "Datastreams"
    Then I should see "MODS Record"
    Given I click "edit" in the "MODS" row
    Then I press "Update"
    Given the cache has been cleared
    Given I am on "/islandora/object/samples%3A1"
    Then I should see "Worm-eating Warbler (REPLACED)"
    # Able to search for newly edited MODS datastream for AUDIO object using Islandora simple search?
    Given I am on "/islandora/search/Worm-eating%20Warbler%20%28Audio%29%20-%20REPLACED?type=dismax"
    Then I should see "Worm-eating Warbler (REPLACED)"
  
    # Restore Original MODS Datastream
    Given I am logged in as a user with the "administrator" role
    Given I am on "/islandora/object/samples%3A1"
    Then I should see "Worm-eating Warbler"
    Then I click "Manage"
    Then I click "Datastreams"
    Then I should see "MODS Record"
    Given I click "replace" in the "MODS" row
    Then I should see "Replace Datastream"
    Then I should see "Label: MODS Record"
    When I attach the file "/var/www/html/isle-ingest-samples/Batches-by-CModel/audioCModel/files/1/Worm-eating Warbler.xml" to "edit-file-upload"
    Given I press "Upload"
    Then I press "Add Contents"
    Given I am on "/islandora/object/samples%3A1"
    Then I should see "Worm-eating Warbler"
    Then I click "Manage"
    Then I click "Datastreams"
    Then I should see "MODS Record"
    Given I click "edit" in the "MODS" row
    Then I press "Update"
    Given the cache has been cleared
    Given I am on "/islandora/object/samples%3A1"
    Then I should see "Worm-eating Warbler (Audio)"


    # Able to edit Object Title for audio Object 
    Given I am logged in as a user with the "administrator" role
    # Navigate to Object
    Given I am on "islandora/object/samples%3A2"
    Then I should see "American Goldfinch (Audio)"  
    # Navigate to and change Object title
    Then I click "Manage"
    Then I click "Datastreams"
    Then I should see "MODS Record"
    Given I click "edit" in the "MODS" row
    Then I should see "Title of the work"
    Then I fill in "edit-titleinfo-title" with "American Goldfinch (Audio-edited)"
    When I press "Update"
    Then I should see "American Goldfinch (Audio-edited)"
    # Test that object title did change and that search picks it up
    Given I am on "/islandora/search/American%20Goldfinch%20%28Audio-edited%29?type=dismax"
    Then I should see "samples:2"
    # Change Object title back to original
    Given I am on "/islandora/object/samples%3A2"
    Then I should see "American Goldfinch (Audio-edited)"
    Then I click "Manage"
    Then I click "Datastreams"
    Then I should see "MODS Record"
    Given I click "edit" in the "MODS" row
    Then I should see "Title of the work"
    Then I fill in "edit-titleinfo-title" with "American Goldfinch (Audio)"
    When I press "Update"
    Then I should see "American Goldfinch (Audio)"
    # Check that object title is original and that search is picking it up
    Given I am on "/islandora/search/American%20Goldfinch%20%28Audio%29?type=dismax"
    Then I should see "samples:2"
  #  similar test for "replace" - but we'll need to add a new MODS xml file to "assets" so we can upload it like a TN


    # Able to edit the Item Label of an AUDIO object's Properties?
    Given I am logged in as a user with the "administrator" role
    # Navigate to Object
    Given I am on "islandora/object/samples%3A2"
    Then I should see "American Goldfinch (Audio)"
    # Navigate to and change item label form  
    Then I click "Manage"
    Then I click "Properties"
    Then I should see "A human-readable label"
    Then I fill in "edit-object-label" with "American Goldfinch (Audio-LABEL-EDITED)"
    When I press "Update Properties"
    Then I should see "American Goldfinch (Audio-LABEL-EDITED)"
    # Able to search for newly edited Item Label of an AUDIO object's Properties using Islandora simple search?
    Given I am on "/islandora/search/American%20Goldfinch%20%28Audio-label-edited%29?type=dismax"
    Then I should see "samples:2"
    Given I am on "/islandora/object/samples%3A2"
    Then I should see "American Goldfinch (Audio-LABEL-EDITED)"
    # Change item label back to original
    Then I click "Manage"
    Then I click "Properties"
    Then I should see "A human-readable label"
    Then I fill in "edit-object-label" with "American Goldfinch (Audio)"
    When I press "Update Properties"
    Then I should see "American Goldfinch (Audio)"
    # Check that item label is now original
    Given I am on "/islandora/search/American%20Goldfinch%20%28Audio%29?type=dismax"
    Then I should see "samples:2"


    When I am on "/islandora/object/samples%3Acollection"
    Then I click "last"
    Then I should see the link "Z Red-winged Blackbird (Audio) TEST OBJECT"
    # Delete new object
    When I click "Z Red-winged Blackbird (Audio) TEST OBJECT"
    Then I should see "In collections"
    When I click "Manage"
    Then I click "Properties"
    Then I should see "Item Label"
    Then I press "Permanently remove 'Z Red-winged Blackbird (Audio...' from repository"
    Then I should see "This action cannot be undone."
    Then I press "Delete"
    # Check that new object is deleted
    When I am on "/islandora/object/samples%3Acollection"
    Then I click "last"
    Then I should not see the link "Z Red-winged Blackbird (Audio) TEST OBJECT"