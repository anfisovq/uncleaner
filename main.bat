@ECHO OFF
CHCP 866
color 0F
CLS
FOR /F "tokens=1,2*" %%V IN ('bcdedit') DO SET adminTest=%%V
	IF (%adminTest%)==(Отказано) GOTO errNoAdmin
	IF (%adminTest%)==(Access) GOTO errNoAdmin

ECHO.
ECHO ██    ██ ███    ██  ██████ ██      ███████  █████  ███    ██ ███████ ██████  
ECHO ██    ██ ████   ██ ██      ██      ██      ██   ██ ████   ██ ██      ██   ██ 
ECHO ██    ██ ██ ██  ██ ██      ██      █████   ███████ ██ ██  ██ █████   ██████  
ECHO ██    ██ ██  ██ ██ ██      ██      ██      ██   ██ ██  ██ ██ ██      ██   ██ 
ECHO  ██████  ██   ████  ██████ ███████ ███████ ██   ██ ██   ████ ███████ ██   ██ 
ECHO 1 - Очистка основных логов в реестре
ECHO 2 - Очистка всех логов в реестре, файлов Perfect и Minidump
ECHO 3 - Очистка всех логов, файлов Perfect и журналов Windows 
ECHO 4 - Очистка подозрительных файлов Unturned / Конфигураций читов
ECHO 5 - Удаление логов Unturned

ECHO ENTER - Выход из программы
ECHO.
SET /p doset="Выберите действие: " 
ECHO.
IF NOT (%doset% GEQ 1 AND %doset% LEQ 5) EXIT
IF %doset% EQU 4 (
	ECHO.
	ECHO Очистка подозрительных файлов Unturned...
	rd /s /q "C:\Program Files (x86)\Steam\steamapps\common\Unturned\Screenshots"
	ECHO Скриншоты Unturned очищены.
	del "C:\Program Files (x86)\Steam\steamapps\common\Unturned\emptyhacks.log"
	ECHO Очищен emptyhacks.log
	del "C:\Program Files (x86)\Steam\steamapps\common\Unturned\loader_logs.log"
	ECHO Очищен loader_logs.log
	del "C:\Program Files (x86)\Steam\steamapps\common\Unturned\Spy.jpg"
	ECHO Очищен Spy.jpg
	del "C:\Users\steam\AppData\Roaming\config.UwU"
	del "C:\Users\steam\AppData\Roaming\config.txt"
	ECHO Очищены конфигурации EmptyHack/UndeadHack
	ECHO.
	ECHO Очистка подозрительных файлов закончена.
	ECHO.
)

IF %doset% EQU 5 (
	ECHO.
	ECHO Начал очистку Client.log
	del /f "C:\Program Files (x86)\Steam\steamapps\common\Unturned\Logs\Client.log" & type nul > "C:\Program Files (x86)\Steam\steamapps\common\Unturned\Logs\Client.log"
	ECHO Очистил Client.log
	ECHO Начал очистку Сlient_Prev.log
	del /f "C:\Program Files (x86)\Steam\steamapps\common\Unturned\Logs\Client_Prev.log" & type nul > "C:\Program Files (x86)\Steam\steamapps\common\Unturned\Logs\Client_Prev.log"
	ECHO Очистил Client_Prev.log
	ECHO.
)

IF %doset% EQU 3 (
	ECHO.
	ECHO ОЧИСТКА ВСЕХ ЖУРНАЛОВ Windows
	FOR /F "tokens=*" %%G in ('wevtutil.exe el') DO (call :do_clear "%%G")
	ECHO.
	ECHO Выполнено
	ECHO.
)
ECHO.
ECHO ОЧИСТКА ИСТОРИИ ShellBag - реестр
REG DELETE "HKEY_CURRENT_USER\Software\Classes\Local Settings\Software\Microsoft\Windows\Shell\MuiCache" /va /f
REG DELETE "HKEY_CURRENT_USER\Software\Classes\Local Settings\Software\Microsoft\Windows\Shell\BagMRU" /f
REG DELETE "HKEY_CURRENT_USER\Software\Classes\Local Settings\Software\Microsoft\Windows\Shell\Bags" /f
REG DELETE "HKEY_CURRENT_USER\Software\Microsoft\Windows\Shell\BagMRU" /f
REG DELETE "HKEY_CURRENT_USER\Software\Microsoft\Windows\Shell\Bags" /f
ECHO.
ECHO.
ECHO ОЧИСТКА ИСТОРИИ Explorer - реестр
REG DELETE "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\RunMRU" /va /f
ECHO.
ECHO.
ECHO ОЧИСТКА ИСТОРИИ OpenSave и LastVisited - реестр
REG DELETE "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\ComDlg32\FirstFolder" /va /f
REG DELETE "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\ComDlg32\LastVisitedPidlMRU" /va /f
REG DELETE "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\ComDlg32\LastVisitedPidlMRULegacy" /va /f
REG DELETE "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\ComDlg32\OpenSavePidlMRU" /f
REG ADD "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\ComDlg32\OpenSavePidlMRU"
ECHO.
IF %doset% NEQ 1 (	
	ECHO.	
	ECHO ОЧИСТКА ИСТОРИИ UserAssist - реестр
	REG DELETE "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\UserAssist" /f
	REG ADD "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\UserAssist"
	ECHO.
)

ECHO.
ECHO ОЧИСТКА ИСТОРИИ AppCompatCache - реестр
REG DELETE "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\AppCompatCache" /va /f
REG DELETE "HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Control\Session Manager\AppCompatCache" /va /f
ECHO.
ECHO.
ECHO ОЧИСТКА ИСТОРИИ DiagnosedApplications - реестр
REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\RADAR\HeapLeakDetection\DiagnosedApplications" /f
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\RADAR\HeapLeakDetection\DiagnosedApplications"
ECHO.
FOR /F "tokens=2" %%i IN ('whoami /user /fo table /nh') DO SET usersid=%%i
ECHO.
ECHO ОЧИСТКА ИСТОРИИ Search - реестр
	REG DELETE "HKEY_USERS\%usersid%\Software\Microsoft\Windows\CurrentVersion\Search\RecentApps" /f
	REG ADD "HKEY_USERS\%usersid%\Software\Microsoft\Windows\CurrentVersion\Search\RecentApps"
ECHO.
ECHO.
ECHO ОЧИСТКА ИСТОРИИ службы Background Activity Moderator - реестр
REG DELETE "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\bam\UserSettings\%usersid%" /va /f
REG DELETE "HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Services\bam\UserSettings\%usersid%" /va /f
ECHO.
ECHO.
ECHO ОЧИСТКА ИСТОРИИ AppCompatFlags - реестр
REG DELETE "HKEY_USERS\%usersid%\Software\Microsoft\Windows NT\CurrentVersion\AppCompatFlags\Compatibility Assistant\Store" /va /f
IF %doset% NEQ 1 (
	REG DELETE  "HKEY_USERS\%usersid%\Software\Microsoft\Windows NT\CurrentVersion\AppCompatFlags\Layers" /va /f
)
ECHO.
ECHO.
ECHO ОЧИСТКА ИСТОРИИ MountedDevices - реестр
ECHO.
REG DELETE "HKEY_USERS\%usersid%\Software\Microsoft\Windows\CurrentVersion\Explorer\MountPoints2" /f
REG ADD "HKEY_USERS\%usersid%\Software\Microsoft\Windows\CurrentVersion\Explorer\MountPoints2"
ECHO.
ECHO.
ECHO ОЧИСТКА ИСТОРИИ Recent - файловая система
DEL /f /q %APPDATA%\Microsoft\Windows\Recent\*.*
DEL /f /q %APPDATA%\Microsoft\Windows\Recent\CustomDestinations\*.*
DEL /f /q %APPDATA%\Microsoft\Windows\Recent\AutomaticDestinations\*.*
ECHO Выполнено
ECHO.
ECHO.
ECHO ОЧИСТКА ИСТОРИИ Panther - файловая система
DEL /f /q %systemroot%\Panther\*.*
ECHO Выполнено
ECHO.
ECHO.
ECHO ОЧИСТКА ИСТОРИИ AppCompat - файловая система
DEL /f /q %systemroot%\appcompat\Programs\*.txt
DEL /f /q %systemroot%\appcompat\Programs\*.xml
DEL /f /q %systemroot%\appcompat\Programs\Install\*.txt
DEL /f /q %systemroot%\appcompat\Programs\Install\*.xml
ECHO Выполнено
ECHO.

IF %doset% NEQ 1 (
	ECHO.
	ECHO ОЧИСТКА ИСТОРИИ Prefetch - файловая система
	DEL /f /q %systemroot%\Prefetch\*.pf
	DEL /f /q %systemroot%\Prefetch\*.ini
	DEL /f /q %systemroot%\Prefetch\*.7db
	DEL /f /q %systemroot%\Prefetch\*.ebd
	DEL /f /q %systemroot%\Prefetch\*.bin
	DEL /f /q %systemroot%\Prefetch\*.db
	DEL /f /q %systemroot%\Prefetch\ReadyBoot\*.fx
	ECHO Выполнено
	ECHO.
	ECHO.
	ECHO ОЧИСТКА ИСТОРИИ Minidump - файловая система
	DEL /f /q %systemroot%\Minidump\*.*
	ECHO Выполнено
)
ECHO.


PAUSE
EXIT

:do_clear
ECHO Очистка журнала %1
wevtutil.exe cl %1
GOTO :eof

:errNoAdmin
COLOR 4
cscript //nologo driver.vbs
ECHO.
EXIT