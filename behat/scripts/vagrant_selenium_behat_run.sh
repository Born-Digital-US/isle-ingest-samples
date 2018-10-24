#! bin/bash

TODAY=`date '+%Y_%m_%d__%H_%M_%S'`;

HUB_SELENIUM_PATH="/home/islandora/selenium/selenium-server-standalone-2.53.1.jar"
HUB_DOMAIN="compass-vagrant.fivecolleges.edu"
HUB_URI_PROTOCOL="http://"
HUB_USER="islandora"
HUB_BEHAT_PATH="/var/www/html/sites/behat"
HUB_BEHAT_PROFILE="vagrant_pat"
HUB_BEHAT_RESULTS_FILE="/var/www/html/sites/behat/results/$HUB_BEHAT_PROFILE-$TODAY.txt"

NODE_SELENIUM_PATH="/Users/pat/Sites/Selenium/selenium-server-standalone-2.53.1.jar"
NODE_DOMAIN="localhost"
NODE_USER="pat"


echo "Starting selenium hub on $HUB_DOMAIN"
ssh -n -f $HUB_USER@$HUB_DOMAIN "sh -c 'nohup java -jar $HUB_SELENIUM_PATH  -role hub > /dev/null 2>&1 &'"

echo "Waiting 10 seconds for selenium server to start on hub"
sleep 10s

echo "Starting selenium node on $NODE_DOMAIN"
ssh -n -f $NODE_USER@$NODE_DOMAIN "sh -c 'nohup java -jar $NODE_SELENIUM_PATH -role node -hub $HUB_URI_PROTOCOL$HUB_DOMAIN:4444/grid/register > /dev/null 2>&1 &'"

echo "Waiting 10 seconds for selenium server to start on node"
sleep 10s


echo "Commencing behat tests using the profile \"$HUB_BEHAT_PROFILE\""
ssh $HUB_USER@$HUB_DOMAIN "cd $HUB_BEHAT_PATH; php behat --profile=$HUB_BEHAT_PROFILE | tee $HUB_BEHAT_RESULTS_FILE; exit;"


echo "Killing selenium-server on node"
ssh -n -f $NODE_USER@$NODE_DOMAIN "kill \$(ps -eo pid,command | grep \"java -jar $NODE_SELENIUM_PATH -role node\" | grep -v grep | awk '{print \$1}')"

echo "Killing selenium-server on hub"
ssh -n -f $HUB_USER@$HUB_DOMAIN "kill \$(ps -eo pid,command | grep \"java -jar $HUB_SELENIUM_PATH -role hub\" | grep -v grep | awk '{print \$1}')"

echo "Done. View results at $HUB_DOMAIN:$HUB_BEHAT_RESULTS_FILE"
