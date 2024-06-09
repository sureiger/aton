#!/bin/bash

used_space=$(df / | grep / | awk '{print $5}' | sed 's/%//g')

smtp_server='smtp.yandex.ru'
smtp_port=587
username='user'
password='passwd'

from='example@yandex.ru'
to='example@gmail.com'
subject='Alarm'
body='Привет! У тебя свободного объема менее 85%.'

echo "Your used memory is $used_space %"

if [ "$used_space" -gt 15 ]; then
        sendemail -f "$from" \
         -t "$to" -u "$subject" \
         -m "$body" -s "$smtp_server:$smtp_port" \
         -xu "$username" -xp "$password" -o tls=yes;    
         echo "Message was sent to your EMAIL"
else echo  "You have enough free memory"
fi
