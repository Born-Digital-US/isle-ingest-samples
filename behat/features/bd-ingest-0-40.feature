Feature: Test BriefIngest (through line 56, no video no newspaper issues)
  In order to prove the Brief Ingest properly loaded
  As a developer
  I need to test some sample data

  @javascript
  Scenario: Viewing newspaper root
    Given I am an anonymous user
    And I am on "/islandora/object/samples%3Anewspaper"
    Then I should see a "body" element
    Then I should see "Connecticut Western News (Newspaper)"

  @javascript
  Scenario: Viewing sample:1
    Given I am on "/islandora/object/samples%3A2"
    Then I should see "American Goldfinch (Audio)"

  @javascript
  Scenario: Viewing sample:2
    Given I am on "/islandora/object/samples%3A3"
    Then I should see a "body" element
    Then I should see "Red-winged Blackbird (Audio)"

  @javascript
  Scenario: Viewing sample:3
    Given I am on "/islandora/object/samples%3A1"
    Then I should see a "body" element
    Then I should see "Worm-eating Warbler (Audio)"

  @javascript
    Scenario: Viewing sample:4
      Given I am on "/islandora/object/samples%3A4"
      Then I should see a "body" element
      Then I should see "Apple Tree of note (Basic Image)"

  @javascript
  Scenario: Viewing sample:5
    Given I am on "/islandora/object/samples%3A6"
    Then I should see a "body" element
    Then I should see "Palm Tree type (Basic Image)"

  @javascript
  Scenario: Viewing sample:6
    Given I am on "/islandora/object/samples%3A5"
    Then I should see a "body" element
    Then I should see "Letter of note (Basic Image)"
