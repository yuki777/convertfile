convertfile.xxxlabo.com.8080が使う変換スクリプト。
cronで毎分起動している。
```
* * * * * cd /var/script/convertfile; /bin/bash /var/script/convertfile/run.bash > /var/script/convertfile/logs/cron.log 2>&1
```
