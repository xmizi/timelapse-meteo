# Ukládání streamu z kamery Ecowitt HP-10 a vytvoření timelapse

* Skripty a výsledná videa jsou v /opt/camera. Vytvořte strukturu:
```
mkdir -p /opt/camera/bin
mkdir -p /opt/camera/tmp
mkdir -p /opt/camera/timelapse
```
  Skript _camera-timelapse.sh_ se uloží do _/opt/camera/bin_. Zajistí spuštění služby v období po nautickémn svítání Slunce, a ukončí po nautickém západu Slunce. Vytvořené video se pak přejmenuje podle aktuálního data a přesune do _/opt/camera/timelapse_.

* systemd služba:

  soubor _systemd/meteo-camera-timelapse.service_ zkopírujte do _/etc/systemd/system/_

  soubor _systemd/meteo-camera-timelapse_ zkopírujte do _/etc/default/_

  reload konfigurace
```
systemctl daemon-reload
```
  Službu není třeba startovat ručně - o to se stará cron.

* CRONTAB - stačí unístit soubory do _/etc/cron.d/_ (pozor, na konci souboru musí být prázdný řádek)

  Skript pro stažení aktuálních údajů, ze kterých se zjišťuje nautický úsvit a západ se spouští každý den po půlnoci (stačí 1x denně - neriskuje se ban pro časté přístupy k API)
```
01 00 * * *  root /opt/camera/bin/get-sunrise.sh
```

  Každou minutu se kontroluje zda služba běží, a pokud je čas v rozmezí nastaveném pro nahrávání, spustí ji.
```
* * * * *  root /opt/camera/bin/camera-timelapse.sh >/dev/null 2>&1
```


