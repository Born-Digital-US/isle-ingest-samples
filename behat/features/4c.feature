Feature: 4c: Create a collection... does SOLR equivalent collection auto-create? (GUI, not backend)
  Write a test that creates an Islandora collection then:
  Confirms that a Drupal Solr collection is created.
  Confirms that objects of the collection appear on the solr collection page. (viewed as admin)
  Confirms that the title appears.
  Confirms that the page is not visible when logged out.

  @api @javascript
  Scenario: 4c : Create a collection... does SOLR equivalent collection auto-create? (GUI, not backend).
    ### Create the collection object
    Given I am logged in as a user with the "administrator" role
    And I am on "islandora/object/islandora:root"
    And I click "Manage"
    And I click "Add an object to this Collection"
    And I check the box "isct_auto_create"
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
#    And wait for the page to be loaded
    Then I should see "MARCXML File"
    And I click on the selector "#edit-next"
    And wait for the page to be loaded
    Then I should see "Collection Title"
    When I fill in the following:
      | titleInfo[title] | Behat Test Collection - SOLR Collection Creation Test |
    And I click on the selector "#edit-next"
    And wait 5 seconds
    Then I should see the success message "has been ingested"
    And I should see "1 solr collection count updated. Solr collection Behat Test Collection - SOLR Collection Creation Test created"

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
    And wait 15 seconds
    Then I should see the success message "has been ingested"
    And wait 5 seconds

    # Does the solr collection page display the one object?
    Given I am on "collections/behat-test-collection-solr-collection-creation-test"
    Then I should see "Behat Test Collection - SOLR Collection Creation Test"
    And I should see 1 solr search results
    And I should see the link "Behat Test Basic Image"

    ### Come back as admin and clean up.
    # Delete the collection and its children.
    Given I am logged in as a user with the "administrator" role
    And I am on "islandora/object/behattest:collection/manage/properties"
    When I click on the selector "#edit-delete"
    And wait for the page to be loaded
    When I click on the selector "#edit-submit"
    And wait 3 seconds
    Then I should see "Deleted 1 child from"
    # Delete the solr collection object.
#    Given I am on "collections/behat-test-collection-solr-collection-creation-test"
#    And wait 1 seconds
#    And I click "Edit"
#    And wait for the page to be loaded
#    Then I click on the selector "#edit-delete"
#    And wait for the page to be loaded
#    Then I click on the selector "#edit-submit"
#    And wait for the page to be loaded
#    Then I should see "Islandora Solr Content Behat Test Collection - SOLR Collection Creation Test has been deleted"
