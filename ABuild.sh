BuildConfiguration=Release # 打包Release or Debug
SCHEMENAME=demo      # 项目scheme名
SOURCEPATH=$PWD    # 项目路径


DATE=`date +%Y%m%d_%H%m`
# 打包目标路径
IPAPATH=$SOURCEPATH/autoBuild/$DATE
IPANAME=$SCHEMENAME_$DATE.ipa

#  clean
xcodebuild clean \
-workspace $SOURCEPATH/$SCHEMENAME.xcworkspace \
-scheme ${SCHEMENAME} \
-configuration ${BuildConfiguration}
if [[ $? != 0 ]]; then
    exit
fi


# archive
xcodebuild archive \
-workspace $SOURCEPATH/$SCHEMENAME.xcworkspace \
-scheme ${SCHEMENAME} \
-configuration $BuildConfiguration \
-archivePath $IPAPATH/${SCHEMENAME}.xcarchive

if [ -e $IPAPATH ]; then
    echo "build OK"
else
    echo "build fail"
    exit 1
fi


# 导出 ipa包
xcodebuild -exportArchive \
-archivePath $IPAPATH/${SCHEMENAME}.xcarchive \
-exportPath ${IPAPATH}/${SCHEMENAME} \
-exportOptionsPlist ${SOURCEPATH}/buildScript/AppStoreExportOptions.plist

if [ -e ${IPAPATH}/${SCHEMENAME} ]; then
    osascript -e 'display notification "打包成功！" with title "${IPAPATH}/${SCHEMENAME}"'
    echo "Archive OK"
    open ${IPAPATH}/${SCHEMENAME}
else
    echo "Archive fail"
fi

###################################
#发布到iTunesConnect
###################################
altoolPath="/Applications/Xcode.app/Contents/Applications/Application Loader.app/Contents/Frameworks/ITunesSoftwareService.framework/Versions/A/Support/altool"
appleid=xxx@.163.com
applepassword=xxx

#validate
"$altoolPath" --validate-app \
-f "${IPAPATH}/${SCHEMENAME}/${IPANAME}"\
-u "$appleid"\
-p "$applepassword"\
-t ios \
osascript -e 'display notification "Release To AppStore" with title "Validate Complete!"'

#upload
"$altoolPath" --upload-app \
-f "${IPAPATH}/${SCHEMENAME}/${IPANAME}" \
-u "$appleid" -p "$applepassword" \
-t ios \
--output-format xml
osascript -e 'display notification "Release To AppStore" with title "Upload Complete!"'




