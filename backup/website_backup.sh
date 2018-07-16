#!/bin/bash
# backup website for all
#author:lope
 
time=`date +%Y%m%d`   
 [ ! -e /backup/wwwrootbak/$time  ] && mkdir -p /backup/wwwrootbak/$time
ls -l   /home/wwwroot | grep  -v test|  awk 'NR!=1{ print  $NF }' > sitename.txt #记录网站根目录名字
cat sitename.txt | while  read sitename
do
cd /home/wwwroot/$sitename
tar zcf  /backup/wwwrootbak/$time/$sitename.tar.gz   *
done
find  /backup/wwwrootbak/ -type d  -mtime +15  |xargs rm -rf
