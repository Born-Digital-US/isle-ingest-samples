@search
Feature: Solr Search
  In order to prove that islandora search is working properly site-wide and in collections
  As a developer
  I want to verify that search page content and results found match expectations

  @core @api @prod
  Scenario: Running a search from the home page as an anonymous user, no search term or collection specified.
    Given I am on the homepage
    When I press "Search" in the "global_search" region
    Then the response should not contain "messages error"
    And I should see "Search results" in an item with selector "h1.page-header"
    And "h4.anonymous-user.browsing-as" selector should be visible in the "mezzanine_row" region
    And I should see "Log In to make restricted access items visible"
    And I should see "Search By Term" in the 'sidebar_first'
    And "#block-islandora-solr-basic-facets" selector should be visible
    And I should see "Collection" in an item with selector '.islandora-solr-facet-wrapper'
    And I should see "\d+ [\S ]*found in.+collection[s]* \[showing \d* - \d*\]" regex pattern in the "mezzanine_row"
    And I should see 20 solr search results

  @core @api @prod
  Scenario: Running a search from the home page as an anonymous user, with a search term.
    Given I am on the homepage
    When I fill in "islandora_simple_search_query" with "Test"
    And I press "Search" in the "global_search" region
    Then the response should not contain "messages error"
    And I should see at least 3 solr search results


  @core @api @prod
  Scenario: Searching Hampshire collections
    Given I am viewing the page for "hampshire collections" test
    When I fill in "islandora_simple_search_query" with "Test"
    And I press "Search" in the "global_search" region
    Then the response should not contain "messages error"
    And I should see at most 20 solr search results

