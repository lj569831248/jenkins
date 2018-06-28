#!/bin/bash

baseAppleIdentifier="tydinfo@tydtech.com"
baseAppName="droiautoapp"
baseBundleId="com.droi.droiautoapp"
baseTeamId="5K93T4P36N"
basePsw="Joseph17969213"

if [ $# -eq 5 ] ;then
	echo "input param is bundleid "
	bundleid=$1
    appname=$2
    appleid=$3
    teamid=$4
	applepsw=$5
	sed -i "" 's/'"$baseBundleId"'/'"$bundleid"'/g' droiautoapp/fastlane/.env
    sed -i "" 's/'"$baseAppName"'/'"$appname"'/g' droiautoapp/fastlane/.env
	sed -i "" 's/'"$baseAppleIdentifier"'/'"$appleid"'/g' droiautoapp/fastlane/.env
	sed -i "" 's/'"$baseTeamId"'/'"$teamid"'/g' droiautoapp/fastlane/.env
	sed -i "" 's/'"$basePsw"'/'"$applepsw"'/g' droiautoapp/fastlane/.env

elif [ $# -eq 0 ];then
	echo "use default env"
else
	exit -1	
fi
