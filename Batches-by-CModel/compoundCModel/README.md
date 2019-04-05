How to ingest compound objects using drush. 

IMPORTANT: This requires that the islandora_compound_batch module be installed: 
https://github.com/MarcusBarnes/islandora_compound_batch

```bash
# Modify the paths as appropriate.
##### Structure files have already been generated. The next two lines are provided to show
##### how that was done.
##### cd /var/www/html/sites/all/modules/islandora/islandora_compound_batch/extras/scripts
##### php create_structure_files.php /var/www/html/sites/default/files/bd-samples/Batches-by-CModel/compoundCModel

drush -u 1 islandora_compound_batch_preprocess --scan_target=/var/www/html/sites/default/files/bd-samples/Batches-by-CModel/compoundCModel/files --namespace=samples --parent=samples:collection
drush -u 1 islandora_batch_ingest
```