# Priority List

1. Finish video conversion / coverage
2. Newspapers
3. Compound Objects
4. Regroup (fill in coverage if Noah isn't available)

# ISLE/DOCKER IMAGES

* 1-1	Able to create new ISLE instance?
* 1-2	Able to view Traefik admin port?
* 1-3	Able to view Portainer Admin panel?
* 1-4	Able to view Tomcat admin panel for solr container?
* 1-5	Able to view the Solr admin panel for solr container?
* 1-6	Able to view Tomcat admin panel for image-services container?
* 1-7	Able to view Cantaloupe admin panel for image-services container?
* 1-8	Able to view Adore-djatoka admin panel for image-services container?
* 1-9	Able to view Tomcat admin panel for fedora container?
* 1-10	Able to view Fedora services panels e.g. /objects, /describe etc
* 1-11	Able to view Fedoragsearch panels e.g. /fedoragsearch/rest?operation=updateIndex

# DRUPAL INSTALLATION
2-1	Able to view domain / website url as anonymous user?
2-2	Able to login to Drupal site as an admin user?
2-3	Able to view persistent data folders for xml/xslt/sites and for fedora data store?
2-4	If Drupal multisite, able to login to multisite (not parent) site?
2-5	Drupal Status Report not showing errors? https://<domain>/node#overlay=admin/reports/status

# SAMPLE OBJECT INGESTION
## Collections
* 3-1	Able to create a new collection e.g. test:collection?
    * TODO? This currently happens on test setup
    * We probably want to explicitly test this too
* 3-2	Able to modify a new collection's Collection policies and add Content Models?
    * TODO?
## Audio Content Model - 100%
* 3-3	Able to ingest the test AUDIO sample objects?
    * Covered by audio.feature: "Ingest Audio Sample Object"
* 3-4	Able to upload thumbnail for Audio object?
* 3-5	Able to view / hear an AUDIO object?
* 3-6	Able to download an AUDIO object?
* 3-7	Able to search for newly ingested AUDIO object using Islandora simple search?
* 3-8	Able to edit AUDIO object’s title using the XML form?
* 3-9	Able to search for newly edited AUDIO object’s title using Islandora simple search?
* 3-10	Able to edit the Item Label of an AUDIO object's Properties?
* 3-11	Able to search for newly edited Item Label of an AUDIO object's Properties using Islandora simple search?
* 3-12	Able to edit MODS datastream for AUDIO object?
* 3-13	Able to search for newly edited MODS datastream for AUDIO object using Islandora simple search?
* 3-14	Able to delete TN derivative for AUDIO object?
* 3-15	Able to regenerate all derivatives for AUDIO object?
## Basic Image Content Model - 100%
3-16	Able to ingest these test BASIC IMAGE sample objects?
3-17	Able to view a BASIC IMAGE object?
3-18	Able to download a BASIC IMAGE object?
3-19	Able to search for newly ingested BASIC IMAGE object using Islandora simple search?
3-20	Able to edit BASIC IMAGE object’s title using the XML form?
3-21	Able to search for newly edited BASIC IMAGE object’s title using Islandora simple search?
3-22	Able to edit the Item Label of an BASIC IMAGE object's Properties?
3-23	Able to search for newly edited Item Label of an BASIC IMAGE object's Properties using Islandora simple search?
3-24	Able to edit MODS datastream for BASIC IMAGE object?
3-25	Able to search for newly edited MODS datastream for BASIC IMAGE object using Islandora simple search?
3-26	Able to delete TN derivative for BASIC IMAGE object?
3-27	Able to regenerate all derivatives for BASIC IMAGE object?
## Book Content Model - 100%
3-28	Able to ingest these test BOOK sample objects?
3-29	Able to view a BOOK object?
3-30	Able to download a BOOK object?
3-31	Able to search for newly ingested BOOK object using Islandora simple search?
3-32	Able to edit BOOK object’s title using the XML form?
3-33	Able to search for newly edited BOOK object’s title using Islandora simple search?
3-34	Able to edit the Item Label of an BOOK object's Properties?
3-35	Able to search for newly edited Item Label of an BOOK object's Properties using Islandora simple search?
3-36	Able to edit MODS datastream for BOOK object?
3-37	Able to search for newly edited MODS datastream for BOOK object using Islandora simple search?
3-38	Able to delete TN derivative for BOOK object?
3-39	Able to regenerate all derivatives for BOOK object?
## Compound Object Content Model - 60%
3-40	Able to ingest these test COMPOUND OBJECT sample objects?
3-41	Able to view a COMPOUND OBJECT object?
3-42	Able to download a COMPOUND OBJECT object?
3-43	Able to search for newly ingested COMPOUND OBJECT object using Islandora simple search?
3-44	Able to edit COMPOUND OBJECT object’s title using the XML form?
3-45	Able to search for newly edited COMPOUND OBJECT object’s title using Islandora simple search?
3-46	Able to edit the Item Label of an COMPOUND OBJECT object's Properties?
3-47	Able to search for newly edited Item Label of an COMPOUND OBJECT object's Properties using Islandora simple search?
3-48	Able to edit MODS datastream for COMPOUND OBJECT object?
3-49	Able to search for newly edited MODS datastream for COMPOUND OBJECT object using Islandora simple search?
3-50	Able to delete TN derivative for COMPOUND OBJECT object?
3-51	Able to regenerate all derivatives for COMPOUND OBJECT object?
* Intentionally not done
    * Testing viewers - this is theme dependent. All we do is ingest and test relationships

## Large Image Content Model - 100%
3-52	Able to ingest these test LARGE IMAGE sample objects?
3-53	Able to view a LARGE IMAGE object?
3-54	Able to download a LARGE IMAGE object?
3-55	Able to search for newly ingested LARGE IMAGE object using Islandora simple search?
3-56	Able to edit LARGE IMAGE object’s title using the XML form?
3-57	Able to search for newly edited  LARGE IMAGE object’s title using Islandora simple search?
3-58	Able to edit the Item Label of an LARGE IMAGE object's Properties?
3-59	Able to search for newly edited Item Label of an LARGE IMAGE object's Properties using Islandora simple search?
3-60	Able to edit MODS datastream for LARGE IMAGE object?
3-61	Able to search for newly edited MODS datastream for LARGE IMAGE object using Islandora simple search?
3-62	Able to delete TN derivative for LARGE IMAGE object?
3-63	Able to regenerate all derivatives for LARGE IMAGE object?
## Newspaper Content Model - 100%
3-64	Able to ingest these test NEWSPAPER sample objects?
3-65	Able to view a NEWSPAPER object?
3-66	Able to download a NEWSPAPER object?
3-67	Able to search for newly ingested NEWSPAPER object using Islandora simple search?
3-68	Able to edit NEWSPAPER object’s title using the XML form?
3-69	Able to search for newly edited NEWSPAPER object’s title using Islandora simple search?
3-70	Able to edit the Item Label of an NEWSPAPER object's Properties?
3-71	Able to search for newly edited Item Label of an NEWSPAPER object's Properties using Islandora simple search?
3-72	Able to edit MODS datastream for NEWSPAPER object?
3-73	Able to search for newly edited MODS datastream for NEWSPAPER object using Islandora simple search?
3-74	Able to delete TN derivative for NEWSPAPER object?
3-75	Able to regenerate all derivatives for NEWSPAPER object?
## Oral History Content Model (TODO?)
3-76	Able to ingest these test ORAL HISTORY sample objects?
3-77	Able to view a ORAL HISTORY object?
3-78	Able to download a ORAL HISTORY object?
3-79	Able to search for newly ingested ORAL HISTORY object using Islandora simple search?
3-80	Able to edit ORAL HISTORY object’s title using the XML form?
3-81	Able to search for newly edited ORAL HISTORY object’s title using Islandora simple search?
3-82	Able to edit the Item Label of an ORAL HISTORY object's Properties?
3-83	Able to search for newly edited Item Label of an ORAL HISTORY object's Properties using Islandora simple search?
3-84	Able to edit MODS datastream for ORAL HISTORY object?
3-85	Able to search for newly edited MODS datastream for ORAL HISTORY object using Islandora simple search?
3-86	Able to delete TN derivative for ORAL HISTORY object?
3-87	Able to regenerate all derivatives for ORAL HISTORY object?
## PDF Content Model - 100%
3-88	Able to ingest these test PDF sample objects?
3-89	Able to view a PDF object?
3-90	Able to download a PDF object?
3-91	Able to search for newly ingested PDF object using Islandora simple search?
3-92	Able to edit PDF object’s title using the XML form?
3-93	Able to search for newly edited PDF object’s title using Islandora simple search?
3-94	Able to edit the Item Label of an PDF object's Properties?
3-95	Able to search for newly edited Item Label of an PDF object's Properties using Islandora simple search?
3-96	Able to edit MODS datastream for PDF object?
3-97	Able to search for newly edited MODS datastream for PDF object using Islandora simple search?
3-98	Able to delete TN derivative for PDF object?
3-99	Able to regenerate all derivatives for PDF object?
## Video Content Model - 100%
3-100	Able to ingest these test VIDEO sample objects?
3-101	Able to view a VIDEO object?
3-102	Able to download a VIDEO object?
3-103	Able to search for newly ingested VIDEO object using Islandora simple search?
3-104	Able to edit VIDEO object’s title using the XML form?
3-105	Able to search for newly edited VIDEO object’s title using Islandora simple search?
3-106	Able to edit the Item Label of an VIDEO object's Properties?
3-107	Able to search for newly edited Item Label of an VIDEO object's Properties using Islandora simple search?
3-108	Able to edit MODS datastream for VIDEO object?
3-109	Able to search for newly edited MODS datastream for VIDEO object using Islandora simple search?
3-110	Able to replace MODS datastreams
3-111	Able to search for newly replaced MODS datastreams using Islandora simple search?
3-112	Able to delete TN derivative for VIDEO object?
3-113	Able to regenerate all derivatives for VIDEO object?
## WARC Content Model (TODO?)
3-114	Able to ingest these test WEB ARCHIVE sample objects?
3-115	Able to view a WEB ARCHIVE object?
3-116	Able to download a WEB ARCHIVE object?
3-117	Able to search for newly ingested WEB ARCHIVE object using Islandora simple search?
3-118	Able to edit WEB ARCHIVE object’s title using the XML form?
3-119	Able to search for newly edited WEB ARCHIVE object’s title using Islandora simple search?
3-120	Able to edit the Item Label of an WEB ARCHIVE object's Properties?
3-121	Able to search for newly edited Item Label of an WEB ARCHIVE object's Properties using Islandora simple search?
3-122	Able to edit MODS datastream for WEB ARCHIVE object?
3-123	Able to search for newly edited MODS datastream for WEB ARCHIVE object using Islandora simple search?
3-124	Able to delete TN derivative for WEB ARCHIVE object?
3-125	Able to regenerate all derivatives for WEB ARCHIVE object?

# MAINTENANCE TASKS
4-1	Able to view the expected number of data objects?
4-2	Able to run Drupal cron manuall as signed in user?
4-3	Confirm that Drupal cron runs automatically as scheduled?
4-4	Able to view / tail logs from within containers
4-5	Able to view / tail logs on Host server?
4-6	Able to run a Solr search from website and find ingested objects?
4-7	Able to reindex / rebuild Fedora RI?
4-8	Able to reindex / rebuild Fedora db MYSQL?
4-9	Able to reindex SOLR?
	
# Additional Testing
5-1	Able to create single host server with multi-sites (link to Ben's instructions)
5-2	Able to use mounts instead of Docker volumes
5-3	Able to create new config directories for services
## FEDORA - Able to overide existing settings for: 
5-4	      - ./config/fedora/akubra-llstore.xml:/usr/local/fedora/server/config/spring/akubra-llstore.xml (Allows for deeper hash directories for larger Fedora collections)
5-5	foxmltoSolr.xslt
5-6	islandora_transforms

## SOLR - Able to overide existing settings for: 
5-7	schema.xml
5-8	solrconfig.xml
5-9 	Use IMI for sample ingest testing to speed things up
5-10	Test bind mounting - with nested ancestors set to true foxmltoSolr.xslt and all islandora_transforms, along with solrconfig and schemas