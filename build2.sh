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

echo clean success 

!

