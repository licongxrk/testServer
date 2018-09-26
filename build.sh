#!/bin/shsecurity 
unlock-keychain "-p" "LLcc123"	# MAC授权密码
projectpath=$(pwd)		# 工程路径
basepath=$HOME			# 
appname="testServer"		# APP的名字

# 证书自动配置，故无需配置
# codesignidentify="iPhone Distribution: XXXXXXXX & Technology Co., Ltd. (AS562ZMN1Z)"  

cd $projectpath			#cd到工程目录下  

#clean
xcodebuild -project "$appname.xcodeproj" -target "$appname" -configuration 'Release' clean >> /dev/null

#build
xcodebuild -project "$appname.xcodeproj" -target "$appname" -configuration 'Release' >> /dev/null   # CODE_SIGN_IDENTITY="$codesignidentify"  

#获取版本号，生成文件名，打包
bundleversion=$(/usr/libexec/PlistBuddy -c "print :CFBundleShortVersionString" "$projectpath/$appname/Info.plist")

ipaname="${appname}_v${bundleversion}_`date "+%Y%m%d%H%M"`.ipa"
ipapath="$basepath/Desktop/XXX"
apppath="$projectpath/build/Release-iphoneos/$appname.app"	# .app文件在projectpath路径下

xcrun -sdk iphoneos PackageApplication "$apppath" -o "$ipapath/$ipaname"	#xcrun已被下面方法代替
#xcodebuild -exportArchive -archivePath MyMobileApp.xcarchive -exportPath ExportDestination -exportOptionsPlist 'export.plist'  


# 通过Shell脚本将文件上传到ftp
#ftp -v -n <<!
#open 12.123.123.123 21   # 21之前的为IP地址
#user dev_ios *********   # 账号和密码
#prompt
#epsv4 
#off
#cd /dev/down_ipa     	 #	上传到ftp的路径
#bin
#lcd $ipapath			 #  要上传的文件的路径
#put $ipaname			 #  要上传的文件名
#quit
!

