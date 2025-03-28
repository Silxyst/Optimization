@echo off
title Internet Optimization by sil.xyst
color 0B
mode con: cols=75 lines=25
chcp 65001 >nul

:: Função de carregamento
:start_loading
cls
echo Aguarde, carregando...
for /L %%i in (1,1,2) do (
    echo.
    ping -n 1 127.0.0.1 >nul
)

:: Menu Principal
:menu
cls
echo ====================================================
echo                INTERNET  OPTIMIZATION
echo                 Created by: sil.xyst               
echo ====================================================
echo.
echo  OOO   PPPP  TTTTT III   M   M  I   ZZZZZ   AAA  TTTTT III   OOO   OOO  L     TTTTT  OOO   OOO  L     
echo O   O  P   P   T    I    MM MM  I     Z    A   A   T    I   O   O O   O L       T   O   O O   O L     
echo O   O  PPPP    T    I    M M M  I    Z     AAAAA   T    I   O   O O   O L       T   O   O O   O L     
echo O   O  P       T    I    M   M  I   Z      A   A   T    I   O   O O   O L       T   O   O O   O L     
echo  OOO   P       T   III   M   M  I   ZZZZZ  A   A   T   III   OOO   OOO  LLLLL   T    OOO   OOO  LLLLL  
echo ====================================================
echo [1] Aumentar o Tamanho do Cache de DNS
echo [2] Ativar QoS (Qualidade de Serviço)
echo [3] Desativar o Auto-Tuning do TCP
echo [4] Resetar Conexão e Limpar Cache de DNS
echo [5] Atualizar Drivers de Rede
echo [6] Sair
echo ====================================================
set /p choice= Escolha uma opção [1-6]: 

if "%choice%"=="1" goto dns_cache
if "%choice%"=="2" goto qos
if "%choice%"=="3" goto tcp_tuning
if "%choice%"=="4" goto reset_connection
if "%choice%"=="5" goto update_drivers
if "%choice%"=="6" exit
echo Opção inválida, tente novamente!
pause
goto menu

:: Aumentar o Tamanho do Cache de DNS
:dns_cache
cls
echo ====================================================
echo        Aumentando o Tamanho do Cache de DNS
echo ====================================================
echo.
reg add "HKLM\SYSTEM\CurrentControlSet\Services\Dnscache\Parameters" /v "CacheHashTableBucketSize" /t REG_DWORD /d 1024 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\Dnscache\Parameters" /v "CacheHashTableSize" /t REG_DWORD /d 65536 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Services\Dnscache\Parameters" /v "MaxCacheEntryTtlLimit" /t REG_DWORD /d 14400 /f
echo Tamanho do cache de DNS aumentado com sucesso!
pause
goto menu

:: Ativar QoS (Qualidade de Serviço)
:qos
cls
echo ====================================================
echo                 Ativando QoS
echo ====================================================
echo.
netsh int tcp set global congestionprovider=ctcp
netsh int tcp set global ecncapability=enabled
netsh int tcp set global chimney=enabled
netsh int tcp set global rss=enabled
netsh int tcp set global autotuninglevel=normal
netsh int tcp set global dca=enabled
netsh int tcp set global netdma=enabled
netsh int tcp set supplemental custom congestionprovider=ctcp
echo Qualidade de Serviço ativada com sucesso!
pause
goto menu

:: Desativar o Auto-Tuning do TCP
:tcp_tuning
cls
echo ====================================================
echo           Desativando o Auto-Tuning do TCP
echo ====================================================
echo.
netsh int tcp set global autotuninglevel=disabled
echo Auto-Tuning do TCP desativado com sucesso!
pause
goto menu

:: Resetar Conexão e Limpar Cache de DNS
:reset_connection
cls
echo ====================================================
echo       Resetando Conexão e Limpando o Cache de DNS
echo ====================================================
echo.
ipconfig /flushdns
ipconfig /registerdns
ipconfig /release
ipconfig /renew
netsh winsock reset catalog
netsh int ipv4 reset reset.log
netsh int ipv6 reset reset.log
echo Conexão resetada e cache de DNS limpo com sucesso!
pause
goto menu

:: Atualizar Drivers de Rede
:update_drivers
cls
echo ====================================================
echo           Atualizando Drivers de Rede
echo ====================================================
echo     (Sua conexão pode ser interrompida durante este processo)
echo.
pnputil -e > drivers.txt
findstr /i /c:"Net" drivers.txt > netdrivers.txt
for /f "tokens=1,2* delims= " %%a in (netdrivers.txt) do pnputil -f -d "%%b"
echo Drivers de rede atualizados com sucesso! Recomenda-se reiniciar o seu computador.
pause
goto menu
