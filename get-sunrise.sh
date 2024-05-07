#!/bin/bash

#nutno zjistit souradnice umisteni kameru, a zaměnit XXXXXX a YYYYYY
current_date=$(date +"%Y-%m-%d")
curl -s "https://api.sunrise-sunset.org/json?lat=XXXXXXX,&lng=YYYYYYYYY&date=$current_date&formatted=0&tzid=Europe/Prague" > /opt/kamera/tmp/sun.txt
