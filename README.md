Ukládání streamu z kamery Ecowitt HX10 a vytvoření timelapse


Skripty a výsledná videa jsou v /opt/camera. Vytvoríte následující strukturu:
```
mkdir -p /opt/camera/bin
mkdir -p /opt/camera/tmp
mkdir -p /opt/camera/timelapse
```
Skript camera-timelapse.sh se uloží do /opt/camera/bin. Ten zajistí spuštění služby v období po nautickémn svítání Slunce, a ukončí po nautickém západu Slunce. Aktuální video se pak přejmenuje podle aktuálního data , přesune do /opt/camera/timelapse.

Do crontabu se přidá úloha
```
* * * * *  root /opt/camera/bin/camera-timelapse.sh >/dev/null 2>&1
```
