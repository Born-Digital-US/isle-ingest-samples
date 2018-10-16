How to ingest newspaper issues using drush



```bash
# Modify the scan target as appropriate.
drush -u 1 islandora_newspaper_batch_preprocess --type=directory --scan_target=/var/www/html/sites/default/files/bd-samples/Batches-by-CModel/newspaperIssues --namespace=samples --parent=samples:newspaper --content_models=islandora:newspaperIssueCModel --aggregate_ocr
drush -u 1 islandora_batch_ingest
```