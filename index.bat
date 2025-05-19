@echo off

set folder=Veyon
set exec=veyon-cli.exe
set bd=%cd%

echo %bd%

cd /D "C:/Program Files/%folder%"

:cycle
	cls
	echo.
	echo +------ Menu ------+
	echo [ 1. Remote Access ]
	echo [ 2. Features      ]
	echo [ 3. Get Token     ]
	echo +------------------+
	set /p "opt=Please select an option: "

	if %opt%==1 goto :remAccess
	if %opt%==2 goto :featuresList
	if %opt%==3 goto :getToken
	echo L'opzione  inserita non esiste
	pause
exit ::Dovrebbe terminare il programma

:remAccess
	set /p "opt=Control(0) or View(1): "

	if %opt%==0 set vwOrCt=control
	if %opt%==1 set vwOrCt=view

	type %bd%\ips.txt ::Print the 3rd ottect by laboratory

	set /p "mask=Select 3rd oct: "

	if %mask%==4 echo Nel LAP2 gli ip sono scalati di 30 in avanti

	set /p "addr=Select host addr:"

	%exec% remoteaccess %vwOrCt% 192.168.%mask%.%addr%
	
	pause
goto :cycle

:featuresList
	type %bd%\featureList.txt

	set /p "featureSelected=Select a feature: "

	if %featureSelected%==1  goto :startApp
	if %featureSelected%==2  goto :screenLock
	if %featureSelected%==3  goto :userLogin
	if %featureSelected%==4  goto :userLogoff
	if %featureSelected%==5  goto :reboot
	if %featureSelected%==6  goto :powerDown
	if %featureSelected%==7  goto :textMessage

	if %featureSelected%==8  goto :demoServer
	if %featureSelected%==9  goto :demoFull
	if %featureSelected%==10 goto :demoWin
	echo. && echo WARN: Hai selezionato un opzione che non esiste! && echo.
	
	pause
goto :cycle

:getToken

	start cmd /k %exec% webapi runserver

	set /p "mask=Select 3rd oct: "
	set /p "addr=Select host addr:"

	curl localhost:11080/api/v1/authentication/192.168.%mask%.%addr%
	
	pause

goto :cycle


::Feature Management

:startApp
	set /p "noApp=Insert the number of apps: "
	
	set json="{ "applications": ["
	
	set i=0
	:loop_for
	if i GEQ %noApp% goto :exitLoop_for
		set /p "appName=\tInsert app path: "
		set json=%json%"%appName%",
	goto :loop_for
	:exitLoop_for
	
	set json=%json%]}

	echo %json%
	
	pause
goto :cycle
	
:screenLock
	set /p "mask=Select 3rd oct: "
	set /p "addr=Select host addr:"
	
	%exec% feature start screenLock 192.168.%mask%.%addr%
	pause
	%exec% feature stop screenLock 192.168.%mask%.%addr%
	
goto :cycle
:userLogin
echo Non ancora implementato
goto :cycle
:userLogoff
	set /p "mask=Select 3rd oct: "
	set /p "addr=Select host addr:"
	
	%exec% feature start 192.168.%mask%.%addr% UserLogoff
	pause
goto :cycle
:reboot
echo Non ancora implementato
goto :cycle
:powerDown
echo Non ancora implementato
goto :cycle
:textMessage
	set /p "mask=Select 3rd oct: "
	set /p "addr=Select host addr:"
	set /p "msg=Insert msg:"
	
	%exec% feature start 192.168.%mask%.%addr% TextMessage '{\"text\":\"%msg%\"}'
	pause
goto :cycle
:demoServer
echo Non ancora implementato
goto :cycle
:demoFull
echo Non ancora implementato
goto :cycle
:demoWin
echo Non ancora implementato
goto :cycle