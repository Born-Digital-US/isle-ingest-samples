
Feature: Test ingesting to collection with embargo policy and check resulting policy on child object

  @api @javascript
  Scenario: I am an administrator and I create a collection and set embargo policy on it.
    ### Create the collection object
    Given I am logged in as a user with the "administrator" role
    And I am on "islandora/object/islandora:root"
    And I click "Manage"
    And I click "Add an object to this Collection"
    And I uncheck the box "isct_auto_create"
    And I uncheck the box "inherit_policy"
    And I check the box "content_models[islandora:sp_basic_image]"
    And I fill in the following:
      | edit-pid  | behattest:collection |
      | namespace | behattest            |
    And I select "None" from "xacml"
    And I click on the selector "#edit-next"
    And wait for the page to be loaded
#    Then I should see "Will this object be described in ArchivesSpace?"
#    When I select the radio button "No" with the id "edit-islandora-aspace-enable-0"
#    And I click on the selector "#edit-next"
    And wait for the page to be loaded
    Then I should see "MARCXML File"
    And I click on the selector "#edit-next"
    Then I should see "Collection Title"
    When I fill in the following:
      | titleInfo[title] | Behat Test Collection |
    And I click on the selector "#edit-next"
    And wait 5 seconds
    Then I should see the success message "has been ingested"

      ### Create a basic image object in this collection
    When I click "Manage"
    And wait for the page to be loaded
    And I click "Collection" in the "secondary_tabs" region
    And wait for the page to be loaded
    Then I click "Add an object to this Collection"
    And wait for the page to be loaded
#    Then I should see "Will this object be described in ArchivesSpace?"
#    When I select the radio button "No" with the id "edit-islandora-aspace-enable-0"
#    And I click on the selector "#edit-next"
#    And wait for the page to be loaded
    Then I should see "MARCXML File"
    When I press "Next"
    And wait for the page to be loaded
    And I fill in the following:
      | titleInfo[title] | Behat Test Basic Image |
    And I click on the selector "#edit-next"
    And wait for the page to be loaded
    And I attach the file "ducky-5.jpg" to "files[file]"
    And I click on the selector "#edit-next"
    ### Setting embargoes makes this take longer time
    And wait 15 seconds
    Then I should see the success message "has been ingested"

    ### Go back to the collection and set the datastream embargo, recursive.
    ### We can't do recursive earlier until the collection has at least one object.
    Given I am on "islandora/object/behattest:collection/manage/embargo"
    When I select the radio button "Datastreams (one or more datastreams, not the entire object)" with the id "edit-dsid-datastream"
    And I check the box "ds_options_other"
    And I fill in the following:
      | ds_other | OBJ,JPEG,MEDIUM_SIZE |
    And I select "anonymous user" from "roles[]"
    And I select "2019" from "embargo_date[year]"
    And I check the box "recurse"
    And I select "All children of this collection and collections within this collection." from "recurse_options"
    And I press "Update"
    And wait for the page to be loaded

    ### Now come in as anonymous user and see what there is to see.
    Given I am an anonymous user
    ### Anonymous can't go to the collection, so we find it via search.
    And I am on the homepage
    When I fill in "islandora_simple_search_query" with "\"Behat Test Basic Image\""
    And I press "Search" in the "global_search" region
    Then the response should not contain "messages error"
    And I should see 1 solr search results
    When I click "Behat Test Basic Image"
    And wait for the page to be loaded

    ### Here's the test we care about: The image element and download toggle button should not be visible.
    Then "#block-system-main > div > div.islandora-basic-image-content-wrapper.islandora-object-content-wrapper.clearfix > div.islandora-basic-image-content.islandora-object-content > a > img" selector should not be visible
    And "#ds_download_widget_toggle" selector should not be visible
    And the response should not contain "messages error"

    ### Come back as admin and clean up.
    Given I am logged in as a user with the "administrator" role
    And I am on "islandora/object/behattest:collection/manage/properties"
    When I click on the selector "#edit-delete"
    And wait for the page to be loaded
    When I click on the selector "#edit-submit"
    And wait 10 seconds
    And I should see the success message "Deleted 1 child from"
#    And grab me a screenshot
