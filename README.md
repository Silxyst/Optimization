@echo off
title Otimizador do Windows
color 0A
echo ==============================
echo      Otimizando o Windows
echo ==============================
echo.

:: Executa como administrador
net session >nul 2>&1 || (
    echo Por favor, execute como Administrador.
    pause
    exit
)

:: DESATIVAR SERVIÇOS DESNECESSÁRIOS
echo Desativando serviços desnecessários...
sc config "SysMain" start=disabled
sc config "DiagTrack" start=disabled
sc config "dmwappushservice" start=disabled
sc config "TabletInputService" start=disabled
sc config "WSearch" start=disabled
sc config "Fax" start=disabled
sc config "RemoteRegistry" start=disabled
sc stop "SysMain"
sc stop "DiagTrack"
sc stop "dmwappushservice"
sc stop "TabletInputService"
sc stop "WSearch"
sc stop "Fax"
sc stop "RemoteRegistry"
echo Serviços desativados!

:: LIMPAR ARQUIVOS TEMPORÁRIOS
echo Limpando arquivos temporários...
del /s /q "%temp%\*.*"
del /s /q "C:\Windows\Temp\*.*"
del /s /q "C:\Windows\Prefetch\*.*"
echo Limpeza concluída!

:: DESATIVAR EFEITOS VISUAIS PARA DESEMPENHO
echo Ajustando efeitos visuais para desempenho...
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects" /v VisualFXSetting /t REG_DWORD /d 2 /f
reg add "HKCU\Control Panel\Desktop" /v FontSmoothing /t REG_DWORD /d 2 /f
reg add "HKCU\Control Panel\Desktop" /v UserPreferencesMask /t REG_BINARY /d 9012038010000000 /f
echo Efeitos visuais otimizados!

:: DESATIVAR A FUNÇÃO DE EXECUÇÃO AUTOMÁTICA DE PROGRAMAS
echo Desativando programas desnecessários na inicialização...
reg add "HKLM\Software\Microsoft\Windows\CurrentVersion\Run" /v "OneDrive" /t REG_SZ /d "" /f
reg add "HKLM\Software\Microsoft\Windows\CurrentVersion\Run" /v "Teams" /t REG_SZ /d "" /f
echo Inicialização limpa!

:: LIBERAR MEMÓRIA RAM
echo Liberando memória RAM...
echo %windir%\system32\rundll32.exe advapi32.dll,ProcessIdleTasks
echo Memória otimizada!

echo.
echo Otimização concluída! Reinicie o PC para aplicar todas as mudanças.
pause
exit
