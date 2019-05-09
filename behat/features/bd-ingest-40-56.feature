Feature: Test BriefIngest (through line 56, no video no newspaper issues)
  In order to prove the Brief Ingest properly loaded
  As a developer
  I need to test some sample data

  @apache @book
  Scenario: Viewing samples:7
    Given I am logged in as a user with the "administrator" role
    And I am on "/islandora/object/samples%3A7#page/1/mode/1up"
    Then I should see a "body" element
    Then I should see "The Use of the Antennæ in Insects (Book)"
    # tests here for main book object
    Then I click "Pages"
    # are all the pages here?
    Then I should see "samples:7-001"
    Then I should see "samples:7-002"
    Then I should see "samples:7-003"
    Then I should see "samples:7-004"
    Then I should see "samples:7-005"
    Then I should see "samples:7-006"
    Then I click "samples:7-001"
    # here you can test the interior pages here
    Then I click "Return to Book View"
    # then you could test more of the pages

  @apache @book
  Scenario: Viewing samples:14
    Given I am logged in as a user with the "administrator" role
    And I am on "/islandora/object/samples%3A14"
    Then I should see a "body" element
    Then I should see "On the Tides at Malta (Book)"
    # tests here for main book object
    Then I click "Pages"
    # are all the pages here?
    Then I should see "samples:14-001"
    Then I should see "samples:14-002"
    Then I should see "samples:14-003"
    Then I should see "samples:14-004"
    Then I should see "samples:14-005"
    Then I should see "samples:14-006"
    Then I click "samples:14-001"
    # here you can test the interior pages here
    Then I click "Return to Book View"
    # then you could test more of the pages

  @apache @compound
  Scenario: Viewing samples:21
    Given I am an anonymous user
    And I am on "/islandora/object/samples%3A21"
    Then I should see a "body" element
    Then I should see "Amherst 1886"

  @apache @compound
  Scenario: Viewing samples:22
    Given I am an anonymous user
    And I am on "/islandora/object/samples%3A22"
    Then I should see a "body" element
    Then I should see "Adams 1882"

  @apache @compound @javascript
  Scenario: Viewing samples:23
    Given I am logged in as a user with the "administrator" role
    And I am on "/islandora/object/samples%3A23"
    Then I should see a "body" element
    Then I should see "Adams 1882"
    Then I click "Manage"
    Then I click "Compound"
    Then I click "Reorder"
    Then I should see "sample:22"
    Then I should see "sample:21"

  @apache @compound
  Scenario: Viewing samples:24
    Given I am an anonymous user
    And I am on "/islandora/object/samples%3A24"
    Then I should see a "body" element
    Then I should see "Springfield 1875"

  @apache @compound
  Scenario: Viewing samples:25
    Given I am an anonymous user
    And I am on "/islandora/object/samples%3A25"
    Then I should see a "body" element
    Then I should see "Springfield 1875"

  @apache @compound
  Scenario: Viewing samples:26
    Given I am an anonymous user
    And I am on "/islandora/object/samples%3A26"
    Then I should see a "body" element
    Then I should see "Turners Falls 1877"

  @apache @largeimage
  Scenario: Viewing samples:27
    Given I am an anonymous user
    And I am on "/islandora/object/samples%3A27"
    Then I should see a "body" element
    Then I should see "Amherst College, Lawrence Observatory (Large Image)"

  @apache @largeimage
  Scenario: Viewing samples:28
    Given I am an anonymous user
    And I am on "/islandora/object/samples%3A28"
    Then I should see a "body" element
    Then I should see "Easthampton Town Hall (Large Image)"

  @apache @largeimage
  Scenario: Viewing samples:29
    Given I am an anonymous user
    And I am on "/islandora/object/samples%3A29"
    Then I should see a "body" element
    Then I should see "Nehemiah Strong House (Large Image)"

  @apache @pdf
  Scenario: Viewing samples:30
    Given I am an anonymous user
    And I am on "/islandora/object/samples%3A30"
    Then I should see a "body" element
    Then I should see "Nonantum Hill Nursery materials (PDF)"

  @apache @pdf
  Scenario: Viewing samples:31
    Given I am an anonymous user
    And I am on "/islandora/object/samples%3A31"
    Then I should see a "body" element
    Then I should see "Catalogue of fruit and ornamental trees, shrubbery, and plants, for sale at the nurseries at Linnaean Hill, Rock Creek, near Washington, D.C. (PDF)"

  @apache @pdf
  Scenario: Viewing samples:32
    Given I am an anonymous user
    And I am on "/islandora/object/samples%3A32"
    Then I should see a "body" element
    Then I should see "Catalogue of the plants found in New Bedford and its vicinity; arranged according to the season of their flowering. (PDF)"


  # Able to ingest these test VIDEO sample objects?
    #(Javascript does not work because it cannot interact with second "Next" button)
  @api @apache
  Scenario: Injest Video Sample Objects
    Given I am logged in as a user with the "administrator" role
    And I am on "/islandora/object/samples%3Acollection"
    Then I should see "ICG Samples"
    Then I click "Manage"
    Then I click "Add an object to this Collection"
    When select "Islandora Video Content Model" from "models"
    Then I press "Next"
    # When I attach the file "/var/www/html/isle-ingest-samples/behat/features/assets/Videos/ZsafetyRazorTEST.xml" to "edit-file-upload"
    # Then I press "Upload"
    # When I wait for AJAX to finish

    # (Next again because we always skip MARCXML)
    Then I press "Next"
    Then I fill in "edit-titleinfo-title" with "Z American Safey Razor (Video) TEST OBJECT"
    Then I press "Next"
    When I attach the file "/var/www/html/isle-ingest-samples/behat/features/assets/Videos/ZsafetyRazorTEST.mp4" to "edit-file-upload"
    Then I press "Upload"
    #When wait 20 seconds
    Then I press "Ingest"
    When I am on "/islandora/object/samples%3Acollection"
    Then I click "last"
    Then I should see the link "Z American Safey Razor (Video) TEST OBJECT"
    When I click "Z American Safey Razor (Video) TEST OBJECT"
    Then I should see "In collections"
    When I click "Manage"
    Then I click "Properties"
    Then I should see "Item Label"
    Then I press "Permanently remove 'Z American Safey Razor (Video...' from repository"
    Then I should see "This action cannot be undone."
    Then I press "Delete"
    #When wait 20 seconds
    When I am on "/islandora/object/samples%3Acollection"
    Then I click "last"
    Then I should not see the link "Z American Safey Razor (Video) TEST OBJECT"



  # Able to view a VIDEO object?
  @apache @video
  Scenario: Viewing samples:33
    Given I am an anonymous user
    And I am on "/islandora/object/samples%3A33"
    Then I should see a "body" element
    Then I should see "Brim Coffee (Video)"

  # Able to download a VIDEO object?
  @api @apache
    Scenario: Check for Video download
      Given I am logged in as a user with the "administrator" role
      Given I am on "/islandora/object/samples%3A33"
      Then I should get a 200 HTTP response

  # Able to search for newly ingested VIDEO object using Islandora simple search?
  @api @apache
  Scenario: Check for Videos using simple search
    Given I am logged in as a user with the "administrator" role
    Given I am on "/islandora/search/video?type=dismax"
    Then I should see "islandora:video_collection"
    Then I should see "samples:33"
    Then I should see "samples:34"
    Then I should see "samples:35"


  # Able to edit VIDEO object’s title using the XML form?
  @api @apache
  Scenario: Edit Basic Video title
    Given I am logged in as a user with the "administrator" role
    Given I am on "/islandora/object/samples%3A33"
    Then I should see "Brim Coffee (Video)"
    Then I click "Manage"
    Then I click "Datastreams"
    Then I should see "MODS Record"
    Given I click "edit" in the "MODS" row
    Then I should see "Title"
    Then I fill in "edit-titleinfo-title" with "Brim Coffee (Video) - EDITED"
    When I press "update"
    Then I should see "Brim Coffee (Video) - EDITED"
    # Able to search for newly edited VIDEO object’s title using Islandora simple search?
    Given I am on "/islandora/search/Brim%20Coffee%20%28Video%29%20-%20EDITED?type=dismax"
    Then I should see "samples:33"
    # Undo Changes
    Given I am on "/islandora/object/samples%3A33"
    Then I should see "Brim Coffee (Video) - EDITED"
    Then I click "Manage"
    Then I click "Datastreams"
    Then I should see "MODS Record"
    Given I click "edit" in the "MODS" row
    Then I should see "Title"
    Then I fill in "edit-titleinfo-title" with "Brim Coffee (Video)"
    When press "update"
    Then I should see "Brim Coffee (Video)"
    When I fill in "edit-islandora-simple-search-query" with "Brim Coffee (Video)"
    When I press "search"
    Then I should see "samples:33"


  # Able to edit the Item Label of an VIDEO object's Properties?
  @api @apache
  Scenario: Edit Video Item Label
    Given I am logged in as a user with the "administrator" role
    Given I am on "/islandora/object/samples%3A33"
    Then I should see "Brim Coffee (Video)"
    Then I click "Manage"
    Then I click "Properties"
    Then I should see "A human-readable label"
    Then I fill in "edit-object-label" with "Brim Coffee (Video-LABEL-EDITED)"
    When I press "Update Properties"
    Then I should see "Brim Coffee (Video-LABEL-EDITED)"
    # Able to search for newly edited Item Label of an VIDEO object's Properties using Islandora simple search?
    Given I am on "/islandora/search/Brim%20Coffee%20%28Video-LABEL-EDITED%29?type=dismax"
    Then I should see "samples:33"
    # Undo changes to object label
    Given I am on "/islandora/object/samples%3A33"
    Then I should see "Brim Coffee (Video-LABEL-EDITED)"
    Then I click "Manage"
    Then I click "Properties"
    Then I should see "A human-readable label"
    Then I fill in "edit-object-label" with "Brim Coffee (Video)"
    When I press "Update Properties"
    Then I should see "Brim Coffee (Video)"
    # Search for original object label to confirm that it is back to its original state
    Given I am on "/islandora/search/Brim%20Coffee%20%28Video%29?type=dismax"
    Then I should see "samples:33"


  # Able to edit MODS datastream for VIDEO object?


  # Able to search for newly edited MODS datastream for VIDEO object using Islandora simple search?

  # Able to replace MODS datastreams
  @api @apache @javascript
  Scenario: Replace MODS datastream for Video
    Given I am logged in as a user with the "administrator" role
    Given I am on "/islandora/object/samples%3A33"
    Then I should see "Brim Coffee (Video)"
    Then I click "Manage"
    Then I click "Datastreams"
    Then I should see "MODS Record"
    Given I click "replace" in the "MODS" row
    Then I should see "Replace Datastream"
    Then I should see "Label: MODS Record"
    When I attach the file "/var/www/html/isle-ingest-samples/behat/features/assets/MODS-replace-brim-coffee.xml" to "edit-file-upload"
    And grab me a screenshot
    Then I press "Upload"
    Then wait 1 seconds
    Then I press "Add Contents"
    Then wait 30 seconds
    Given the cache has been cleared

    # TODO: this next assertion should succeed, but it doesn't:
    Then I should see "Brim Coffee (Video) - MODS - REPLACED"
    ## Pat/Derek should Replacing MODS update automatically after replace? !!! ACCORDING TO DEREK THIS IS A PROBLEM

    #Able to search for newly replaced MODS datastreams using Islandora simple search?
    Given I am on "/islandora/search/Brim%20Coffee%20%28Video%29%20-%20MODS%20-%20REPLACED?type=dismax"
    Then I should see "samples:33"
    Then I should see "Brim Coffee (Video) - MODS - REPLACED"

    # NOW WE UNDO
    Given the cache has been cleared
    Given I am on "/islandora/search/Brim%20Coffee%20%28Video%29%20-%20MODS%20-%20REPLACED?type=dismax"
    Then I should see "samples:33"
    Then I should see "Brim Coffee (Video) - MODS - REPLACED"
    # Put original MODS back
    Given I am on "/islandora/object/samples%3A33"
    # TODO uncomment this when bugfixed also
    # Then I should see "Brim Coffee (Video) - MODS - REPLACED"
    Then I click "Manage"
    Then I click "Datastreams"
    Then I should see "MODS Record"
    Given I click "replace" in the "MODS" row
    Then I should see "Replace Datastream"
    Then I should see "Label: MODS Record"
    When I attach the file "/var/www/html/isle-ingest-samples/Batches-by-CModel/videoCModel/files/1/brim.xml" to "edit-file-upload"
    Then I press "Upload"
    Then wait 3 seconds
    Then I press "Add Contents"
    Then wait 3 seconds
    Given the cache has been cleared
    # todo uncomment after bugfix
    Then I should see "Brim Coffee (Video)"
    Given I am on "/islandora/object/samples%3A33"
    Then I should see "Brim Coffee (Video)"



  # Able to delete TN derivative for VIDEO object?
  @api @apache
  Scenario: Test for Video TN Image
    Given I am logged in as a user with the "administrator" role
    Given I am on "/islandora/search/samples%3A33?type=dismax"
    Then the "dl.solr-thumb" element should contain "TN/view"

  @api @apache
  Scenario: Delete Video TN derivative and TN datastream
    Given I am logged in as a user with the "administrator" role
    Given I am on "/islandora/object/samples%3A33"
    Then I should see the link "Manage"
    When I click "Manage"
    Then I should see "PARENT COLLECTIONS"
    Then I click "Datastreams"
    Given I click "delete" in the "TN" row
    Then I check the box "Delete Derivatives"
    Given I press "Delete"
    Given I am on "/islandora/search/samples%3A33?type=dismax"
    Then the "dl.solr-thumb" element should contain "defaultimg.png"

  @api @apache
  Scenario: Test for No Video TN Image
    Given I am logged in as a user with the "administrator" role
    Given I am on "/islandora/search/samples%3A33?type=dismax"
    Then the "dl.solr-thumb" element should contain "defaultimg.png"


  #Replace original TN
  @api @apache
  Scenario: Add Video TN Datastream
    Given I am logged in as a user with the "administrator" role
    Given I am on "/islandora/object/samples%3A33"
    Then I should see the link "Manage"
    When I click "Manage"
    Then I click "Datastreams"
    Given I click "Add a datastream"
    Then I fill in "edit-dsid" with "TN"
    Then I fill in "edit-label" with "Thumbnail"
    When I attach the file "assets/ducky-5.jpg" to "edit-file-upload"
    And I press "Upload"
    ## When wait 3 seconds
    And I press "Add Datastream"
    Then I should see "Brim Coffee (Video)"
    Then I should see the link "Manage"
    When I click "Manage"
    ## When wait for 3 seconds
    Then I click "Datastreams"
    Given I click "regenerate" in the "TN" row
    Then I should see "Are you sure you want to regenerate the derivative for the TN datastream?"
    Then I press "Regenerate"
    Given I am on "/islandora/search/samples%3A33?type=dismax"
    Then the "dl.solr-thumb" element should contain "TN/view"

  # Able to regenerate all derivatives for VIDEO object?
  @api @apache @javascript
  Scenario: Regenerate Video TN Derivatives
    Given I am logged in as a user with the "administrator" role
    Given I am on "/islandora/object/samples%3A33"
    Then I should see the link "Manage"
    When I click "Manage"
    When wait 5 seconds
    Then I click "Datastreams"
    Given I click "regenerate" in the "TN" row
    Then I should see "Are you sure you want to regenerate the derivative for the TN datastream?"
    Then I press "Regenerate"
    When wait 5 seconds
    Given I am on "/islandora/search/samples%3A33?type=dismax"
    Then the "dl.solr-thumb" element should contain "TN/view"

  @apache @video
  Scenario: Viewing samples:33
    Given I am an anonymous user
    And I am on "/islandora/object/samples%3A33"
    Then I should see a "body" element
    Then I should see "Brim Coffee (Video)"

  @apache @video
  Scenario: Viewing samples:34
    Given I am an anonymous user
    And I am on "/islandora/object/samples%3A34"
    Then I should see a "body" element
    Then I should see "AMF: Roadmaster Evel Knievel Bicycles (Video)"

  @apache @video
  Scenario: Viewing samples:35
    Given I am an anonymous user
    And I am on "/islandora/object/samples%3A35"
    Then I should see a "body" element
    Then I should see "American Safety Razor (Video)"
