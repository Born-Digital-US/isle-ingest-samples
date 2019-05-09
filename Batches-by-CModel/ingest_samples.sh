#!/usr/bin/env bash

# Usage:
# sh /path/to/this/script /path/to/drupal/root

if [  -z "$1" ]; then
    echo "Error: path to drupal root must be provided when calling this script"
    echo "Example usage: sh ingest_samples.sh /var/www/html"
    exit 1
fi

DRUPAL_ROOT=$1
RUN_NEWSPAPERS_ONLY=$2

if [ ! -d "$DRUPAL_ROOT" ]; then
    echo "The path provided for the drupal root does not exist"
    exit 1
fi


# Get the path of this script file, which is in the parent directory for each batch ingest set
SCRIPT_DIR="$( cd "$(dirname "$0")" ; pwd -P )"

cd $DRUPAL_ROOT

echo "Ingesting the \"ICG Samples\" collection to hold everything else."
drush -u 1 islandora_batch_with_derivs_preprocess --key_datastream=MODS --scan_target=$SCRIPT_DIR/Collections/files --use_pids=true --namespace=samples --parent=islandora:root --content_models=islandora:collectionCModel
drush -u 1 islandora_batch_ingest

echo "Ingesting the newspaper object which needs to exist before ingesting issues."
drush -u 1 islandora_batch_with_derivs_preprocess --key_datastream=MODS --scan_target=$SCRIPT_DIR/Newspaper/files --use_pids=true --namespace=samples --parent=samples:collection --content_models=islandora:newspaperCModel
drush -u 1 islandora_batch_ingest

echo "Ingesting audio content"
drush -u 1 islandora_batch_scan_preprocess --type=directory --scan_target=$SCRIPT_DIR/audioCModel/files/1 --namespace=samples --parent=samples:collection --content_models=islandora:sp-audioCModel
# why are we doing batches of one, you ask? because we were getting random PID assignments which made testing difficult and we wanted to control the order
drush -u 1 islandora_batch_scan_preprocess --type=directory --scan_target=$SCRIPT_DIR/audioCModel/files/2 --namespace=samples --parent=samples:collection --content_models=islandora:sp-audioCModel
drush -u 1 islandora_batch_scan_preprocess --type=directory --scan_target=$SCRIPT_DIR/audioCModel/files/3 --namespace=samples --parent=samples:collection --content_models=islandora:sp-audioCModel
drush -u 1 islandora_batch_ingest

echo "Ingesting basic image content"
drush -u 1 islandora_batch_scan_preprocess --type=directory --scan_target=$SCRIPT_DIR/basicImageCModel/files/1 --namespace=samples --parent=samples:collection --content_models=islandora:sp_basic_image
drush -u 1 islandora_batch_scan_preprocess --type=directory --scan_target=$SCRIPT_DIR/basicImageCModel/files/2 --namespace=samples --parent=samples:collection --content_models=islandora:sp_basic_image
drush -u 1 islandora_batch_scan_preprocess --type=directory --scan_target=$SCRIPT_DIR/basicImageCModel/files/3 --namespace=samples --parent=samples:collection --content_models=islandora:sp_basic_image
drush -u 1 islandora_batch_ingest

echo "Ingesting book content"
drush -u 1 islandora_book_batch_preprocess --type=directory --scan_target=$SCRIPT_DIR/bookCModel/files --namespace=samples --parent=samples:collection
drush -u 1 islandora_book_batch_preprocess --type=directory --scan_target=$SCRIPT_DIR/bookCModel/files2 --namespace=samples --parent=samples:collection
drush -v -u 1 islandora_batch_ingest

echo "Ingesting compound content"
drush -u 1 islandora_compound_batch_preprocess --scan_target=$SCRIPT_DIR/compoundCModel/files --namespace=samples --parent=samples:collection
drush -u 1 islandora_compound_batch_preprocess --scan_target=$SCRIPT_DIR/compoundCModel/files2 --namespace=samples --parent=samples:collection
drush -u 1 islandora_compound_batch_preprocess --scan_target=$SCRIPT_DIR/compoundCModel/files3 --namespace=samples --parent=samples:collection
drush -u 1 islandora_batch_ingest

echo "Ingesting large images"
drush -u 1 islandora_batch_scan_preprocess --type=directory --scan_target=$SCRIPT_DIR/largeImageCModel/files --namespace=samples --parent=samples:collection --content_models=islandora:sp_large_image_cmodel
drush -u 1 islandora_batch_scan_preprocess --type=directory --scan_target=$SCRIPT_DIR/largeImageCModel/files2 --namespace=samples --parent=samples:collection --content_models=islandora:sp_large_image_cmodel
drush -u 1 islandora_batch_scan_preprocess --type=directory --scan_target=$SCRIPT_DIR/largeImageCModel/files3 --namespace=samples --parent=samples:collection --content_models=islandora:sp_large_image_cmodel
drush -u 1 islandora_batch_ingest

echo "Ingesting pdf content"
drush -u 1 islandora_batch_scan_preprocess --type=directory --scan_target=$SCRIPT_DIR/pdfCModel/files --namespace=samples --parent=samples:collection --content_models=islandora:sp_pdf
drush -u 1 islandora_batch_scan_preprocess --type=directory --scan_target=$SCRIPT_DIR/pdfCModel/files2 --namespace=samples --parent=samples:collection --content_models=islandora:sp_pdf
drush -u 1 islandora_batch_scan_preprocess --type=directory --scan_target=$SCRIPT_DIR/pdfCModel/files3 --namespace=samples --parent=samples:collection --content_models=islandora:sp_pdf
drush -u 1 islandora_batch_ingest

echo "Ingesting video content"
drush -u 1 islandora_batch_scan_preprocess --type=directory --scan_target=$SCRIPT_DIR/videoCModel/files --namespace=samples --parent=samples:collection --content_models=islandora:sp_videoCModel
drush -u 1 islandora_batch_scan_preprocess --type=directory --scan_target=$SCRIPT_DIR/videoCModel/files2 --namespace=samples --parent=samples:collection --content_models=islandora:sp_videoCModel
drush -u 1 islandora_batch_scan_preprocess --type=directory --scan_target=$SCRIPT_DIR/videoCModel/files3 --namespace=samples --parent=samples:collection --content_models=islandora:sp_videoCModel
drush -u 1 islandora_batch_ingest

echo "Ingesting citation content"
drush -u 1 islandora_batch_scan_preprocess --type=directory --scan_target=$SCRIPT_DIR/ir-citationCModel/files --namespace=samples --parent=samples:collection --content_models=ir:citationCModel
drush -u 1 islandora_batch_ingest

drush -u 1 islandora_batch_scan_preprocess --type=directory --scan_target=$SCRIPT_DIR/ir-thesisCModel/files --namespace=samples --parent=samples:collection --content_models=ir:thesisCModel
drush -u 1 islandora_batch_ingest

# 50 minute time limit for FREE travis accounts - skip lengthy newspapers?
if [ CI!=TRUE ] ; then
    echo "Pre-processing newspaper issues. This may take a while..."
    echo "Vol 1 No 7"
    drush -u 1 islandora_newspaper_batch_preprocess --type=directory --scan_target=$SCRIPT_DIR/newspaperIssues/files1 --namespace=samples --parent=samples:newspaper --content_models=islandora:newspaperIssueCModel --aggregate_ocr
    echo "Newspaper batch Vol 1 No 7 pre-processed. Ingesting..."
    drush -v -u 1 islandora_batch_ingest

    echo "Vol 1 No 8"
    drush -u 1 islandora_newspaper_batch_preprocess --type=directory --scan_target=$SCRIPT_DIR/newspaperIssues/files2 --namespace=samples --parent=samples:newspaper --content_models=islandora:newspaperIssueCModel --aggregate_ocr
    echo "Newspaper batch Vol 1 No 8 pre-processed. Ingesting..."
    drush -v -u 1 islandora_batch_ingest
    echo "Vol 2 No 7"
    drush -u 1 islandora_newspaper_batch_preprocess --type=directory --scan_target=$SCRIPT_DIR/newspaperIssues/files3 --namespace=samples --parent=samples:newspaper --content_models=islandora:newspaperIssueCModel --aggregate_ocr
    echo "Newspaper batch Vol 2 No 7 pre-processed. Ingesting..."
    drush -v -u 1 islandora_batch_ingest
fi 
