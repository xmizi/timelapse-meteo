#!/bin/bash

# Získání aktuálního datumu
current_date=$(date +"%Y-%m-%d")
current_time_unix=$(date +"%s")
data=$(cat /opt/kamera/tmp/sun.txt)

# Zpracování výstupu a extrakce času východu a západu Slunce
vychod=$(date -d  $(echo "$data" | jq -r '.results.civil_twilight_begin') +%s)
zapad=$(date -d  $(echo "$data" | jq -r '.results.civil_twilight_end') +%s)

FFMPEG_PID=$(pidof ffmpeg)
ERRNO_FFMPEG=$?

#echo $ERRNO_FFMPEG

if [[ "$current_time_unix" > "$vychod" && "$current_time_unix" < "$zapad" && "$ERRNO_FFMPEG" == 1 ]]; then
    /usr/bin/systemctl start meteo-kamera-stream
elif [[ "$current_time_unix" > "$zapad" && "$ERRNO_FFMPEG" == 0 ]]; then
    /usr/bin/systemctl stop meteo-kamera-stream
    mv /opt/kamera/timelapse/timelapse.mp4 /opt/kamera/timelapse/timelapse_$current_date.mp4
fi
