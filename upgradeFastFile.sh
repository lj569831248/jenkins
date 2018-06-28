#!/bin/bash

baseAppleIdentifier="APPLE_ID=tydinfo@tydtech.com"
baseAppName="APP_NAME=droiautoapp"
baseBundleId="BUNDLE_ID=com.droi.droiautoapp"
baseTeamId="TEAM_ID=5K93T4P36N"
basePsw="FASTLANE_PASSWORD=Joseph17969213"

if [ $# -eq 5 ] ;then

	bundleid="BUNDLE_ID="$1""
    appname="APP_NAME="$2""
    appleid="APPLE_ID="$3""
    teamid="TEAM_ID="$4""
	applepsw="FASTLANE_PASSWORD="$5""
	sed -i "" 's/'"$baseBundleId"'/'"$bundleid"'/g' fastlane/.env
    sed -i "" 's/'"$baseAppName"'/'"$appname"'/g' fastlane/.env
	sed -i "" 's/'"$baseAppleIdentifier"'/'"$appleid"'/g' fastlane/.env
	sed -i "" 's/'"$baseTeamId"'/'"$teamid"'/g' fastlane/.env
	sed -i "" 's/'"$basePsw"'/'"$applepsw"'/g' fastlane/.env

elif [ $# -eq 0 ];then
	echo "use default env"
else
	exit -1	
fi
