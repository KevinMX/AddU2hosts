:: --------------------------------------------------------------
::	��Ŀ: CloudflareSpeedTest �Զ�����滻���� U2 Hosts
::	�汾: 0.0.1
::	��Ŀ: https://github.com/Ukenn2112/AddU2hosts/
::
::	ԭ��Ŀ: CloudflareSpeedTest �Զ����� Hosts
::	ԭ����: XIU2
::	ԭ��Ŀ: https://github.com/XIU2/CloudflareSpeedTest
:: --------------------------------------------------------------
@echo off
Setlocal Enabledelayedexpansion

::�ж��Ƿ��ѻ�ù���ԱȨ��

>nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system" 

if '%errorlevel%' NEQ '0' (  
    goto UACPrompt  
) else ( goto gotAdmin )  

::д�� vbs �ű��Թ���Ա������б��ű���bat��

:UACPrompt  
    echo Set UAC = CreateObject^("Shell.Application"^) > "%temp%\getadmin.vbs" 
    echo UAC.ShellExecute "%~s0", "", "", "runas", 1 >> "%temp%\getadmin.vbs" 
    "%temp%\getadmin.vbs" 
    exit /B  

::�����ʱ vbs �ű����ڣ���ɾ��
  
:gotAdmin  
    if exist "%temp%\getadmin.vbs" ( del "%temp%\getadmin.vbs" )  
    pushd "%CD%" 
    CD /D "%~dp0" 


::�������ж��Ƿ��Ի�ù���ԱȨ�ޣ����û�о�ȥ��ȡ��������Ǳ��ű���Ҫ����


::��� nowip.txt �ļ������ڣ�˵���ǵ�һ�����иýű�
if not exist "nowip.txt" ( 
    echo # U2 dmhy Host Start>> %SystemRoot%\system32\drivers\etc\hosts
    echo 104.25.26.31 u2.dmhy.org>> %SystemRoot%\system32\drivers\etc\hosts
    echo 104.25.26.31 tracker.dmhy.org>> %SystemRoot%\system32\drivers\etc\hosts
    echo 104.25.26.31 daydream.dmhy.best>> %SystemRoot%\system32\drivers\etc\hosts

    echo �ýű�������Ϊ ���Cloudflare CDN����Ⱦ�����޷�ֱ�ӵ�¼������԰
    echo ��ʹ�� CloudflareST ���ٺ��ȡ��� IP ���滻 Hosts �е� Cloudflare CDN IP��
    echo.
    echo 104.25.26.31>nowip.txt
    echo.
)  

::�� nowip.txt �ļ���ȡ��ǰ Hosts ��ʹ�õ� Cloudflare CDN IP
set /p nowip=<nowip.txt
echo ��ʼ����...

:: ��������Լ���ӡ��޸� CloudflareST �����в�����echo.| ���������Զ��س��˳����򣨲�����Ҫ���� -p 0 �����ˣ�
echo.|CloudflareST-amd64.exe

for /f "tokens=1 delims=," %%i in (result.csv) do (
    SET /a n+=1 
    If !n!==2 (
        SET bestip=%%i
        goto :END
    )
)
:END
echo %bestip%>nowip.txt
echo.
echo �� IP Ϊ %nowip%
echo �� IP Ϊ %bestip%
C:
CD "C:\Windows\System32\drivers\etc"
echo.
echo ��ʼ���� Hosts �ļ���hosts_backup��...
copy hosts hosts_backup
echo.
echo ��ʼ�滻...
(
    for /f "tokens=*" %%i in (hosts_backup) do (
        set s=%%i
        set s=!s:%nowip%=%bestip%!
        echo !s!
        )
)>hosts
echo ���...
echo.
pause 