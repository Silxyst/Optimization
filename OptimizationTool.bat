@echo off
title Optimization Tool by sil.xyst
color 0B
mode con: cols=75 lines=25
chcp 65001 >nul

:: Função de carregamento
:start_loading
cls
echo Please wait, loading...
for /L %%i in (1,1,2) do (
    echo.
    ping -n 1 127.0.0.1 >nul
)

:: Menu Principal
:menu
cls
echo ====================================================
echo                 OPTIMIZATION TOOL
echo                 Created by: sil.xyst
echo ====================================================
echo.
echo  OOO   PPPP  TTTTT III   M   M  I   ZZZZZ   AAA  TTTTT III   OOO   OOO  L     TTTTT  OOO   OOO  L
echo O   O  P   P   T    I    MM MM  I     Z    A   A   T    I   O   O O   O L       T   O   O O   O L
echo O   O  PPPP    T    I    M M M  I    Z     AAAAA   T    I   O   O O   O L       T   O   O O   O L
echo O   O  P       T    I    M   M  I   Z      A   A   T    I   O   O O   O L       T   O   O O   O L
echo  OOO   P       T   III   M   M  I   ZZZZZ  A   A   T   III   OOO   OOO  LLLLL   T    OOO   OOO  LLLLL
echo ====================================================
echo [1] FPS Boost
echo [2] RAM Boost
echo [3] Clean Cache
echo [4] Clean Logs
echo [5] Additional Optimizations
echo [6] Internet Optimizations
echo [7] Open Links (YouTube, Twitch, Instagram, Patreon)
echo [8] Exit
echo ====================================================
set /p choice= Enter your choice:

:: Redirecionamento para as opções
if "%choice%"=="1" goto fps_boost
if "%choice%"=="2" goto ram_boost
if "%choice%"=="3" goto clean_cache
if "%choice%"=="4" goto clean_logs
if "%choice%"=="5" goto additional_optimizations
if "%choice%"=="6" goto internet_optimizations
if "%choice%"=="7" goto open_links
if "%choice%"=="8" exit
echo Invalid option, try again!
pause
goto menu

:: FPS Boost
:fps_boost
cls
echo Applying FPS Boost...
bcdedit /set useplatformtick yes >nul 2>&1
bcdedit /set disabledynamictick yes >nul 2>&1
bcdedit /set tscsyncpolicy Enhanced >nul 2>&1
powercfg -h off >nul 2>&1
echo FPS Boost Applied Successfully!
pause
goto menu

:: RAM Boost
:ram_boost
cls
echo Clearing RAM...
wmic os get FreePhysicalMemory /format:value
echo RAM Boost Applied Successfully!
pause
goto menu

:: Clean Cache
:clean_cache
cls
echo Cleaning Cache...
del /s /q /f "%temp%\*.*" >nul 2>&1
del /s /q /f "C:\Windows\Temp\*.*" >nul 2>&1
del /s /q /f "C:\Windows\Prefetch\*.*" >nul 2>&1
echo Cache Cleaned!
pause
goto menu

:: Clean Logs
:clean_logs
cls
echo Cleaning Logs...
del /s /q /f "C:\Windows\Logs\*.*" >nul 2>&1
echo Logs Cleaned!
pause
goto menu

:: Additional Optimizations
:additional_optimizations
cls
echo Applying Additional Optimizations...

:: Disable unnecessary features that don’t impact performance but improve experience
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "DisableNotificationCenter" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "EnableBalloonTips" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "EnableActivityFeed" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "ShowSyncProviderNotifications" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "VisualFXSetting" /t REG_DWORD /d 2 /f >nul 2>&1
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "IconsOnly" /t REG_DWORD /d 1 /f >nul 2>&1

:: Disable telemetry
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\DataCollection" /v "AllowTelemetry" /t REG_DWORD /d 0 /f >nul 2>&1

:: Disable content delivery features
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies" /v "SubscribedContentEnabled" /t REG_DWORD /d 0 /f >nul 2>&1

echo Additional Optimizations Applied Successfully!
pause
goto menu

:: Open Links
:open_links
cls
echo Opening Links...
start https://www.youtube.com/@sil_xyst
start https://www.twitch.tv/silxyst1
start https://www.instagram.com/sil.xyst/
start https://www.patreon.com/c/VeloTrackMods
goto menu

:: Internet Optimizations
:internet_optimizations
cls
echo Increasing DNS Cache Size...
reg add "HKLM\SYSTEM\CurrentControlSet\Services\Dnscache\Parameters" /v "CacheHashTableBucketSize" /t REG_DWORD /d 1024 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\Dnscache\Parameters" /v "CacheHashTableSize" /t REG_DWORD /d 65536 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\Dnscache\Parameters" /v "MaxCacheEntryTtlLimit" /t REG_DWORD /d 14400 /f
echo DNS Cache Size Increased Successfully!

echo Enabling QoS...
netsh int tcp set global congestionprovider=ctcp
netsh int tcp set global ecncapability=enabled
netsh int tcp set global chimney=enabled
netsh int tcp set global rss=enabled
netsh int tcp set global autotuninglevel=normal
netsh int tcp set global dca=enabled
netsh int tcp set global netdma=enabled
netsh int tcp set supplemental custom congestionprovider=ctcp
echo Quality of Service Activated Successfully!

echo Disabling TCP Auto Tuning...
netsh int tcp set global autotuninglevel=disabled
echo TCP Auto Tuning Disabled Successfully!

echo Resetting Connection and Clearing DNS Cache...
ipconfig /flushdns
ipconfig /registerdns
ipconfig /release
ipconfig /renew
netsh winsock reset catalog
netsh int ipv4 reset reset.log
netsh int ipv6 reset reset.log
echo Connection Reset and DNS Cache Cleared Successfully!

echo Updating Network Drivers (Your connection may be temporarily disabled)...
pnputil -e > drivers.txt
findstr /i /c:"Net" drivers.txt > netdrivers.txt
for /f "tokens=1,2* delims= " %%a in (netdrivers.txt) do pnputil -f -d "%%b"
echo Network Drivers Updated Successfully! Please restart your computer.
pause
goto menu
