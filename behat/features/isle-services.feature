Feature: Test IsleServices
  In order to prove that ISLE is fully online after a build
  I need to make sure I can access services on their expected ports

  # SOURCE: ISLE 1.1 RC tests 1-2 through 1-11
  # Able to view Traefik admin port?
  # http://traefik:8080

  @traefik
  Scenario: traefik online
    Given I am on "/"
    Then I should see that the page title is "Traefik"
    # Then I should

  # Able to view Portainer Admin panel?
  # http://isle-portainer:9000
  @portainer
  Scenario: portainer online
    Given I am on "/"
    Then I should see that the page title is "Portainer"

  # Able to connect to MYQSL?
  # http://mysql:3306
  @mysql
  Scenario: mysql online
    # Given I am on "/ --output file.txt"
    # Then I should see "5.7.26"
    Given I run mysqladmin health check

  # Able to view Tomcat admin panel for solr container?
  # Able to view the Solr admin panel for solr container?
  # http://solr:8080, http://solr:8080/solr
  @solr
  Scenario: solr online
    Given I am on "/solr/"
    Then I should see that the page title is "Solr Admin"
    # Then I should see a "body" element

  # Able to view Tomcat admin panel for image-services container?
  # Able to view Cantaloupe admin panel for image-services container?
  # Able to view Adore-djatoka admin panel for image-services container?
  # http://image-services:8080/, http://image-services:8080/cantaloupe/,
  #  http://image-services:8080/adore-djatoka/
  @imageservices
  Scenario: imageservices online
    Given I am on "/"
    Then I should see "If you're seeing this, you've successfully installed Tomcat. Congratulations!"
    Given I am on "/cantaloupe/"
    Then I should see that the page title is "Cantaloupe Image Server"
    Given I am on "/adore-djatoka"
    Then I should see that the page title is "djatoka OpenURL Demo"

  # Able to view Tomcat admin panel for fedora container?
  # Able to view Fedora services panels e.g. /objects, /describe etc
  # Able to view Fedoragsearch panels e.g. /fedoragsearch/rest?operation=updateIndex (requires auth)
  # http://fedora:8080
  @fedora
  Scenario: fedora online
    Given I am on "/"
    Then I should see "If you're seeing this, you've successfully installed Tomcat. Congratulations!"
    Given I am on "/fedora/describe"
    Then I should see that the page title is "Repository Information HTML Presentation"
    Given I am on "/fedora/objects"
    Then I should see that the page title is "Search Repository"
    Given I am on "fedoragsearch/rest?operation=updateIndex"
    Then I should see "HTTP Status 401 – Unauthorized"
    # do it again authorized? should get
    ## test like 'Index name: FgsIndex' or 'Admin Client for Fedora Generic Search Service'
