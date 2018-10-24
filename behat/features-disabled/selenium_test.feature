Feature: Test if Selenium is working

  @mink:selenium2
  Scenario: Run an ajax example
    Given I am on "http://compass-vagrant.fivecolleges.edu/object/smith:7"
    Then I should see "Contact Us" in the "#iw_webform_links_85" element
    When I click "Contact Us"
    And I wait for AJAX to finish
    Then I should see "In regards to: CV Test Large Image" in the "#webform-client-form-85" element


  @mink:selenium2 @prod
  Scenario: Test selenium on compass-dev -- Carmen Vazquez
    Given I am on "http://compass-dev.fivecolleges.edu/object/smith:828"
    And grab me a screenshot
    Then I should see "accession 062-96, box 1"
    Then I should see "Contact Us" in the "#iw_webform_links_85" element
    When I click "Contact Us"
    And I wait for AJAX to finish
    Then I should see "In regards to:" in the "#webform-client-form-85" element

  @mink:selenium2 @prod
  Scenario: Test selenium on compass-newprod -- Carmen Vazquez
    Given I am on "https://compass-stage.fivecolleges.edu/object/smith:667"
    And grab me a screenshot
    Then I should see "accession 062-96, box 1"
    Then I should see "Contact Us" in the "#iw_webform_links_85" element
    When I click "Contact Us"
    And I wait for AJAX to finish
    Then I should see "In regards to:" in the "#webform-client-form-85" element

  @mink:selenium2 @prod
  Scenario: Test selenium on compass-newprod -- Carmen Vazquez
    Given I am on "https://compass.fivecolleges.edu/object/smith:667"
    And grab me a screenshot
    Then I should see "accession 062-96, box 1"
    Then I should see "Contact Us" in the "#iw_webform_links_85" element
    When I click "Contact Us"
    And I wait for AJAX to finish
    Then I should see "In regards to:" in the "#webform-client-form-85" element

#  @mink:selenium2 @prod
#  Scenario: Run yet another ajax example
#    Given I am on "https://www.google.com/ncr"
#    Then I should see "I'm feeling lucky"
#    When I fill in the following:
#      | q  | home depot |
#    Then I click "Google Search"
#    And wait for the page to be loaded
#    Then I should see "Pittsfield, MA 01201"