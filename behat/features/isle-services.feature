Feature: Test IsleServices
  In order to prove that ISLE is fully online after a build
  I need to make sure I can access services on their expected ports

  # SOURCE: ISLE 1.1 RC tests 1-2 through 1-11
  # Able to view Traefik admin port?
  # Able to view Portainer Admin panel?
  # Able to view Tomcat admin panel for solr container?
  # Able to view the Solr admin panel for solr container?
  # Able to view Tomcat admin panel for image-services container?
  # Able to view Cantaloupe admin panel for image-services container?
  # Able to view Adore-djatoka admin panel for image-services container?
  # Able to view Tomcat admin panel for fedora container?
  # Able to view Fedora services panels e.g. /objects, /describe etc
  # Able to view Fedoragsearch panels e.g. /fedoragsearch/rest?operation=updateIndex

  # @javascript
  Scenario: traefik online
    Given I am on "/dashboard/"
    Then I should see that the page title is "Page not found | ISLE.localdomain"
    # Then I should see a "body" element
