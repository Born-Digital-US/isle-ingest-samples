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

run_islandora_tests()
{
  php behat --verbose
  # also run Drupal and Islandora test suites
}

if [ "$RUN_INSTRUCTS" = "all" ]; then
  run_service_tests
  run_islandora_tests
fi

if [ "$RUN_INSTRUCTS" = "services" ]; then
  run_service_tests
fi
# service tests first

# apache / islandora tests last
if [ "$RUN_INSTRUCTS" = "islandora" ]; then
  run_islandora_tests
fi
