How to ingest using drush



```bash
# Modify the scan target as appropriate.
drush -u 1 islandora_batch_scan_preprocess --type=directory --scan_target=/var/www/html/sites/default/files/bd-samples/Batches-by-CModel/largeImageCModel --namespace=samples --parent=samples:collection --content_models=islandora:sp_large_image_cmodel
drush -u 1 islandora_batch_ingest
```