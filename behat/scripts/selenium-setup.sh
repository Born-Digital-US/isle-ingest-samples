TODAY=`date '+%Y_%m_%d__%H_%M_%S'`;
export HUB_BEHAT_PATH=/var/www/html/sites/behat
export HUB_BEHAT_RESULTS_FILE=/var/www/html/sites/behat/results/-.txt
export HUB_SELENIUM_PATH=/usr/local/bin/selenium-server-standalone.jar

selenium_start() {
  echo "Starting selenium"
  sh -c 'nohup java -jar $HUB_SELENIUM_PATH > /dev/null 2>&1 &'

  echo "Waiting 10 seconds for selenium server to start on hub"
  sleep 10s

}

selenium_stop() {
 kill $(ps -eo pid,command | grep "java -jar $HUB_SELENIUM_PATH" | grep -v grep | awk '{print $1}')
}

alias selenium-start="selenium_start"
alias selenium-stop="selenium_stop"
