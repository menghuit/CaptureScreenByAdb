@echo off
@setlocal enabledelayedexpansion

echo Just a second...

rem ==============���뵱ǰĿ¼==============
cd /d %~sdp0

rem ==============���"result"�ļ����Ƿ����==============
set bat_dir=%~sdp0
set result_dir=%bat_dir%\result
if not exist "%bat_dir%\result" (
    md result
)

rem ==============����adb·��==============
set adb=%bat_dir%\tools\adb.exe

rem ==============����豸�Ƿ����==============
%adb% get-state |findstr "device">nul
if %errorlevel% equ 0 (
    rem �豸����
	goto :onValidDevice
) else (
    rem �豸������
    echo �豸�����ã������豸������Ƿ���USB����
    goto :omega
)

rem ==============�豸��Ч==============
:onValidDevice
rem �ж��Ƿ��ڲ������Ѿ�ָ���˽�ͼ��
set name=%~1
if "%name%"=="" (
    goto :waitCommand
) else (
    call :UseName "%name%"
	goto :omega
)

rem ==============�ȴ������ļ���==============
:waitCommand
echo �����ļ���
set/p input= >nul
call :TakeScreenShot "%input%"

rem ==============�˳�==============
:omega
pause
goto :eof


rem ==============�ӳ����(Take a screen shot)==============
:TakeScreenShot
set fn=%~1
rem echo User Input:%fn% --- %result_dir%\%fn%

%adb% shell screencap /sdcard/screenshot.png
%adb% pull /sdcard/screenshot.png "%result_dir%\%fn%.png"
goto :eof
rem ==============�ӳ����(Take a screen shot)==============


rem ==============�ӳ����(ʹ�����в�����Ϊ�ļ���)==============
:UseName
set fn=%~1
call :TakeScreenShot "%fn%"
goto :eof
rem ==============�ӳ����(ʹ�����в�����Ϊ�ļ���)==============