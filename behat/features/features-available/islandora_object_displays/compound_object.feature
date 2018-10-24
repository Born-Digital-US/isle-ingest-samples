@islandora_objects
Feature: Compound Object Display
  In order to prove that the compound object display is working properly
  As a developer
  I want to validate that the correct content is/isn't displayed on each page

  @core @api @prod @debug
  Scenario: Viewing a compound object that is not restricted.
    Given I am viewing the page for "islandora cm compound" test
    Then the response should not contain "messages error"
    And ".islandora-object-content-wrapper" selector should be visible
    And ".part-title" selector should be visible in the "object_content"
    And ".navigation-item.active" selector should be visible in the "jail_wrapper"
    And I should see "Permalink:" in an item with selector "#object_links div.permalink > span.permalink-label"
    And "#compound_parent_metadata" selector should be visible
    And "#object_metadata" selector should be visible
#    And I should see the link "Mary Lyon Collection" in the "breadcrumb"
#    And I should see the link "Archives and Special Collections" in the "breadcrumb"
#    And I should see the link "Mount Holyoke College Collections" in the "breadcrumb"
    And I should see the link "Browse All Collections" in the "breadcrumb"
    And I should see the link "Home" in the "breadcrumb"
    And "#ds_download_widget_toggle" selector should be visible
    And "#ds_download_widget_popup" selector should not be visible
    And ".webform-link.use-ajax" selector should be visible


  @core @api @javascript
  Scenario: Clicking on the download button.
    Given I am viewing the page for "islandora cm compound" test
    Then "#ds_download_widget_toggle" selector should be visible
    When I click on the selector "#ds_download_widget_toggle"
    Then "#ds_download_widget_popup" selector should be visible
    And I should see the link "Compass Terms of Use" in the "object_links" region
    And ".ds-download-popup-links .download-link a.download-link.jpg" selector should be visible
