#!/bin/bash 
#backup mysql all
#auth:lope
TIME=`date +%Y%m%d%H%M%S`
LOGFILE="/data/mysqlbak/mysql_full_bak_time.log"
MYSQL_BAKDIR="/data/mysqlbak/full$TIME"
USER=root
PASSWORD=xxxxxx
[ ! -d $MYSQL_BAKDIR  ] &&  mkdir -p $MYSQL_BAKDIR
[ ! -e  $LOGFILE ] && touch  $LOGFILE
DATABASE=`mysqlshow  -u$USER  -p$PASSWORD  |  grep  -Ev "Data|info|per|sys|zabbix" | grep  -v + | awk '{print  $2}'`  #提取多个数据库名
for bakmysqlname in $DATABASE
do
/usr/bin/mysqldump  -u$USER  -p$PASSWORD  $bakmysqlname  --skip-lock-tables > $MYSQL_BAKDIR/$TIME_$bakmysqlname.sql
tar zcf $MYSQL_BAKDIR/$TIME_$bakmysqlname.tar.gz   $MYSQL_BAKDIR/$TIME_$bakmysqlname.sql --remove-files &> /dev/null
done
ret=$?
FINISHTIME=`date +%Y%m%d_%H%M%S`
 
[ $ret -eq 0 ] && echo  "Mysql fullbakup  finished, time: $FINISHTIME">>  $LOGFILE || echo "Mysql fullbakup failed,please check time:$FINISHTIME" >>  $LOGFILE
find  /data/mysqlbak/ -type d  -mtime +30  |xargs rm -rf  #超过30天的删除。
