# Born-Digital Sample IMI Test Set

## Contents

* Test Collection IMI set
  * testCol.csv
  * testCol-tn.png.zip
* Items to populate test collection IMI set
  * IMI_data.csv
  * IMIasset_files.zip
* TWIG Template (_source: Metropolitan New York Library Council (Metro)_)
  * [mods_twig_base.txt](https://raw.githubusercontent.com/mnylc/dcmny/master/twig/mods_twig_base.html)

### Requirements

* [Islandora Multi Importer Module](https://github.com/mnylc/islandora_multi_importer)

  * This module requires the following dependencies i.e. software/modules/libraries:
    * [Composer](https://getcomposer.org/)
    * [Islandora](https://github.com/islandora/islandora)  
    * [Tuque](https://github.com/islandora/tuque)
    * [Islandora Basic Collection](https://github.com/Islandora/islandora_solution_pack_collection)


  * Installation for **non-ISLE** sites, follow the **Installation** section / process of that repo's README.md
    * `cd /var/www/html/sites/all/islandora`

    * `git clone https://github.com/mnylc/islandora_multi_importer.git`

    * `cd islandora_multi_importer`

    * `composer install`

  * Installation for a running **ISLE** site with an installed and active Drupal site
    * Open a terminal and navigate to the ISLE project Repository directory and then run this command:
```
docker exec -i isle-apache-ld sh -c 'cd /var/www/html/sites/all/modules/islandora && git clone https://github.com/mnylc/islandora_multi_importer.git && chown -Rv islandora:www-data islandora_multi_importer && cd /var/www/html/sites/all/modules/islandora/islandora_multi_importer && composer install && drush en -y islandora_multi_importer'
```

### Ingest Process

#### Assumptions
* `Islandora simple search` is setup as the `Sidebar first` block instead of the default `Drupal search form`. this is to test searching on object metadata and additional values if using a default un-themed Drupal site.

* The `PDF.js` viewer is enabled within the PDF Solution Pack.

#### 1. Create the Test Collection

* In the Drupal site, Navigation section on the left, click the `Multi Import Objects` link

* In the `Choose your Data source type` dropdown, select `Spreadsheet File to be uploaded` aka a `.csv file` and click the `Next` button.

* Click the `Choose File` button and select the csv file: `testCol.csv` and then click the `Upload` button.

* Click the `Preprocess` button

* In the `Your data` tab, toggle / click the `Preview submited...` drop-down to verify there’s data in your rows

* Go to the `Templating` tab:

  * If there is not yet a twig template:

      * Delete the sample `{% block content %} Hello {{ name }}{% endblock %}` from the `Twig Template Input` field.

      * Copy and paste the `mods_twig_base.txt` template text into the template text area.

      * Within the `Manage your templates` section at the bottom, click the `Save Template As`

      * Enter a new name e.g. `bd_mods_template` in the `Name for your new template` field and then click the `Save Template` button. A green check mark will indicate a successful save.

  * Else if there is a preexisting twig template -select the previously saved template.

* Go to the `CMODEL Mapping` tab:

  * Select from the drop-down list; `cmodel` and click the `Check CMODELS` button.

  * A block of drop-downs should appear for each CModel you have in your input (.csv)
      * DC - `default XSLT`

      * TN - select `tn`

* Go to the `Object Properties Tab` and within the `Source Field Mapping` table:

  * Set `Object Pid` to `collection_pid` and **uncheck** the checkbox for `Check to let Islandora build PID...`

  * Set `Parent Object` to `parent` and leave checkbox **checked** for `If value is not a well formed PID...`

  * Set `Object Label` to `title`

  * Set `Sequence and Ordering` to `collection_pid` (_most likely default_)

  * Set `Remote DS sources` to `ZIP`

* Leave the `What Type of Batch Action…` as it is (`ingest new objects`) (_most likely default_)

* Click on the `Ingest` button

* Click the `Choose File` button and select the zip file: `testCol-tn.png.zip` and the click the `Upload` button.

  * **Please note:** There will be this warning `For security reasons, your upload has been renamed to testCol-tn.png_.zip.` Ignore it.


* Click the `Ingest` button

* Now you should see a green message box e.g. `You are all set( id = 1)!` with a set ID that is a link. Click on the `id = ` link.

* The `Set __ Batch Queue` prompt / overlay should appear. Click on the link: `Process Set`

* Click on the `Start Batch Processing` button

* You should see `Processing complete` message.

* Click on the `home` icon at the top left hand of the site to get back to the homepage.

* Within the `Navigation` links, click on `Islandora Repository`.

* Within the list of collections you should see your new `Test Collection` with a witty thumbnail icon. Click on the icon.

* To set the CMODELS for this collection, click on the `Manage` tab.

* Go to the `Collection` sub-tab, then to the `Manage Collection Policy` sub-tab (_should be there by default_) and then check **ALL** the check boxes within the `About Collection Policies` table to the right.

* Click the `Update Collection Policy` button. A green checkmark message `updated collection policy...` should appear.

---

#### Ingest the sample objects to the Test Collection

* In the Drupal site, Navigation section on the left, click the `Multi Import Objects` link

* In the `Choose your Data source type` dropdown, select `Spreadsheet File to be uploaded` aka a `.csv file` and click the `Next` button.

* Click the `Choose File` button and select the csv file: `IMI_data.csv` and then click the `Upload` button.

* Click the `Preprocess` button

* In the `Your data` tab, toggle / click the `Preview submited...` drop-down to verify there’s data in your rows

* Go to the `Templating` tab:

    * From the `Load existing template` drop-down,  select the previously saved template e.g. `bd_mods_template`

* Go to the `CMODEL Mapping` tab and select from the drop-down list; `cmodel` and click the `Check CMODELS` button. A block of drop-downs should appear for each CModel you have in your input (.csv)

* `islandora:sp_large_image_cmodel`
  * DC -  `default XSLT`
  * MODS - at the bottom of the menu - under `Use Twig Template` choose template created above e.g. `bd_mods_template` e.g. `bd_mods_template`
  * OBJ - `obj_file`
  * TN - at the bottom under `Derivatives` choose `Build using derivative from OBJ`
  * JPG - at the bottom under `Derivatives` choose `Build using derivative from OBJ`
  * JP2 - at the bottom under `Derivatives` choose `Build using derivative from OBJ`


* `islandora:sp-audioCModel`
  * DC - `default XSLT`
  * MODS - at the bottom of the menu - under `Use Twig Template` choose template created above e.g. `bd_mods_template` e.g. `bd_mods_template`
  * OBJ - `obj_file`
  * Proxy_mp3 - at the bottom under `Derivatives` choose `Build using derivative from OBJ`
  * TN - `tn`


* `islandora:compoundCModel`
  * DC - `default XSLT`
  * MODS - at the bottom of the menu - under `Use Twig Template` choose template created above e.g. `bd_mods_template` e.g. `bd_mods_template`
  * OBJ - `obj_file`
  * TN - `tn`


* `islandora:bookCModel`
  * DC - `default XSLT`
  * MODS - at the bottom of the menu - under `Use Twig Template` choose template created above e.g. `bd_mods_template` e.g. `bd_mods_template`
  * TN - `tn`
  * PDF - `obj_file`


* `islandora:pageCModel`
  * DC - `default XSLT`
  * MODS - at the bottom of the menu - under `Use Twig Template` choose template created above e.g. `bd_mods_template`
  * OBJ - `obj_file`
  * JP2 - at the bottom under `Derivatives` choose `Build using derivative from OBJ`
  * TN - at the bottom under `Derivatives` choose `Build using derivative from OBJ`
  * JPG - at the bottom under `Derivatives` choose `Build using derivative from OBJ`
  * OCR - at the bottom under `Derivatives` choose `Build using derivative from OBJ`
  * HOCR - at the bottom under `Derivatives` choose `Build using derivative from OBJ`


* `islandora:sp_basic_image`
  * DC - `default XSLT`
  * MODS - at the bottom of the menu - under `Use Twig Template` choose template created above e.g. `bd_mods_template`
  * OBJ - `obj_file`
  * TN - at the bottom under `Derivatives` choose `Build using derivative from OBJ`
  * Medium_Size - at the bottom under `Derivatives` choose `Build using derivative from OBJ`


* `islandora:newspaperCModel`
  * DC - `default XSLT`
  * MODS - at the bottom of the menu - under `Use Twig Template` choose template created above e.g. `bd_mods_template`
  * TN - `tn`


* `islandora:newspaperIssueCModel`
  * DC - `default XSLT`
  * MODS - at the bottom of the menu - under `Use Twig Template` choose template created above e.g. `bd_mods_template`
  * TN - `line-no` (_this is to make it ignore the TN since this is not req._)


* `islandora:newspaperPageCModel`
  * DC - `default XSLT`
  * MODS - at the bottom of the menu - under `Use Twig Template` choose template created above e.g. `bd_mods_template`
  * OBJ - `obj_file`
  * JP2 -  at the bottom under `Derivatives` choose `Build using derivative from OBJ`
  * TN - at the bottom under `Derivatives` choose `Build using derivative from OBJ`
  * JPG - at the bottom under `Derivatives` choose `Build using derivative from OBJ`
  * OCR - at the bottom under `Derivatives` choose `Build using derivative from OBJ`
  * HOCR - at the bottom under `Derivatives` choose `Build using derivative from OBJ`


* `islandora:sp_pdf`
  * DC - `default XSLT`
  * MODS - at the bottom of the menu - under `Use Twig Template` choose template created above e.g. `bd_mods_template`
  * OBJ - `obj_file`
  * PDFA - `obj_file`
  * Full_text - at the bottom under `Derivatives` choose `Build using derivative from OBJ`
  * TN - at the bottom under `Derivatives` choose `Build using derivative from OBJ`
  * Preview - at the bottom under `Derivatives` choose `Build using derivative from OBJ`


* `islandora:sp_videoCModel`
  * DC - `default XSLT`
  * MODS - at the bottom of the menu - under `Use Twig Template` choose template created above e.g. `bd_mods_template`
  * OBJ - `obj_file`
  * TN - at the bottom under `Derivatives` choose `Build using derivative from OBJ`
  * OGG - `obj_file`
  * MKV - at the bottom under `Derivatives` choose `Build using derivative from OBJ`
  * TECHMD_FITS - `line-no` (_to ignore_)
  * MP4 - `obj-file`


* Go to the `Object Properties Tab` and within the `Source Field Mapping` table:

  * Set `Object Pid` to `line-no` and leave checkbox **checked** for `Check to let Islandora build PID...`

  * Set `Parent Object` to `parent` and leave checkbox **checked** for `If value is not a well formed PID...`

  * Set `Object Label` to `title`

  * Set `Sequence and Ordering` to `line-no` (_most likely default_)

  * Set `Remote DS sources` to `ZIP`

* Click the `Ingest` button

* Click the `Choose File` button and select the zip file: `IMIasset_files.zip` and the click the `Upload` button.

* Click the `Ingest` button

* Now you should see a green message box e.g. `You are all set( id = 2)!` with a set ID that is a link and the message `54 Object added successfully to set`. Click on the `id = ` link.

* The `Set __ Batch Queue` prompt / overlay should appear. Click on the link: `Process Set`

* Click on the `Start Batch Processing` button. Wait - this takes a while... (_20 - 30 mins or more depending on the speed of your system._)

* You should see `Processing complete` message.

* Click on the `home` icon at the top left hand of the site to get back to the homepage.

* Within the `Navigation` links, click on `Islandora Repository`.

* Within the list of collections you should see your new `Test Collection` the witty thumbnail icon. Click on the icon to enter that collection and verify that all your objects are present.
