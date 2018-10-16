Use of this ingest set requires the islandora_batch_with_derivs module to be installed and enabled. See instructions at the link below.

- https://github.com/mjordan/islandora_batch_with_derivs

To ingest this set to islandora:root, use the following drush commands:

```bash
# Modify the scan target as appropriate.
drush -u 1 islandora_batch_with_derivs_preprocess --key_datastream=MODS --scan_target=/var/www/html/sites/default/files/bd-samples/Batches-by-CModel/Newspaper --use_pids=true --namespace=samples --parent=samples:collection --content_models=islandora:newspaperCModel
drush -u 1 islandora_batch_ingest 
```