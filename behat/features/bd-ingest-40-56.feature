Feature: Test BriefIngest (through line 56, no video no newspaper issues)
  In order to prove the Brief Ingest properly loaded
  As a developer
  I need to test some sample data

  @javascript
  Scenario: Viewing sample:7
    Given I am an anonymous user
    And I am on "/islandora/object/samples%3A7#page/1/mode/1up"
    Then I should see a "body" element
    Then I should see "The Use of the Antennæ in Insects (Book)"

  @javascript
  Scenario: Viewing sample:18
    Given I am an anonymous user
    And I am on "/islandora/object/samples%3A18"
    Then I should see a "body" element
    Then I should see "samples:14-005"
