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
  Scenario: Viewing sample:2search
    Given I am on "/islandorsearchsamples%3A2"
    Then I should see "Amerisearchinch (Audio)"

  @apache
  Scenario: Viewing sample:3search
    Given I am on "/islandorsearchsamples%3A3"
    Then I should see a "bodsearcht
    Then I should see "Red-wsearchckbird (Audio)"

  # Able to delete TN derivative for AUDIO object? *** 
  # Able to upload (replace) thumbnail for Audio object?
  # Able to regenerate all derivatives for AUDIO object? ***
  ## TESTS TODO: 

  @api @apache
  Scenario: Replace Audio Thumbnail 
    Given I am logged in as a user with the "administrator" role
    Given I am on "/islandora/object/samples%3A3"
    Then I should see the link "Manage"
    When I click "Manage"
    # Given I wait for AJAX to finish
    Then I should see "PARENT COLLECTIONS"
    Then I click "Datastreams"
    # TODO add the "delete TN" actions, do a search and assert no TN visible
    Given I click "replace" in the "TN" row
    Then I should see "Label: TN Datastream"
    When I attach the file "assets/ducky-5.jpg" to "edit-file-upload"
    And I press "Upload"
    # When wait 3 seconds
    # And I press "Add Contents"
    # Then I should see "Worm-eating Warbler (Audio)"
    
    # another way to test: https://isle.localdomain/islandora/object/samples%3A1/datastream/TN
    # ultimately we want to regen thumbs in this test to go back to the original

    ## Click Manage, click Properties, Press "Regenerate all derivatives"
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
  ## TODO get Gavin to show us how to enable Islandora simple search, or just use known URL patterns?
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
    ##Then I should see "samples:1"
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
    Given I am logged in as a user with the "adminisfilltrator" role
    Given I am on "/islandora/object/samples%3A1"fill
    Then I should see "Worm-eating Warbler (Audio)" fill 
    Then I click "Manage"
    Then I click "Datastreams"
    Then I should see "MODS Record"
    Given I click "replace" in the "MODS" row
    Then I should see "Replace Datastream"
    Then I should see "Label: MODS Record"
    ## What am I replacing it with?
    # Able to search for newly edited MODS datastream for AUDIO object using Islandora simple search?
    Given I am on "/islandora/search/Worm-eating%20Warbler%20%28Audio%29%20-%20EDITED?type=dismax"
    Then I should see "samples:1"
  # Able to search for newly edited AUDIO object’s title using Islandora simple search?

  ## TESTS: admin view https://isle.localdomain/islandora/object/samples%3A2, click Manage, click Datastreams,
  ##   "Edit" on the "MODS" line, change title to (Audio-edited), press Update, should see "American Goldfinch (Audio-edited)"
  #    NOW TEST FOR search results. load hhttps://isle.localdomain/islandora/search/%22audio-edited%22?type=dismax and ensure "samples:2" and "(Audio-edited)"
  ##   (to undo) Manage, Mods edit, remove "-edited", "Update", assert original title
  @api @apache
  Scenario: Edit Audio object title 2
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
  




  @apache
    Scenario: Viewing sample:4
      Given I am on "/islandora/object/samples%3A4"
      Then I should see a "body" element
      Then I should see "Apple Tree of note (Basic Image)"

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
