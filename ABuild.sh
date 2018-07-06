# 打包Release or Debug
BuildConfiguration=Release
# 项目scheme名
SCHEMENAME=demo     
# 项目路径
SOURCEPATH=/Users/admin/Desktop/demo   

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


# build
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
    echo "Archive OK"
    open ${IPAPATH}/${SCHEMENAME}
else
    echo "Archive fail"
fi




