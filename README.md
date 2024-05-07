# Ukládání streamu z kamery Ecowitt HP-10 a vytvoření timelapse

* Skripty a výsledná videa jsou v /opt/camera. Vytvořte strukturu:
```
mkdir -p /opt/camera/bin
mkdir -p /opt/camera/tmp
mkdir -p /opt/camera/timelapse
```
Skript camera-timelapse.sh se uloží do /opt/camera/bin. Zajistí spuštění služby v období po nautickémn svítání Slunce, a ukončí po nautickém západu Slunce. Aktuální video se pak přejmenuje podle aktuálního data , přesune do /opt/camera/timelapse.

* systemd služba:
soubor systemd/meteo-camera-timelapse.service zkopírujte do /etc/systemd/system/camera-timelapse
soubor systemd/meteo-camera-timelapse zkopírujte do /etc/default/meteo-camera-timelapse
proveďte reload konfigurace
```
systemctl daemon-reload
```
Službu není třeba startovat ručně - o to se stará cron.

* do crontabu se přidá úloha
```
* * * * *  root /opt/camera/bin/camera-timelapse.sh >/dev/null 2>&1
```
Každou minutu se kontroluje zda služba běží, a pokud je čas v rozmezí nastaveném pro nahrávání, spustí ji.
