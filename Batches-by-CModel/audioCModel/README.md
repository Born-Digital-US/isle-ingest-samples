How to ingest using drush



```bash
# Modify the scan target as appropriate.
drush -u 1 islandora_batch_scan_preprocess --type=directory --scan_target=/var/www/html/sites/default/files/bd-samples/Batches-by-CModel/audioCModel/files --namespace=samples --parent=samples:collection --content_models=islandora:sp-audioCModel
drush -u 1 islandora_batch_ingest
```