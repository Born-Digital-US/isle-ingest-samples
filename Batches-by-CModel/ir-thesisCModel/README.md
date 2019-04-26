How to ingest using drush



```bash
# Modify the scan target as appropriate.
drush -u 1 islandora_batch_scan_preprocess --type=directory --scan_target=/var/www/html/sites/default/files/bd-samples/Batches-by-CModel/ir-thesisCModel/files --namespace=samples --parent=samples:collection --content_models=ir:thesisCModel
drush -u 1 islandora_batch_ingest
```