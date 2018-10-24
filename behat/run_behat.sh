#! bin/bash

TODAY=`date '+%Y_%m_%d__%H_%M_%S'`;

HUB_SELENIUM_PATH="/usr/local/bin/selenium-server-standalone.jar"
HUB_BEHAT_PATH="/var/www/html/sites/behat"
HUB_BEHAT_RESULTS_FILE="$HUB_BEHAT_PATH/results/$HUB_BEHAT_PROFILE-$TODAY.txt"

if [ "$1" != "" ]; then
    HUB_BEHAT_PROFILE="$1"
else
    echo "No behat profile name provided. Assuming \"default\""
    HUB_BEHAT_PROFILE="default"
fi

selenium_start() {
  echo "Starting selenium"
  sh -c 'java -jar $HUB_SELENIUM_PATH -Wdriver.chrome.driver=/usr/local/bin/chromedriver > /dev/null 2>&1 &'

  echo "Waiting 10 seconds for selenium server to start on hub"
  sleep 10s

}
selenium_stop() {
 echo "Stopping selenium"
 kill $(ps -eo pid,command | grep "java -jar $HUB_SELENIUM_PATH" | grep -v grep | awk '{print $1}')
}


selenium_start

echo "Commencing behat tests using the profile \"$HUB_BEHAT_PROFILE\""
cd $HUB_BEHAT_PATH
php behat --profile=$HUB_BEHAT_PROFILE | tee $HUB_BEHAT_RESULTS_FILE

selenium_stop
