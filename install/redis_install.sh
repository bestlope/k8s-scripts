#!/bin/bash
#function:  Install  redis  for centos 7.x_64bit
#author:lope
downloaddir=/usr/local/src
 
function menu(){
	echo "###############################################################"
	cat <<EOF
	Please choose  redis version  which  you want to install:
	1,Redis-2.8.21-4.el7.art.x86_64
	2,Redis-3.0.7-4.el7.art.x86_64
EOF
	echo "###############################################################"
}
 
function  checkroot(){
if [ $UID -ne  0 ]
  then
	echo "Please login as  root"
	exit;
fi
}
 
function  msgbox(){
if [ $? -eq 0 ] ;then
	echo "This step sucess" 
else 
	echo  "This step failed,please check"
	exit;
fi
}
function  check_env(){
echo  -e "checking  epel\n"
rpm  -qa | grep epel
if [ $? -eq 0 ]; then
        echo -e  "epel  has been installed\nInstall  required  libs:"
	yum install jemalloc -y >/dev/null
else
        echo  "epel does not install,now  install  epel"
        yum install  epel-release  -y > /dev/null
	echo  "Install  required  libs:"
	yum install jemalloc -y >/dev/null
fi
}
 
function  redis_version(){
read  -p  "please choose redis  version that you  want to install:" flag
}
 
function  redis_install(){
 
case $flag  in
 
1)
	version="redis-2.8.21-4.el7.art.x86_64"
	echo "Redis 2.8.X will be  install" && wget  -O ${downloaddir}/${version}.rpm  http://www6.atomicorp.com/channels/atomic/centos/7/x86_64/RPMS/${version}.rpm 
	rpm -ih --force --nodeps ${downloaddir}/${version}.rpm
;;
2)
	version="redis-3.0.7-4.el7.art.x86_64"
	echo "Redis 3.0.X will be  install" && wget  -O ${downloaddir}/${version}.rpm   http://www6.atomicorp.com/channels/atomic/centos/7/x86_64/RPMS/${version}.rpm
	rpm -ih --force --nodeps ${downloaddir}/${version}.rpm
;;
*)
echo "Please  input 1 or 2,other novalid"
redis_version
redis_install
esac
}
function  check_install_status(){
service redis start
netstat   -tunlp | grep  6379
if [ $? -eq 0 ]; then
	echo  "Redis install sucess"
	chkconfig  redis  on
else
	echo  "Redis  install  failed,please  check"
	exit;
fi
}
function main(){
checkroot
check_env
menu
redis_version
redis_install
check_install_status
}
main
