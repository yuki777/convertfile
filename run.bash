#!/bin/bash

dir=/var/script/convertfile
cd $dir

# 多重起動防止
script_pid=$dir/.pid
if [ -f $script_pid ]; then
    PID=`cat $script_pid `
    if (ps -e | awk '{print $1}' | grep $PID > /dev/null); then
        echo "process is already running." > /dev/stderr
        exit 1
    fi
fi
echo $$ > $script_pid

# main処理
/usr/bin/ruby $dir/app.rb

# 多重起動防止ファイル削除
rm $script_pid
