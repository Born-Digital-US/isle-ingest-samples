Feature: Test BriefIngest (through line 56, no video no newspaper issues)
  In order to prove the Brief Ingest properly loaded
  As a developer
  I need to test some sample data

  @apache
  Scenario: Viewing newspaper root
    Given I am an anonymous user
    And I am on "/islandora/object/samples%3Anewspaper"
    Then I should see a "body" element
    Then I should see "Connecticut Western News (Newspaper)"

  # Able to ingest the test AUDIO sample objects?
  ## TEST: check URLs for ingested objects

  @apache
  Scenario: Viewing sample:1
    Given I am on "/islandora/object/samples%3A1"
    Then I should see a "body" element
    Then I should see "Worm-eating Warbler (Audio)"

  @apache
  Scenario: Viewing sample:2
    Given I am on "/islandora/object/samples%3A2"
    Then I should see "American Goldfinch (Audio)"

  @apache
  Scenario: Viewing sample:3
    Given I am on "/islandora/object/samples%3A3"
    Then I should see a "body" element
    Then I should see "Red-winged Blackbird (Audio)"



  ## TESTS TODO: 

  @api @apache @javascript
  Scenario: Replace Audio Thumbnail 
    Given I am logged in as a user with the "administrator" role
    Given I am on "/islandora/object/samples%3A3"
    Then I should see the link "Manage"
    When I click "Manage"
    # Given I wait for AJAX to finish
    Then I should see "PARENT COLLECTIONS"
    Then I click "Datastreams"
    Given I click "replace" in the "TN" row
    Then I should see "Update Datastream"
    When I attach the file "assets/ducky-5.jpg" to "edit-file-upload"
    And I press "Upload"
    # When wait 3 seconds
    # And I press "Add Contents"
    # Then I should see "Worm-eating Warbler (Audio)"
    
    # another way to test: https://isle.localdomain/islandora/object/samples%3A1/datastream/TN
    # ultimately we want to regen thumbs in this test to go back to the original
    Given I am logged in as a user with the "administrator" role
    Given I am on "/islandora/object/samples%3A3"
    Then I should see the link "Manage"
    When I click "Manage"
    # Given I wait for AJAX to finish
    Then I should see "PARENT COLLECTIONS"
    Then I click "Datastreams"
    Given I click "replace" in the "TN" row
    Then I should see "Label: TN Datastream"
    When I attach the file "Batches-by-CModel/audioCModel/files/1/Worm-eating Warbler.png" to "edit-file-upload"
    And I press "Upload"
    # When wait 3 seconds
    # And I press "Add Contents"
    # Then I should see "Worm-eating Warbler (Audio)"


  # Ab/islandora/object/samples%3A1#overlay-context=islandora/object/samples%253A1le to delete TN derivative for AUDIO object? *** 
  @api @apache 
  Scenario: Delete TN derivative for Audio Object 
    Given I am logged in as a user with the "administrator" role
    Given I am on "/islandora/object/samples%3A1"
    Then I should see the link "Manage"
    When I click "Manage"
    # Given I wait for AJAX to finish
    When wait 3 seconds
    #Then I should see "PARENT COLLECTIONS"
    Then I click "Datastreams"
    Given I click "delete" in the "TN" row
    Then I check the box "Delete Derivatives" 
    # TODO add the "delete TN" actions, do a search and assert no TN visible
    #Replace original TN
    ## Given I am logged in as a user with the "administrator" role
    ## Given I am on "/islandora/object/samples%3A3"
    ## Then I should see the link "Manage"
    ## When I click "Manage"
    ## # Given I wait for AJAX to finish
    ## Then I should see "PARENT COLLECTIONS"
    ## Then I click "Datastreams"
    ## Given I click "replace" in the "TN" row
    ## Then I should see "Label: TN Datastream"
    ## When I attach the file "Batches-by-CModel/audioCModel/files/1/Worm-eating Warbler.png" to "edit-file-upload"
    ## And I press "Upload"
    ## # When wait 3 seconds
    ## # And I press "Add Contents"
    ## # Then I should see "Worm-eating Warbler (Audio)"

  #Add Original Thumbnail and Thumbnail datastream back
  @api @apache
  Scenario: Add Audio Object TN Datastream 
    Given I am logged in as a user with the "administrator" role
    Given I am on "/islandora/object/samples%3A1"
    Then I should see the link "Manage"
    When I click "Manage"
    Then I click "Datastreams"
    Given I click "Add a datastream"
    Then I fill in "edit-dsid" with "TN"
    Then I fill in "edit-label" with "Thumbnail"
    When I attach the file "Batches-by-CModel/audioCModel/files/1/Worm-eating Warbler.png" to "edit-file-upload"
    And I press "Upload"
    ## When I wait for 3 seconds
    And I press "Add Datastream"
    Then I should see "Worm-eating Warbler (Audio)"
    Then I should see the link "Manage"
    When I click "Manage"
    Then I click "Datastreams"
    Given I click "regenerate" in the "TN" row
    Then I should see "Are you sure you want to regenerate the derivative for the TN datastream?"
    Then I click "Regenerate"

  # Able to upload (replace) thumbnail for Audio object?
  # Able to regenerate all derivatives for AUDIO object? ***  See lower tests

    ## Click Manage, click Properties, Press "Regenerate all derivatives"
    @api @apache
    Scenario: Regenerate all Audio derivatives
      Given I am logged in as a user with the "administrator" role
      Given I am on "/islandora/object/samples%3A3"
      Then I should see the link "Manage"
      When I click "Manage"

    ## figure out how to check for original thumbnail image
    ## maybe: load search https://isle.localdomain/islandora/search/Worm-eating%20Warbler?type=dismax
    ##   ask for "a" tag with href="/islandora/object/samples%3A1" and look for the child img tag, and assert that it's src attribute is 

  # Able to view / hear an AUDIO object?
  ## TESTS: Noah is skeptical that we can test for audio output

  # Able to download an AUDIO object?
  ## TESTS: load https://isle.localdomain/islandora/object/samples%3A1/datastream/OBJ and check for status 200 response code
  @api @apache
  Scenario: Check for Audio OBJ download
    Given I am logged in as a user with the "administrator" role
    Given I am on "/islandora/object/samples%3A1/datastream/OBJ"
    Then I should get a 200 HTTP response

  # Able to search for newly ingested AUDIO object using Islandora simple search?
  ## Tests: load https://isle.localdomain/islandora/search/Audio?type=dismax and look for the things we expect:
  ##   islandora:audio_collection, samples:2, samples:3, samples:1
  @api @apache
  Scenario: Check for Audio Objects using simple search
    Given I am logged in as a user with the "administrator" role
    Given I am on "/islandora/search/Audio?type=dismax"
    Then I should see "islandora:audio_collection"
    Then I should see "samples:3"
    Then I should see "samples:2"
    Then I should see "samples:1"
   

  # Able to edit AUDIO object’s title using the XML form? ("edit")
  @api @apache
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
    ##When I fill in "edit-islandora-simple-search-query" with "Worm-eating Warbler (Audio) - EDITED"
    ##When I press "submit"
    ##Then I should see "samples:1"@api @apache
  Scenario: Check for Audio Objects using simple search
    Given I am logged in as a user with the "administrator" role
    Given I am on "/islandora/search/Audio?type=dismax"
    Then I should see "islandora:audio_collection"
    Then I should see "samples:3"
    Then I should see "samples:2"
    Then I should see "samples:1"
    Given I am on "/islandora/search/Worm-eating%20Warbler%20%28Audio%29%20-%20EDITED?type=dismax"
    Then I should see "samples:1"
    # Undo Changes
    Given I am on "/islandora/object/samples%3A1"
    Then I should see "Worm-eating Warbler (Audio) - EDITED"
    Then I click "Manage"
    Then I click "Datastreams"
    Then I should see "MODS Record"
    Given I click "edit" in the "MODS" row
    Then I should see "Title of the work"
    Then I fill in "edit-titleinfo-title" with "Worm-eating Warbler (Audio)"
    When I press "Update"
    Then I should see "Worm-eating Warbler (Audio)"
    When I fill in "edit-islandora-simple-search-query" with "Worm-eating Warbler (Audio) - EDITED"
    When I press "search"
    Then I should see "samples:1"
  ## I undid my changes right in the test, because if the title was changed then the test would fail the next time


  # Able to edit MODS datastream for AUDIO object? ("replace") ****
  @api @apache
  Scenario: Edit MODS datastream for Audio object
    Given I am logged in as a user with the "administrator" role
    Given I am on "/islandora/object/samples%3A1"
    Then I should see "Worm-eating Warbler (Audio)"
    Then I click "Manage"
    Then I click "Datastreams"
    Then I should see "MODS Record"
    Given I click "replace" in the "MODS" row
    Then I should see "Replace Datastream"
    Then I should see "Label: MODS Record"
    When I attach the file "assets/MODS-replace-warbler.xml" to "edit-file-upload"
    ## Pat/Derek should Replacing MODS update automatically after replace?
    # Able to search for newly edited MODS datastream for AUDIO object using Islandora simple search?
    Given the cache has been cleared
    Given I am on "/islandora/search/Worm-eating%20Warbler%20%28Audio%29%20-%20REPLACED?type=dismax"
    Then I should see "samples:1"  
    Then I should see "Worm-eating Warbler (REPLACED)"
  # Able to search for newly edited AUDIO object’s title using Islandora simple search?
    Given I am on "/islandora/search/Worm-eating%20Warbler%20%28Audio%29%20-%20REPLACED?type=dismax"
    Then I should see "Worm-eating Warbler (REPLACED)"
    # Put original MODS back
    Given I am on "/islandora/object/samples%3A1"
    Then I should see "Worm-eating Warbler (Audio)"
    Then I click "Manage"
    Then I click "Datastreams"
    Then I should see "MODS Record"
    Given I click "replace" in the "MODS" row
    Then I should see "Replace Datastream"
    Then I should see "Label: MODS Record"
    When I attach the file "Batches-by-CModel/audioCModel/files/1/Worm-eating Warbler.xml" to "edit-file-upload"
    Given the cache has been cleared
    Given I am on "/islandora/object/samples%3A1"
    Then I should see "Worm-eating Warbler (Audio)"


  ## TESTS: admin view https://isle.localdomain/islandora/object/samples%3A2, click Manage, click Datastreams,
  ##   "Edit" on the "MODS" line, change title to (Audio-edited), press Update, should see "American Goldfinch (Audio-edited)"
  #    NOW TEST FOR search results. load hhttps://isle.localdomain/islandora/search/%22audio-edited%22?type=dismax and ensure "samples:2" and "(Audio-edited)"
  ##   (to undo) Manage, Mods edit, remove "-edited", "Update", assert original title
  @api @apache
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
  @api @apache
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
  


  # Able to ingest these test BASIC IMAGE sample objects?


  # Able to view a BASIC IMAGE object?
  @apache
  Scenario: Viewing sample:4
    Given I am on "/islandora/object/samples%3A4"
    Then I should see a "body" element
    Then I should see "Apple Tree of note (Basic Image)"

  # Able to download a BASIC IMAGE object?
  @api @apache
  Scenario: Check for Basic Image download
    Given I am logged in as a user with the "administrator" role
    Given I am on "/islandora/object/samples%3A4"
    Then I should get a 200 HTTP response

  # Able to search for newly ingested BASIC IMAGE object using Islandora simple search?
  @api @apache
  Scenario: Check for Basic Images using simple search
    Given I am logged in as a user with the "administrator" role
    Given I am on "/islandora/search/Basic%20Image?type=dismax"
    Then I should see "islandora:sp_basic_image_collection"
    Then I should see "samples:4"
    Then I should see "samples:5"
    Then I should see "samples:6"

  # Able to edit BASIC IMAGE object’s title using the XML form?
  @api @apache
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
    When I press "update"
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
    Given I am on "/islandora/object/samples%3A4"
    Then I should see "Apple Tree of note (Basic Image) - EDITED"  
    Then I click "Manage"
    Then I click "Datastreams"
    Then I should see "MODS Record"
    Given I click "edit" in the "MODS" row
    Then I should see "Title"
    Then I fill in "edit-titleinfo-title" with "Apple Tree of note (Basic Image)"
    When press "update"
    Then I should see "Apple Tree of note (Basic Image)"
    When I fill in "edit-islandora-simple-search-query" with "Apple Tree of note (Basic Image)"
    When I press "search"
    Then I should see "samples:4"



  # Able to edit the Item Label of a BASIC IMAGE object's Properties?
  @api @apache
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
  ## @api @apache
  ## Scenario: Replace MODS datastream for Basic Image object
  ##   Given I am logged in as a user with the "administrator" role
  ##   Given I am on "/islandora/object/samples%3A4"
  ##   Then I should see "Apple Tree of note (Basic Image)"
  ##   Then I click "Manage"
  ##   Then I click "Datastreams"
  ##   Then I should see "MODS Record"
  ##   Given I click "replace" in the "MODS" row
  ##   Then I should see "Replace Datastream"
  ##   Then I should see "Label: MODS Record"
  ##   When I attach the file "assets/MODS-replace-apple-tree.xml" to "edit-file-upload"
  ##   Then I press "Upload"
  ##   Then I wait 3 seconds
  ##   Then I press "Add Contents"
  ##   Then I wait 3 seconds
  ##   Given the cache has been cleared
  ##   Then I should see "Apple Tree of note (Basic Image - MODS - REPLACED"
  ##   ## Pat/Derek should Replacing MODS update automatically after replace? !!! ACCORDING TO DEREK THIS IS A PROBLEM
  ##  # Able to search for newly edited MODS datastream for BASIC IMAGE object using Islandora simple search?
  ##   Given I am on "/islandora/search/Worm-eating%20Warbler%20%28Audio%29%20-%20REPLACED?type=dismax"
  ##   Then I should see "samples:4"  
  ##   Then I should see "Apple Tree of note (Basic Image - MODS - REPLACED"
  ## @api @apache
  ## Scenario: Undo Changes to MODS datastream for Basic Image object
  ##   Given the cache has been cleared
  ##   Given I am on "/islandora/search/Worm-eating%20Warbler%20%28Audio%29%20-%20REPLACED?type=dismax"
  ##   Then I should see "samples:4"  
  ##   Then I should see "Worm-eating Warbler (REPLACED)"
  ##   # Put original MODS back
  ##   Given I am on "/islandora/object/samples%3A4"
  ##   Then I should see "Worm-eating Warbler (Audio)"
  ##   Then I click "Manage"
  ##   Then I click "Datastreams"
  ##   Then I should see "MODS Record"
  ##   Given I click "replace" in the "MODS" row
  ##   Then I should see "Replace Datastream"
  ##   Then I should see "Label: MODS Record"
  ##   When I attach the file "Batches-by-CModel/basicImageCModel/files/1/Apple Tree of note.xml" to "edit-file-upload"
  ##   Then I press "Upload"
  ##   Then I wait 3 seconds
  ##   Then I press "Add Contents"
  ##   Then I wait 3 seconds
  ##   Given the cache has been cleared
  ##   Then I should see "Apple Tree of note (Basic Image)"
  ##   Given I am on "/islandora/object/samples%3A4"
  ##   Then I should see "Apple Tree of note (Basic Image)"

  
  # Able to delete TN derivative for BASIC IMAGE object?
  @api @apache
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
    Given I am on "/islandora/search/samples%3A4?type=dismax"
    Then the "dl.solr-thumb" element should contain "defaultimg.png"

  @api @apache
  Scenario: Test for No TN Image
    Given I am logged in as a user with the "administrator" role
    Given I am on "/islandora/search/samples%3A4?type=dismax"
    Then the "dl.solr-thumb" element should contain "defaultimg.png"

  @api @apache
  Scenario: Test for TN Image
    Given I am logged in as a user with the "administrator" role
    Given I am on "/islandora/search/samples%3A4?type=dismax"
    Then the "dl.solr-thumb" element should contain "TN/view"

  #Replace original TN
  @api @apache
  Scenario: Add Basic Image TN Datastream
    Given I am logged in as a user with the "administrator" role
    Given I am on "/islandora/object/samples%3A4"
    Then I should see the link "Manage"
    When I click "Manage"
    Then I click "Datastreams"
    Given I click "Add a datastream"
    Then I fill in "edit-dsid" with "TN"
    Then I fill in "edit-label" with "Thumbnail"
    When I attach the file "Batches-by-CModel/basicImageCModel/files/1/Apple Tree of note.jpg" to "edit-file-upload"
    And I press "Upload"
    And I press "Add Datastream"
    Then I should see "Apple Tree of note"
    Then I should see the link "Manage"
    When I click "Manage"
    ## When I wait for 3 seconds
    Then I click "Datastreams"
    Given I click "regenerate" in the "TN" row
    Then I should see "Are you sure you want to regenerate the derivative for the TN datastream?"
    Then I press "Regenerate"
    Given I am on "/islandora/search/samples%3A4?type=dismax"
    Then the "dl.solr-thumb" element should contain "TN/view"


  # Able to regenerate all derivatives for BASIC IMAGE object?
  @api @apache @javascript
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

  @apache
  Scenario: Viewing sample:5
    Given I am on "/islandora/object/samples%3A5"
    Then I should see a "body" element
    Then I should see "Letter of note (Basic Image)"

  @apache
  Scenario: Viewing sample:6
    Given I am on "/islandora/object/samples%3A6"
    Then I should see a "body" element
    Then I should see "Palm Tree type (Basic Image)"











