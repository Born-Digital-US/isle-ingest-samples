How to ingest books using drush



```bash
# Modify the scan target as appropriate.
drush -u 1 islandora_book_batch_preprocess --type=directory --scan_target=/var/www/html/sites/default/files/bd-samples/Batches-by-CModel/bookCModel --namespace=samples --parent=samples:collection
drush -u 1 islandora_batch_ingest
```