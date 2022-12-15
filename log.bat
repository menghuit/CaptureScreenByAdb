@echo off
@setlocal enabledelayedexpansion

echo Just a second...

rem ==============进入当前目录==============
cd /d %~sdp0

rem ==============检查"result"文件夹是否存在==============
set bat_dir=%~sdp0
set result_dir=%bat_dir%\result
if not exist "%bat_dir%\result" (
    md result
)

rem ==============设置adb路径==============
set adb=%bat_dir%\tools\adb.exe

rem ==============检测设备是否可用==============
%adb% get-state |findstr "device">nul
if %errorlevel% equ 0 (
    rem 设备可用
    goto :onValidDevice
) else (
    rem 设备不可用
    echo 设备不可用，插上设备，检查是否开启USB调试
    goto :omega
)

rem ==============设备有效==============
:onValidDevice
rem 判断是否在参数中已经指定了截图名
set name=%~1
if "%name%"=="" (
    goto :waitCommand
) else (
    call :UseName "%name%"
    goto :omega
)

rem ==============等待输入文件名==============
:waitCommand
echo 输入关键字，输入完成后按回车键
set/p input= >nul
call :Logcat "%input%"

rem ==============退出==============
:omega
pause
goto :eof


rem ==============子程序段(logcat)==============
:Logcat
set fn=%~1
rem echo User Input:%fn% --- %result_dir%\%fn%

%adb% logcat |findstr "%fn%"
goto :eof
rem ==============子程序段(Take a screen shot)==============


rem ==============子程序段(使用运行参数作为文件名)==============
:UseName
set fn=%~1
call :Logcat "%fn%"
goto :eof
rem ==============子程序段(使用运行参数作为文件名)==============