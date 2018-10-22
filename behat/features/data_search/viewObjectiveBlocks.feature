Feature: DataSearch Objective Block
  In order to prove the objective blocks load
  As an anonymous user
  I need to view objective blocks

  @javascript
  Scenario: Viewing TU-19.1 objective block
    Given I am an anonymous user
    And I am on "/2020/data-search/Search-the-Data#objid=5338"
    And I wait for AJAX to finish
    Then I should see "TU-19.1"
    And I should see "Reduce the illegal sales rate to minors through enforcement of laws prohibiting the sale of tobacco products to minors in States and the District of Columbia"

  @javascript
  Scenario: Viewing TU-19.2 objective block
    #Given I wait 15 seconds
    Given I am an anonymous user
    And I am on "/2020/data-search/Search-the-Data#objid=5339"
    And I wait for AJAX to finish
    Then I should see "TU-19.2"
    And I should see "Reduce the illegal sales rate to minors through enforcement of laws prohibiting the sale of tobacco products to minors in Territories"
