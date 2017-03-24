#!/usr/bin/env bash
# save it as /usr/local/bin/notify_about_attack.sh

# @halbebruno - Via Livre

USERID="<USERID>"
KEY="<BOT_KEY>"
TIMEOUT="10"
URL="https://api.telegram.org/bot$KEY/sendMessage"


# This script will get following params:
#  $1 client_ip_as_string
#  $2 data_direction
#  $3 pps_as_string
#  $4 action (ban or unban)

#
# Please be carefult! You should not remove cat >
#

if [ "$4" = "unban" ]; then
    # No details arrived to stdin here

    # Unban actions if used
    exit 0
fi

#
# For ban and attack_details actions we will receive attack details to stdin
# if option notify_script_pass_details enabled in FastNetMon's configuration file
# 
# If you do not need this details, please set option notify_script_pass_details to "no".
#
# Please do not remove "cat" command if you have notify_script_pass_details enabled, because
# FastNetMon will crash in this case (it expect read of data from script side).
#

if [ "$4" = "ban" ]; then
    cat | curl -s --max-time $TIMEOUT -d "chat_id=$USERID&disable_web_page_preview=1&text=FastNetMon Guard: IP $1 blocked because $2 attack with power $3 pps" $URL > /dev/null ;
    # You can add ban code here!
    exit 0
fi

if [ "$4" == "attack_details" ]; then
    cat | curl -s --max-time $TIMEOUT -d "chat_id=$USERID&disable_web_page_preview=1&text=FastNetMon Guard: IP $1 blocked because $2 attack with power $3 pps" $URL > /dev/null ;

    exit 0
fi
