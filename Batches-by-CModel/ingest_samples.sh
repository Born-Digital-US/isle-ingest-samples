#!/usr/bin/env bash

# Usage:
# sh /path/to/this/script /path/to/drupal/root

if [  -z "$1" ]; then
    echo "Error: path to drupal root must be provided when calling this script"
    echo "Example usage: sh ingest_samples.sh /var/www/html"
    exit 1
fi

DRUPAL_ROOT=$1

if [ ! -d "$DRUPAL_ROOT" ]; then
    echo "The path provided for the drupal root does not exist"
    exit 1
fi


# Get the path of this script file, which is in the parent directory for each batch ingest set
SCRIPT_DIR="$( cd "$(dirname "$0")" ; pwd -P )"

cd $DRUPAL_ROOT

echo "Ingesting the \"ICG Samples\" collection to hold everything else."
drush -u 1 islandora_batch_with_derivs_preprocess --key_datastream=MODS --scan_target=$SCRIPT_DIR/Collections --use_pids=true --namespace=samples --parent=islandora:root --content_models=islandora:collectionCModel
drush -u 1 islandora_batch_ingest

echo "Ingesting the newspaper object which needs to exist before ingesting issues."
drush -u 1 islandora_batch_with_derivs_preprocess --key_datastream=MODS --scan_target=$SCRIPT_DIR/Newspaper --use_pids=true --namespace=samples --parent=samples:collection --content_models=islandora:newspaperCModel
drush -u 1 islandora_batch_ingest

echo "Ingesting audio content"
drush -u 1 islandora_batch_scan_preprocess --type=directory --scan_target=$SCRIPT_DIR/audioCModel --namespace=samples --parent=samples:collection --content_models=islandora:sp-audioCModel
drush -u 1 islandora_batch_ingest

echo "Ingesting basic image content"
drush -u 1 islandora_batch_scan_preprocess --type=directory --scan_target=$SCRIPT_DIR/basicImageCModel --namespace=samples --parent=samples:collection --content_models=islandora:sp_basic_image
drush -u 1 islandora_batch_ingest

echo "Ingesting book content"
drush -u 1 islandora_book_batch_preprocess --type=directory --scan_target=$SCRIPT_DIR/bookCModel --namespace=samples --parent=samples:collection
drush -u 1 islandora_batch_ingest

echo "Ingesting compound content"
drush -u 1 islandora_compound_batch_preprocess --scan_target=$SCRIPT_DIR/compoundCModel --namespace=samples --parent=samples:collection
drush -u 1 islandora_batch_ingest

echo "Ingesting large images"
drush -u 1 islandora_batch_scan_preprocess --type=directory --scan_target=$SCRIPT_DIR/largeImageCModel --namespace=samples --parent=samples:collection --content_models=islandora:sp_large_image_cmodel
drush -u 1 islandora_batch_ingest

echo "Ingesting pdf content"
drush -u 1 islandora_batch_scan_preprocess --type=directory --scan_target=$SCRIPT_DIR/pdfCModel --namespace=samples --parent=samples:collection --content_models=islandora:sp_pdf
drush -u 1 islandora_batch_ingest

echo "Ingesting video content"
drush -u 1 islandora_batch_scan_preprocess --type=directory --scan_target=$SCRIPT_DIR/videoCModel --namespace=samples --parent=samples:collection --content_models=islandora:sp_videoCModel
drush -u 1 islandora_batch_ingest

echo "Ingesting newspaper issues. This may take a while..."
drush -u 1 islandora_newspaper_batch_preprocess --type=directory --scan_target=$SCRIPT_DIR/newspaperIssues --namespace=samples --parent=samples:newspaper --content_models=islandora:newspaperIssueCModel --aggregate_ocr
drush -u 1 islandora_batch_ingest