Feature: Test FeatureContext
  In order to prove the Drupal context is working properly
  As a developer
  I need to test some sample data

  @javascript
  Scenario: Viewing sample:1
    Given I am on "/islandora/object/samples%3A1"
    Then I should see "American Goldfinch (Audio)"

  @javascript
  Scenario: Viewing sample:2
    Given I am on "/islandora/object/samples%3A2"
    Then I should see a "body" element
    Then I should see "Worm-eating Warbler (Audio)"

  @javascript
  Scenario: Viewing sample:4
    Given I am on "/islandora/object/samples%3A4"
    Then I should see a "body" element
    Then I should see "Palm Tree type (Basic Image)"

  @javascript
  Scenario: Viewing sample:5
    Given I am on "/islandora/object/samples%3A5"
    Then I should see a "body" element
    Then I should see "Letter of note (Basic Image)"

  # REMOVED TO SPEED THINGS UP
  #  @javascript
  #  Scenario: Viewing sample:7
  #    Given I am an anonymous user
  #    And I am on "/islandora/object/samples%3A7#page/1/mode/1up"
  #    Then I should see a "body" element
  #    Then I should see "The Use of the Antennæ in Insects (Book)"
  #
  #  @javascript
  #  Scenario: Viewing sample:18
  #    Given I am an anonymous user
  #    And I am on "/islandora/object/samples%3A18"
  #    Then I should see a "body" element
  #    Then I should see "samples:14-005"
