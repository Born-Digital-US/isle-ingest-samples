Feature: Test BriefIngest (through line 56, no video no newspaper issues)
  In order to prove the Brief Ingest properly loaded
  As a developer
  I need to test some sample data

  @apache @newspaper
  Scenario: Viewing newspaper root
    Given I am an anonymous user
    And I am on "/islandora/object/samples%3Anewspaper"
    Then I should see a "body" element
    Then I should see "Connecticut Western News (Newspaper)"

  @api @apache @setup
  Scenario: Enable Simple Search
    Given I am logged in as a user with the "administrator" role
    And I am on "/admin/structure/block"
    Then I should see the link "Add block"
    Given I select "Sidebar first" from "edit-blocks-islandora-solr-simple-region"
    Then I press "Save blocks"
  
  # Able to ingest the test AUDIO sample objects?
    #(DO NOT USE JAVASCRIPT)
  @api @apache @audio
  Scenario: Injest Audio Sample Objects
    Given I am logged in as a user with the "administrator" role
    And I am on "/islandora/object/samples%3Acollection"
    Then I should see "ICG Samples"
    Then I click "Manage"
    Then I click "Add an object to this Collection"
    When select "Islandora Audio Content Model" from "models"
    Then I press "Next"
    #When wait 20 seconds
    Then I press "Next"
    Then I fill in "edit-titleinfo-title" with "Z Red-winged Blackbird (Audio) TEST OBJECT"
    Then I press "Next"
    When I attach the file "/var/www/html/isle-ingest-samples/behat/features/assets/Audio/ZRed-winged BlackbirdTest.mp3" to "edit-audio-file-upload"
    Then I press "Upload"
    #When wait 20 seconds
    Given I check the box "Upload Thumbnail"
    When I attach the file "/var/www/html/isle-ingest-samples/behat/features/assets/Audio/ZRed-winged BlackbirdTest.png" to "edit-thumbnail-file-upload"
    Then I press "Upload"
    Then I press "Ingest"
    When I am on "/islandora/object/samples%3Acollection"
    Then I click "last"
    Then I should see the link "Z Red-winged Blackbird (Audio) TEST OBJECT"
    When I click "Z Red-winged Blackbird (Audio) TEST OBJECT"
    Then I should see "In collections"
    When I click "Manage"
    Then I click "Properties"
    Then I should see "Item Label"
    Then I press "Permanently remove 'Z Red-winged Blackbird (Audio...' from repository"
    Then I should see "This action cannot be undone."
    Then I press "Delete"
    #When wait 15 seconds
    When I am on "/islandora/object/samples%3Acollection"
    Then I click "last"
    Then I should not see the link "Z Red-winged Blackbird (Audio) TEST OBJECT"
  ## TEST: check URLs for ingested objects

  @apache @audio
  Scenario: Viewing sample:1
    Given I am on "/islandora/object/samples%3A1"
    Then I should see a "body" element
    Then I should see "Worm-eating Warbler (Audio)"

  @apache @audio
  Scenario: Viewing sample:2
    Given I am on "/islandora/object/samples%3A2"
    Then I should see "American Goldfinch (Audio)"

  @apache @audio
  Scenario: Viewing sample:3
    Given I am on "/islandora/object/samples%3A3"
    Then I should see a "body" element
    Then I should see "Red-winged Blackbird (Audio)"



  ## TESTS TODO: 
  # Able to upload (replace) thumbnail for Audio object?
  @api @apache @javascript @audio
  Scenario: Replace Audio Thumbnail 
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
  @api @pache @javascript @audio
  Scenario: Undo replacement of Audio Thumbnail
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


  # Ab/islandora/object/samples%3A1#overlay-context=islandora/object/samples%253A1le to delete TN derivative for AUDIO object? *** 
  @api @apache @javascript @audio
  Scenario: Delete TN derivative for Audio Object 
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
    #(No need to have this be separate scenario)
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

    ## Click Manage, click Properties, Press "Regenerate all derivatives"
    @api @apache @javascript @audio
    Scenario: Regenerate all derivatives for Audio Object
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
    ## maybe: load search https://isle.localdomain/islandora/search/Worm-eating%20Warbler?type=dismax
    ##   ask for "a" tag with href="/islandora/object/samples%3A1" and look for the child img tag, and assert that it's src attribute is 

  # Able to view / hear an AUDIO object?
  ## TESTS: Noah is skeptical that we can test for audio output

  # Able to download an AUDIO object?
  ## TESTS: load https://isle.localdomain/islandora/object/samples%3A1/datastream/OBJ and check for status 200 response code
  @api @apache @audio
  Scenario: Check for Audio OBJ download
    Given I am logged in as a user with the "administrator" role
    Given I am on "/islandora/object/samples%3A1/datastream/OBJ"
    Then I should get a 200 HTTP response

  # Able to search for newly ingested AUDIO object using Islandora simple search?
  ## Tests: load https://isle.localdomain/islandora/search/Audio?type=dismax and look for the things we expect:
  ##   islandora:audio_collection, samples:2, samples:3, samples:1
  @api @apache @audio
  Scenario: Check for Audio Objects using simple search
    Given I am logged in as a user with the "administrator" role
    Given I am on "/islandora/search/Audio?type=dismax"
    Then I should see "islandora:audio_collection"
    Then I should see "samples:3"
    Then I should see "samples:2"
    Then I should see "samples:1"
   

  # Able to edit AUDIO object’s title using the XML form? ("edit")
  @api @apache @audio
  Scenario: Edit Audio object title
    Given I am logged in as a user with the "administrator" role
    Given I am on "/islandora/object/samples%3A1"
    Then I should see "Worm-eating Warbler (Audio)"  
    Then I click "Manage"
    Then I click "Datastreams"
    Then I should see "MODS Record"
    Given I click "edit" in the "MODS" row
    Then I should see "Title of the work"
    Then I fill in "edit-titleinfo-title" with "Worm-eating Warbler (Audio) - EDITED"
    When I press "Update"
    Then I should see "Worm-eating Warbler (Audio) - EDITED"
    # Able to search for newly edited AUDIO object’s title using Islandora simple search? (Noah, help with search? says not pressable or clickable)
    When I fill in "edit-islandora-simple-search-query" with "Worm-eating Warbler (Audio) - EDITED"
    When I press "search"
    Then I should see "samples:1"
    Given I am on "/islandora/search/Audio?type=dismax"
    Then I should see "islandora:audio_collection"
    Then I should see "samples:3"
    Then I should see "samples:2"
    Then I should see "samples:1"
    Given I am on "/islandora/search/Worm-eating%20Warbler%20%28Audio%29%20-%20EDITED?type=dismax"
    Then I should see "samples:1"
    # Undo Changes
  @api @apache @audio
  Scenario: Undo Changes to Audio object title
    Given I am logged in as a user with the "administrator" role
    Given I am on "/islandora/object/samples%3A1"
    Then I should see "Worm-eating Warbler"
    Then I click "Manage"
    Then I click "Datastreams"
    Then I should see "MODS Record"
    Given I click "edit" in the "MODS" row
    Then I should see "Title of the work"
    Then I fill in "edit-titleinfo-title" with "Worm-eating Warbler (Audio)"
    When I press "Update"
    Then I should see "Worm-eating Warbler (Audio)"
    When I fill in "edit-islandora-simple-search-query" with "Worm-eating Warbler (Audio)"
    When I press "search"
    Then I should see "samples:1"
  ## I undid my changes right in the test, because if the title was changed then the test would fail the next time


  # Able to edit MODS datastream for AUDIO object? ("replace") ****
  @api @apache @audio
  Scenario: Replace MODS datastream for Audio Object
    Given I am logged in as a user with the "administrator" role
    Given I am on "/islandora/object/samples%3A1"
    Then I should see "Worm-eating Warbler"
    Then I click "Manage"
    Then I click "Datastreams"
    Then I should see "MODS Record"
    Given I click "replace" in the "MODS" row
    Then I should see "Replace Datastream"
    Then I should see "Label: MODS Record"
    When I attach the file "assets/MODS-replace-warbler.xml" to "edit-file-upload"
    Given I press "Upload"
    Then I press "Add Contents"
    ## Pat/Derek should Replacing MODS update automatically after replace?
    # Able to search for newly edited MODS datastream for AUDIO object using Islandora simple search?
    #Given the cache has been cleared
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
  # Able to search for newly edited AUDIO object’s title using Islandora simple search?
    Given I am on "/islandora/search/Worm-eating%20Warbler%20%28Audio%29%20-%20REPLACED?type=dismax"
    Then I should see "Worm-eating Warbler (REPLACED)"
    # Put original MODS back
  @api @apache @audio
  Scenario: Restore Original MODS datastream for Audio Object
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


  ## TESTS: admin view https://isle.localdomain/islandora/object/samples%3A2, click Manage, click Datastreams,
  ##   "Edit" on the "MODS" line, change title to (Audio-edited), press Update, should see "American Goldfinch (Audio-edited)"
  #    NOW TEST FOR search results. load hhttps://isle.localdomain/islandora/search/%22audio-edited%22?type=dismax and ensure "samples:2" and "(Audio-edited)"
  ##   (to undo) Manage, Mods edit, remove "-edited", "Update", assert original title
  @api @apache @audio
  Scenario: Edit Audio (Goldfinch) object title 
    Given I am logged in as a user with the "administrator" role
    Given I am on "islandora/object/samples%3A2"
    Then I should see "American Goldfinch (Audio)"  
    Then I click "Manage"
    Then I click "Datastreams"
    Then I should see "MODS Record"
    Given I click "edit" in the "MODS" row
    Then I should see "Title of the work"
    Then I fill in "edit-titleinfo-title" with "American Goldfinch (Audio-edited)"
    When I press "Update"
    Then I should see "American Goldfinch (Audio-edited)"
    Given I am on "/islandora/search/American%20Goldfinch%20%28Audio-edited%29?type=dismax"
    Then I should see "samples:2"
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
    Given I am on "/islandora/search/American%20Goldfinch%20%28Audio%29?type=dismax"
    Then I should see "samples:2"
  #  similar test for "replace" - but we'll need to add a new MODS xml file to "assets" so we can upload it like a TN
  #  to satisfy search requirements, do a search after both changes (edit and replace) to ensure search index is picking up changes

  
  # Able to edit the Item Label of an AUDIO object's Properties?
  ## TESTS:  Click Manage, clikc Properties, change Item Label to (Audio-LABEL-EDITED)
  ### When I fill in "edit-object-label" with "American Goldfinch (Audio-LABEL-EDITED)"
  ## click update properties, check for "Successfully"
  @api @apache @audio
  Scenario: Edit Audio object Item Label
    Given I am logged in as a user with the "administrator" role
    Given I am on "islandora/object/samples%3A2"
    Then I should see "American Goldfinch (Audio)"  
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
    Then I click "Manage"
    Then I click "Properties"
    Then I should see "A human-readable label"
    Then I fill in "edit-object-label" with "American Goldfinch (Audio)"
    When I press "Update Properties"
    Then I should see "American Goldfinch (Audio)"
    Given I am on "/islandora/search/American%20Goldfinch%20%28Audio%29?type=dismax"
    Then I should see "samples:2"
 
  ## TESTS:  Click Manage, click Properties, change Item Label to (Audio-LABEL-EDITED)
  ### When I fill in "edit-object-label" with "Worm-eating Warbler (Audio-LABEL-EDITED)"
  ## click update properties, check for "Successfully"
  #   check search results, then undo and final assert original


  # Able to view a BASIC IMAGE object?
  @apache @basicimage
  Scenario: Viewing sample:4
    Given I am on "/islandora/object/samples%3A4"
    Then I should see a "body" element
    Then I should see "Apple Tree of note (Basic Image)"

  # Able to download a BASIC IMAGE object?
  @api @apache @basicimage
  Scenario: Check for Basic Image download
    Given I am logged in as a user with the "administrator" role
    Given I am on "/islandora/object/samples%3A4"
    Then I should get a 200 HTTP response

  # Able to search for newly ingested BASIC IMAGE object using Islandora simple search?
  @api @apache @basicimage
  Scenario: Check for Basic Images using simple search
    Given I am logged in as a user with the "administrator" role
    Given I am on "/islandora/search/Basic%20Image?type=dismax"
    Then I should see "islandora:sp_basic_image_collection"
    Then I should see "samples:4"
    Then I should see "samples:5"
    Then I should see "samples:6"

  # Able to edit BASIC IMAGE object’s title using the XML form?
  @api @apache @javascript @basicimage
  Scenario: Edit Basic Image title
    Given I am logged in as a user with the "administrator" role
    Given I am on "/islandora/object/samples%3A4"
    Then I should see "Apple Tree of note (Basic Image)"  
    Then I click "Manage"
    Then I click "Datastreams"
    Then I should see "MODS Record"
    Given I click "edit" in the "MODS" row
    Then I should see "Title"
    Then I fill in "edit-titleinfo-title" with "Apple Tree of note (Basic Image) - EDITED"
    When I press "Update"
    Then I should see "Apple Tree of note (Basic Image) - EDITED"
    # Able to search for newly edited Basic Image's title using Islandora simple search?
    Given I am logged in as a user with the "administrator" role
    Given I am on "/islandora/search/Basic%20Image?type=dismax"
    Then I should see "islandora:sp_basic_image_collection"
    Then I should see "samples:4"
    Then I should see "samples:5"
    Then I should see "samples:6"
     # Able to search for newly edited BASIC IMAGE object’s title using Islandora simple search?
    Given I am on "/islandora/search/Apple%20Tree%20of%20note%20%28Basic%20Image%29%20-%20EDITED?type=dismax"
    Then I should see "samples:4"
    # Undo Changes
  @api @apache @javascript @basicimage
  Scenario: Undo Changes to Basic Image Title
    Given I am logged in as a user with the "administrator" role
    Given I am on "/islandora/object/samples%3A4"
    Then I should see "Apple Tree of note"  
    Then I click "Manage"
    Then I click "Datastreams"
    Then I should see "MODS Record"
    Given I click "edit" in the "MODS" row
    Then I should see "Title"
    Then I fill in "edit-titleinfo-title" with "Apple Tree of note (Basic Image)"
    When press "Update"
    Then I should see "Apple Tree of note (Basic Image)"
    When I fill in "edit-islandora-simple-search-query" with "Apple Tree of note (Basic Image)"
    When I press "search"
    Then I should see "samples:4"



  # Able to edit the Item Label of a BASIC IMAGE object's Properties?
  @api @apache @basicimage
  Scenario: Edit Basic Image Item Label
    Given I am logged in as a user with the "administrator" role
    Given I am on "/islandora/object/samples%3A4"
    Then I should see "Apple Tree of note (Basic Image)"  
    Then I click "Manage"
    Then I click "Properties"
    Then I should see "A human-readable label"
    Then I fill in "edit-object-label" with "Apple Tree of note (Basic Image-LABEL-EDITED)"
    When I press "Update Properties"
    Then I should see "Apple Tree of note (Basic Image-LABEL-EDITED)"
    # Able to search for newly edited Item Label of an BASIC IMAGE object's Properties using Islandora simple search?
    Given I am on "/islandora/search/Apple%20Tree%20of%20note%20%28Basic%20Image-LABEL-EDITED%29?type=dismax"
    Then I should see "samples:4"
    # Undo changes to object label
  @api @apache @basicimage
  Scenario: Undo Changes to Basic Image Item Label
    Given I am logged in as a user with the "administrator" role
    Given I am on "/islandora/object/samples%3A4"
    Then I should see "Apple Tree of note (Basic Image-LABEL-EDITED)"
    Then I click "Manage"
    Then I click "Properties"
    Then I should see "A human-readable label"
    Then I fill in "edit-object-label" with "Apple Tree of note (Basic Image)"
    When I press "Update Properties"
    Then I should see "Apple Tree of note (Basic Image)"
    # Search for original object label to confirm that it is back to its original state
    Given I am on "/islandora/search/Apple%20Tree%20of%20note%20%28Basic%20Image%29?type=dismax"
    Then I should see "samples:4"

  # Able to edit MODS datastream for BASIC IMAGE object?
  # Able to Replace MODS datastream for BASIC IMAGE object?
  @api @apache @javascript @basicimage
  Scenario: Replace MODS datastream for Basic Image object
    Given I am logged in as a user with the "administrator" role
    Given I am on "/islandora/object/samples%3A4"
    Then I should see "Apple Tree of note (Basic Image)"
    Then I click "Manage"
    Then I click "Datastreams"
    Then I should see "MODS Record"
    Given I click "replace" in the "MODS" row
    Then I should see "Replace Datastream"
    Then I should see "Label: MODS Record"
    When I attach the file "assets/MODS-replace-apple-tree.xml" to "edit-file-upload"
    Then I press "Upload"
    Then wait 3 seconds
    Then I press "Add Contents"
    Then wait 3 seconds
    Given I am on "/islandora/object/samples%3A4"
    Then I should see "Apple Tree of note (Basic Image)"
    Then I click "Manage"
    Then I click "Datastreams"
    Then I should see "MODS Record"
    Given I click "edit" in the "MODS" row
    Then I press "Update"
    Given the cache has been cleared
    Given I am on "/islandora/object/samples%3A4"
    Given the cache has been cleared
    Then I should see "Apple Tree of note (Basic Image - MODS - REPLACED )"
    ## Pat/Derek should Replacing MODS update automatically after replace? !!! ACCORDING TO DEREK THIS IS A PROBLEM
   # Able to search for newly edited MODS datastream for BASIC IMAGE object using Islandora simple search?
    Given I am on "/islandora/search/Apple%20Tree%20of%20note%20%28Basic%20Image%20-%20MODS%20-%20REPLACED?type=dismax"
    Then I should see "samples:4"  
    Then I should see "Apple Tree of note (Basic Image - MODS - REPLACED )"
  @api @apache @javascript @basicimage
  Scenario: Undo Changes to MODS datastream for Basic Image object
    Given I am logged in as a user with the "administrator" role
    Given the cache has been cleared
    # Put original MODS back
    Given I am on "/islandora/object/samples%3A4"
    Then I should see "Apple Tree of note"
    Then I click "Manage"
    Then I click "Datastreams"
    Then I should see "MODS Record"
    Given I click "replace" in the "MODS" row
    Then I should see "Replace Datastream"
    Then I should see "Label: MODS Record"
    When I attach the file "/var/www/html/isle-ingest-samples/Batches-by-CModel/basicImageCModel/files/1/Apple Tree of note.xml" to "edit-file-upload"
    Then I press "Upload"
    Then wait 3 seconds
    Then I press "Add Contents"
    Then wait 3 seconds
    Given I am on "/islandora/object/samples%3A4"
    Then I click "Manage"
    Then I click "Datastreams"
    Then I should see "MODS Record"
    Given I click "edit" in the "MODS" row
    Then I press "Update"
    Given the cache has been cleared
    Given I am on "/islandora/object/samples%3A4"
    Given the cache has been cleared
    Then I should see "Apple Tree of note (Basic Image)"
    Given I am on "/islandora/object/samples%3A4"
    Then I should see "Apple Tree of note (Basic Image)"

  
  # Able to delete TN derivative for BASIC IMAGE object?
  @api @apache @basicimage
  Scenario: Delete Basic Image TN derivative and TN datastream
    Given I am logged in as a user with the "administrator" role
    Given I am on "/islandora/object/samples%3A4"
    Then I should see the link "Manage"
    When I click "Manage"
    Then I should see "PARENT COLLECTIONS"
    Then I click "Datastreams"
    Given I click "delete" in the "TN" row
    Then I check the box "Delete Derivatives"
    Given I press "Delete"
    Given I am on "/islandora/search/\"Apple%20Tree\"?type=dismax"
    Then the "dl.solr-thumb" element should contain "defaultimg.png"

  #Replace original TN
  @api @apache @javascript @basicimage
  Scenario: Add Basic Image TN Datastream
    Given I am logged in as a user with the "administrator" role
    Given I am on "/islandora/object/samples%3A4"
    Then I should see the link "Manage"
    When I click "Manage"
    Then I click "Datastreams"
    Given I click "Add a datastream"
    Then I fill in "edit-dsid" with "TN"
    Then I fill in "edit-label" with "Thumbnail"
    When I attach the file "/var/www/html/isle-ingest-samples/Batches-by-CModel/basicImageCModel/files/1/Apple Tree of note.jpg" to "edit-file-upload"
    And I press "Upload"
    And I press "Add Datastream"
    Then I should see "Apple Tree of note"
    Then I should see the link "Manage"
    When I click "Manage"
    When wait 3 seconds
    Then I click "Datastreams"
    Given I click "regenerate" in the "TN" row
    Then I should see "Are you sure you want to regenerate the derivative for the TN datastream?"
    Then I press "Regenerate"
    Given I am on "/islandora/search/samples%3A4?type=dismax"
    Then the "dl.solr-thumb" element should contain "TN/view"


  # Able to regenerate all derivatives for BASIC IMAGE object?
  @api @apache @javascript @basicimage
  Scenario: Regenerate Basic Image TN Derivatives
    Given I am logged in as a user with the "administrator" role
    Given I am on "/islandora/object/samples%3A4"
    Then I should see the link "Manage"
    When I click "Manage"
    When wait 10 seconds
    Then I click "Datastreams"
    Given I click "regenerate" in the "TN" row
    Then I should see "Are you sure you want to regenerate the derivative for the TN datastream?"
    Then I press "Regenerate"
    When wait 10 seconds
    Given I am on "/islandora/search/samples%3A4?type=dismax"
    Then the "dl.solr-thumb" element should contain "TN/view"
  
  ## Javascript test
  @api @apache @javascript
  Scenario: Java wait test
    Given I am logged in as a user with the "administrator" role
    Given I am on "/islandora/object/samples%3A4"
    When wait 5 seconds

  @apache @basicimage
  Scenario: Viewing sample:5
    Given I am on "/islandora/object/samples%3A5"
    Then I should see a "body" element
    Then I should see "Letter of note (Basic Image)"

  @apache @basicimage
  Scenario: Viewing sample:6
    Given I am on "/islandora/object/samples%3A6"
    Then I should see a "body" element
    Then I should see "Palm Tree type (Basic Image)"











