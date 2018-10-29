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
  Scenario: Viewing sample:8
    Given I am an anonymous user
    And I am on "/islandora/object/samples%3A8"
    Then I should see a "body" element
    Then I should see "samples:7-006"

  @javascript
  Scenario: Viewing sample:9
    Given I am an anonymous user
    And I am on "/islandora/object/samples%3A9"
    Then I should see a "body" element
    Then I should see "samples:7-002"

  @javascript
  Scenario: Viewing sample:10
    Given I am an anonymous user
    And I am on "/islandora/object/samples%3A10"
    Then I should see a "body" element
    Then I should see "samples:7-004"

  @javascript
  Scenario: Viewing sample:11
    Given I am an anonymous user
    And I am on "/islandora/object/samples%3A11"
    Then I should see a "body" element
    Then I should see "samples:7-005"

  @javascript
  Scenario: Viewing sample:12
    Given I am an anonymous user
    And I am on "/islandora/object/samples%3A12"
    Then I should see a "body" element
    Then I should see "samples:7-003"

  @javascript
  Scenario: Viewing sample:13
    Given I am an anonymous user
    And I am on "/islandora/object/samples%3A13"
    Then I should see a "body" element
    Then I should see "samples:7-001"

  @javascript
  Scenario: Viewing sample:14
    Given I am an anonymous user
    And I am on "/islandora/object/samples%3A14#page/1/mode/1up"
    Then I should see a "body" element
    Then I should see "On the Tides at Malta (Book)"

  @javascript
  Scenario: Viewing sample:15
    Given I am an anonymous user
    And I am on "/islandora/object/samples%3A15"
    Then I should see a "body" element
    Then I should see "samples:14-001"

  @javascript
  Scenario: Viewing sample:16
    Given I am an anonymous user
    And I am on "/islandora/object/samples%3A16"
    Then I should see a "body" element
    Then I should see "samples:14-002"

  @javascript
  Scenario: Viewing sample:17
    Given I am an anonymous user
    And I am on "/islandora/object/samples%3A17"
    Then I should see a "body" element
    Then I should see "samples:14-004"

  @javascript
  Scenario: Viewing sample:18
    Given I am an anonymous user
    And I am on "/islandora/object/samples%3A18"
    Then I should see a "body" element
    Then I should see "samples:14-005"

  @javascript
  Scenario: Viewing sample:19
    Given I am an anonymous user
    And I am on "/islandora/object/samples%3A19"
    Then I should see a "body" element
    Then I should see "samples:14-003"

  @javascript
  Scenario: Viewing sample:20
    Given I am an anonymous user
    And I am on "/islandora/object/samples%3A20"
    Then I should see a "body" element
    Then I should see "samples:14-001"

  @javascript
  Scenario: Viewing sample:21
    Given I am an anonymous user
    And I am on "/islandora/object/samples%3A21"
    Then I should see a "body" element
    Then I should see "Holyoke / S. Hadley 1881"

  @javascript
  Scenario: Viewing sample:22
    Given I am an anonymous user
    And I am on "/islandora/object/samples%3A22"
    Then I should see a "body" element
    Then I should see "Holyoke 1872"

  @javascript
  Scenario: Viewing sample:23
    Given I am an anonymous user
    And I am on "/islandora/object/samples%3A23"
    Then I should see a "body" element
    Then I should see "Holyoke 1872"

  @javascript
  Scenario: Viewing sample:24
    Given I am an anonymous user
    And I am on "/islandora/object/samples%3A24"
    Then I should see a "body" element
    Then I should see "Adams 1882"

  @javascript
  Scenario: Viewing sample:5
    Given I am an anonymous user
    And I am on "/islandora/object/samples%3A25"
    Then I should see a "body" element
    Then I should see "Adams 1882"

  @javascript
  Scenario: Viewing sample:26
    Given I am an anonymous user
    And I am on "/islandora/object/samples%3A26"
    Then I should see a "body" element
    Then I should see "Amherst 1886"

  @javascript
  Scenario: Viewing sample:27
    Given I am an anonymous user
    And I am on "/islandora/object/samples%3A27"
    Then I should see a "body" element
    Then I should see "Turners Falls 1877"

  @javascript
  Scenario: Viewing sample:28
    Given I am an anonymous user
    And I am on "/islandora/object/samples%3A28"
    Then I should see a "body" element
    Then I should see "Springfield 1875"

  @javascript
  Scenario: Viewing sample:29
    Given I am an anonymous user
    And I am on "/islandora/object/samples%3A29"
    Then I should see a "body" element
    Then I should see "Springfield 1875"

  @javascript
  Scenario: Viewing sample:30
    Given I am an anonymous user
    And I am on "/islandora/object/samples%3A30"
    Then I should see a "body" element
    Then I should see "Amherst College, Lawrence Observatory (Large Image)"

  @javascript
  Scenario: Viewing sample:31
    Given I am an anonymous user
    And I am on "/islandora/object/samples%3A31"
    Then I should see a "body" element
    Then I should see "Easthampton Town Hall (Large Image)"

  @javascript
  Scenario: Viewing sample:32
    Given I am an anonymous user
    And I am on "/islandora/object/samples%3A32"
    Then I should see a "body" element
    Then I should see "Nehemiah Strong House (Large Image)"

  @javascript
  Scenario: Viewing sample:33
    Given I am an anonymous user
    And I am on "/islandora/object/samples%3A33"
    Then I should see a "body" element
    Then I should see "Nonantum Hill Nursery materials (PDF)"

  @javascript
  Scenario: Viewing sample:34
    Given I am an anonymous user
    And I am on "/islandora/object/samples%3A34"
    Then I should see a "body" element
    Then I should see "Catalogue of fruit and ornamental trees, shrubbery, and plants, for sale at the nurseries at Linnaean Hill, Rock Creek, near Washington, D.C. (PDF)"

  @javascript
  Scenario: Viewing sample:35
    Given I am an anonymous user
    And I am on "/islandora/object/samples%3A35"
    Then I should see a "body" element
    Then I should see "Catalogue of the plants found in New Bedford and its vicinity; arranged according to the season of their flowering. (PDF)"
