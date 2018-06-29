#!/bin/bash

bundleid=$1
appname=$2
appleid=$3
teamid=$4
applepsw=$5

#develop
echo "budleId:${bundleid}"
echo "appname:${appname}"
echo "appleid:${appleid}"
echo "teamid:${teamid}"

# if [ $# != 2 ];then
#     echo "first param must be shopid"
#     echo "second param must be app name !"
#     exit -1
# fi

# shopid=$1
# appname=$2
# echo "shopid is : "$shopid
# echo "appname is : "$appname

getappleid(){
	if [ $# != 1 ];then
		echo "first param must be app create log file name!"
		exit -1	
	fi

	create_new=$1
	create_exist=$1
	appid_success=$(grep -r "Connect with ID" $create_new | awk -F "Connect with ID" '{print $2}' | sed 's/ //g')
	appid_exist=$(grep -r "nothing to do on iTunes Connect" $create_exist | awk -F "(" '{print $2}'| awk -F ")" '{print $1}' | sed 's/ //g')

    if [ ${#appid_success} != 0 ];then
		echo $appid_success
	elif [ ${#appid_exist} != 0 ];then
		echo $appid_exist
	else
        echo $1
		exit -1
	fi 
}


 ./upgradeFastFile.sh ${bundleid} ${appname} ${appleid} ${teamid} ${applepsw}
if [ $? != 0 ];then
	echo "upgrade fastfile failed!"
	exit -1
fi
# source baashelper.sh
if [ -f create_ios_app.log ];then
    rm create_ios_app.log
fi
fastlane ios createApp >create_ios_app.log
if [ $? != 0 ];then
	echo "create app failed!!!"
	cat create_ios_app.log
	# upresult=$(updateAppReviewResult ${bundleid} 0 "create app failed in appstore!")
	# if [ $? != 0 ];then
	# 	echo "------update create app result to baas failed."
	# else
	# 	echo "------have update create result to baas."	
	# fi 
	exit -1
else
#	appstoreid=$(echo $result | grep -r "Connect with ID" | awk -F "Connect with ID" '{print $2}' |sed 's/ //g')
	echo "create app success"

	appstoreid=$(getappleid create_ios_app.log)

	if [ $? != 0 ];then
      echo "get appstore id failed,please goto itues to get appStoreid"
	else
        echo "get  app store ID success"
	    if [ ${#appstoreid} != 0 ];then
            echo "appstoreid is : "$appstoreid
            # upresult=$(updateAppID $bundleid $appstoreid)
	        # if [ $? != 0 ];then
            #     echo "create app successed!"
	 	    #     echo "update appstore failed! result: "$upresult
            #     exit -1
	        # else
            #     echo "update appstoreid to appinfo success!"
	        # fi
	    else
            echo "app store id may be wrong!"
            exit -1
        fi
	fi
	fastlane ios get_cer
	fastlane ios getPush
	fastlane ios get_adhoc_profile
	fastlane ios update_info
	fastlane ios set_code_sign
	fastlane ios adhoc
fi

