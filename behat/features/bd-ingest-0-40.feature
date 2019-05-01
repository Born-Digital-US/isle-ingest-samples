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

  # Able to edit AUDIO object’s title using the XML form? ("edit")
  # Able to edit MODS datastream for AUDIO object? ("replace") ****
  # Able to search for newly edited MODS datastream for AUDIO object using Islandora simple search?
  # Able to search for newly edited AUDIO object’s title using Islandora simple search?
  ## TESTS: admin view https://isle.localdomain/islandora/object/samples%3A2, click Manage, click Datastreams,
  ##   "Edit" on the "MODS" line, change title to (Audio-edited), press Update, should see "American Goldfinch (Audio-edited)"
  #    NOW TEST FOR search results. load hhttps://isle.localdomain/islandora/search/%22audio-edited%22?type=dismax and ensure "samples:2" and "(Audio-edited)"
  ##   (to undo) Manage, Mods edit, remove "-edited", "Update", assert original title
  #  similar test for "replace" - but we'll need to add a new MODS xml file to "assets" so we can upload it like a TN
  #  to satisfy search requirements, do a search after both changes (edit and replace) to ensure search index is picking up changes

  
  # Able to edit the Item Label of an AUDIO object's Properties?
  # Able to search for newly edited Item Label of an AUDIO object's Properties using Islandora simple search?
  ## TESTS:  Click Manage, clikc Properties, change Item Label to (Audio-LABEL-EDITED)
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
