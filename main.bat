@ECHO OFF
CHCP 866
color 0F
CLS
FOR /F "tokens=1,2*" %%V IN ('bcdedit') DO SET adminTest=%%V
	IF (%adminTest%)==(�⪠����) GOTO errNoAdmin
	IF (%adminTest%)==(Access) GOTO errNoAdmin

ECHO.
ECHO ��    �� ���    ��  ������ ��      �������  �����  ���    �� ������� ������  
ECHO ��    �� ����   �� ��      ��      ��      ��   �� ����   �� ��      ��   �� 
ECHO ��    �� �� ��  �� ��      ��      �����   ������� �� ��  �� �����   ������  
ECHO ��    �� ��  �� �� ��      ��      ��      ��   �� ��  �� �� ��      ��   �� 
ECHO  ������  ��   ����  ������ ������� ������� ��   �� ��   ���� ������� ��   �� 
ECHO 1 - ���⪠ �᭮���� ����� � ॥���
ECHO 2 - ���⪠ ��� ����� � ॥���, 䠩��� Perfect � Minidump
ECHO 3 - ���⪠ ��� �����, 䠩��� Perfect � ��ୠ��� Windows 
ECHO 4 - ���⪠ ������⥫��� 䠩��� Unturned / ���䨣��権 �⮢
ECHO 5 - �������� ����� Unturned

ECHO ENTER - ��室 �� �ணࠬ��
ECHO.
SET /p doset="�롥�� ����⢨�: " 
ECHO.
IF NOT (%doset% GEQ 1 AND %doset% LEQ 5) EXIT
IF %doset% EQU 4 (
	ECHO.
	ECHO ���⪠ ������⥫��� 䠩��� Unturned...
	rd /s /q "C:\Program Files (x86)\Steam\steamapps\common\Unturned\Screenshots"
	ECHO ��ਭ��� Unturned ��饭�.
	del "C:\Program Files (x86)\Steam\steamapps\common\Unturned\emptyhacks.log"
	ECHO ��饭 emptyhacks.log
	del "C:\Program Files (x86)\Steam\steamapps\common\Unturned\loader_logs.log"
	ECHO ��饭 loader_logs.log
	del "C:\Program Files (x86)\Steam\steamapps\common\Unturned\Spy.jpg"
	ECHO ��饭 Spy.jpg
	del "C:\Users\steam\AppData\Roaming\config.UwU"
	del "C:\Users\steam\AppData\Roaming\config.txt"
	ECHO ��饭� ���䨣��樨 EmptyHack/UndeadHack
	ECHO.
	ECHO ���⪠ ������⥫��� 䠩��� �����祭�.
	ECHO.
)

IF %doset% EQU 5 (
	ECHO.
	ECHO ��砫 ����� Client.log
	del /f "C:\Program Files (x86)\Steam\steamapps\common\Unturned\Logs\Client.log" & type nul > "C:\Program Files (x86)\Steam\steamapps\common\Unturned\Logs\Client.log"
	ECHO ���⨫ Client.log
	ECHO ��砫 ����� �lient_Prev.log
	del /f "C:\Program Files (x86)\Steam\steamapps\common\Unturned\Logs\Client_Prev.log" & type nul > "C:\Program Files (x86)\Steam\steamapps\common\Unturned\Logs\Client_Prev.log"
	ECHO ���⨫ Client_Prev.log
	ECHO.
)

IF %doset% EQU 3 (
	ECHO.
	ECHO ������� ���� �������� Windows
	FOR /F "tokens=*" %%G in ('wevtutil.exe el') DO (call :do_clear "%%G")
	ECHO.
	ECHO �믮�����
	ECHO.
)
ECHO.
ECHO ������� ������� ShellBag - ॥���
REG DELETE "HKEY_CURRENT_USER\Software\Classes\Local Settings\Software\Microsoft\Windows\Shell\MuiCache" /va /f
REG DELETE "HKEY_CURRENT_USER\Software\Classes\Local Settings\Software\Microsoft\Windows\Shell\BagMRU" /f
REG DELETE "HKEY_CURRENT_USER\Software\Classes\Local Settings\Software\Microsoft\Windows\Shell\Bags" /f
REG DELETE "HKEY_CURRENT_USER\Software\Microsoft\Windows\Shell\BagMRU" /f
REG DELETE "HKEY_CURRENT_USER\Software\Microsoft\Windows\Shell\Bags" /f
ECHO.
ECHO.
ECHO ������� ������� Explorer - ॥���
REG DELETE "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\RunMRU" /va /f
ECHO.
ECHO.
ECHO ������� ������� OpenSave � LastVisited - ॥���
REG DELETE "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\ComDlg32\FirstFolder" /va /f
REG DELETE "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\ComDlg32\LastVisitedPidlMRU" /va /f
REG DELETE "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\ComDlg32\LastVisitedPidlMRULegacy" /va /f
REG DELETE "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\ComDlg32\OpenSavePidlMRU" /f
REG ADD "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\ComDlg32\OpenSavePidlMRU"
ECHO.
IF %doset% NEQ 1 (	
	ECHO.	
	ECHO ������� ������� UserAssist - ॥���
	REG DELETE "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\UserAssist" /f
	REG ADD "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\UserAssist"
	ECHO.
)

ECHO.
ECHO ������� ������� AppCompatCache - ॥���
REG DELETE "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\AppCompatCache" /va /f
REG DELETE "HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Control\Session Manager\AppCompatCache" /va /f
ECHO.
ECHO.
ECHO ������� ������� DiagnosedApplications - ॥���
REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\RADAR\HeapLeakDetection\DiagnosedApplications" /f
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\RADAR\HeapLeakDetection\DiagnosedApplications"
ECHO.
FOR /F "tokens=2" %%i IN ('whoami /user /fo table /nh') DO SET usersid=%%i
ECHO.
ECHO ������� ������� Search - ॥���
	REG DELETE "HKEY_USERS\%usersid%\Software\Microsoft\Windows\CurrentVersion\Search\RecentApps" /f
	REG ADD "HKEY_USERS\%usersid%\Software\Microsoft\Windows\CurrentVersion\Search\RecentApps"
ECHO.
ECHO.
ECHO ������� ������� �㦡� Background Activity Moderator - ॥���
REG DELETE "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\bam\UserSettings\%usersid%" /va /f
REG DELETE "HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Services\bam\UserSettings\%usersid%" /va /f
ECHO.
ECHO.
ECHO ������� ������� AppCompatFlags - ॥���
REG DELETE "HKEY_USERS\%usersid%\Software\Microsoft\Windows NT\CurrentVersion\AppCompatFlags\Compatibility Assistant\Store" /va /f
IF %doset% NEQ 1 (
	REG DELETE  "HKEY_USERS\%usersid%\Software\Microsoft\Windows NT\CurrentVersion\AppCompatFlags\Layers" /va /f
)
ECHO.
ECHO.
ECHO ������� ������� MountedDevices - ॥���
ECHO.
REG DELETE "HKEY_USERS\%usersid%\Software\Microsoft\Windows\CurrentVersion\Explorer\MountPoints2" /f
REG ADD "HKEY_USERS\%usersid%\Software\Microsoft\Windows\CurrentVersion\Explorer\MountPoints2"
ECHO.
ECHO.
ECHO ������� ������� Recent - 䠩����� ��⥬�
DEL /f /q %APPDATA%\Microsoft\Windows\Recent\*.*
DEL /f /q %APPDATA%\Microsoft\Windows\Recent\CustomDestinations\*.*
DEL /f /q %APPDATA%\Microsoft\Windows\Recent\AutomaticDestinations\*.*
ECHO �믮�����
ECHO.
ECHO.
ECHO ������� ������� Panther - 䠩����� ��⥬�
DEL /f /q %systemroot%\Panther\*.*
ECHO �믮�����
ECHO.
ECHO.
ECHO ������� ������� AppCompat - 䠩����� ��⥬�
DEL /f /q %systemroot%\appcompat\Programs\*.txt
DEL /f /q %systemroot%\appcompat\Programs\*.xml
DEL /f /q %systemroot%\appcompat\Programs\Install\*.txt
DEL /f /q %systemroot%\appcompat\Programs\Install\*.xml
ECHO �믮�����
ECHO.

IF %doset% NEQ 1 (
	ECHO.
	ECHO ������� ������� Prefetch - 䠩����� ��⥬�
	DEL /f /q %systemroot%\Prefetch\*.pf
	DEL /f /q %systemroot%\Prefetch\*.ini
	DEL /f /q %systemroot%\Prefetch\*.7db
	DEL /f /q %systemroot%\Prefetch\*.ebd
	DEL /f /q %systemroot%\Prefetch\*.bin
	DEL /f /q %systemroot%\Prefetch\*.db
	DEL /f /q %systemroot%\Prefetch\ReadyBoot\*.fx
	ECHO �믮�����
	ECHO.
	ECHO.
	ECHO ������� ������� Minidump - 䠩����� ��⥬�
	DEL /f /q %systemroot%\Minidump\*.*
	ECHO �믮�����
)
ECHO.


PAUSE
EXIT

:do_clear
ECHO ���⪠ ��ୠ�� %1
wevtutil.exe cl %1
GOTO :eof

:errNoAdmin
COLOR 4
cscript //nologo driver.vbs
ECHO.
EXIT