#!/bin/bash

RUN_INSTRUCTS=default

for i in "$@"
do
case $i in
    -r=*|--run=*)
    RUN_INSTRUCTS="${i#*=}"
    shift # past argument=value
    ;;

    *)
          # unknown option
    ;;
esac
done
echo "RUN INSTRUCTIONS  = ${RUN_INSTRUCTS}"

run_service_tests()
{
  php behat --profile=traefik --verbose
  php behat --profile=portainer --verbose
  php behat --profile=mysql --verbose
  php behat --profile=solr --verbose
  php behat --profile=fedora --verbose
  php behat --profile=imageservices --verbose
}

run_apache_tests()
{
  php behat --verbose
}

run_drupal_tests()
{
  cd /var/www/html
  php scripts/run-tests.sh --clean
  php scripts/run-tests.sh --url http://apache --all --color --verbose
  cd /var/www/html/sites/behat
}

run_islandora_tests()
{
  cd /var/www/html
  php scripts/run-tests.sh --clean
  php scripts/run-tests.sh --url http://apache --color --verbose --directory sites/all/modules/islandora
  cd /var/www/html/sites/behat
}

if [ "$RUN_INSTRUCTS" = "all" ]; then
  run_service_tests
  run_apache_tests
  # also run Drupal and Islandora test suites
  run_drupal_tests
  run_islandora_tests
elif [ "$RUN_INSTRUCTS" = "services" ]; then
  run_service_tests
elif [ "$RUN_INSTRUCTS" = "apache" ]; then
  run_apache_tests
elif [ "$RUN_INSTRUCTS" = "islandora" ]; then
  run_islandora_tests
elif [ "$RUN_INSTRUCTS" = "drupal" ]; then
  run_drupal_tests
else
  echo "Please run this command with --run=[all,services,islandora,drupal]"
  echo "'services' and 'behat' are both behat suites"
  echo "'islandora' runs all PHPUnit tests for islandora modules (SLOW)"
  echo "'drupal' runs all PHPUnit tests for Drupal and all modules (VERY SLOW)"
fi
