#!/usr/bin/env bash


export APP_HOME

if [ -z "$APP_HOME" ];then

APP_HOME=$(cd ../ && pwd)

fi


export LOG_HOME=$APP_HOME/logs

export LIB_HOME=$APP_HOME/lib

export CONF_RESOURCES=$APP_HOME/conf/resources

safemkdir(){
  if [ ! -d $1 ]; then
   mkdir -p $1
  fi

}



if [ -z "$LOG_HOME" ];then

LOG_HOME=`dirname $0`/../logs

fi

if [ -z "$LIB_HOME" ];then

LIB_HOME=`dirname $0`/../lib

fi

#echo $APP_HOME $LOG_HOME


for f in  $LIB_HOME/*
 do
 if [ -f $f ]; then

   if [ "${f##*.}" = "jar" ]; then
    export CLASSPATH=$f:$CLASSPATH

   fi
  fi

done

LOG_DATE_DIR=$(date '+%Y%m%d')

safemkdir $LOG_HOME
safemkdir $APP_HOME/pid

export PID_FILE=$APP_HOME/pid/task.pid

#echo $CLASSPATH

export IPADDR=`hostname -I | awk '{print $1}'`

echo $IPADDR

export CLASSPATH=$CONF_RESOURCES:$CLASSPATH

export JAVA_OPTIONS="-Dapp_home=$APP_HOME -DLOG_HOME=$LOG_HOME -Dcom.sun.management.jmxremote -Dcom.sun.management.jmxremote.port=7070 -Dcom.sun.management.jmxremote.authenticate=false -Dcom.sun.management.jmxremote.ssl=false -Djava.rmi.server.hostname=$IPADDR"


 case $1 in
         start)
           echo "start application"

           if [ ! -f "$PID_FILE" ]; then
              nohup java -cp $CLASSPATH $JAVA_OPTIONS com.coda.erp.ERPApplication 1>>$LOG_HOME/task_manager_${LOG_DATE_DIR}.log  2>&1 & echo $! > $PID_FILE
              sleep 3
              echo "start successfully"


           else
           echo "Application already started,please stop it!!"
           fi
         ;;
         stop )
          echo "stop application [Begin]"
           if [  -f "$PID_FILE" ]; then
             cat $PID_FILE | xargs kill -9
              rm $PID_FILE
               echo "stop application [OK]"
            else
              echo "Application not started yet"
           fi

         ;;
         *)
           echo "Ignorant"
         ;;
 esac


